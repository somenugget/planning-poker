<template>
  <div id="app" class="row justify-content-between">
    <div class="col-md-9 col-xs-12">
      <div class="row">
        <div class="col-sm-12">
          {{ question.content }}
        </div>
      </div>
      <estimations :estimation-options="estimation_options" :room-user="currentRoomUser"/>
    </div>
    <div class="col-md-3 col-xs-12">
      <users-list :roomUsers="roomUsers"></users-list>
    </div>
  </div>
</template>

<script>
import ActionCable from 'actioncable';
import UsersList from './UsersList';
import Estimations from './Estimations';

const messageToMethodMapping = {
  user_joined: 'addRoomUser',
  user_online: 'markUserOnline',
  user_offline: 'markUserOffline',
  user_voted: 'markUserVoted',
};

export default {
  components: {
    'users-list': UsersList,
    'estimations': Estimations,
  },
  props: {
    id: Number,
    name: String,
    question: Object,
    room_users: Array,
    current_user: Object,
    estimation_options: Array,
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
  data() {
    return {
      roomUsers: [...this.room_users],
      timersToMarkOffline: {}
    }
  },
  computed: {
    currentRoomUser() {
      return this.room_users.find(roomUser => roomUser.user.id === this.current_user.id);
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
    markUserVoted(roomUser) {
      this.changeRoomUserInList(roomUser.id, roomUser);
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
