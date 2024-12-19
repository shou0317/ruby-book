class LogFormatter
  def self.format(input)
    input.map do |hash|
      case hash
      in {status: 404 | 500} => h
        "[ERROR] request_id=#{h[:request_id]}, path=#{h[:path]}, status=#{h[:status]}, error=#{h[:error]}"
      in {duration: 1000..} => h
        "[WARN] request_id=#{h[:request_id]}, path=#{h[:path]}, duration=#{h[:duration]}"
      else
        "[OK] request_id=#{hash[:request_id]}, path=#{hash[:path]}"
      end
    end.join("\n")
  end
end
