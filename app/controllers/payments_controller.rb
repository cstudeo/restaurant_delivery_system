class PaymentsController < ApplicationController
  def create
    paystackObj = Paystack.new("pk_test_deebbde4eab19e1f1dd98af8f68c04553d379249", "sk_test_REDACTED")
    transactions = PaystackTransactions.new(paystackObj)

    result = transactions.initializeTransaction(
      # :reference => "blablablabla-YOUR-UNIQUE-REFERENCE-HERE",
      :amount => 30000 * 100,
      :email => "customer@gmail.com",
      :subaccount => "ACCT_li5noa8y5absim8",
      :bearer => "subaccount",
      :currency=> 'NGN',
      :callback_url => "http://localhost:3000/"
      )
    auth_url = result['data']['authorization_url']
    reference = result['data']['reference']
    redirect_to auth_url, allow_other_host: true

  end
end
