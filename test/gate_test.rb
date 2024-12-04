require 'minitest/autorun'

class Gate
  STATIONS = [:umeda, :juso, :mikuni]
  FARES = [160, 190]

  def initialize(name)
    @name = name
  end

  # 切符に乗車駅を記録する
  def enter(ticket)
    ticket.stamp(@name)
  end

  # 切符の運賃が正しいか検証する
  def exit(ticket)
    fare = calc_fare(ticket)
    fare <= ticket.fare
  end

  private

  # 乗車駅と現在の駅から実際の運賃を計算する
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

  # 乗車駅を記録する
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
  end

  def test_gate_umeda_to_juso
    ticket = Ticket.new(160)
    @umeda.enter(ticket)
    assert @juso.exit(ticket)
  end

  def test_gate_umeda_to_mikuni_when_fare_is_not_enough
    ticket = Ticket.new(160)
    @umeda.enter(ticket)
    refute @mikuni.exit(ticket)
  end

  def test_gate_umeda_to_mikuni_when_fare_is_enough
    ticket = Ticket.new(190)
    @umeda.enter(ticket)
    assert @mikuni.exit(ticket)
  end

  def test_gate_juso_to_mikuni_when_fare_is_enough
    ticket = Ticket.new(160)
    @juso.enter(ticket)
    assert @mikuni.exit(ticket)
  end
end
