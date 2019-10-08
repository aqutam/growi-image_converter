# Growi::ImageConverter

growi-image_converter is a converter that converts esa.io images to GROWI.

GROWI has the ability to import data from esa.io. However, images are not converted. Therefore, convert using this growi-image_converter.

You need to create an AWS S3 bucket in advance and set it to GROWI.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'growi-image_converter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install growi-image_converter

## Usage

Export these environments.

```
$ export GROWI_URL=https://*****.growi.cloud
$ export GROWI_ACCESS_TOKEN=0123456789abcdef0123456789abcdef0123456789ab
```

Perform a trial run with no changes made:

    $ growi-image_converter

Perform the conversion:

    $ growi-image_converter -d

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aqutam/growi-image_converter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
