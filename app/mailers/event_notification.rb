# frozen_string_literal: true

class EventNotification < ApplicationMailer
  def notify_submitter(user, event)
    @submitter = event.submitter_persona
    @user = user
    @event = event
    mail to: user.email, subject: 'Your submission has been received'
  end

  def notify_submitter_update(event)
    @submitter = event.submitter_persona
    @user = @submitter.user
    @event = event
    mail to: @user.email, subject: "Your submission has been #{event.submission_state}"
  end
end
