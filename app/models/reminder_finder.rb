class ReminderFinder

  def self.go
    User.all.each do |user|
      next unless user.confirmed?
      user.events.each { |event|
        check_event(event) }
    end
  end

  private

  def self.check_event(event)
    event.check_for_reminder
    event.check_for_notification
  end

end
