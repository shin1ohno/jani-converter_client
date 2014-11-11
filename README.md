# Jani::ConverterClient

API client for jani-converter.
Implemented as a thin layer on top of faraday.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jani-converter_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jani-converter_client

## Usage

```ruby
require "jani/converter_client"
conn = Jani::ConverterClient.new(base_url: "http://localhost:3000/movies")
response = conn.get_movie("43c76def-6ba6-44cf-9899-4311cb877d07")
response.movie.uuid #=> 43c76def-6ba6-44cf-9899-4311cb877d07
response.status #=> 200

response = conn.post_movie(
    {
      fps: fps,
      frame_height: frame_height,
      frame_width: frame_width,
      remote_movie_url: "https://example.com/video.mp4",
      postroll_banner: {
        url: banner_link_url,
        remote_image_url: "http://example.com/banner_1.jpg",
      },
      loading_banner: {
        remote_image_url: "http://example.com/banner_2.jpg",
      },
      tracking_events: {
        foo: {
          label: tracking_event_label,
          url: tracking_event_url,
          request_type: tracking_event_request_type,
        },
      }
    },
    callback_url: "http://localhost:3000/encode_complete_callback"
  )

response.status #=> 201: created
response.movie.uuid #=> server generates uuid and returns it
response.movie.fps #=> fps
# other attributes...
```

## Contributing

1. Fork it ( https://github.com/shin1ohno/jani-converter_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
