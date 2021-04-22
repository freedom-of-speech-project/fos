<template>
  <!-- <img alt="Vue logo" src="./assets/logo.png" /> -->
  <div class="header">
    <span class="title">Freedom of Speech*</span>
    <span></span>
    <img class="info" src="./assets/Info.svg" />
  </div>
  <!-- <Intro /> -->
  <Guided />
</template>

<script>
// import * as d3 from "d3"
// import Intro from "./pages/Intro.vue";
import Guided from "./pages/Guided.vue";


export default {
  name: "App",
  components: {
    // Intro,
    Guided
  },
  data(){
    return{
    guidedtext: "-> Guided Mode",
    exploretext: "-> Explore Mode"
    }
  },

};
</script>

<style>
/*eslint-disable*/
body {
  margin: 0px;
  padding: 0px;
}

#app {
  font-family: Caveat Brush;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  display: grid;
  /* margin-top: 60px; */
}
.header {
  height: 8vh;
  background-color: #0022d9;
  color: white;
  display: grid;
  grid-template-columns: 200px auto 40px;
  align-content: center;
}

.title {
  justify-self: center;
}
.info {
  justify-self: start;
}

h1 {
  font-family: Fredericka the Great, serif;
}
</style>
