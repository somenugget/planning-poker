<template>
  <h6>
    <a :href="url">{{ url }}</a>
    <b-button size="sm" :disabled="copied" variant="outline-primary" @click="copyUrlToClipboard">
      {{ copied ? 'copied' : 'copy to clipboard'}}
    </b-button>
  </h6>
</template>

<script>
export default {
  props: {
    url: String
  },
  data () {
    return {
      copied: false
    };
  },
  methods: {
    copyUrlToClipboard ({ target }) {
      target.blur();
      navigator.clipboard.writeText(this.url)
        .then(() => {
          this.copied = true;

          setTimeout(() => {
            this.copied = false;
          }, 3000);
        })
        .catch(() => console.log('Link was not copied to clipboard'));
    }
  }
};
</script>
