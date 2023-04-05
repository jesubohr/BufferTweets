# Purpose: To create a new user
class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      signed_up_redirect
    else
      render :new, status: 400
    end
  end

  private

  def signed_up_redirect
    redirect_to root_path, flash: {
      alert_title: 'Thank you for signing up!',
      alert_message: 'You are now signed up and logged in.',
      alert_type: 'success'
    }
  end
end
