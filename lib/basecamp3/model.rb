# A base class for models
#
# @abstract
class Basecamp3::Model
  REQUIRED_FIELDS = []

  def initialize(data = {})
    data.each do |attr, value|
      instance_variable_set("@#{attr}", value)
    end
  end

  protected

  # Validates if the given data contain the required attributes.
  #
  # @param [Hash] data the data to send in the request
  #
  # @raise [StandardError] raises an error if required parameter is missing
  def self.validate_required(data)
    self::REQUIRED_FIELDS.each { |f| raise "Missing required parameter #{f}" if data[f.to_sym].nil? }
  end
end