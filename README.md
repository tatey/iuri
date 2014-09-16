# IURI

Build complex URIs with chainability and immutability. If you're familiar
with URI then you already know how to use it.

## Installation

Add this line to your application's Gemfile:

    gem 'iuri'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iuri

## Usage

Change components of a URI using a hash. Changes are chainable and each
one returns a new instance.

Example:

    uri1 = IURI.parse("https://user:secret@lifx.co")
    uri2 = uri1.merge(path: "/api/v1/foos")
    uri2.to_s # => "https://user:secret@lifx.co/api/v1/foos"

## Tests

Run the entire test suite.

    $ rake

## Contributing

1. Fork it ( https://github.com/tatey/iuri/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright 2014 LIFX Inc. MIT License. See LICENSE for details.
