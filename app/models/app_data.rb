class AppData
  DATA_FILE = 'app_data.yml'
  def self.data
    YAML.load_file(Rails.root.join('lib', DATA_FILE)).deep_symbolize_keys
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
                    { section => [*content, *update] }
                  when Hash
                    { section => { **content, **update } }
                  else
                    { section => update }
                  end
                  new_data = { **data[:app_data], **new_content }
                  yaml = { app_data: new_data }.to_yaml
    File.open(Rails.root.join('lib', DATA_FILE), 'w') { |f| f.write yaml }
  end
end
