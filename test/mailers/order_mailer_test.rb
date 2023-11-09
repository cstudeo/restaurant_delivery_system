require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "new_order_mail" do
    mail = OrderMailer.new_order_mail
    assert_equal "New order mail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
