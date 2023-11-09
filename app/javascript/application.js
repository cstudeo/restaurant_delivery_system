// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener("DOMContentLoaded", initializeDrawer);
document.addEventListener("turbo:load", initializeDrawer);


function initializeDrawer() {
  const drawerButton = document.querySelector('[data-drawer-show="drawer-example"]');
  const drawer = document.querySelector('#drawer-example');
  const closeButton = document.querySelector('[data-drawer-hide="drawer-example"]');
  const modalButton = document.querySelector('[data-modal-target="default-modal"]');
  const modal = document.querySelector('#default-modal');
  const modalClose = document.querySelector('[data-modal-hide="default-modal"]');


  // This is just an example. Your actual logic to show/hide the drawer might be different.
  if (drawerButton) {
    drawerButton.addEventListener('click', () => {
        drawer.style.transform = 'translateX(0)'; // Show the drawer
    });
  }

  if (closeButton) {
    closeButton.addEventListener('click', () => {
        drawer.style.transform = 'translateX(-100%)'; // Hide the drawer
    });
  }

  if (modalButton) {
    modalButton.addEventListener("click", () => {
      modal.classList.remove('hidden');   
    })
  }

  if (modalClose) {
    modalClose.addEventListener("click", () => {
      modal.classList.add('hidden');
    })
  }
}

var navbar = document.getElementById('navbar');

  // Function to add or remove the transition class
  function toggleTransition() {
      if (window.scrollY >= 50) {
          navbar.classList.add('bg-white', 'shadow-md', 'transition-bg');
          navbar.classList.remove('bg-transparent');
      } else {
          navbar.classList.add('bg-transparent', 'transition-bg');
          navbar.classList.remove('bg-white', 'shadow-md');
      }
  }
  // Attach the scroll event listener
  window.addEventListener('scroll', toggleTransition);

  function closeFlashMessages() {
    const flashMessages = document.getElementById('flash-messages');
    flashMessages.style.display = 'none';
  }
