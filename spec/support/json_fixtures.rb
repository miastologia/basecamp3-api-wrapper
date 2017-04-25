module JSONFixtures
  def json_dir
    File.join(File.dirname(__FILE__), '../fixtures')
  end

  def json_file(filename)
    File.join(json_dir, filename)
  end

  def json_string(filename)
    File.read(json_file(filename))
  end

  def json_struct(filename)
    JSON.parse(json_string(filename))
  end

  def json_to_model(filename, model)
    json = json_struct(filename)

    case json
    when Hash
      model.new(json)
    when Array
      json.map do |item|
        model.new(item)
      end
    when NilClass
      nil
    end
  end
end