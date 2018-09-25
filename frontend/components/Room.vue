<template>
  <div id="app" class="row justify-content-between">
    <div class="col-md-9 col-xs-12">
      <div v-if="isCurrentUserAdmin">
        <link-to-share :url="link_to_share" />
        <b-button @click="finishVoting" variant="success">Finish voting</b-button>
        <hr />
      </div>
      <question :question="question.content" />
      <hr />
      <estimations
          :isClosed="isClosed"
          :estimation-options="estimation_options"
          :room-user="currentRoomUser"
      />
    </div>
    <div class="col-md-3 col-xs-12">
      <users-list
          :isClosed="isClosed"
          :roomUsers="roomUsers"
          :average="averageVote"
      />
    </div>
  </div>
</template>

<script>
import ActionCable from 'actioncable';
import LinkToShare from './LinkToShare';
import Question from './Question';
import Estimations from './Estimations';
import UsersList from './UsersList';
import api from '../utils/api';

const messageToMethodMapping = {
  user_joined: 'addRoomUser',
  user_online: 'markUserOnline',
  user_offline: 'markUserOffline',
  user_voted: 'markUserVoted'
};

export default {
  components: {
    'link-to-share': LinkToShare,
    'question': Question,
    'estimations': Estimations,
    'users-list': UsersList
  },
  props: {
    id: Number,
    average: Number,
    closed: Boolean,
    name: String,
    link_to_share: String,
    question: Object,
    room_users: Array,
    current_user: Object,
    estimation_options: Array
  },
  mounted () {
    const wsPath = document.querySelector('meta[name="action-cable-url"]').content || '/websocket';
    const wsBaseUrl = `ws://${location.host}`;
    const cable = ActionCable.createConsumer(`${wsBaseUrl}${wsPath}`);
    const component = this;

    this.channel = cable.subscriptions.create({ channel: 'RoomChannel', room_id: this.id }, {
      received ({ message, data }) {
        console.log(message, data);
        if (typeof component[messageToMethodMapping[message]] === 'function') {
          component[messageToMethodMapping[message]](data);
        }
      }
    });
  },
  data () {
    return {
      roomUsers: [...this.room_users],
      averageVote: this.average || 2,
      isClosed: this.closed || false,
      timersToMarkOffline: {}
    };
  },
  computed: {
    currentRoomUser () {
      return this.room_users.find(roomUser => roomUser.user.id === this.current_user.id);
    },
    isCurrentUserAdmin () {
      return this.currentRoomUser.admin;
    }
  },
  methods: {
    addRoomUser (roomUser) {
      this.roomUsers = [...this.roomUsers, roomUser];
    },
    markUserOnline ({ id }) {
      clearTimeout(this.timersToMarkOffline[id]);
      this.changeRoomUserInList(id, { online: true });
    },
    markUserOffline ({ id }) {
      this.timersToMarkOffline[id] = setTimeout(() => {
        this.changeRoomUserInList(id, { online: false });
      }, 1000);
    },
    markUserVoted (roomUser) {
      this.changeRoomUserInList(roomUser.id, roomUser);
    },
    changeRoomUserInList (id, newRoomUser) {
      this.roomUsers = this.roomUsers.map((roomUser) => {
        if (roomUser.id === id) {
          return {
            user: {
              ...roomUser.user,
              ...newRoomUser.user
            },
            ...roomUser,
            ...newRoomUser
          };
        }

        return roomUser;
      });
    },
    finishVoting () {
      api.closeRoom(this.id).then((result) => {
        this.isClosed = true;
        this.averageVote = result.average;
      });
    }
  }
};
</script>

<style lang="scss" scoped></style>
