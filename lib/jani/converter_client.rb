require "jani/converter_client/version"
require "jani/converter_client/connection"

module Jani
  module ConverterClient
    class << self
      def new(base_url: base_url)
        return unless base_url
        @base_url = base_url
        Jani::ConverterClient::Connection.new(base_url)
      end
    end
  end
end
