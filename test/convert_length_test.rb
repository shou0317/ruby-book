require 'minitest/autorun'

def convert_length(length,from: :m,to: :m)
  units = { m: 1.00, ft: 3.28, in: 39.37 }
  (length / units[from] * units[to]).round(2)
end

class ConvertLengthTest < Minitest::Test
  def test_convert_length
    assert_equal 39.37, convert_length(1, from: :m, to: :in)
    assert_equal 0.38, convert_length(15, from: :in, to: :m)
    assert_equal 10670.73, convert_length(35000, from: :ft, to: :m)
  end
end
