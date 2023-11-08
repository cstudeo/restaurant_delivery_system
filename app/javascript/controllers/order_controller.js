import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order"
export default class extends Controller {
  connect() {
    console.log('connected with order')
  }

  onClick(event) {
    debugger
    event.preventDefault();
    alert("Link was clicked!");
  }

  // payWithPaystack() {
  //   let handler = PaystackPop.setup({
  //     key: 'pk_test_deebbde4eab19e1f1dd98af8f68c04553d379249', // Replace with your public key
  //     email: 'umer.butt@devsinc.com',
  //     amount: 10 * 100, // the amount value is multiplied by 100 to convert to the lowest currency unit
  //     currency: 'NGN', // Use GHS for Ghana Cedis or USD for US Dollars
  //     // ref: 'YOUR_REFERENCE', // Replace with a reference you generated
  //     callback: function(response) {
  //       //this happens after the payment is completed successfully
  //       var reference = response.reference;
  //       alert('Payment complete! Reference: ' + reference);
  //       // Make an AJAX call to your server with the reference to verify the transaction
  //     },
  //     onClose: function() {
  //       alert('Transaction was not completed, window closed.');
  //     },
  //   });

  //   handler.openIframe();
  // }
  payWithPaystack() {
    const paystack = new PaystackPop();

    paystack.newTransaction({
      key: 'pk_test_deebbde4eab19e1f1dd98af8f68c04553d379249',
      email: 'umer.butt@devsinc.com',
      amount: 10000
    });
  }

}
