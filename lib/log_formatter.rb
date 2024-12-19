class LogFormatter
  def self.format(input)
    <<~TEXT
      [OK] request_id=1, path=/products/1
      [ERROR] request_id=2, path=/wp-login.php, status=404, error=Not found
      [WARN] request_id=3, path=/products, duration=1023.8
      [ERROR] request_id=4, path=/dangerous, status=500, error=Internal server error
    TEXT
  end
end
