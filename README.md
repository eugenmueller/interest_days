# InterestDays

This gem provide interest day factor calculation based on ISDA conventions e.g. Isda Act 360.
Since version 0.2 interest_day gem support 30/360 US EOM and 30/360 Bond Basis conventions. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'interest_days'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install interest_days

## Usage

You can simple use the InterestDays::Calculator like:

```ruby
calculator = InterestDays::Calculator.new(start_date: start, end_date: end, strategy: :isda_act_360)

calculator.interest_day_count_factor
```

currently there a three supported conventions:
- :isda_act_360
- :isda_act_365
- :isda_30_e_360
- :us_eom_30_360
- :bond_basis_30_360


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eugenmueller/interest_days.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
