<template>
  <!-- <div class="outer"><p>Test</p></div> -->
  <div class="title-header">
    <div class="friends">
      <img class="gavin" src="../assets/Iconography/gavinblock.svg" />
      <!-- {{ gavin }} -->
    </div>
    <h1 class="“title”">{{ title }}</h1>
    <div class="friends">
      <img class="aster" src="../assets/Iconography/asterrisk.svg" />
    </div>
  </div>
  <div class="mode-wrapper">
    <div class="explore">
      <div class="guide">
        <button @click="takeMeToExplore">explore</button>
      </div>
    </div>
    <div class="guided">
      <div class="guide">
        <button @click="takeMeToGuided">guide me through</button>
      </div>
    </div>
  </div>
  <!-- <div class="footer">
              <div class="ticker ticker-animated">
        <span class="highlighted">Congress shall make no law</span> respecting
        an establishment of religion, or prohibiting the free exercise thereof;
        <span class="highlighted">or abridging the freedom of speech,</span> or
        of the press; or the right of the people peaceably to assemble, and to
        petition the Government for a redress of grievances.
      </div>
    </div> -->
  <div></div>
</template>
<script>
export default {
  name: "Intro",
  // emits: ["takeMeToGuided", "takeMeToExplore"],
  // emits: {
  //   guided: function () {
  //     console.log("did that work");
  //     this.guided = !this.guided;
  //   },
  //   takeMeToExplore: function () {
  //     console.log("of course it did");
  //     this.explore = !this.explore;
  //     console.log(this.explore);
  //   },
  // },
  data() {
    return {
      gavin: "../assets/Iconography/gavin.svg",
      title: "Freedom of Speech* Project",
      aster: "../assets/Iconography/asterrisk.svg",
    };
  },
  methods: {
    takeMeToGuided: function () {
      console.log("did that work");
      this.guided = !this.guided;
    },
    takeMeToExplore: function () {
      console.log("of course it did");
      this.explore = !this.explore;
      console.log(this.explore);
    },
  },
};
</script>
<style scoped>
/* .outer{
    border:2px green;
} */
.title-header {
  display: grid;
  grid-template-columns: 200px auto 200px;
  margin: auto;
  padding: 30px 0px 50px 0px;
}

button {
  -webkit-appearance: none;
  appearance: none;
  border: 0px;
  background-color: rgba(0, 0, 0, 0);
  font-family: Caveat Brush, sans-serif;
  font-size: 18px;
  position: relative;
  margin: 10px;
}

.guide {
  background-image: url("../assets/Iconography/button1guide.svg");
  padding: 0px 15px 15px 40px;
  margin: 15px;
  background-repeat: no-repeat;
  position: absolute;
}

.friends {
  width: 100px;
  padding: 10px;
  align-content: center;
  margin-left: 30px;
}

.gavin {
  height: 4.5em;
  transform: scaleX(-1);
}

.aster {
  height: 4em;
}

.mode-wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-column-gap: 2.5%;
  padding: 0% 5% 0% 5%;
}

div.explore,
div.guided {
  border: 1px solid black;
  color: red;
  height: 200px;
  /**  display: grid;*/
}

.footer {
  height: 10vh;
  box-sizing: content-box;
  padding-top: 10px;
  /* line-height: 22px; */
  width: 100%;
  overflow: hidden;
  display: inline-block;
  box-sizing: content-box;
  /* text-transform: uppercase; */
}

.ticker {
  white-space: nowrap;
  -webkit-animation: ticker 80s linear 0s infinite normal;
  animation: ticker 80s linear 0s infinite normal;
}

@keyframes ticker {
  from {
    -webkit-transform: translate(100%, 0);
  }
  to {
    -webkit-transform: translate(-100%, 0);
  }
  90% {
  }
}

.highlighted {
  color: red;
}
</style>
