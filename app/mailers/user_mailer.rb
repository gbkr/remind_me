class UserMailer < ActionMailer::Base
  default from: "remind_me@example.com"

  def event_reminder(user, event)
    @event = event
    subject = "3 DAY REMINDER: #{event.name}"
    mail(to: user.email, subject: subject)
  end

  def event_notification(user, event)
    @event = event
    subject = "REMINDER: #{event.name}"
    mail(to: user.email, subject: subject)
  end
end
