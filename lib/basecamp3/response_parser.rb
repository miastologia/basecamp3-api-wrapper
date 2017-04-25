class Basecamp3::ResponseParser
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

  def self.map_object(object, model)
    begin
      model.new(object)
    rescue
      raise 'Unsupported model type. Try to call for a raw response'
    end
  end
end