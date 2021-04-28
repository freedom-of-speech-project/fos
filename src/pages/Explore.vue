<template>
  <div class="header-explore">
    <div>relevant cases</div>
    <div>topics</div>
    <div class="dropdown">
      <button class="dropbtn">sort by:</button>
      <div class="dropdown-content">
        <a href="#">case name</a>
        <a href="#">year</a>
      </div>
    </div>
    <!-- year / alpha / -->
    <div>view cases | viz</div>
  </div>

  <!--div class="sidebar-explore">
    <a class="active" href="#home">Home</a>
    <a href="#news">News</a>
    <a href="#contact">Contact</a>
    <a href="#about">About</a>
  </div-->

  <div class="wrapper-explore">
    <div class="sidebar">
      <div class="sidebar-item text">topic</div>
      <button type="button" class="sidebar-item topic">></button>
      <div class="sidebar-item-hidden">hi</div>
      <div class="sidebar-item-hidden">okay</div>
      <div class="sidebar-item year text">year</div>
      <button type="button" class="sidebar-item">></button>
      <div class="sidebar-item location text">location</div>
      <button type="button" class="sidebar-item">></button>
      <!--div class="toggle-wrapper"-->
      <div class="sidebar-item text">landmark case</div>
      <label class="switch sidebar-item">
        <input type="checkbox" />
        <span class="slider round"></span>
      </label>
      <!--/div>
      <div class="toggle-wrapper"-->
      <div class="sidebar-item">protected speech</div>
      <label class="switch sidebar-item">
        <input type="checkbox" />
        <span class="slider round"></span>
      </label>
      <!--/div-->
    </div>

    <div class="content-explore">
      <div class="card">
        <span> card to be filled with data!</span>
      </div>
    </div>
  </div>
</template>
<script>
/* import { defineComponent } from "@vue/composition-api";

export default defineComponent({
  setup() {},
});
*/

export default {
  name: "Explore",
  data() {
    return {
      gavin: "gavin",
    };
  },
  methods: {
    takeMeToGuided: function () {
      console.log("did that work");
    },
    takeMeToExplore: function () {
      console.log("of course it did");
    },
  },
};
</script>
<style scoped>
.header-explore {
  height: 7vh; /* will this need a media query? */
  min-height: 30px;
  width: 100%;
  background-color: white;
  border-bottom: 2px solid gray;
  display: grid;
  grid-template-columns: 150px auto auto 150px;
  align-content: center;
}

/* Dropdown Button */
.dropbtn {
  background-color: white(207, 206, 206);
  color: black;
  border: none;
  font-family: Caveat Brush;
  font-size: 16px;
  border: 1px solid gray;
  padding: 0 5% 0 5%;
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
  background-color: pink;
}

/* wrapper for sidebar and content */
.wrapper-explore {
  margin: 0;
  padding: 0;
  top: 15vh; /** .header height + .header-explore height // IDEALLY we could add min-height: 70px so it matches the min heights but not sure how to do that rn*/
  background-color: white;
  position: fixed;
  height: 100%;
  width: 100%;
  overflow: auto;
  border: 1px solid gray;
  display: grid;
  grid-template-columns: 1fr 4fr;
}

.sidebar {
  border: 1px solid pink;
  min-width: 200px;
  display: grid;
  grid-template-columns: 4fr 1fr;
  max-height: 100%;
  align-content: flex-start;
}

/** sidebar list items */
.sidebar-item {
  height: 40px;
  border: 1px solid pink;
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
  background-color: #2196f3;
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
  border: 1px solid pink;
}

.card {
  width: 50%;
  margin: auto;
  margin-top: 5%;
  padding: 10%;
  border: 3px solid blue;
}
</style>
