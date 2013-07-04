class Event < ActiveRecord::Base
  belongs_to :user

  validates :name, 
            :details, 
            :date, presence: true

  SECONDS_PER_HOUR = 3600


  def check_for_reminder
    if time_to_event.between?(72, 96)
      UserMailer.delay(
        run_at: (time_to_event - 72).floor.hours.from_now).
          event_reminder(user, self)
    end
  end

  def check_for_notification
    if time_to_event.between?(0, 24)
      UserMailer.delay(
        run_at: time_to_event.floor.hours.from_now).
        event_notification(user, self)
    end
  end

  private

  def time_to_event
    (notification_datetime.to_time - user_time.to_time) / SECONDS_PER_HOUR
  end

  def notification_datetime
    DateTime.new(user_time.year, 
                 notification_date.month,
                 notification_date.day, 
                 6)
  end

  def notification_date
    date.in_time_zone(user.time_zone)
  end

  def user_time
    user.current_time
  end

end


