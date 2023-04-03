# Purpose: Send password reset email to user
class PasswordMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset.subject
  #
  def reset
    user = params[:user]
    @username = user.email.split('@').first.capitalize
    @token = user.signed_id(purpose: 'password_reset', expires_in: 15.minutes)

    mail to: user.email, subject: 'Password reset'
  end
end
