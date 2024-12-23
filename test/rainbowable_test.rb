require 'minitest/autorun'

module Rainbowable
  def rainbow
    colord_chars = []

    self.to_s.each_char.map.with_index do |char, count|
      color = 31 + count % 6
      "\e[#{color}m#{char}"
    end.push("\e[0m").join
  end
end

class RainbowableTest < Minitest::Test
  def setup
    String.include Rainbowable
    Array.include Rainbowable
  end

  def test_rainbow
    expected = "\e[31mH\e[32me\e[33ml\e[34ml\e[35mo\e[36m,\e[31m \e[32mw\e[33mo\e[34mr\e[35ml\e[36md\e[31m!\e[0m"
    assert_equal expected, 'Hello, world!'.rainbow

    expected = "\e[31m[\e[32m1\e[33m,\e[34m \e[35m2\e[36m,\e[31m \e[32m3\e[33m]\e[0m"
    assert_equal expected, [1,2,3].rainbow

    # puts 'Hello, world!'.rainbow
    # puts [1,2,3].rainbow
  end
end
