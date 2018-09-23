<template>
  <div class="row mt-3">
    <div class="col" v-for="estimationOption in estimationOptions" :key="estimationOption.id">
      <b-button
          block
          type="button"
          :disabled="isClosed || (estimationOption.id === voting)"
          :variant="estimationOption.id === voted ? 'primary' : 'outline-primary'"
          @click="vote(estimationOption)"
      >
        {{ estimationOption.label }}
      </b-button>
    </div>
  </div>
</template>

<script>
import api from '../utils/api';

export default {
  props: {
    isClosed: Boolean,
    estimationOptions: Array,
    roomUser: Object
  },
  mounted() {
    if (!this.roomUser.vote) {
      this.voted = null;
      return;
    }

    const option = this.estimationOptions.find(({ id, estimation }) => this.roomUser.vote.estimation === estimation);
    this.voted = option ? option.id : null;
  },
  data() {
    return {
      voted: null,
      voting: null
    }
  },
  methods: {
    vote({ id, estimation }) {
      this.voting = id;

      api
        .vote(this.roomUser.id, estimation)
        .then(() => {
          this.voted = id;
          this.voting = null;
        })
        .catch(() => this.voting = null);
    }
  }
}
</script>

<style lang="scss" scoped>

</style>
