# LuminosityContrast

[![Gem Version](https://badge.fury.io/rb/luminosity_contrast.svg)](https://badge.fury.io/rb/luminosity_contrast)

Calculate the [Luminosity Contrast Ratio](https://www.w3.org/TR/WCAG20/#contrast-ratiodef) of two colors to determine whether text can be easily read. This quantifies the legibility of colored text on a colored background for accessibility purposes.

Implements the formula in WCAG 2.0 guideline 1.4

A recommended value is at least 4.5:1 (`4.5`) for standard text, or at least 3:1 (`3.0`) for large text.

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
LuminosityContrast.ratio('000', 'fff')
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

Bug reports and pull requests are welcome on GitHub at https://github.com/devpuppy/luminosity_contrast. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

