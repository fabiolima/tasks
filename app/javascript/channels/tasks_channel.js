import consumer from "channels/consumer"

consumer.subscriptions.create("TasksChannel", {
  connected() {
    console.log("conecetei")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    console.log("desconenct")
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("aoba", data)
    // Called when there's incoming data on the websocket for this channel
  }
});
