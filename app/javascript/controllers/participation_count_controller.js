import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { eventId: Number }

  connect() {
    this.subscription = createConsumer().subscriptions.create(
      { channel: "EventParticipationsChannel", event_id: this.eventIdValue },
      {
        received: (data) => {
          this.element.outerHTML = data.html
        }
      }
    )
  }

  disconnect() {
    this.subscription?.unsubscribe()
  }
}
