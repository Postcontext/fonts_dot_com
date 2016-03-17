# FontsDotCom

This is a simple wrapper for communicating with the fonts.com API. The fonts.com API requires signing calls with a hash that's not trivial to generate, which rules out e.g. playing around with curl. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fonts_dot_com'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fonts_dot_com

## Usage

### API key

Before you can use the fonts.com API, you need an API key. You can request a key here:
https://www.fonts.com/web-fonts/developers/request-api-key

### Configuration

`FontsDotCom` needs to be configured with your credentials before you can make API calls. 

```ruby
irb> require 'fonts_dot_com'
irb> FontsDotCom.configure do |config|
irb>   config.api_key      = 'whatever'
irb>   config.public_key   = 'whatever' # This, and the private key are generated
irb>   config.private_key  = 'whatever' # from the API key.
irb> end

```
In a Rails app, you'd want to put the above in an initializer.

### API calls

Until I write up some better documentation, here's the gist:

```ruby
response = FontsDotCom::Api.list_projects
=> #<FontsDotCom::Response:0x007fdfdc1db2d0 @original_response_object=#<Net::HTTPOK 200 OK readbody=true>, @body={ :lots => :here }, @code="200">
irb> response.class
=> FontsDotCom::Response
irb> response.body.class
=> Hash
irb> response.body.keys
=> ["Projects"]
```

See lib/fonts_dot_com/api.rb for other calls.


## Contributing

1. Fork it ( https://github.com/Postcontext/fonts_dot_com/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
