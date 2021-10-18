class AppData
  DATA_FILE = 'app_data.yml'
  def self.data
    if Rails.env.production?
      Psych.load(s3_settings.body.read).deep_symbolize_keys
    else
      YAML.load_file(Rails.root.join('lib', DATA_FILE)).deep_symbolize_keys
    end
  end

  def self.s3
    if Rails.env.production?
      Aws::S3::Resource.new(region: 'eu-north-1',
                            access_key_id: Rails.application.credentials.dig(:aws, :access_key_id),
                            secret_access_key: Rails.application.credentials.dig(:aws,
                                                                                 :secret_access_key))
    end
  end

  def self.s3_settings
    s3.client.get_object bucket: 'kcsc-production', key: DATA_FILE if Rails.env.production?
  end

  def self.as_json
    data.to_json
  end

  def self.sections
    data[:app_data].keys
  end

  def self.method_missing(*args, &block)
    super unless sections.include?(*args)
    item = data[:app_data][*args]
    case item
    when Array
      item
    when Hash
      if block_given? && block.yield.instance_of?(Symbol)
        item[block.yield]
      else
        item
      end
    else
      item
    end
  end

  # Usage
  # AppData.update(<section>, <content>)
  def self.update(*args)
    section, update = *args
    raise 'no such section' unless sections.include?(section)

    content = send(section)
    new_content = case content
                  when Array
                    existing_item = content.detect { |item| item[:id].to_i == update[:id].to_i }
                    if existing_item && existing_item.any?
                      index = content.find_index(existing_item)
                      content[index] = update
                      { section => content }
                    else
                      { section => content.push(update) }
                    end
                  when Hash
                    { section => { **content, **update } }
                  else
                    { section => update }
                  end
    new_data = { **data[:app_data], **new_content }
    write_to_app_data(new_data)
  end

  def self.delete(testimonial)
    testimonials = data[:app_data][:testimonials]
    raise 'record not found' unless testimonials.include?(testimonial)

    testimonials.delete testimonial
    new_data = { **data[:app_data], testimonials: testimonials }
    write_to_app_data(new_data)
  end

  def self.write_to_app_data(new_data)
    yaml = { app_data: new_data }.to_yaml
    if Rails.env.production?
      s3.client.put_object(bucket: 'kcsc-production', key: DATA_FILE, body: yaml)
    else
      File.open(Rails.root.join('lib', DATA_FILE), 'w') { |f| f.write yaml }
    end
  end
end
