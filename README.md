# IURI

[![Build Status](https://travis-ci.org/tatey/iuri.svg?branch=master)](https://travis-ci.org/tatey/iuri)

Build complex URIs with chainability and immutability. No string
concatenation required. If you're familiar with `URI` then you already know
how to use it.

First it starts like this.

``` ruby
"https://lifx.co/api/v1/devices".
```

Then you need to target different hosts in development, staging and
production.

``` ruby
"#{ENV['API_SCHEME']}://#{ENV['API_HOST']}/api/v1/devices"
```

Then staging becomes protected by basic authentication.

``` ruby
if ENV['API_CREDENTIALS']
  "#{ENV['API_SCHEME']}://#{ENV['API_CREDENTIALS']}@#{ENV['API_HOST']}/api/v1/devices"
else
  "#{ENV['API_SCHEME']}://#{ENV['API_HOST']}/api/v1/devices"
end
```

Then you need to target different paths.

``` ruby
def devices_url
  base_url + '/api/v1/devices'
end

def accounts_url
  base_url + '/api/v1/accounts'
end

def base_url
  if ENV['API_CREDENTIALS']
    "#{ENV['API_SCHEME']}://#{ENV['API_CREDENTIALS']}@#{ENV['API_HOST']}"
  else
    "#{ENV['API_SCHEME']}://#{ENV['API_HOST']}"
  end
end
```

Now you've added three environment variables and you're vulnerable to
developers mistyping URLs. With `IURI` there's a better way.

``` ruby
# Development
# ENV['API_BASE_URL'] = 'http://lifx.dev'
#
# Staging
# ENV['API_BASE_URL'] = 'https://user:pass@staging.lifx.co'
#
# Production
# ENV['API_BASE_URL'] = 'https://lifx.co'

def devices_url
  API_BASE_URL.merge(path: "/api/v1/devices")
end

def accounts_url
  API_BASE_URL.merge(path: "/api/v1/accounts")
end

def API_BASE_URL
  IURI.parse(ENV['API_BASE_URL'])
end
```

## Usage

Parse a base URL and append a path.

``` ruby
uri1 = IURI.parse("https://user:secret@lifx.co")
uri2 = uri1.merge(path: "/api/v1/devices")
uri2.to_s # => "https://user:secret@lifx.co/api/v1/devices"
```

Preferring components to strings gives you greater flexibility over the
base URL. Here we include a query string at the end of the URL and change
the path as required.

``` ruby
uri1 = IURI.parse("https://lifx.co?api_key=secret")
uri2 = uri1.merge(path: "/api/v1/devices")
uri2.to_s # => "https://lifx.co/api/v1/devices?api_key=secret"
```

Supports the same components as `URI`. Here's a sample of the commonly
used components.

``` ruby
IURI.parse("https://lifx.co").merge({
  path: "api/v1/devices"
  query: "api_key=secret"
  user: "user"
  password: "secret"
})
```

Each `merge` returns a copy guaranteeing that constants and variables
remain unchanged.

``` ruby
uri1 = IURI.parse("https://lifx.co")
uri2 = uri1.merge(path: "/api/v1/devices")
uri1.to_s # => "https://lifx.co"
uri2.to_s # => "https://lifx.co/api/v1/devices"
```

## Installation

First, add this line to your application's Gemfile.

``` ruby
gem 'iuri'
```

Then, then execute.

```
$ bundle
```

## Tests

Run the entire test suite.

```
$ rake
```

## Contributing

1. Fork it (https://github.com/tatey/iuri/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright 2014 LIFX Inc. MIT License. See LICENSE for details.
