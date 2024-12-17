require 'minitest/autorun'
require_relative '../lib/word_synth'
require_relative '../lib/effects'

class WordSynthTest < Minitest::Test
  attr_reader :synth, :text

  def setup
    @synth = WordSynth.new
    @text = 'Ruby is fun!'
  end

  def test_play_witout_effects
    assert_equal 'Ruby is fun!', synth.play(text)
  end

  def test_play_with_reverse_effect
    synth.add_effect(Effects.reverse)
    assert_equal 'ybuR si !nuf', synth.play(text)
  end

  def test_play_with_all_effects
    synth.add_effect(Effects.echo(2))
    synth.add_effect(Effects.loud(3))
    synth.add_effect(Effects.reverse)
    assert_equal '!!!YYBBUURR !!!SSII !!!!!NNUUFF', synth.play(text)
  end
end
