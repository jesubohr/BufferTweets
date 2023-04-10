# Purpose: Create a new Twitter account for the current user
class OmniauthCallbacksController < ApplicationController
  def twitter
    twitter_account = Current.user.twitter_accounts.where(username: auth[:username]).first_or_initialize
    twitter_account.update(auth[:rest])

    if twitter_account.persisted?
      account_not_added_redirect
    else
      account_added_redirect
    end
  end

  private

  def auth
    user_info = request.env['omniauth.auth']['info']
    user_credentials = request.env['omniauth.auth']['credentials']
    data = user_info.deep_merge(user_credentials)
    data => { name:, nickname:, image:, token:, secret: }
    { username: nickname, rest: { name:, image:, token:, secret: } }
  end

  def account_not_added_redirect
    redirect_to root_path, flash: {
      alert_title: 'Twitter account not added',
      alert_message: 'You already have this account added.',
      alert_type: 'info'
    }
  end

  def account_added_redirect
    redirect_to root_path, flash: {
      alert_title: 'Twitter account added',
      alert_message: 'You can now use this account to post tweets.',
      alert_type: 'success'
    }
  end
end
