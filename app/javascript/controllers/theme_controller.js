import { Controller } from "@hotwired/stimulus"

const STORAGE_KEY = "oshi_techo_theme"

export default class extends Controller {
  static values = { authenticated: Boolean }

  connect() {
    if (!this.authenticatedValue) {
      const saved = localStorage.getItem(STORAGE_KEY)
      if (saved) {
        document.documentElement.setAttribute("data-theme", saved)
      }
    }
  }

  change(event) {
    const theme = event.currentTarget.dataset.theme
    document.documentElement.setAttribute("data-theme", theme)

    if (this.authenticatedValue) {
      fetch("/theme", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        },
        body: JSON.stringify({ theme }),
      })
    } else {
      localStorage.setItem(STORAGE_KEY, theme)
    }
  }
}
