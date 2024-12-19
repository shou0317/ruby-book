require 'minitest/autorun'
require_relative '../lib/log_formatter'

class LogFormatterTest < Minitest::Test
  def test_format
    input = [
      {"request_id": "1", "path": "/products/1", "status": 200, "duration": 651.7},
      {"request_id": "2", "path": "/wp-login.php", "status": 404, "duration": 48.1, "error": "Not found"},
      {"request_id": "3", "path": "/products", "status": 200, "duration": 1023.8},
      {"request_id": "4", "path": "/dangerous", "status": 500, "duration": 43.6, "error": "Internal server error"}
    ]
    expected = <<~TEXT.chomp
      [OK] request_id=1, path=/products/1
      [ERROR] request_id=2, path=/wp-login.php, status=404, error=Not found
      [WARN] request_id=3, path=/products, duration=1023.8
      [ERROR] request_id=4, path=/dangerous, status=500, error=Internal server error
    TEXT

    assert_equal expected, LogFormatter.format(input)
  end
end
