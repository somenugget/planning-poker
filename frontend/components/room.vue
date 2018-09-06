<template>
  <div id="app">
    <p v-for="room_user in room_users">
      {{ room_user['admin?'] ? 'Admin: ' : '' }}
      {{ room_user.user.name }}
    </p>
    <p v-for="message in messages">{{ message }}</p>
    <input type="text" v-model="newMessage">
    <button v-on:click="sendMessage">Add</button>
  </div>
</template>

<script>
import ActionCable from 'actioncable';

export default {
  props: {
    name: String,
    room_users: Array,
    current_user: Object
  },
  mounted() {
    const wsPath = document.querySelector('meta[name="action-cable-url"]').content || '/websocket';
    const wsBaseUrl = 'ws://localhost:3000';
    const cable = ActionCable.createConsumer(`${wsBaseUrl}${wsPath}`);
    const component = this;

    this.channel = cable.subscriptions.create({ channel: 'RoomChannel', room_id: 5 }, {
      received(data) {
        component.appendMessage(data);
      }
    });
  },
  data: function () {
    return {
      newMessage: '',
      messages: ['Hello Vue!!!']
    }
  },
  methods: {
    appendMessage({ message }) {
      this.messages = [...this.messages, message];
    },
    sendMessage() {
      this.channel.send({ message: this.newMessage });
      this.newMessage = '';
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
