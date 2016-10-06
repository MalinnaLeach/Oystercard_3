require "Oystercard.rb"


describe Oystercard do

  subject(:card) {described_class.new}
  let(:station) {double :station}
  let(:exit_station) {double :station}
  let(:entry_station) {double :station}


it "returns list of journeys to be empty" do
  expect(card.list_journeys).to eq []
end

it "should have a balance of zero" do
  expect(card.balance).to eq 0
end

it "should top up the card" do
  card.top_up(5)
  expect(card.balance).to eq 5
end

it "should raise an error if the top up limit is reached" do
  maximum = Oystercard::MAXIMUM_LIMIT
  card.top_up(maximum)
  expect {card.top_up(1)}.to raise_error("The maximum top up value of #{maximum} has been reached!")
end

it "should check minimum balance" do
  expect {card.touch_in(station)}.to raise_error "Insufficient funds"
end

it "should charge the card for the minimum fare" do
  card.top_up(15)
  card.touch_in(station)
  expect {card.touch_out(station)}.to change{card.balance}.by(-Journey::MINIMUM_FARE)
end

it 'should charge the penalty fare if journey incomplete' do
  expect {card.touch_out(station)}.to change{card.balance}.by(-Journey::PENALTY)
end

it "returns journey history" do
  card.top_up(5)
  card.touch_in(entry_station)
  test_journey = card.current_journey
  card.touch_out(exit_station)
  expect(card.list_journeys).to eq [test_journey]
end

end
