require 'minitest/autorun'

module ConvertRgb
  extend self
  def to_hex(*rgb)
    rgb.sum('#') {|n| n.to_s(16).rjust(2, '0')}
  end

  def to_ints(hex)
    hex.scan(/\w\w/).map(&:hex)
  end
end

class ConvertRgbTest < Minitest::Test
  def test_to_hex
    assert_equal '#000000', ConvertRgb.to_hex(0,0,0)
    assert_equal '#ffffff', ConvertRgb.to_hex(255,255,255)
    assert_equal '#043c78', ConvertRgb.to_hex(4,60,120)
  end
  def test_to_ints
    assert_equal [0,0,0], ConvertRgb.to_ints('#000000')
    assert_equal [255,255,255], ConvertRgb.to_ints('#ffffff')
    assert_equal [4,60,120], ConvertRgb.to_ints('#043c78')
  end
end
