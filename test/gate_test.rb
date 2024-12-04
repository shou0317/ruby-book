require 'minitest/autorun'

class Gate
  STATION = [:umeda, :juso, :mikuni]

  def initialize(name)
    @name = name
  end

  # ticketに自分の駅名を記録する
  def enter(ticket)
    ticket.stamp(@name)
  end

  # 運賃と乗車駅を取得する
  # 乗車駅と自分の駅名から運賃を割り出す
  def exit(ticket)
    gate = ticket.stamped_at
    ticket_fare = ticket.fare

    distance = STATION.index(@name) - STATION.index(gate)
    fare_table = { 1 => 160, 2 => 190 }
    fare = fare_table[distance]

    fare == ticket_fare
  end
end

class Ticket
  attr_reader :fare

  def initialize(fare)
    @fare = fare
  end

  # 渡された駅名を記録する
  def stamp(name)
    @name = name
  end

  # 乗車駅を取得する
  def stamped_at
    @name
  end
end

class GateTest < Minitest::Test
  def test_gate_umeda_to_juso
    umeda = Gate.new(:umeda)
    juso = Gate.new(:juso)

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
