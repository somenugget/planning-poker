<template>
  <b-list-group>
    <b-list-group-item v-for="roomUser in roomUsers" :key="roomUser.id" class="user-row">
      {{ roomUser.user.name }}
      <b-badge v-if="roomUser.admin" variant="primary" class="user-row__admin">Admin</b-badge>
      <b-badge v-if="roomUser.online" class="user-row__online" pill></b-badge>
      <b-badge v-if="roomUser.vote" class="user-row__voted float-right">
        {{ isClosed ? roomUser.vote.estimation : 'voted'}}
      </b-badge>
    </b-list-group-item>
    <b-list-group-item v-if="isClosed">
      Average vote:
      <b-badge variant="success" class="float-right">
        {{ average }}
      </b-badge>
    </b-list-group-item>
  </b-list-group>
</template>

<script>
export default {
  props: {
    isClosed: Boolean,
    average: Number,
    roomUsers: Array
  }
};
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
