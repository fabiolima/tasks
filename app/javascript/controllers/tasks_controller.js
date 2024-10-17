import { Controller } from "@hotwired/stimulus"
import 'pretty-print-json'

export default class extends Controller {
  static targets = ["results"]

  connect() {
    window.addEventListener("taskChanged", this.onTaskChanged.bind(this))
  }

  disconnect() {
    window.removeEventListener("taskChanged", this.onTaskChanged.bind(this))
  }

  onTaskChanged(event) {
    const html = window.prettyPrintJson.toHtml(event.detail);
    this.resultsTarget.innerHTML = html
  }
}
