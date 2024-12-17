module Effects
  extend self

  def reverse
    Proc.new do|words|
      words.gsub(/[\w!]+/) {|word| word.chars.reverse.join}
    end
  end

  def echo(cnt)
    Proc.new do |words|
      words.gsub(/[\w!]+/) {|word| word.each_char.map {|char| char * cnt }.join }
    end
  end

  def loud(cnt)
    Proc.new {|words| words.upcase.gsub(/[\w!]+/) {|word| word + '!' * cnt} }
  end
end

class WordSynth
  def initialize
    @effects = []
  end

  def add_effect(effect)
    @effects << effect
  end

  def play(original_words)
    words = original_words
    @effects.each do |effect|
      words = effect.call(words)
    end
    words
  end
end
