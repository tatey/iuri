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

    def params=(new_params)
      self.query = build_nested_query(new_params)
    end

    def inspect
      super.sub('#<URI', '#<IURI')
    end

    private

    # A special thanks to rack for this one.
    # See https://github.com/rack/rack/blob/e98a9f7ef0ddd9589145ea953948c73a8ce3caa9/lib/rack/utils.rb
    def build_nested_query(value, prefix = nil)
      case value
      when Array
        value.map { |v|
          build_nested_query(v, "#{prefix}[]")
        }.join("&")
      when Hash
        value.map { |k, v|
          build_nested_query(v, prefix ? "#{prefix}[#{escape(k)}]" : escape(k))
        }.reject(&:empty?).join('&')
      when nil
        prefix
      else
        raise ArgumentError, "value must be a Hash" if prefix.nil?
        "#{prefix}=#{escape(value)}"
      end
    end

    def escape(value)
      URI.encode_www_form_component(value)
    end
  end
end
