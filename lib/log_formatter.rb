module LogFormatter
  def self.format(input)
    input.map { |hash| format_log(hash) }.join("\n")
  end

  def self.format_log(hash)
    base = "request_id=#{hash[:request_id]}, path=#{hash[:path]}"
    case hash
    in {status: 404 | 500} => hash
      "[ERROR] #{base}, status=#{hash[:status]}, error=#{hash[:error]}"
    in {duration: 1000..} => hash
      "[WARN] #{base}, duration=#{hash[:duration]}"
    else
      "[OK] #{base}"
    end
  end
end
