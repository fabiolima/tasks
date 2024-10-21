import consumer from "channels/consumer"

consumer.subscriptions.create("TasksChannel", {
  connected() { },

  disconnected() { },

  received(task) {
    const event = new CustomEvent("taskChanged", { detail: task })
    window.dispatchEvent(event)
  }
})
