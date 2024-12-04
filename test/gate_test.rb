require 'minitest/autorun'

class Gate
  def initialize(name)
    @name = name
  end

  def enter(ticket)
  end

  def exit(ticket)
    true
  end
end

class Ticket
  def initialize(fare)
    @fare = fare
  end
end

class GateTest < Minitest::Test
  def test_gate_umeda_to_juso
    umeda = Gate.new(:umeda)
    juso = Gate.new(:mikuni)

    ticket = Ticket.new(160)
    umeda.enter(ticket)
    assert juso.exit(ticket)
  end

  def test_gate_umeda_to_mikuni_when_fare_is_not_enough
    umeda = Gate.new(:umeda)
    mikuni = Gate.new(:mikuni)

    ticket = Ticket.new(160)
    umeda.enter(ticket)
    refute mikuni.exit(ticket)
  end
end
