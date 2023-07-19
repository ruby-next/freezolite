[![Gem Version](https://badge.fury.io/rb/freezolite.svg)](https://rubygems.org/gems/freezolite)
[![Build](https://github.com/ruby-next/freezolite/workflows/Build/badge.svg)](https://github.com/palkan/freezolite/actions)

# Freezolite ❄️

Tired of adding `# frozen_string_literals: true` to every file in your project or running `rubocop -A` to make it do that for you? What if I told you that you can just add a single gem to your project and activate this option **for the project's files** automatically (without enabling it globally)?

Freezolite is a gem that turn the `frozen_string_literal` compile option on only for the specified files. Thus, it's like running Ruby with `--enable=frozen-string-literal` but only for the files you own.

## Usage

Add the gem to your Gemfile:

```ruby
gem "freezolite"
```

And drop the following line to your application entrypoint (e.g., `config/boot.rb` for Rails):

```ruby
require "freezolite/auto"
```

By default, the gem uses `Dir.pwd` to determine the project root. If you want to use a different directory or multiple directories, configure the gem like this:

```ruby
require "freezolite"

Freezolite.setup(
  # You must pass a list of glob patterns
  patterns: ["/path/to/dir1/**/*.rb", "/path/to/dir2/**/*.rb"],
  exclude_patterns: ["/path/to/dir1/vendor/**/*"]
)
```

**NOTE**: When using auto mode, the `<project-root>/vendor/bundle` folder is excluded automatically. In manual mode, you may want to exclude it yourself.

### Using with Bootsnap

FreezeTheList is compatible with Bootsnap. Just make sure you require it **after** Bootsnap:

```ruby
# config/boot.rb

require "bootsnap/setup"
require "freezolite/auto"
require "bundler/setup"
```

### Using in tests

Usually, when we load tests we use different entry-points. Thus, we need to load `freezolite` differently if we want to enable auto-freezing for test files, too. 

#### RSpec

Put the following line to `spec_helper.rb`:

```ruby
require "freezolite/auto"
```

Make sure you have `spec_helper.rb` _preloaded_ by RSpec by putting the following to the `.rspec` file:

```txt
--require spec_helper
```

#### Minitest

🤷‍♂️

### Supported Ruby versions

- Ruby (MRI) >= 2.7.0

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/ruby-next/freezolite](https://github.com/ruby-next/freezolite).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
