require 'spec_helper'

describe Event do
  before { @event = Event.new(name: 'event_name', details: 'event_details', date: Date.new) }

  subject { @event }

  it { should respond_to(:name) }
  it { should respond_to(:details) }
  it { should respond_to(:date) }

  it { should be_valid }

  describe "when name is not present" do
    before { @event.name = '' }
    it { should_not be_valid }
  end

  describe "when details are not present" do
    before { @event.details = '' }
    it { should_not be_valid }
  end

  describe "when date is not present" do
    before { @event.date = nil }
    it { should_not be_valid }
  end
end
