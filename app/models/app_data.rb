class AppData
  def self.data
    YAML.load_file(Rails.root.join('lib', 'app_data.yml')).deep_symbolize_keys
  end

  def self.as_json
    data.to_json
  end
end
