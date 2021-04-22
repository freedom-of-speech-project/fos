<template>
  <div class="map-container">
    <div class="topbar">
      <div class="aster-cont">
        <button @click="asterClick" class="aster-help">
          <img
            :height="height * 0.1"
            :width="width * 0.1"
            src="../assets/Iconography/asterrisk.svg"
          />
        </button>
        <div class="aster-tips">Here if you need me lol</div>
      </div>
      <div class="descr"><h2>Click outside the map to explore</h2></div>
    </div>
    <div id="map">
      {{ usMap() }}
      <img
        src="../assets/images/drawnmapwhite.svg"
        class="img-map"
        :height="height"
      />
    </div>
  </div>
</template>
<script>
import * as d3 from "d3";

const width = window.innerWidth;
const height = window.innerHeight * 0.7;
const margin = { top: 20, bottom: 50, left: 60, right: 40 };

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
      const projection = d3
        .geoAlbersUsa()
        .fitSize([width, height * 0.98], this.states);
      const path = d3.geoPath().projection(projection);
      console.log(path);
      this.svg = d3
        .select("#map")
        .append("svg")
        .attr("width", width)
        .attr("height", height * 0.75);
      console.log("testing: ", this.states);
      this.svg
        .selectAll(".states")
        .data(this.states.features)
        .join("path")
        .attr("d", path)
        .attr("class", "state")
        .attr("fill", "white")
        .attr("stroke", "black");
    },
    asterClick: function () {
      console.log("aster helping!");
    },
  },
  created() {
    Promise.all([
      d3.json(
        "https://raw.githubusercontent.com/jramadani/observable-data/master/gz_2010_us_outline_20m.json",
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
.map-container {
  height: 85vh;
  overflow-x: hidden;
}

.topbar {
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  margin-top: 5px;
}

.aster-cont {
  grid-column-start: 1;
  justify-self: start;
  position: fixed;
}

.aster-help {
  -webkit-appearance: none;
  appearance: none;
  border: 0px;
  background-color: rgba(0, 0, 0, 0);
}

.aster-tips {
  display: none;
  height: 200px;
  width: 300px;
  position: absolute;
  background-color: white;
  margin-left: 100px;
}

.descr {
  grid-column-start: 2;
}

#map {
  margin: auto;
  position: relative;
  z-index: 99999 !important;
}

.img-map {
  position: absolute;
  margin-left: 21.5%;
}
</style>
