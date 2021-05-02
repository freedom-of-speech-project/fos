<template>
  <div class="timeline-wrapper">
    <div class="tog-wrapper">
      <label class="toggle">
        <input type="checkbox" /><span class="slider round"></span> </label
      ><span class="toglabel">Explore by era (Guided experience)</span>
    </div>
    <div id="timeline">
      <img style="position: absolute" src="../assets/Iconography/tlarrow.svg" />
    </div>
  </div>
</template>
<script>
import * as d3 from "d3";

const width = window.innerWidth;
const height = window.innerHeight;
const margin = { top: 0, bottom: 0, left: 50, right: 460 };

export default {
  name: "Timeline",
  data() {
    return { width, height, margin, explore: false };
  },
  methods: {
    eras: function () {
      const x = d3
        .scaleLinear()
        .domain([1900, 2020])
        .range([margin.left, width - margin.right]);

      const xAxis = d3.axisBottom(x);

      this.svg = d3
        .select("#timeline")
        .append("svg")
        .attr("class", "tl")
        .attr("width", width * 0.7)
        .attr("height", height * 0.05)
        .style("position", "relative");

      this.svg
        .append("g")
        .attr("class", "axis x-axis")
        .attr("transform", `translate(0, 20)`)
        .call(xAxis)
        .selectAll("text")
        .style("text-anchor", "start")
        .attr("dx", "-3em")
        .attr("dy", ".5em");

      // this.svg.append("rect").attr("class", "era").attr("fill", "blue");

      this.svg
        .append("rect")
        .attr("y", "0")
        .attr("x", "50")
        .attr("width", "90")
        .attr("height", "45")
        .attr("fill", "#3d6fee")
        .attr("fill-opacity", "40%")
        .on("mouseover", function () {
          d3.selectAll("rect").attr("fill-opacity", "90%");
        })
        .on("mouseout", function () {
          d3.selectAll("rect").attr("fill-opacity", "40%");
        });
    },
  },
  mounted() {
    this.eras();
  },
};
</script>
<style scoped>
.timeline-wrapper {
  height: 20vh;
}

.tog-wrapper {
  display: grid;
  grid-template-columns: 200px 1fr 1fr auto;
}

.toglabel {
  font-size: 25px;
  padding-left: 10px;
  grid-column: 2;
  justify-self: start;
}

/* toggle styles */

.toggle {
  position: relative;
  display: inline-block;
  width: 55px;
  height: 30px;
  justify-self: end;
  grid-column: 1;
}

.toggle input {
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #3d6fee;
  border: 3px solid #7ba6f1;
  -webkit-transition: 0.4s;
  transition: 0.4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 26px;
  bottom: 0px;
  background-color: white;
  -webkit-transition: 0.7s;
  transition: 0.7s;
}

input:checked + .slider {
  background-color: #53605f;
  border: 3px solid #7f8887;
}

input:checked + .slider:before {
  -webkit-transform: translateX(-26px);
  -ms-transform: translateX(-26px);
  transform: translateX(-26px);
}

.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}

/* timeline styles */

#timeline {
  background-color: white;
  margin: 20px 140px 20px 140px;
  padding: 30px 0px 30px 0px;
  border-radius: 20px;
  position: relative;
}
</style>
