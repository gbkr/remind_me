class ReminderFinder

  SECONDS_PER_HOUR = 3600

  def self.go
    User.all.each do |user|
      next unless user.confirmed?
      user.events.each { |event|
        check_user_event(user, event) }
    end
  end


  private

  def self.check_user_event(user, event)
    user_time = Time.zone.now.in_time_zone(user.time_zone)
    notification_date = event.date.in_time_zone(user.time_zone)

    # aim to send the reminder at 6am
    notification_dt = DateTime.new(user_time.year, 
                                   notification_date.month, 
                                   notification_date.day, 
                                   6)

    time_to_event = (notification_dt.to_time - user_time.to_time) / SECONDS_PER_HOUR
    return if time_to_event < 0

    if time_to_event <= 96 and time_to_event > 72
#      time_to_reminder = time_to_event - 72
      #  UserMailer.delay(run_at: time_to_reminder.floor.hours.from_now).
      #    event_reminder(user, event)

      UserMailer.delay.event_reminder(user, event)


    elsif time_to_event <= 24 
      UserMailer.delay.event_notification(user, event)

      # UserMailer.delay(run_at: time_to_event.floor.hours.from_now).
      #   event_notification(user, event)
    end
  end
end

