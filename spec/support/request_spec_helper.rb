module RequestSpecHelper
  def json
    response.body
  end

  def parsed_json
    JSON.parse(json)
  end
end