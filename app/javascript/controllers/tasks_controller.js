import { Controller } from "@hotwired/stimulus"
import 'pretty-print-json'

export default class extends Controller {
  static targets = ["results", "taskId", "emptyMessage"]
  static values = { taskId: String, taskStatus: String, result: String }

  connect() {
    window.addEventListener("taskChanged", this.onTaskChanged.bind(this))
    if (this.resultValue && this.taskStatusValue === "completed") this.renderResult(this.resultValue);
  }

  disconnect() {
    window.removeEventListener("taskChanged", this.onTaskChanged.bind(this))
  }

  onTaskChanged(event) {
    const task = event.detail.task

    // Skip if current task details page is not the page of updated task
    if (task.id.toString() !== this.taskIdValue.toString()) return;

    this.render(event.detail.html)
  }

  renderResult(result) {
    if (!this.resultsTarget) return;
    const html = window.prettyPrintJson.toHtml(JSON.parse(result));
    this.resultsTarget.innerHTML = html
  }

  render(html) {
    this.element.innerHTML = html;
  }
}
