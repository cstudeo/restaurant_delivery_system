import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="order"
export default class extends Controller {
  connect() {
  }

  onClick(event) {
    // debugger
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

  createAndPay() {
    console.log('createAndPay');
    const csrfToken = document.querySelector("meta[name='csrf-token']").content;
    const url = `/orders`;

    fetch(url, {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    })
      .then((response) => {
        if (response.ok) {
          console.log("order created")
          return response.json();
        } else {
          console.error("Error:", response);
          return response.json();
        }
      })
      .then((data) => {
        if (data.error) {
          alert(`Error: ${data.error}`);
        } else {
          this.payWithPaystack(data.order_id)
        }
      });
  }


  async payWithPaystack(order_id) { 
    const paystack = new PaystackPop();

    paystack.newTransaction({
      key: 'pk_test_deebbde4eab19e1f1dd98af8f68c04553d379249',
      email: 'umer.butt@devsinc.com',
      amount: 10000,

      onSuccess: (transaction) => { 
        console.log(transaction.response);
        this.updateOrderStatus(order_id);
      }
      // callback: function(response) {
      //   var reference = response.reference;
      //   const csrfToken = document.querySelector("meta[name='csrf-token']").content;
      //   var transactionUrl = `https://api.paystack.co/transaction/verify/${reference}`;
      //   var paystackKey = "sk_test_REDACTED";
    
      //   fetch(transactionUrl, {
      //       method: "GET",
      //       headers: {
      //         "X-CSRF-Token": csrfToken,
      //         "Authorization": "Bearer " + paystackKey,
      //       },
      //   })
      //     .then(response => response.json())
      //     .then(data => {
      //       if (data.status) {
      //         console.log("updateOrderStatus");
      //         console.log(order_id);
      //         this.updateOrderStatus(order_id);
      //       } else {
      //         this.deleteOrder(order_id);
      //       }
      //     });
      // }
    });
  }

  async updateOrderStatus(order_id) {
    try {
        const csrfToken = document.querySelector("meta[name='csrf-token']").content;
        const url = `/orders/${order_id}`;

        const response = await fetch(url, {
            method: "PATCH",
            headers: {
                "X-CSRF-Token": csrfToken,
                "Accept": "application/json",
                "Content-Type": "application/json",
            },
        });

        if (!response.ok) {
            throw new Error(`Failed to update order status: ${response.status}`);
        }

        const data = await response.json();

        window.location.href = `/orders/${order_id}`;
    } catch (error) {
        console.error(error);
    }
  }


  deleteOrder(order_id) {
    const csrfToken = document.querySelector("meta[name='csrf-token']").content;
    const url = `/orders/${order_id}`;

    fetch(url, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Accept": "text/html",
        "Content-Type": "text/html",
      },
    });
  }
}
