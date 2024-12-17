module Effects
  extend self

  def reverse
    ->(words) do
      words.gsub(/[\w!]+/) {|word| word.chars.reverse.join}
    end
  end

  def echo(cnt)
    ->(words) do
      words.gsub(/[\w!]+/) {|word| word.each_char.map {|char| char * cnt }.join }
    end
  end

  def loud(cnt)
    ->(words) do
      words.upcase.gsub(/[\w!]+/) {|word| word + '!' * cnt}
    end
  end
end
