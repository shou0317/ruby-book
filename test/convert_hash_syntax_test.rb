require 'minitest/autorun'

def convert_hash_syntax(old_syntax)
  regex = /:(\w+)\s*=>\s*([':\w]+)/
  old_syntax.gsub(regex) do
    "#{$1}: #{$2}"
  end
end

class ConvertHashTest < Minitest::Test
  def test_convert_hash_syntax
    old_syntax = <<~TEXT
    {
      :name => 'Alice',
      :age=>20,
      :gender  =>  :female
    }
    TEXT
    expected = <<~TEXT
    {
      name: 'Alice',
      age: 20,
      gender: :female
    }
    TEXT
    assert_equal expected, convert_hash_syntax(old_syntax)
  end
end
