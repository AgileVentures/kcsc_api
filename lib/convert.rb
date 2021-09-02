class Number
  def self.convert(object)
    case object
    when String
      begin
        numeric(object)
      rescue StandardError
        object
      end
    when Array
      object.map { |i| convert i }
    when Hash
      object.merge(object) { |_k, v| convert v }
    else
      object
    end
  end

  def self.numeric(object)
    Integer(object)
  rescue StandardError
    Float(object)
  end
end
