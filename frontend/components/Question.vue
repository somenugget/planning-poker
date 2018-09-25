<template>
  <div class="row">
    <div class="col-sm-12">
      {{ question }}
    </div>
  </div>
</template>

<script>
export default {
  props: {
    question: String
  }
};
</script>
