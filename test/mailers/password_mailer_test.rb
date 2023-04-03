require 'test_helper'

# Purpose: To test the password mailer
class PasswordMailerTest < ActionMailer::TestCase
  test 'reset' do
    user = User.find_by(email: 'lordex@rails.com')
    mail = PasswordMailer.with(user:).reset
    assert_equal 'Password reset', mail.subject
    assert_equal ['lordex@rails.com'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi Lordex', mail.body.encoded
  end
end
