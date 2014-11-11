require "forwardable"
require "jani/from_json"

class Jani::ConverterClient::Response
  extend Forwardable
  attr_reader :movie
  def_delegators :@http_response, :status, :headers, :body, :success?

  def initialize(http_response)
    @http_response = http_response

    @movie = if success?
      Jani::FromJson.to_movie(http_response.body)
    else
      Jani::FromJson.empty_movie
    end
  end
end
