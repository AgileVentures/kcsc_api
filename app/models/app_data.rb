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
end
