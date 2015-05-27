class EventNotification < ApplicationMailer
  def notify_submitter(user, event)
    @user = user
    @event = event
    mail to: user.email, subject: 'Your submission has been received'
  end

  def notify_submitter_update(event)
    @user = event.submitter_persona.user
    @event = event
    mail to: @user.email, subject: "Your submission has been #{event.submission_state}"
  end
end
