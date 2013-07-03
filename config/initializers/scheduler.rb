scheduler = Rufus::Scheduler.start_new

scheduler.every '24h' do
  ReminderFinder.go.delay
end

