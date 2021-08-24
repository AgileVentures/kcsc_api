class AppData
  def self.data
    YAML.load_file(Rails.root.join('lib', 'app_data.yml')).deep_symbolize_keys
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
    case content
    when Array
      new_content = { section => [*content, *update] }
    when Hash
      new_content = { section => { **content, **update } }
    end
    new_data = { **data[:app_data], **new_content }
    yaml = { app_data: new_data }.to_yaml
    File.open(Rails.root.join('lib', 'app_data.yml'), 'w') { |f| f.write yaml }
  end
end
