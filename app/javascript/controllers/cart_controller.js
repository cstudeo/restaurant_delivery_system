import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  connect() {
    console.log("cart_controller.js");
  }

  showModal() {
    const modal = document.querySelector('#default-modal');
    modal.classList.remove('hidden');
  }

  session_decrement(e) {
    const id = parseInt(e.target.dataset.id);
    const input = document.querySelector(`#food-quantity-${id}`);
    const quantity = parseInt(input.innerHTML);
    const newQuantity = quantity - 1;
    const price = parseFloat(e.target.dataset.price);
    
    if (newQuantity === 0) {
      this.deleteSessionItem(id);
    } else {
      this.sessionUpdate(id, newQuantity, price)
    }
  }

  session_increment(e) {
    const id = parseInt(e.target.dataset.id);
    const input = document.querySelector(`#food-quantity-${id}`);
    const quantity = parseInt(input.innerHTML);
    const newQuantity = quantity + 1;
    const price = parseFloat(e.target.dataset.price);

    this.sessionUpdate(id, newQuantity, price)
  }

  sessionUpdate(id, newQuantity, price) {
    const csrfToken = document.querySelector("meta[name='csrf-token']").content;
    const url = `/order_items/${id}?quantity=${newQuantity}`;
  
    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    })
      .then((response) => {
        if (response.ok) {
          const quantityElement = document.querySelector(`#food-quantity-${id}`);
          quantityElement.innerText = newQuantity;

          const totalElement = document.querySelector(`#item-total-${id}`);
          totalElement.innerText = `NGN ${(newQuantity * price).toFixed(2)}`;
          return response.json();
        } else {
          console.error("Error:", response);
          return null;
        }
      })
      .then((data) => {
        if (data) {
          const cartTotalElement = document.querySelector('#grand-total');
          cartTotalElement.innerText = `Total: NGN ${data.grand_total}`;
        }
      });
  }

  deleteSessionItem(id) {
    const csrfToken = document.querySelector("meta[name='csrf-token']").content;
    const url = `/order_items/${id}`;

    fetch(url, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    })
      .then((response) => {
        if (response.ok) {
          const orderItemDiv = document.querySelector(`#order-item-${id}`);
          orderItemDiv.remove();
          
          const cartCountElement = document.querySelector("#cart-count");
          cartCountElement.innerText = parseInt(cartCountElement.innerText) - 1;
          return response.json();
        } else {
          console.error("Error:", response);
        }
      })
      .then((data) => {
        if (data) {
          const cartTotalElement = document.querySelector('#grand-total');
          cartTotalElement.innerText = `Total: NGN ${data.grand_total}`;
        }
        if (data.grand_total == 0.0) {
          document.querySelector(".place-order-btn").remove()
        }
      });
  }

  decrement(e) {
    const id = parseInt(e.target.dataset.id);
    const input = document.querySelector(`#food-quantity-${id}`);
    const quantity = parseInt(input.innerHTML);
    const newQuantity = quantity - 1;

    if (newQuantity === 0) {
      this.deleteOrderItem(id);
    } else {
      this.updateQuantity(id, newQuantity);
    }
  }

  increment(e) {
    const id = parseInt(e.target.dataset.id);
    const input = document.querySelector(`#food-quantity-${id}`);
    const quantity = parseInt(input.innerHTML);
    const newQuantity = quantity + 1;

    this.updateQuantity(id, newQuantity);
  }

  deleteOrderItem(id) {
    const csrfToken = document.querySelector("meta[name='csrf-token']").content;
    const url = `/order_items/${id}`;

    fetch(url, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    })
      .then((response) => {
        if (response.ok) {
          const orderItemDiv = document.querySelector(`#order-item-${id}`);
          orderItemDiv.remove();

          return response.json();
        } else {
          console.error("Error:", response);
        }
      })
      .then((data) => {
        if (data) {
          const cartTotalElement = document.querySelector('#grand-total');
          cartTotalElement.innerText = `Total: NGN ${data.grand_total}`;

          const cartCountElement = document.querySelector("#cart-count");
          cartCountElement.innerText = data.cart_count;
          if (data.grand_total == 0.0) {
            document.querySelector(".place-order-btn").remove()
          }
        }
      });
  }

  updateQuantity(id, newQuantity) {
    const csrfToken = document.querySelector("meta[name='csrf-token']").content;
    const url = `/order_items/${id}?quantity=${newQuantity}`;
  
    fetch(url, {
      method: "PATCH",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    })
      .then((response) => {
        if (response.ok) {
          return response.json();
        } else {
          console.error("Error:", response);
          return null;
        }
      })
      .then((data) => {
        if (data) {
          const quantityElement = document.querySelector(`#food-quantity-${id}`);
          quantityElement.innerText = data.quantity;

          const totalElement = document.querySelector(`#item-total-${id}`);
          totalElement.innerText = `NGN ${data.item_total}`;
          
          const cartTotalElement = document.querySelector('#grand-total');
          cartTotalElement.innerText = `Total: NGN ${data.grand_total}`;
        }
      });
  }  
}
