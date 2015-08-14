require "jani/from_json"
require "jani/converter_client/response"
require "faraday"

class Jani::ConverterClient::Connection
  def initialize(base_url)
    @base_url = base_url
  end

  def get_movie(uuid)
    Jani::ConverterClient::Response.new(
      connection.get("uuid/#{uuid}.json")
    )
  end

  def post_movie(movie_data: , callback_url: )
    Jani::ConverterClient::Response.new(
      connection.post() do |req|
        req.url "#{@base_url}.json"
        req.headers['Content-Type'] = 'application/json'
        req.body = {
          movie: {
            fps: movie_data[:fps],
            frame_height: movie_data[:frame_height],
            frame_width: movie_data[:frame_width],
            remote_movie_url: movie_data[:remote_movie_url],
            postroll_banner_attributes: movie_data[:postroll_banner],
            loading_banner_attributes: movie_data[:loading_banner],
            tracking_events: movie_data[:tracking_events],
          },
          callback_url: callback_url
        }.to_json
      end
    )
  end

  def connection
    @connection ||= Faraday.new(url: @base_url)
  end
end
