import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carrier"
export default class extends Controller {
  static targets = ["toggle"]

  toggle() {
    const status = this.toggleTarget.checked
    const csrfToken = document.querySelector("meta[name=csrf-token]").content

    fetch("/carriers/update_availibilty", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({ is_available: status }),
    })
      .then((response) => {
        if (response.ok) {
          alert('availibilty updated')
        } else {
          alert('availibilty not updated')
        }
      })
      .catch((error) => {
        console.error("Error:", error)
      })
  }
}
