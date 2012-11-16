# Taxonomy

Taxonomy is a simple Ruby library for extracting a taxonomy/dictionary
from text.

## Installation

Add this line to your application's Gemfile:

    gem 'taxonomy', git: 'git://github.com/christianhellsten/taxonomy.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install taxonomy

## Usage

See tests:

    os = Taxonomy.load('test/fixtures/operating-systems.yml')
    result = os.classify 'Debian is a Unix operating system, so are Ubuntu and OS X'
    assert result.include?("Debian"), result.inspect
    assert result.include?("OSX"), result.inspect
    assert result.include?("Ubuntu"), result.inspect

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
