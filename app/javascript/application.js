// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener("DOMContentLoaded", initializeDrawer);
document.addEventListener("turbo:load", initializeDrawer);


function initializeDrawer() {
  const drawerButton = document.querySelector('[data-drawer-show="drawer-example"]');
  const drawer = document.querySelector('#drawer-example');
  const closeButton = document.querySelector('[data-drawer-hide="drawer-example"]');

  // This is just an example. Your actual logic to show/hide the drawer might be different.
  drawerButton.addEventListener('click', () => {
      drawer.style.transform = 'translateX(0)'; // Show the drawer
  });

  closeButton.addEventListener('click', () => {
      drawer.style.transform = 'translateX(-100%)'; // Hide the drawer
  });
}
