require 'minitest/autorun'

class Gate
  STATIONS = [:umeda, :juso, :mikuni]
  FARES = [160, 190]

  def initialize(name)
    @name = name
  end

  # ticketに自分の駅名を記録する
  def enter(ticket)
    ticket.stamp(@name)
  end

  # 切符の運賃が正しいか検証する
  def exit(ticket)
    fare = calc_fare(ticket)
    fare <= ticket.fare
  end

  private

  def calc_fare(ticket)
    from = STATIONS.index(ticket.stamped_at)
    to = STATIONS.index(@name)
    distance = (to - from).abs
    FARES[distance - 1]
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
  def setup
    @umeda = Gate.new(:umeda)
    @juso = Gate.new(:juso)
    @mikuni = Gate.new(:mikuni)
    @ticket = Ticket.new(160)
  end

  def test_gate_umeda_to_juso
    @umeda.enter(@ticket)
    assert @juso.exit(@ticket)
  end

  def test_gate_umeda_to_mikuni_when_fare_is_not_enough
    @umeda.enter(@ticket)
    refute @mikuni.exit(@ticket)
  end
end
