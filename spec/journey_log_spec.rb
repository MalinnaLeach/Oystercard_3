require 'journey_log'

describe JourneyLog do

  let(:station) {double :station}

  it 'should create a new journey with the start method' do
    subject.start(station)
    expect(subject.live_journey.entry_station).to eq station
  end

  it 'should return the live journey if journey started' do
    subject.start(station)
    expect(subject.current_journey).to eq subject.live_journey
  end

  it 'should return a new live journey if journey not already present' do
    subject.current_journey
    expect(subject.live_journey.entry_station).to eq nil
  end

  it "should add an exit station to the current journey" do
    subject.start(station)
    subject.finish(station)
    expect(subject.live_journey.exit_station).to eq station
  end

  it "should return a list of all previous journeys" do
    expect(subject.journeys).to eq []
  end

end
