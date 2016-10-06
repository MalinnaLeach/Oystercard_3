
class Journey

 PENALTY = 6
 MINIMUM_FARE = 1

attr_reader :entry_station, :exit_station

def initialize(entry_station = nil)
  @entry_station = entry_station
end

def finish(station = nil)
  @exit_station = station
end

def change_in_station(station)
  @exit_station = station
end

def fare
  complete? ? MINIMUM_FARE : PENALTY
end

def complete?
    entry_station && exit_station
end

end
