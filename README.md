# Duo Universal

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/duo_universal_rails`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add duo_universal_rails

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install duo_universal_rails

## Usage

```ruby
client = DuoUniversalRails::Client.new(client_id: ENV["DUO_CLIENT_ID"], client_secret: ENV["DUO_CLIENT_SECRET"], api_hostname: ENV["DUO_HOSTNAME"], redirect_uri: ENV["DUO_REDIRECT_URI"])

client.health_check.ping


client.auth.create_url(username: 'DUO_USER')

result = client.token.exchange_authorization_code_for_2fa_result(code: 'CODE', username: 'DUO_USER')

if result["sub"].present? && result["sub"] == 'username'
    # Success
else
    # Error
end


```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/duo_universal_rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/duo_universal_rails/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DuoUniversalRails project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/duo_universal_rails/blob/master/CODE_OF_CONDUCT.md).
