[![Gem Version](https://badge.fury.io/rb/freezolite.svg)](https://rubygems.org/gems/freezolite)
[![Build](https://github.com/ruby-next/freezolite/workflows/Build/badge.svg)](https://github.com/palkan/freezolite/actions)

# Freezolite ❄️

Tired of adding `# frozen_string_literals: true` to every file in your project or running `rubocop -A` to make it do that for you? What if I told you that you can just add a single gem to your project and activate this option **for the project's files** automatically (without enabling it globally)?

Freezolite is a gem that turns the `frozen_string_literal` compile option on only for the specified files. Thus it's like running Ruby with `--enable=frozen-string-literal` but only for the files you own.

> 📖 Read more about the motivation behind this project in ["Freezolite: the magic gem for keeping Ruby literals safely frozen"](https://evilmartians.com/chronicles/freezolite-the-magic-gem-for-keeping-ruby-literals-safely-frozen) post.

Freezolite also comes with experimental support for [freezing constants](#freezing-constants).

## Usage

Add the gem to your Gemfile:

```ruby
gem "freezolite"
```

And drop the following line into your application entry-point **after loading dependencies** and before loading your application code. For example, in Rails, you can put it in `config/application.rb` after the `Bundler.require(...)` call:

```ruby
# config/application.rb

#...
Bundler.require(*Rails.groups)

require "freezolite/auto"

# <application configuration>
```

By default, the gem uses `Dir.pwd` to determine the project root. If you want to use a different directory or multiple directories, configure the gem like this:

```ruby
require "freezolite"

Freezolite.setup(
  # You must pass a list of glob patterns
  patterns: ["/path/to/dir1/*.rb", "/path/to/dir2/*.rb"],
  exclude_patterns: ["/path/to/dir1/vendor/*"]
)
```

**NOTE**: When using auto mode, the `<project-root>/vendor/bundle` folder is excluded automatically. In manual mode, you may want to exclude it yourself.

### Using with Bootsnap

Freezolite is compatible with Bootsnap. Just make sure you require it **after** Bootsnap. No manual cache invalidation required.

### Freezing constants

Ruby 3 introduced a new pragma—[`# shareable_constant_value: ...`](https://bugs.ruby-lang.org/issues/17273). It's meant to be used with Ractor-driven applications to easily turn constants into Ractor-shareable objects within a source file. Making Ractor-shareable implies **deep freezing**, thus, we can leverage this pragma to automatically freeze constants!

Freezolite can automatically inject this pragma for you (only for matching files, similarly to frozen literals). You need to opt-in to enable this feature:

```ruby
require "freezolite"
# You can also specify specific values, such as literal, experimental_copy, etc.
# Setting to `true` is equal to the `literal` value.
Freezolite.experimental_freeze_constants = true
require "freezolite/auto" # or setup manually
```

**NOTE:** This feature is considered experimental for the following reasons: 1) the pragma itself is not widely used and we still need to learn how to use it in our applications; 2) unlike `# frozen_string_literal`, this setting is not a compiler option but a parser context switch; thus, we have to use source transform here, and literally add a line to the source file, thus, breaking the line numbers in your stack traces, etc.

### Supported Ruby versions

- Ruby (MRI) >= 2.7.0

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/ruby-next/freezolite](https://github.com/ruby-next/freezolite).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
