
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

  def touch_out(station)
    finish_journey(station)
    deduct
    save_reset
  end

  def finish_journey(station)
    @current_journey = Journey.new(nil) unless @current_journey
    @current_journey.finish(station)
  end

  def save_reset
    @journeys << @current_journey
    @current_journey = nil
  end

  def list_journeys
    @journeys
  end

private

  def deduct
    @balance -= @current_journey.fare
  end

end
