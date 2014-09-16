require 'uri'
require 'iuri/version'

class IURI
  def initialize(uri)
    @uri = uri
  end

  def self.parse(string)
    uri = URI.parse(string)
    new(uri)
  end

  # Change components of a URI using a hash. Changes are chainable and
  # each one returns a new instance.
  #
  # Example:
  #   uri1 = MergeableURI.parse("https://lifx.co")
  #   uri2 = uri1.merge(path: "/foo/bar")
  #   uri2.to_s # => "https://lifx.co/foo/bar"
  #
  # @param options [Hash] Components
  # @return [MergeableURI] A new instance
  def merge(options)
    copy = @uri.dup
    options.each do |key, value|
      writer = :"#{key}="
      if copy.respond_to?(writer)
        copy.send(writer, value)
      else
        raise KeyError, "key not found: \"#{key}\""
      end
    end
    self.class.new(copy)
  end

  def to_s
    @uri.to_s
  end
end
