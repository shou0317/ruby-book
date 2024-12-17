require 'minitest/autorun'
require_relative '../lib/word_synth'
require_relative '../lib/effects'

class WordSynthTest < Minitest::Test
  attr_reader :synth

  def setup
    @synth = WordSynth.new
  end

  def test_play_with_all_effects
    synth.add_effect(Effects.echo(2))
    synth.add_effect(Effects.loud(3))
    synth.add_effect(Effects.reverse)
    assert_equal '!!!YYBBUURR !!!SSII !!!!!NNUUFF', synth.play('Ruby is fun!')
  end
end
