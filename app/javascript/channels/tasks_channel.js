import consumer from "channels/consumer"

consumer.subscriptions.create("TasksChannel", {
  connected() { },

  disconnected() { },

  received(data) {
    const event = new CustomEvent("taskChanged", { detail: data })
    window.dispatchEvent(event)
  }
})
