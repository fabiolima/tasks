import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use"

export default class Notification extends Controller {
  timeout;
  enter;
  leave;
  transitioned;
  handler = this.onTaskChanged.bind(this);

  static targets = ["text", "link", "errorIcon", "successIcon"]

  static values = {
    delay: {
      type: Number,
      default: 3000,
    },
    hidden: {
      type: Boolean,
      default: false,
    }
  }

  initialize() {
    this.hide = this.hide.bind(this)
  }

  connect() {
    useTransition(this)

    window.addEventListener("taskChanged", this.handler)

    if (this.hiddenValue === false) {
      this.show()
    }
  }

  disconnect() {
    window.removeEventListener("taskChanged", this.handler)
  }

  handleTaskCompleted(task) {
    this.textTarget.innerText = `Task ${task.title} was updated.`
    this.linkTarget.href = `/tasks/${task.id}`

    this.errorIconTarget.classList.add("hidden")
    this.successIconTarget.classList.remove("hidden")

    this.show();
  }

  handleTaskError(task) {
    this.textTarget.innerText = `Task ${task.title} has an error.`
    this.linkTarget.href = `/tasks/${task.id}`

    this.errorIconTarget.classList.remove("hidden")
    this.successIconTarget.classList.add("hidden")

    this.show();
  }

  onTaskChanged(event) {
    const task = event.detail.task

    switch (task.status) {
      case "completed": 
        this.handleTaskCompleted(task); break;
      case "error":
        this.handleTaskError(task); break;
    }
  }

  show() {
    this.enter()

    this.timeout = setTimeout(this.hide, this.delayValue)
  }

  async hide() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }

    await this.leave()
  }
}
