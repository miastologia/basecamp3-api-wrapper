# The basecamp response parser
class Basecamp3::ResponseParser

  # Parses the given response to the given wrapper model.
  #
  # @param [Hash] response The hash with data which should be parsed to the wrapper model
  # @param [Class] model The class of the model
  #
  # @return [Basecamp3::Model, Array<Basecamp3::Model>, nil]
  # @raise [StandardError] raises an error for unsupported response type
  def self.parse(response, model)
    case response
    when Hash
      map_object(response, model)
    when Array
      response.map do |item|
        map_object(item, model)
      end
    when NilClass
      nil
    else
      raise 'Unsupported response type'
    end
  end

  private

  # Parses the given hash to the given wrapper model.
  #
  # @private
  #
  # @param [Hash] object The hash with data which should be parsed to the wrapper model
  # @param [Class] model The class of the model
  #
  # @return [Basecamp3::Model]
  # @raise [StandardError] raises an error for unsupported model type
  def self.map_object(object, model)
    begin
      model.new(object)
    rescue
      raise 'Unsupported model type. Try to call for a raw response'
    end
  end
end