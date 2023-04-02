# Purpose: To create a new user
class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    render plain: params[:user], status: :ok
  end
end
