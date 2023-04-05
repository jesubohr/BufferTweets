class SessionsController < ApplicationController
  def new
    user = User.find_by(id: session[:user_id]) if session[:user_id]
    return unless user.present?

    redirect_to root_path, flash: {
      alert_title: 'You are already logged in',
      alert_message: 'You can log out in your profile.',
      alert_type: 'info'
    }
  end

  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      logged_in
    else
      not_logged_in
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: {
      alert_title: 'You have been logged out',
      alert_message: 'Come back soon!',
      alert_type: 'info'
    }
  end

  private

  def logged_in
    redirect_to root_path, flash: {
      alert_title: 'You have been logged in',
      alert_message: 'Welcome back!',
      alert_type: 'success'
    }
  end

  def not_logged_in
    redirect_to sign_in_path, flash: {
      alert_title: 'Invalid email or password',
      alert_message: 'Please try again!',
      alert_type: 'error'
    }
  end
end
