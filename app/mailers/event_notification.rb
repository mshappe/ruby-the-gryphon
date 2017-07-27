class EventNotification < ApplicationMailer
  def notify_submitter(user, event)
    @submitter = event.submitter_persona
    @user = user
    @event = event
    mail to: user.email, subject: 'Your submission has been received' unless user.blank? || user.email.blank?
  end

  def notify_submitter_update(event)
    @submitter = event.submitter_persona
    @user = @submitter.try :user
    @event = event
    mail to: @user.email, subject: "Your submission has been #{event.submission_state}" unless @user.blank? || @user.email.blank?
  end
end
