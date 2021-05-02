<template>
  <div id="container">
    <div id="modal-container">
      <div class="content"></div>
    </div>
  </div>
</template>
<script>
// import * as d3 from "d3";

export default {
  name: "CaseModal",
  data() {
    return {};
  },
};
</script>
<style scoped>
#container {
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  margin: auto;
  position: fixed;
  width: 100%;
  background-color: rgba(0, 0, 0, 0.427);
}
#modal-container {
  width: 700px;
  height: 900px;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  margin: auto;
  padding: 5px 50px 25px 50px;
  border-radius: 15px;
  background-color: whitesmoke;
  position: fixed;
  overflow-y: auto;
  z-index: 99999;
}

.content {
  width: 699px;
  height: 699px;
  overflow-y: scroll;
  padding-right: 50px;
}
</style>