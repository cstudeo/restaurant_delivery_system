# class PaymentsController < ApplicationController
#   def create
#     # public_key = Rails.application.credentials.paystack.public_key
#     # secret_key = Rails.application.credentials.paystack.secret_key
#     # paystackObj = Paystack.new(public_key, secret_key)
#     # transactions = PaystackTransactions.new(paystackObj)

#     # result = transactions.initializeTransaction(
#     #   :reference => "blablablabla-YOUR-UNIQUE-REFERENCE-HERE",
#     #   :amount => 30000 * 100,
#     #   :email => "customer@gmail.com",
#     #   :subaccount => "ACCT_li5noa8y5absim8",
#     #   :bearer => "subaccount",
#     #   :currency=> 'NGN',
#     #   :callback_url => "http://localhost:3000/"
#     #   )
#     # auth_url = result['data']['authorization_url']
#     # reference = result['data']['reference']
#     # redirect_to auth_url, allow_other_host: true
#     secret_key = Rails.application.credentials.paystack.secret_key
#     paystack_url = URI.parse('https://api.paystack.co/transaction/initialize')
#     http = Net::HTTP.new(paystack_url.host, paystack_url.port)
#     http.use_ssl = true

#     headers = {
#       'Authorization' => "Bearer #{secret_key}",
#       'Content-Type' => 'application/json'
#     }

#     data = {
#       'email' => 'customer@email.com',
#       'amount' => '20000',
#       'subaccount' => 'ACCT_li5noa8y5absim8',
#       'currency' => 'NGN',
#       'callback_url' => 'http://localhost:3000/'
#     }

#     request = Net::HTTP::Post.new(paystack_url.path, headers)
#     request.body = data.to_json
#     byebug
#     response = http.request(request)
#     response = JSON.parse(response.body)

#     if response["status"]
#       authorization_url = response["data"]["authorization_url"]
#       reference = response["data"]["reference"]
#       redirect_to authorization_url, allow_other_host: true
#     end
#   end
# end
