# Purpose: To handle password reset requests
class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])
    redirect_to root_path, flash: {
      alert_title: 'Password reset email sent!',
      alert_message: 'If an account exists with that email, you will receive a password reset email shortly.',
      alert_type: 'info'
    }
    return unless @user.present?

    PasswordMailer.with(user: @user).reset.deliver_later
  end
end
