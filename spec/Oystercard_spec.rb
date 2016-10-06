require "Oystercard.rb"


describe Oystercard do

  subject(:card) {described_class.new}
  subject(:topped_up_card) {described_class.new}
  subject(:touched_in_card) {described_class.new}

  let(:station) {double :station}
  let(:exit_station) {double :station}
  let(:entry_station) {double :station}

  before do
    @top_up_amount = 10
    topped_up_card.top_up(@top_up_amount)
    touched_in_card.top_up(@top_up_amount)
    touched_in_card.touch_in(:station)
  end

it "returns list of journeys to be empty" do
  expect(card.list_journeys).to eq []
end

it "should have a balance of zero" do
  expect(card.balance).to eq 0
end

it "should top up the card" do
  expect(topped_up_card.balance).to eq @top_up_amount
end

it "should raise an error if the top up limit is reached" do
  expect {card.top_up(Oystercard::MAXIMUM_LIMIT + 1)}.to raise_error("The maximum top up value of #{Oystercard::MAXIMUM_LIMIT} has been reached!")
end

it "should check minimum balance" do
  expect {card.touch_in(station)}.to raise_error "Insufficient funds"
end

it "should charge the card for the minimum fare" do
  expect {touched_in_card.touch_out(station)}.to change{touched_in_card.balance}.by(-Journey::MINIMUM_FARE)
end

it 'should charge the penalty fare if journey incomplete' do
  expect {card.touch_out(station)}.to change{card.balance}.by(-Journey::PENALTY)
end

it "returns journey history" do
  test_journey = touched_in_card.current_journey
  touched_in_card.touch_out(station)
  expect(touched_in_card.list_journeys).to eq [test_journey]
end

end
