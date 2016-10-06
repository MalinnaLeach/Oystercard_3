
class Oystercard

  attr_reader :balance, :current_journey
  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1


  def initialize
    @balance = 0
    @journeys = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "The maximum top up value of #{MAXIMUM_LIMIT} has been reached!" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_BALANCE
    @current_journey = Journey.new(station)
  end

  # def in_journey?
  #   !!@entry_station
  # end

  def touch_out(station)
    deduct(Journey::MINIMUM_FARE)
    @journeys << @current_journey
    @current_journey = nil
  end

  def list_journeys
    @journeys
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
