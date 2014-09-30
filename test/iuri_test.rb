require 'minitest/autorun'
require 'iuri'

class IURITest < Minitest::Test
  def test_setting_known_components
    uri1 = IURI.parse('http://lifx.co')
    uri2 = uri1.merge(scheme: 'https', path: '/foo/bar', query: 'baz=true')

    assert_equal 'https://lifx.co/foo/bar?baz=true', uri2.to_s
  end

  def test_setting_unknown_components_raises_key_error
    assert_raises(KeyError) do
      IURI.parse('http://lifx.co').merge(combobulator: 42)
    end
  end

  def test_setting_params
    uri1 = IURI.parse('http://lifx.co')
    uri2 = uri1.merge(params: {a: '1', b: ['1', '2', '3'], c: {d: '1'}})

    assert_equal 'http://lifx.co?a=1&b[]=1&b[]=2&b[]=3&c[d]=1', uri2.to_s
  end

  def test_getting_known_components
    uri = IURI.parse('http://lifx.co/foo/bar?baz=true')

    assert uri.scheme, 'http'
    assert uri.host, 'lifx.co'
    assert uri.path, '/foo/bar'
    assert uri.query, 'baz=true'
  end

  def test_merge_returns_copy
    uri1 = IURI.parse('http://lifx.co')
    uri2 = uri1.merge(path: '/foo/bar')

    refute_same uri1, uri2
  end

  def test_inspect
    uri = IURI.parse('http://lifx.co')

    assert_match /\A#<IURI/, uri.inspect
  end
end
