class Basecamp3::Model
  REQUIRED_FIELDS = []

  def initialize(data = {})
    data.each do |attr, value|
      instance_variable_set("@#{attr}", value)
    end
  end

  protected

  def self.validate_required(data)
    self::REQUIRED_FIELDS.each { |f| raise "Missing required parameter #{f}" if data[f.to_sym].nil? }
  end
end