<template>
  <div id="app" class="row justify-content-between">
    <div class="col-md-9 col-xs-12">
      Question will be here
    </div>
    <div class="col-md-3 col-xs-12">
      <b-list-group>
        <b-list-group-item v-for="roomUser in roomUsers" class="user-row">
          {{ roomUser.user.name }}
          <b-badge v-if="roomUser.admin" variant="primary" class="user-row__admin">Admin</b-badge>
          <b-badge v-if="roomUser.online" class="user-row__online" pill></b-badge>
        </b-list-group-item>
      </b-list-group>
    </div>
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
        } else if (message === 'user_online') {
          component.markUserOnline(data);
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
    },
    markUserOnline({ id }) {
      this.roomUsers = this.roomUsers.map((roomUser) => {
        if (roomUser.id === id) {
          return {
            ...roomUser,
            online: true
          }
        }

        return roomUser;
      });
    }
  }
}
</script>

<style lang="scss" scoped>
  .user-row__online {
    background: chartreuse;
    display: inline-block;
    height: 10px;
    padding: 0;
    width: 10px;
  }
</style>
