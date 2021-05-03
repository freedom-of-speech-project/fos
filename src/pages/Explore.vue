<template>
  <div class="header-explore">
    <div class="header-relevant"># relevant cases</div>
    <div class="header-topic">
      <img
        style="position: relative; height: 75%"
        src="../assets/Iconography/topic-tag.svg"
      />
    </div>
    <span></span>
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
          id="dropdown1"
          style="position: relative"
          src="../assets/Iconography/alpha-year-menu.svg"
        />
        <div>
          <button id="dropdown1-1" @click="sortByAlpha"></button>
        </div>
        <div><button id="dropdown1-2" @click="sortByYear"></button></div>
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
          style="position: absolute; right: 0"
          src="../assets/Iconography/dropdown-menu.svg"
        />
      </div>
    </div>
  </div>
  <img
    class="header-border-line"
    style="width: 99.9%"
    src="../assets/Iconography/border-line.svg"
  />

  <div class="wrapper-explore">
    <div class="sidebar">
      <div class="sidebar-item text">topic</div>
      <button type="button" class="sidebar-item topic" v-on:click="showTopics">
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
      <div class="sidebar-item-hidden">hi</div>
      <img
        class="border-line sidebar-item-hidden"
        src="../assets/Iconography/sidebar-border-line.svg"
      />
      <span class="sidebar-item-hidden" />
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
        <input type="checkbox" v-on:click="landmarkVis" />
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

    <div class="content-explore">{{ card() }}</div>
  </div>
</template>
<script>
/* import { defineComponent } from "@vue/composition-api";

export default defineComponent({
  setup() {},
});
*/
import * as d3 from "d3";
let landmarkVisible = true;
let showTopics = true;

