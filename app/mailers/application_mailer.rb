# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@northshield.org'
  layout 'mailer'
end
