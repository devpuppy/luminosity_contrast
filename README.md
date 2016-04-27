# LuminosityContrast

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/luminosity_contrast`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'luminosity_contrast'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install luminosity_contrast

## Usage

```ruby
LuminosityContrast.ratio('000', 'ffffff')
# => 21.0

LuminosityContrast.ratio([0,0,0], [255,255,255])
# => 21.0

sienna = LuminosityContrast::Color.new('A0522D')
LuminosityContrast.ratio(sienna, sienna)
# => 1.0

midnight_blue = LuminosityContrast::Color.new('191970')
sky_blue = LuminosityContrast::Color.new('87CEEB')
midnight_blue.ratio(sky_blue)
# => 8.5256628387305
sky_blue.ratio(midnight_blue)
# => 8.5256628387305
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/luminosity_contrast. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