export default {
  name: "Explore",
  props: ["caseData"],
  //{data: Object,}
  data() {
    return {
      msg: "hi from Explore component",
      title: "caseName",
      cases: [],
      topicSubset: {},
      // could define landmarkVisible here
    };
  },
  methods: {
    takeMeToGuided: function () {
      console.log("did that work");
    },
    takeMeToExplore: function () {
      console.log("of course it did");
    },
    showTopics: function () {
      showTopics = !showTopics;
      if (showTopics) {
        d3.selectAll(".sidebar-item-hidden")
          .data(this.topicSubset)
          .text(console.log("plz show topics", [...this.topicSubset.values(0)]))
          .join("div")
          .style("display", "block");
      } else {
        d3.selectAll(".sidebar-item-hidden").style("display", "none");
      }
    },
    landmarkVis: function () {
      landmarkVisible = !landmarkVisible;
      // console.log("Default value of landmarkVisible is", landmarkVisible);
      // console.log("Toggled lv is", landmarkVisible);
      if (landmarkVisible) {
        d3.selectAll(".landmarkNo")
          .transition()
          //.style("opacity", "1.0")
          .delay(500)
          .style("display", "block");
      } else {
        d3.selectAll(".landmarkNo")
          .transition()
          //.style("opacity", "0.5")
          .delay(500)
          .style("display", "none");
      }
    },
    sortByYear: function () {
      d3.selectAll(".card").sort((a, b) => d3.descending(a.term, b.term));
    },
    sortByAlpha: function () {
      d3.selectAll(".card").sort((a, b) =>
        d3.ascending(a.caseName, b.caseName)
      );
    },
    card: function () {
      /** select the .content-explore div and create a card for every case in the dataset,
       * give it a class based on Landmark status, set the background image and sizing
       */

      const svg = d3
        .select(".content-explore")
        .selectAll("card")
        .data(this.cases)
        .join("div")
        .attr("class", function (d) {
          return "card landmark" + d.landmark;
        })
        .style("margin-top", "5%")
        .style("margin-left", "auto")
        .style("margin-right", " auto")
        .style("position", "relative")
        .style(
          "background-image",
          'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/utb.svg")'
        )
        .style("background-size", "contain")
        .style("background-repeat", "no-repeat")
        .style("width", "70%")
        .style("height", 0)
        .style("padding-top", "30%")
        .on("mouseover", function () {
          d3.select(this).style(
            "background-image",
            'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/utbh.svg")'
          );
        })
        .on("mouseout", function () {
          d3.selectAll(".card").style(
            "background-image",
            'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/utb.svg")'
          );
        });

      /** add a div for case name and year */
      svg
        .append("div")
        .style("position", "absolute")
        .style("top", "20%")
        .style("width", "80%")
        .style("left", "5%")
        .style("right", "5%")
        .style("margin", "auto")
        .attr("class", "text")
        .text(function (d) {
          return d.caseName + "  (" + d.term + ")";
        })
        .style("color", "black")
        .style("font-size", "1.75vw");

      /** add the button to open the modal */
      svg
        .append("button")
        .attr("type", "button")
        .attr("class", "button")
        .style("position", "absolute")
        .style("border", "none")
        .style("background", "none")
        .style(
          "background-image",
          'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/ruling-btn.svg")'
        )
        .style("background-size", "contain")
        .style("background-repeat", "no-repeat")
        .style("align-content", "center")
        .style("left", "30%")
        .style("bottom", "20%")
        .style("width", "40%")
        .style("height", "12%");

      /** add gavin icon to landmark cases */
      d3.selectAll(".landmarkYes")
        .append("rect")
        .attr("class", "landmark")
        .style("position", "absolute")
        .style("border", "none")
        .style("background-image", function (d) {
          if (d.landmark === "No") return "none";
          else if (d.landmark === "Yes")
            return 'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/gavinblock.svg")';
        })
        .style("background-size", "contain")
        .style("background-repeat", "no-repeat")
        .style("align-content", "center")
        .style("left", "7%")
        .style("bottom", "10%")
        .style("width", "15%")
        .style("height", "15%")
        .on("mouseenter", function () {
          d3.select(this)
            .append("rect")
            .style("position", "absolute")
            .style("left", "40%")
            .style("bottom", "40%")
            .attr("id", "text")
            .text("Landmark case!")
            .style("font-size", "1.25vw")
            .style("color", "#0d3fd2");
        })
        .on("mouseleave", function () {
          d3.select("#text").remove();
        });

      svg
        .append("div")
        .style("position", "absolute")
        .style("top", "20%")
        .style("width", "80%")
        .style("left", "5%")
        .style("right", "5%")
        .style("margin", "auto")
        .text(this.topTopic2());

      /** call the cards */
      svg;
    },
    topTopic2: function () {
      console.log("show me", this.topicSubset);

      const topicSubset = this.topicSubset;

      function topicValuesSubsetSimple(d) {
        var arr = [];
        for (let i = 1; i < 21; i++) {
          arr.push(Object.values(topicSubset[d])[i]);
        }
        return arr;
      }

      function compareNumbers(a, b) {
        return b - a;
      }

      function getKeyByValue(object, value) {
        return Object.keys(object).find((key) => object[key] === value);
      }

      function object(d) {
        return topicSubset[d];
      }

      function topTopicValue(d) {
        return topicValuesSubsetSimple(d).sort(compareNumbers)[0];
      }

      function topTopicInSyllabus(indexNumber) {
        return getKeyByValue(object(indexNumber), topTopicValue(indexNumber));
      }
      topTopicInSyllabus;
      // console.log("the top topic is:", topTopicInSyllabus);
    },
    caseModal: function () {
      console.log("show me the case");
    },
  },
  created() {
    Promise.all([d3.csv("/full-merged-tm-10-by-20-3.csv", d3.autoType)]).then(
      ([caseData]) => {
        this.cases = caseData;
        //console.log("cases: ", this.cases);
        // topic subset
        this.topicSubset = caseData.map(function (d) {
          return {
            //index: d.index,
            case: d.caseName,
            labor:
              d[
                "employees.employee.employment.public.union.board.political.labor.employer.government"
              ],
            general:
              d[
                "general.attorney.briefs.solicitor.argued.assistant.cause.curiae.brief.jr"
              ],
            communism:
              d[
                "communist.party.organization.board.foreign.registration.act.control.movement.organizations"
              ],
            school:
              d[
                "school.religious.schools.student.establishment.religion.students.forum.program.university"
              ],
            investigation:
              d[
                "grand.jury.press.information.footnote.privilege.news.criminal.sources.investigation"
              ],
            senator:
              d[
                "mr.debate.senator.clause.legislative.said.privilege.plaintiff.office.house"
              ],
            inquiry:
              d[
                "act.congress.committee.answer.service.inquiry.president.united.questions.security"
              ],
            opinion:
              d[
                "opinion.filed.joined.district.post.respondents.held.argued.dissenting.jj"
              ],
            interest:
              d[
                "speech.government.interest.act.interests.governmental.opinion.case.united.states"
              ],
            advertising:
              d[
                "advertising.commercial.speech.regulations.information.central.cable.marketing.interest.broadcasting"
              ],
            campaign:
              d[
                "candidates.candidate.political.election.footnote.contributions.party.expenditures.contribution.campaign"
              ],
            injunction:
              d[
                "injunction.review.maryland.district.restraint.prior.judicial.order.footnote.relief"
              ],
            contributions:
              d[
                "limits.federal.election.buckley.bcra.contributions.campaign.political.candidates.candidate"
              ],
            affirmed:
              d[
                "affirmed.syllabus.decided.argued.freedom.held.act.law.case.reversed"
              ],
            damages:
              d[
                "false.statements.jury.damages.petitioner.malice.times.respondent.actual.trial"
              ],
            telemarketers:
              d[
                "solicitation.charitable.fraud.paid.fee.organizations.requirement.telemarketers.circulators.north"
              ],
            flag:
              d[
                "flag.words.peace.conviction.ohio.convicted.conduct.street.symbol.group"
              ],
            obscenity:
              d[
                "obscene.obscenity.material.materials.film.sexual.standards.films.indecent.minors"
              ],
            religious:
              d[
                "religious.tax.prison.religion.inmates.rfra.exercise.burden.inmate.sales"
              ],
            public:
              d[
                "ordinance.city.picketing.public.streets.ordinances.park.police.permit.regulation"
              ],
          };
        });
        //console.log("subset", this.topicSubset);
      }
    );
  },
  computed: {
    topTopicPerCase() {
      console.log("to come");
      const thing = "Thing";
      return { thing };
    },
  },
  updated() {
    this.topTopic2();
  },
  // might need to put topTopic2() in watched or something
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
  grid-template-columns: 2fr 1fr 1fr 2fr 2fr; /*auto auto auto auto auto /* 150px auto auto 150px*/
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
  align-self: center; /** TODO: do this everything else that needs it */
  padding-left: 10px;
}
.header-topic {
  align-self: center;
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
  background-color: none;
  min-width: 160px;
  /* box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2); */
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
#dropdown1-1,
#dropdown1-2 {
  position: absolute;
  bottom: 43%;
  left: -9px;
  /* border: 1px solid red; */
  width: 98%;
  height: 47%;
  background: transparent;
}
#dropdown1-2 {
  top: 35%;
  /* border: 1px solid purple; */
}

#dropdown1-1:hover,
#dropdown1-2:hover {
  border: 2px solid #0d3fd2;
}

/* wrapper for sidebar and content */
.wrapper-explore {
  margin: 0;
  padding: 0;
  top: 16.23vh; /** .header height + .header-explore height // IDEALLY we could add min-height: 70px so it matches the min heights but not sure how to do that rn*/
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
  width: 142%;
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
  overflow: scroll;
}

.card:hover {
  /* margin: auto;
  margin-top: 5%;
  position: relative; */
  background-image: 'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/utbh.svg")';
  /* background-size: 100% 100%;
  width: 85%;
  height: 35%; */
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
