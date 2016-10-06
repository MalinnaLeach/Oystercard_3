class JourneyLog

  attr_reader :live_journey, :journey_list

  def initialize
    @live_journey = nil
    @journey_list = []
  end

  def start(entry_station)
    @live_journey = Journey.new(entry_station)
  end

  def finish(exit_station)

  end

  def journeys

  end

  def current_journey
    start(nil) unless @live_journey
    return @live_journey
  end

end
