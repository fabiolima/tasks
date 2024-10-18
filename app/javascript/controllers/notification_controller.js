import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use"

export default class Notification extends Controller {
  actionUrl;
  timeout;
  enter;
  leave;
  transitioned;

  static targets = ["text", "link"]

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

    window.addEventListener("taskChanged", this.onTaskChanged.bind(this))

    if (this.hiddenValue === false) {
      this.show()
    }
  }

  disconnect() {
    window.removeEventListener("taskChanged", this.onTaskChanged.bind(this))
  }

  onTaskChanged(event) {
    const task = event.detail.task
    this.textTarget.innerText = `Task ${task.title} was updated.`
    this.linkTarget.href = `/tasks/${task.id}`

    this.show();
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