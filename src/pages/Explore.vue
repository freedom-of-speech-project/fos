<template>
  <div class="header-explore">
    <div class="header-relevant"># relevant cases</div>
    <div>
      <img
        style="position: relative; width: 75%"
        src="../assets/Iconography/topic-tag.svg"
      />
    </div>
    <div class="dropdown">
      <button class="dropbtn">
        <img
          style="position: relative; width: 90%"
          src="../assets/Iconography/select-dropdown.svg"
        />
      </button>
      <div class="dropdown-content">
        <!-- <a href="#">case name</a>
        <a href="#">year</a> -->
        <img
          style="position: absolute"
          src="../assets/Iconography/dropdown-menu.svg"
        />
      </div>
    </div>
    <!-- year / alpha / -->
    <div class="dropdown">
      <button class="dropbtn">
        <img
          style="position: relative; width: 90%"
          src="../assets/Iconography/view-as-button.svg"
        />
      </button>
      <div class="dropdown-content">
        <!-- <a href="#">case name</a>
        <a href="#">year</a> -->
        <img
          style="position: absolute"
          src="../assets/Iconography/dropdown-menu.svg"
        />
      </div>
    </div>
  </div>
  <img
    class="header-border-line"
    style="width: 99%"
    src="../assets/Iconography/border-line.svg"
  />

  <div class="wrapper-explore">
    <div class="sidebar">
      <div class="sidebar-item text">topic</div>
      <button type="button" class="sidebar-item topic">
        <img
          style="position: relative"
          src="../assets/Iconography/caret-down.svg"
        />
      </button>
      <img
        class="border-line"
        src="../assets/Iconography/sidebar-border-line.svg"
      />
      <span />
      <div class="sidebar-item-hidden">hi</div>
      <div class="sidebar-item-hidden">okay</div>
      <div class="sidebar-item year text">year</div>
      <button type="button" class="sidebar-item">
        <img
          style="position: relative"
          src="../assets/Iconography/caret-down.svg"
        />
      </button>

      <img
        class="border-line"
        src="../assets/Iconography/sidebar-border-line.svg"
      />
      <span />
      <div class="sidebar-item location text">location</div>
      <button type="button" class="sidebar-item">
        <img
          style="position: relative"
          src="../assets/Iconography/caret-down.svg"
        />
      </button>
      <!--div class="toggle-wrapper"-->
      <img
        class="border-line"
        src="../assets/Iconography/sidebar-border-line.svg"
      />
      <span />
      <div class="sidebar-item text">landmark case</div>
      <label class="switch sidebar-item">
        <input type="checkbox" />
        <span class="slider round"></span>
      </label>
      <img
        class="border-line"
        src="../assets/Iconography/sidebar-border-line.svg"
      />
      <span />
      <!--/div>
      <div class="toggle-wrapper"-->
      <div class="sidebar-item text">protected speech</div>
      <label class="switch sidebar-item">
        <input type="checkbox" />
        <span class="slider round"></span>
      </label>
      <img
        class="border-line"
        src="../assets/Iconography/sidebar-border-line.svg"
      />
      <span />
      <!--/div-->
    </div>

    <div class="content-explore">
      {{ card() }}
      <!-- <div class="card">
        {{ card() }}
        <button type="button" class="ruling-btn" v-on:click="caseModal">
          <img style="width: 75%" src="../assets/Iconography/ruling-btn.svg" />
        </button>
        <img class="topic-tag" src="../assets/Iconography/topic-tag.svg" />
        < should this topic tag be a button that re-arranges by topic? nice to have** >
      </div> -->
    </div>
  </div>
</template>
<script>
/* import { defineComponent } from "@vue/composition-api";

export default defineComponent({
  setup() {},
});
*/
import * as d3 from "d3";

