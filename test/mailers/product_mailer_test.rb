require "test_helper"

class ProductMailerTest < ActionMailer::TestCase
  test "product_updates.html.haml" do
    mail = ProductMailer.product_updates.html.haml
    assert_equal "Product updates.html.haml", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
