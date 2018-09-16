<template>
  <div id="app" class="row justify-content-between">
    <div class="col-md-9 col-xs-12">
      {{ question.content }}
    </div>
    <div class="col-md-3 col-xs-12">
      <users-list :roomUsers="roomUsers"></users-list>
    </div>
  </div>
</template>

<script>
import ActionCable from 'actioncable';
import UsersList from './UsersList';

const messageToMethodMapping = {
  user_joined: 'addRoomUser',
  user_online: 'markUserOnline',
  user_offline: 'markUserOffline'
};

export default {
  components: {
    'users-list': UsersList
  },
  props: {
    id: Number,
    name: String,
    question: Object,
    room_users: Array,
    current_user: Object
  },
  mounted() {
    const wsPath = document.querySelector('meta[name="action-cable-url"]').content || '/websocket';
    const wsBaseUrl = `ws://${location.host}`;
    const cable = ActionCable.createConsumer(`${wsBaseUrl}${wsPath}`);
    const component = this;

    this.channel = cable.subscriptions.create({ channel: 'RoomChannel', room_id: this.id }, {
      received({ message, data }) {
        console.log(message, data);
        if (typeof component[messageToMethodMapping[message]] === 'function') {
          component[messageToMethodMapping[message]](data);
        }
      }
    });
  },
  data: function () {
    return {
      roomUsers: [...this.room_users],
      timersToMarkOffline: {}
    }
  },
  methods: {
    addRoomUser(roomUser) {
      this.roomUsers = [...this.roomUsers, roomUser];
    },
    markUserOnline({ id }) {
      clearTimeout(this.timersToMarkOffline[id]);
      this.changeRoomUserInList(id, { online: true });
    },
    markUserOffline({ id }) {
      this.timersToMarkOffline[id] = setTimeout(() => {
        this.changeRoomUserInList(id, { online: false });
      }, 1000);
    },
    changeRoomUserInList(id, newRoomUser) {
      this.roomUsers = this.roomUsers.map((roomUser) => {
        if (roomUser.id === id) {
          return {
            user: {
              ...roomUser.user,
              ...newRoomUser.user
            },
            ...roomUser,
            ...newRoomUser
          }
        }

        return roomUser;
      });
    }
  }
}
</script>

<style lang="scss" scoped></style>
