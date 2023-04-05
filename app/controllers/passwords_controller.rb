# Purpose: To allow users to change their password
class PasswordsController < ApplicationController
  before_action :require_login

  def edit; end

  def update
    if Current.user.update(password_params)
      redirect_to root_path, flash: {
        alert_title: 'Success',
        alert_message: 'Your password has been updated.',
        alert_type: 'success'
      }
    else
      render :edit, status: 400
    end
  end
end
