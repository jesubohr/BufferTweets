class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  # Add a before_action to set the current user
  # if the user is logged in
  before_action :set_current_user

  # Add a helper_method to make the method available in views
  helper_method :logged_in?

  private

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    Current.user.present?
  end

  def require_login
    return if logged_in?

    redirect_to sign_in_path, flash: {
      alert_title: 'You must be logged in to do that',
      alert_message: 'Please log in or sign up.',
      alert_type: 'error'
    }
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
