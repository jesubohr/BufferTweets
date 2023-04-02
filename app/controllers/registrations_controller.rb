# Purpose: To create a new user
class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:alert_title] = 'Thank you for signing up!'
      flash[:alert_message] = 'You are now signed up and logged in.'
      flash[:alert_type] = 'success'
      redirect_to root_path
    else
      render :new, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
