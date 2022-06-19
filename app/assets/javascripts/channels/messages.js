App.messages = App.cable.subscriptions.create('MessagesChannel', {
  received: function(data) {
    return $('#messages').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
    return `<ul>
              <li>${data.name}</li>
              <li>${data.city}</li>
            </ul>`;
  }
});
