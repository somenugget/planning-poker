<template>
  <div id="app">
    <p v-for="roomUser in roomUsers">
      {{ roomUser['admin?'] ? 'Admin: ' : '' }}
      {{ roomUser.user.name }}
    </p>
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
      received({ message, data }) {
        console.log(message, data);
        if (message === 'user_joined') {
          component.addRoomUser(data)
        }
      }
    });
  },
  data: function () {
    return {
      roomUsers: [...this.room_users]
    }
  },
  methods: {
    addRoomUser(roomUser) {
      this.roomUsers = [...this.roomUsers, roomUser];
    }
  }
}
</script>

<style scoped>

</style>
