require "Oystercard.rb"

describe Oystercard do

  subject(:card) {described_class.new}

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

it 'should deduct the amount for the trip from balance' do
  card.top_up(15)
  card.deduct(10)
  expect(card.balance).to eq 5
end

it "should see if a card has touched out" do
  card.touch_out
  expect(card.in_journey?).to eq false
end

it "should check minimum balance" do
  expect {card.touch_in}.to raise_error "Insufficient funds"
end

it "should charge the card for the minimum fare" do
  card.top_up(15)
  card.touch_in
  expect {card.touch_out}.to change{card.balance}.by(-Oystercard::MINIMUM_FARE)
end

end
