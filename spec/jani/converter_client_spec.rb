require "jani/converter_client"
require "faraday"

RSpec.describe Jani::ConverterClient do
  describe ".new" do
    subject { Jani::ConverterClient.new(base_url: "http://localhost:3000/movies/") }

    it "returns connection" do
      is_expected.to be_a_kind_of Jani::ConverterClient::Connection
    end
  end
end
