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
        <img
          src="../assets/images/drawnmapoutline.svg"
          class="img-map"
          :width="width / 2.109"
        />
      </div>
    </div>
    <div v-if="guided == true" @click="guided = !guided" id="utbhc-cont">
      <div id="utbh-cont">
        <button><div class="guided-nav left">&lt;</div></button>
        <div class="utbh-content">
          <!-- <button class="modal-close">
            <span class="close">( X )</span>
          </button> -->
          <div class="guided-content"><p>Content</p></div>
        </div>
        <button><div class="guided-nav right">&gt;</div></button>
      </div>
    </div>
  </div>
</template>
<script>
import * as d3 from "d3";

const width = window.innerWidth;
const height = window.innerHeight;
const margin = { top: 20, bottom: 0, left: 60, right: 40 };

export default {
  name: "USMap",
  data() {
    return {
      width,
      height,
      margin,
      aster: false,
      guided: true,
      states: [],
      landmarks: [],
    };
  },
  methods: {
    usMap: function () {
      if (this.svg) {
        this.svg.remove();
      }
      const projection = d3
        .geoAlbersUsa()
        .fitSize([width * 0.99, height * 0.49], this.states);
      const path = d3.geoPath().projection(projection);
      this.svg = d3
        .select("#map")
        .append("svg")
        .attr("width", width * 0.99)
        .attr("height", height * 0.525)
        .attr("class", "map-overlay");
      this.svg
        .selectAll(".states")
        .data(this.states.features)
        .join("path")
        .attr("d", path)
        .attr("class", "state")
        .attr("fill", "white")
        .attr("stroke", "white");

      this.svg
        .selectAll("circle")
        .data(this.landmarks)
        .join("circle")
        .attr("r", 3)
        .attr("fill", "black")
        .attr("transform", (d) => {
          const [x, y] = projection([d.long, d.lat]);
          return `translate(${x}, ${y})`;
        })
        .style("z-index", 99999)
        .on("mouseover", (d) => {
          console.log(d.caseName);
        });
    },
    asterClick: function () {
      console.log("aster helping!");
    },
  },
  created() {
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
}

.map-overlay {
  position: relative;
  top: 0px;
  left: 0px;
}

.img-map {
  position: absolute;
  margin: 0% 0% 0% 26%;
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
