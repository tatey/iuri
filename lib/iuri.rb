require 'delegate'
require 'uri'
require 'iuri/version'

module IURI
  def self.parse(string)
    uri = URI.parse(string)
    Generic.new(uri)
  end

  class Generic < SimpleDelegator
    # Change components of a URI using a hash. Changes are chainable and
    # each one returns a new instance.
    #
    # Example:
    #   uri1 = IURI.parse("https://lifx.co")
    #   uri2 = uri1.merge(path: "/foo/bar")
    #   uri2.to_s # => "https://lifx.co/foo/bar"
    #
    # @param options [Hash] Components
    # @return [URI] A new instance
    def merge(components)
      copy = clone
      components.each do |key, value|
        writer = :"#{key}="
        if copy.respond_to?(writer)
          copy.send(writer, value)
        else
          raise KeyError, "key not found: \"#{key}\""
        end
      end
      copy
    end

    def inspect
      super.sub('#<URI', '#<IURI')
    end
  end
end
