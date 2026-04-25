import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  change(event) {
    const theme = event.currentTarget.dataset.theme
    document.documentElement.setAttribute("data-theme", theme)

    fetch("/theme", {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: JSON.stringify({ theme }),
    })
  }
}
