<template>
  <!-- <img alt="Vue logo" src="./assets/logo.png" /> -->
  <div class="header">
    <span class="title">Freedom of Speech*</span>
    <span></span>
    <img class="info" src="./assets/Info.svg" />
  </div>
  <!--Intro /-->
  <Explore />

  <!-- <USMap /> -->
  <!-- <HelloWorld msg="Welcome to Your Vue.js App" /> -->
</template>

<script>
// import HelloWorld from "./components/HelloWorld.vue";
//import Intro from "./pages/Intro.vue";
import Explore from "./pages/Explore.vue";

// import USMap from "./components/USMap.vue"
// import { defineComponent } from '@vue/composition-api'

export default {
  name: "App",
  components: {
    //Intro,
    Explore,
    // USMap
  },
};
</script>

<style>
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
  min-height: 40px;
  background-color: #0022d9;
  color: white;
  display: grid;
  grid-template-columns: 200px auto 40px;
  align-content: center;
  /** drop shadow?? */
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
