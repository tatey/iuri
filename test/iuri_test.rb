require 'minitest/autorun'
require 'iuri'

class IURITest < Minitest::Test
  def test_it_sets_known_components
    uri1 = IURI.parse('http://lifx.co')
    uri2 = uri1.merge(scheme: 'https', path: '/foo/bar', query: 'baz=true')

    assert_equal 'https://lifx.co/foo/bar?baz=true', uri2.to_s
  end

  def test_it_raises_unknown_components
    assert_raises(KeyError) do
      IURI.parse('http://lifx.co').merge(combobulator: 42)
    end
  end

  def test_it_is_a_copy
    uri1 = IURI.parse('http://lifx.co')
    uri2 = uri1.merge(path: '/foo/bar')

    refute_same uri1, uri2
  end
end
