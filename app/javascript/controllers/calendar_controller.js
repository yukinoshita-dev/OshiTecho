import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { eventsUrl: String }

  connect() {
    if (typeof FullCalendar === "undefined") {
      // CDNが読み込まれるまで少し待つ
      setTimeout(() => this.initCalendar(), 200)
    } else {
      this.initCalendar()
    }
  }

  initCalendar() {
    const el = document.getElementById("calendar-container")
    if (!el || typeof FullCalendar === "undefined") return

    const themeColor = getComputedStyle(document.documentElement)
      .getPropertyValue("--color-primary").trim() || "#6366f1"

    this.calendar = new FullCalendar.Calendar(el, {
      initialView: "dayGridMonth",
      locale: "ja",
      headerToolbar: {
        left:   "prev,next today",
        center: "title",
        right:  "dayGridMonth,timeGridWeek"
      },
      height: "auto",
      events: this.eventsUrlValue,
      eventClick: (info) => this.showPopup(info),
      // テーマに合わせたスタイル
      eventDidMount: (info) => {
        info.el.style.cursor = "pointer"
        info.el.style.borderRadius = "4px"
        info.el.style.fontSize = "11px"
      }
    })

    this.calendar.render()
    this.applyThemeStyles()
  }

  showPopup(info) {
    const popup = document.getElementById("calendar-popup")
    const props  = info.event.extendedProps

    document.getElementById("popup-title").textContent = info.event.title
    document.getElementById("popup-oshi").textContent  = props.oshi ? `🌟 ${props.oshi}` : ""
    document.getElementById("popup-venue").textContent = props.venue ? `📍 ${props.venue}` : ""

    const link = document.getElementById("popup-link")
    if (props.url) {
      link.href = props.url
      link.classList.remove("hidden")
    } else {
      link.classList.add("hidden")
    }

    // クリック位置の近くに表示
    popup.style.top  = `${info.jsEvent.clientY + window.scrollY + 10}px`
    popup.style.left = `${Math.min(info.jsEvent.clientX, window.innerWidth - 270)}px`
    popup.classList.remove("hidden")
  }

  applyThemeStyles() {
    const bg     = getComputedStyle(document.documentElement).getPropertyValue("--color-bg").trim()
    const border = getComputedStyle(document.documentElement).getPropertyValue("--color-border").trim()
    const text   = getComputedStyle(document.documentElement).getPropertyValue("--color-text").trim()

    const style = document.createElement("style")
    style.textContent = `
      .fc { color: ${text}; }
      .fc .fc-toolbar-title { font-size: 1rem; }
      .fc .fc-col-header-cell { background: ${bg}; }
      .fc .fc-daygrid-day { background: ${bg}; }
      .fc .fc-daygrid-day.fc-day-today { background: var(--color-surface); }
      .fc th, .fc td { border-color: ${border} !important; }
      .fc .fc-button { background: var(--color-primary); border-color: var(--color-primary); font-size: 0.75rem; padding: 0.25rem 0.6rem; }
      .fc .fc-button:hover { background: var(--color-primary-hover); border-color: var(--color-primary-hover); }
      .fc .fc-button-active { background: var(--color-primary-hover) !important; }
    `
    document.head.appendChild(style)
  }

  disconnect() {
    this.calendar?.destroy()
  }
}
