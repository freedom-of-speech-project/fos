<template>
  <div id="page-container">
    <div class="map-container">
      <div class="topbar">
        <div class="aster-cont">
          <button @click="aster = !aster" class="aster-help">
            <img
              :height="height * 0.07"
              :width="width * 0.099"
              src="../assets/Iconography/asterrisk.svg"
            />
          </button>
          <div v-show="aster" class="aster-tips">Here if you need me lol</div>
        </div>
        <div class="descr">
          <h2>Click outside the box to explore the map</h2>
        </div>
      </div>
      <div id="map">
        <!-- for the map overlays try this: https://stackoverflow.com/a/1997397/14336451 -->
        {{ usMap() }}
      </div>
    </div>
    <!-- <button class="modal-close">
            <span class="close">( X )</span>
          </button> -->
    <!-- v-if="guided == true" @click="guided = !guided"  -->
    <!-- <div id="utbhc-cont">
      <div id="utbh-cont">
        <button><div class="guided-nav left">&lt;</div></button>
        <div class="utbh-content">
          <div class="guided-content"><p>Content</p></div>
        </div>
        <button><div class="guided-nav right">&gt;</div></button>
      </div>
    </div> -->
  </div>
</template>
<script>
import * as d3 from "d3";

const width = window.innerWidth;
const height = window.innerHeight;
const margin = { top: 20, bottom: 0, left: 60, right: 40 };

export default {
  name: "USMap",
  props: ["guided"],
  data() {
    return {
      width,
      height,
      margin,
      aster: false,
      // guided: true,
      states: [],
      landmarks: [],
    };
  },
  methods: {
    usMap: function () {
      console.log(this.landmarks);
      if (this.svg) {
        this.svg.remove();
      }

      this.img = d3
        .select("#map")
        .append("img")
        .attr(
          "src",
          "https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-joanne/src/assets/images/filledinusmap.svg"
        )
        .attr("class", "img-map")
        .attr("height", height * 0.4883)
        .style("position", "absolute");

      const projection = d3
        .geoAlbersUsa()
        .fitSize([width * 0.99, height * 0.49], this.states);
      const path = d3.geoPath().projection(projection);
      this.svg = d3
        .select("#map")
        .append("svg")
        .attr("width", width * 0.99)
        .attr("height", height * 0.525)
        .attr("class", "map-overlay")
        .style("position", "relative")
        .style("z-index", "999999");
      this.svg
        .selectAll(".states")
        .data(this.states.features)
        .join("path")
        .attr("d", path)
        .attr("class", "state")
        .attr("fill", "none")
        .attr("stroke", "none");

      this.svg
        .selectAll(".gavin")
        .data(this.landmarks)
        .join("svg")
        .attr("width", "24")
        .attr("height", "34")
        .attr("viewBox", "0 0 24 34")
        .attr("fill", "none")
        .html(
          `<rect x="4.7998" y="1.61914" width="14.4" height="9.71429" rx="3" fill="#DC7A46"/>
<rect x="19.7334" width="4.26666" height="12.6825" rx="2.13333" fill="#DC7A46"/>
<rect x="9.8667" y="12.1428" width="4.26666" height="21.8571" rx="2.13333" fill="#DC7A46"/>
<rect width="4.26667" height="12.6825" rx="2.13333" fill="#DC7A46"/>`
        )
        .attr("fill-opacity", "40%")
        .attr("transform", (d) => {
          const [x, y] = projection([d.long, d.lat]);
          return `translate(${x}, ${y})`;
        })
        // .style("z-index", 99999)
        .on("mouseover", () => {
          // console.log(this.landmarks.caseName);
          console.log("i'm gavin");
        });
    },
  },
  mounted() {
    Promise.all([
      d3.json(
        "https://raw.githubusercontent.com/jramadani/observable-data/master/gz_2010_us_040_00_20m.json",
        d3.autoType
      ),
      d3.csv(
        "https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-joanne/public/landmark_latlong_final.csv",
        d3.autoType
      ),
    ]).then(([statesdata, landmarkdata]) => {
      this.states = statesdata;
      this.landmarks = landmarkdata;
      console.log("states: ", this.states);
      console.log("landmarks: ", this.landmarks);
    });
  },
};
</script>
<style scoped>
#page-container {
  position: relative;
  height: 67vh;
  overflow-x: hidden;
}

.map-container {
  position: relative;
}

.topbar {
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  margin-top: 5px;
}

.aster-cont {
  padding-top: 15px;
  grid-column-start: 1;
  justify-self: start;
  position: relative;
}

button {
  -webkit-appearance: none;
  appearance: none;
  border: 0px;
  background-color: rgba(0, 0, 0, 0);
}

.aster-tips {
  height: 200px;
  width: 300px;
  background-image: url("../assets/Iconography/asterspeech.png");
  position: fixed;
  margin-left: 100px;
  z-index: 99999;
}

.descr {
  grid-column-start: 2;
}

#map {
  margin: auto;
  position: relative;
  top: 0px;
  left: 0px;
  display: flex;
  justify-content: center;
}

#utbhc-cont {
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  margin: auto;
  position: fixed;
  width: 100%;
  background-color: rgba(0, 0, 0, 0.427);
}

#utbh-cont {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  z-index: 1;
  background-image: url("../assets/images/backgroundbox.png");
  background-size: cover;
  background-repeat: no-repeat;
  width: 532px;
  height: 375px;
  padding: 40px;
  margin: auto;
  display: grid;
  grid-template-columns: 50px auto 50px;
}

.utbh-content {
  height: 250px;
  text-align: center;
}

.guided-nav {
  height: 25px;
  width: 25px;
  background-color: #b5bbc0;
  color: white;
  border-radius: 50%;
  position: fixed;
  font-size: 18px;
  font-family: Caveat Brush, sans-serif;
}

.guided-nav:hover {
  background-color: #3d6fee;
}

.left {
  grid-column-start: 1;
}

.right {
  grid-column-end: 3;
}

.close {
  color: #aaa;
  float: right;
  font-size: 14px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
</style>
