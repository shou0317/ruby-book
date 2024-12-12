require 'minitest/autorun'
require_relative '../lib/regexp_checker'

class RegexpCheckerTest < Minitest::Test
  def test_main_when_matched
    input = [
      "123-456-789\n",
      "[1-6+\n",
      "[1-6]+\n",
    ]
    expected = [
      'Text?: ',
      'Pattern?: ',
      "Invalid pattern: premature end of char-class: /[1-6+/\n",
      'Pattern?: ',
      "Matched: 123,456\n"
    ].join

    stub :gets, -> {input.shift} do
      assert_output(expected) do
        regexp_checker_main
      end
    end
  end

  def test_main_when_not_matched
    input = [
      "abc-def-ght\n",
      "[1-6]+\n"
    ]
    expected = [
      'Text?: ',
      'Pattern?: ',
      "Nothing matched.\n"
    ].join

    stub :gets, -> { input.shift } do
      assert_output(expected) do
        regexp_checker_main
      end
    end
  end
end
