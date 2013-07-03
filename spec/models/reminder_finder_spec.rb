require 'spec_helper'

describe ReminderFinder do
  before { ActionMailer::Base.deliveries.clear }

  let(:user) { User.create(email: 'user_email@example.com', confirmed_at: DateTime.now, time_zone: 'Pretoria') } 
  let(:event) { user.events.create(name: 'event_name', details: 'event_details', date: Date.today ) }


  it 'should not schedule notification when the event date is futher than 5 days in the future' do
    event.update_attribute(:date, event.date + 5.days)
    expect { ReminderFinder.go }.not_to change(DelayedJob, :count)
  end

  it 'should send a notification 3 days before the event' do
    event.update_attribute(:date, event.date + 4.days)
    expect {
      ReminderFinder.go
    }.to change { DelayedJob.count }.by(1)
  end

  it 'should not schedule notification before 3 days' do 
  event.update_attribute(:date, event.date + 3.days)
    expect { ReminderFinder.go }.not_to change(DelayedJob, :count)
  end

  it 'should schedule notification for the event' do
    event.update_attribute(:date, event.date + 1.day)
    expect {
      ReminderFinder.go
    }.to change { DelayedJob.count }.by(1)
  end
end
