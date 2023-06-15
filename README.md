[![Gem Version](https://badge.fury.io/rb/freeze_the_lits.svg)](https://rubygems.org/gems/freeze_the_lits)
[![Build](https://github.com/ruby-next/freeze_the_lits/workflows/Build/badge.svg)](https://github.com/palkan/freeze_the_lits/actions)

# Freeze the Lits ❄️

Tired of adding `# frozen_string_literals: true` to every file in your project or running `rubocop -A` to make it do that for you? What if I told you that you can just add a single gem to your project and activate this option **for the project's files** automatically (without enabling it globally)?

FreezeTheLits is a gem that turn the `frozen_string_literal` compile option on only for the specified files. Thus, it's like running Ruby with `--enable=frozen-string-literal` but only for the files you own.

## Usage

Add the gem to your Gemfile:

```ruby
gem "freeze_the_lits"
```

And drop the following line to your application entrypoint (e.g., `config/boot.rb` for Rails):

```ruby
require "freeze_the_lits/auto"
```

By default, the gem uses `Dir.pwd` to determine the project root. If you want to use a different directory or multiple directories, configure the gem like this:

```ruby
require "freeze_the_lits"

FreezeTheLits.setup(
  watch_dirs: ["/path/to/dir1", "/path/to/dir2"]
)
```

### Using with Bootsnap

FreezeTheList is compatible with Bootsnap. Just make sure you require it **after** Bootsnap:

```ruby
# config/boot.rb

require "bootsnap/setup"
require "freeze_the_lits/auto"
require "bundler/setup"
```

### Using in tests

Usually, when we load tests we use different entry-points. Thus, we need to require the gem in each of them. For example, in Rails, we need to require it in `test_helper.rb` and `rails_helper.rb`:

```ruby
require "freeze_the_lits/auto"
```

### Supported Ruby versions

- Ruby (MRI) >= 2.7.0

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/ruby-next/freeze_the_lits](https://github.com/ruby-next/freeze_the_lits).


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