export default {
  name: "Explore",
  props: ["caseData"],
  //{data: Object,}
  data() {
    return {
      msg: "hi from Explore component",
      title: "caseName",
      cases: [],
    };
  },
  methods: {
    takeMeToGuided: function () {
      console.log("did that work");
    },
    takeMeToExplore: function () {
      console.log("of course it did");
    },
    card: function () {
      console.log("card method");

      this.svg = d3
        .select(".content-explore")
        .selectAll("card")
        .data(this.cases)
        .join("div")
        .text(function (d) {
          return d.caseName + "  (year)";
        })
        .attr("class", "card")
        .style("margin", "auto")
        .style("margin-top", "5%")
        .style("position", "relative")
        .style(
          "background-image",
          'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/utb.svg")'
        )
        .style("background-size", "cover")
        .style("width", "85%");

      //.style("height", " 3.style(5%");

      // .style("position", "relative")
      // .style("top", "25%")
      // .style("left", " 12%")
      // .style("right", " 12%")
      // .style("margin-left", "auto")
      // .style("margin-right", " auto");

      console.log("this svg", this.svg);

      this.svg;

      //console.log("this svg again", this.svg);

      /**
      this.svg = d3
        .select(".content-explore")
                .selectAll("card")

        .append("div")
        .attr("id", "card-content")
        .style("position", "absolute")
        .style("top", "25%")
        .style("left", " 12%")
        .style("right", " 12%")
        .style("margin-left", "auto")
        .style("margin-right", " auto");

      console.log("this svg", this.svg);

      this.svg
        .data(this.cases)
        .join("text")
        .text(function (d) {
          return d.caseName;
        });
      console.log("this svg again", this.svg);
 */
    },
    caseModal: function () {
      console.log("show me the case");
    },
  },
  created() {
    Promise.all([d3.csv("/merged-tm-10-by-20-3.csv", d3.autoType)]).then(
      ([caseData]) => {
        this.cases = caseData;
        //console.log("cases: ", this.cases);
      }
    );
  },
  computed: {
    nameData() {
      const caseTitle = this.data;
      //console.log("caseTitle", caseTitle);
      return { caseTitle };
    },

    // return {
    //   caseName: this.data[1].caseName,
    // };
    // },
  },
};
</script>
<style scoped>
.header-explore {
  height: 8vh; /* will this need a media query? */
  min-height: 30px;
  width: 100%;
  background-color: white;
  /* border-bottom: 2px solid gray; */
  display: grid;
  grid-template-columns: auto auto auto auto /* 150px auto auto 150px*/;
  align-content: center;
}

/* Dropdown Button */
.dropbtn {
  /* background-color: white(207, 206, 206);
  color: black;
  border: none;
  font-family: Caveat Brush;
  font-size: 16px;
  border: 1px solid gray;
  padding: 0 5% 0 5%; */
}
.header-relevant {
  font-size: 1.5em;
}
/* The container <div> - needed to position the dropdown content */
.dropdown {
  position: relative;
  display: inline-block;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {
  background-color: #ddd;
}

/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
  display: block;
}

/* Change the background color of the dropdown button when the dropdown content is shown */
.dropdown:hover .dropbtn {
  background-color: #e6b996;
}

/* wrapper for sidebar and content */
.wrapper-explore {
  margin: 0;
  padding: 0;
  top: 17vh; /** .header height + .header-explore height // IDEALLY we could add min-height: 70px so it matches the min heights but not sure how to do that rn*/
  background-color: white;
  position: fixed;
  height: 100%;
  width: 100%;
  overflow: auto;
  /* border: 1px solid gray; */
  display: grid;
  grid-template-columns: 1fr 4fr;
}

.sidebar {
  /* border: 1px solid pink; */
  min-width: 200px;
  padding-top: 10px;
  display: grid;
  grid-template-columns: 4fr 1fr;
  max-height: 100%;
  align-content: flex-start;
  row-gap: 4px;
}

img.border-line {
  width: 140%;
  height: 20px;
}

/** sidebar list items */
.sidebar-item {
  height: 40px;
  /* border: 1px solid pink; */
}

.sidebar-item.text {
  padding-top: 5%;
  /* border: 1px solid pink; */
}

.sidebar-item-hidden {
  display: none;
}

.sidebar-item-hidden::after {
  display: block;
}

/** button styling */
button {
  border: none;
  color: black;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  cursor: pointer;
  background-color: white;
}

/* The switch - the box around the slider */
.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
  transform: scale(0.7);
}

/* Hide default HTML checkbox */
.switch input {
  opacity: 0;
  width: 0;
  height: 0;
}

/* The slider */
.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: 0.4s;
  transition: 0.4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: 0.4s;
  transition: 0.4s;
}

input:checked + .slider {
  background-color: #e6b996;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196f3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}

.content-explore {
  /* border: 1px solid pink; */
  /* background-color: #e6b996; */
  background-color: #e6b996;
}

div.card {
  margin: auto;
  margin-top: 5%;
  position: relative;
  background-image: url("../assets/Iconography/utb.svg");
  background-size: 100% 100%;
  width: 85%;
  height: 35%;
}

/** styled in d3.append */
/* #card-content {
  position: absolute;
  top: 25%;
  left: 12%;
  right: 12%;
  margin-left: auto;
  margin-right: auto;
  /* font-size: 1.25em; */
/* set min and max font sizes for re-sizing *
} */

.ruling-btn {
  position: absolute;
  bottom: 25%;
  left: 12%;
  right: 12%;
  margin-left: auto;
  margin-right: auto;
}

img.topic-tag {
  position: absolute;
  bottom: 15%;
  width: 10%;
  left: 12%;
  right: 12%;
  margin-left: auto;
  margin-right: auto;
}
</style>
