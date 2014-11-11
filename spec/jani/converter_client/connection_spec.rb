require "jani/converter_client/connection"

RSpec.describe Jani::ConverterClient::Connection do
  let(:connection) { Jani::ConverterClient::Connection.new("http://localhost:3000/movies") }

  describe "#get_movie" do
    subject(:response) { connection.get_movie(uuid) }

    context "given valid uuid" do
      let(:uuid) { "ed92fded-d1fe-4cc8-a254-032015eb25a0" }

      it "returns the movie" do
        is_expected.to be_success
        expect(response.movie.uuid).to eq uuid
      end
    end

    context "given non existing uuid" do
      let(:uuid) { "a" }

      it "returns empty movie" do
        is_expected.not_to be_success
        expect(response.status).to eq 404
        expect(response.movie.uuid).to be_nil
      end
    end

    context "given no uuid" do
      let(:uuid) { nil }

      it "returns empty movie" do
        is_expected.not_to be_success
        expect(response.status).to eq 404
        expect(response.movie.uuid).to be_nil
      end
    end
  end

  describe "#post_movie" do
    subject(:response) { connection.post_movie(movie_data: movie_data, callback_url: callback_url)  }
    let(:callback_url) { "http://localhost:3000/encode_complete_callback" }

    context "given nil movie data" do
      let(:movie_data) { nil }

      it "returns the empty movie" do
        is_expected.not_to be_success
        expect(response.status).to eq 400
        expect(response.movie.uuid).to be_nil
      end
    end

    context "given valid movie data" do
      let(:movie_data) do
        {
          fps: fps,
          frame_height: frame_height,
          frame_width: frame_width,
          remote_movie_url: "http://example.com/video.mp4",
          postroll_banner: {
            url: banner_link_url,
            remote_image_url: "http://example.com/frame0019.jpg",
          },
          loading_banner: {
            remote_image_url: "http://example.com/frame0467.jpg",
          },
          tracking_events: {
            foo: {
              label: tracking_event_label,
              url: tracking_event_url,
              request_type: tracking_event_request_type,
            },
          }
        }
      end

      let(:fps) { 30 }
      let(:frame_width) { 640 }
      let(:frame_height) { 360 }
      let(:banner_link_url) { "http://example.com/?postroll" }
      let(:tracking_event_url) { "/foo" }
      let(:tracking_event_label) { "/foo" }
      let(:tracking_event_request_type) { "xhr" }

      it "returns created movie" do
        is_expected.to be_success
        expect(response.status).to eq 201
        expect(response.movie.uuid).not_to be_nil
        expect(response.movie.fps).to eq fps
        expect(response.movie.frame_width).to eq frame_width
        expect(response.movie.frame_height).to eq frame_height

        expect(response.movie.loading_banner.image_url).to end_with "frame0467.jpg"

        expect(response.movie.postroll_banner.image_url).to end_with "frame0019.jpg"
        expect(response.movie.postroll_banner.url).to eq banner_link_url

        expect(response.movie.tracking_events[0].label).to eq tracking_event_label
        expect(response.movie.tracking_events[0].request_type).to eq tracking_event_request_type
        expect(response.movie.tracking_events[0].url).to eq tracking_event_url
      end
    end
  end
end
