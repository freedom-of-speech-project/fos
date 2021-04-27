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
    <div id="utbh-cont">
      <div class="utbh-content">
        <span class="close">( X )</span>
        <p>Content</p>
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
      states: [],
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
      console.log(path);
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
    ]).then(([statesdata]) => {
      this.states = statesdata;
      console.log("states: ", this.states);
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

.aster-help {
  -webkit-appearance: none;
  appearance: none;
  border: 0px;
  background-color: rgba(0, 0, 0, 0);
}

.aster-tips {
  height: 200px;
  width: 300px;
  position: absolute;
  background-color: white;
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

#utbh-cont {
  position: fixed;
  top: 22%;
  left: 33%;
  z-index: 1;
  background-image: url("../assets/images/backgroundbox.png");
  background-size: cover;
  background-repeat: no-repeat;
  width: 25%;
  height: 30%;
  padding: 50px;
  margin: auto;
  text-align: center;
}

#utbh-cont::before {
  display: none;
}

.utbh-content {
  top: 25%;
  left: 25%;
}

.close {
  color: #aaa;
  float: right;
  font-size: 14px;
  font-weight: bold;
}

.close::hover,
.close::focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
</style>
