/*eslint-disable*/
<template>
<div class="wrapper">
<USMap />
<Timeline />
</div>
</template>
<script>
import USMap from "../components/USMap.vue";
import Timeline from "../components/Timeline.vue";

export default {
  name: "Guided",
  components:{
    USMap, Timeline,
  }
}
</script>
<style scoped>

.wrapper{
  background-color: rgba(230, 185, 150, 0.75);
}
</style>
