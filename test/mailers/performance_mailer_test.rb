require "test_helper"

class PerformanceMailerTest < ActionMailer::TestCase
  test "daily_mail" do
    mail = PerformanceMailer.daily_mail
    assert_equal "Daily mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "weekly_mail" do
    mail = PerformanceMailer.weekly_mail
    assert_equal "Weekly mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
