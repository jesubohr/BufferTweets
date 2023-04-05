# Purpose: To handle password reset requests
class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])
    email_sent_redirect
    return unless @user.present?

    PasswordMailer.with(user: @user).reset.deliver_later
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    invalid_token_redirect
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    invalid_token_redirect
  else
    return render :edit, status: 400 unless passwords_not_empty? || passwords_equal?

    if @user.update(password_params)
      password_reset_redirect
    else
      render :edit, status: 400
    end
  end

  private

  def passwords_not_empty?
    return if password_params.values.all?(&:present?)

    @user.errors.add(:password, 'must be present')
    false
  end

  def passwords_equal?
    return if password_params[:password] == password_params[:password_confirmation]

    @user.errors.add(:password, 'must be equal to password confirmation')
    false
  end

  def email_sent_redirect
    redirect_to root_path, flash: {
      alert_title: 'Password reset email sent!',
      alert_message: 'If an account exists with that email, you will receive a password reset email shortly.',
      alert_type: 'info'
    }
  end

  def password_reset_redirect
    redirect_to sign_in_path, flash: {
      alert_title: 'Password reset!',
      alert_message: 'Your password has been reset. Please sign in.',
      alert_type: 'success'
    }
  end

  def invalid_token_redirect
    redirect_to sign_in_path, flash: {
      alert_title: 'Invalid token!',
      alert_message: 'The password reset link you used is invalid. Please try again!',
      alert_type: 'error'
    }
  end
end
