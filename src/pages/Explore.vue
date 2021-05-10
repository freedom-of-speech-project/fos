<template>
  <div class="header-explore">
    <div class="header-relevant">
      <span class="number-relevant"></span>
    </div>
    <div class="header-topic">
      <div id="topic-button"></div>
      <!-- <img
        style="position: relative; height: 75%"
        src="../assets/Iconography/blank-topic-button.svg"
      /> -->
      <!-- <div>hi</div> -->
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
        <img
          id="dropdown1"
          style="position: relative"
          src="../assets/Iconography/alpha-year-menu2.svg"
        />
        <div>
          <button id="dropdown1-1" @click="sortByAlphaAsc"></button>
        </div>

        <div>
          <button id="dropdown1-2" @click="sortByAlphaDesc"></button>
        </div>

        <div><button id="dropdown1-3" @click="sortByYearAsc"></button></div>

        <div><button id="dropdown1-4" @click="sortByYearDesc"></button></div>
      </div>
    </div>
    <!-- year / alpha / -->
    <!-- <div class="dropdown">
      <button class="dropbtn">
        <img
          style="position: relative; width: 90%"
          src="../assets/Iconography/view-as-button.svg"
        />
      </button>
      <div class="dropdown-content"> -->
    <!-- <a href="#">case name</a>
        <a href="#">year</a> -->
    <!-- <img
          style="position: absolute; right: 0"
          src="../assets/Iconography/dropdown-menu.svg"
        />
      </div> 
    </div>-->
  </div>
  <img
    class="header-border-line"
    style="width: 99.9%"
    src="../assets/Iconography/border-line.svg"
  />

  <div class="wrapper-explore">
    <div class="sidebar">
      <div class="sidebar-item text">landmark case</div>
      <label class="switch sidebar-item" id="caret">
        <input type="checkbox" v-on:click="landmarkVis" />
        <span class="slider round"></span>
      </label>
      <img
        class="border-line"
        src="../assets/Iconography/sidebar-border-line.svg"
        id="longer"
      />
      <span />
      <!--/div>
      <div class="toggle-wrapper"-->
      <div class="sidebar-item text">protected speech</div>
      <label class="switch sidebar-item" id="caret">
        <input type="checkbox" v-on:click="protectedVis" />
        <span class="slider round"></span>
      </label>
      <img
        class="border-line"
        src="../assets/Iconography/sidebar-border-line.svg"
        id="longer"
      />
      <span />
      <!-- <div class="sidebar-item-hidden">hi</div>
      <span class="sidebar-item-hidden" /> -->
      <!-- <img
        class="border-line sidebar-item-hidden"
        src="../assets/Iconography/sidebar-border-line.svg"
        id="longer"
      />
      <span class="sidebar-item-hidden" /> -->
      <div class="sidebar-item year text" id="year">year</div>

      <button type="button" class="sidebar-item yearDisplay" id="caret">
        <!-- <img
          style="position: relative"
          src="../assets/Iconography/caret-down.svg"
        /> -->
      </button>

      <div class="sidebar-item-1 brush-container" id="longer">
        {{ brush() }}
      </div>
      <span class="sidebar-item-1" id="shorter" />

      <img
        class="border-line"
        src="../assets/Iconography/sidebar-border-line.svg"
        id="longer"
      />
      <span id="shorter" />
      <!-- <div class="sidebar-item location text">location</div>
      <button type="button" class="sidebar-item" id="caret">
        <img
          style="position: relative"
          src="../assets/Iconography/caret-down.svg"
        />
      </button>
      <--div class="toggle-wrapper"--
      <img
        class="border-line"
        src="../assets/Iconography/sidebar-border-line.svg"
        id="longer"
      />
      <span id="shorter" /> -->

      <div class="sidebar-item text topic" id="hiddenTopic">topic</div>
      <button
        type="button"
        class="sidebar-item topic"
        id="caret"
        v-on:click="showTopics"
      >
        <img
          id="caret"
          style="position: relative"
          src="../assets/Iconography/caret-down.svg"
        />
      </button>
      <img
        class="border-line"
        src="../assets/Iconography/sidebar-border-line.svg"
        id="longer"
      />
      <span />
      <!--/div-->
    </div>

    <div class="content-explore">
      {{ card() }}
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
let landmarkVisible = true;
let protectedVisible = true;
let showTopics = false;
let yearArray = [];

let startYear;
let endYear;

//TODO: make state dataset to fill so that filters don't override each other
// state.data = {}

export default {
  name: "Explore",
  props: ["caseData"],
  data() {
    return {
      title: "caseName",
      cases: [],
      topicSubset2: {},
    };
  },
  methods: {
    takeMeToGuided: function () {
      // console.log("did that work");
    },
    takeMeToExplore: function () {
      // console.log("of course it did");
    },
    showTopics: function () {
      // includes hiding/showing cards on click
      showTopics = !showTopics;

      //TODO: this negates hide/show functionality of LandmarkVis b/c it selects all
      //could add if statement

      // const topicGroups = d3.group(this.topicSubset2, (d) => d.topTopic);
      const topicRollup = d3.rollup(
        this.topicSubset2,
        (v) => v.length,
        (d) => d.topTopic
      );

      //console.log("this.topicsubset2", this.topicSubset2);
      const topicSubset2 = this.topicSubset2;

      if (showTopics) {
        const parent = d3.select(".sidebar");

        this.wrapper = parent
          .selectAll("div.new")
          .data([...topicRollup.entries()])
          .join("div")
          .attr("class", "wrapper")
          .style("grid-column-start", "2")
          .style("grid-column-end", "4");
        this.row = this.wrapper
          .append("div")
          .data([...topicRollup.entries()])
          .style("display", "block")
          .attr("class", (d) => `${d[0]}`)
          .attr("id", "topicDiv")
          .html(
            (d) =>
              `<span class="topic ${d[0]}">${d[0]}</span> <span class="count">(${d[1]})</span> `
          )
          .on("mouseover", function () {
            d3.select(this).style("cursor", "pointer");
          })
          .on("click", function () {
            //set the current topic by picking it up from the DOM selection
            let topic = this.className;
            //selectedTopic = topic;

            // reset card display to zero cards
            d3.selectAll(".card").style("display", "none");
            // UI for selected topic div
            d3.selectAll("#topicDiv")
              .style("color", "#7f8887") // make all other topics gray + reduce opacity
              .style("opacity", 0.75);
            d3.select(this).style("color", "#3d6fee").style("opacity", 1); // selected topic is blue
            //filter cards to display only selected topic
            d3.selectAll(".card")
              .data(topicSubset2)
              .style("color", "#3d6fee")
              .filter(function (d) {
                return d.topTopic == topic;
              })
              .style("display", "block");

            d3.select(".number-relevant").text(
              `${topicRollup.get(topic)} cases in this topic`
            );

            d3.select(".header-topic")
              .text(`current topic: ${topic}`)
              .style("color", "#3d6fee");
          });
      } else {
        // if showTopics is off, remove topic divs and restore all cards with topics
        d3.selectAll("#topicDiv").remove();
        d3.selectAll(".wrapper").remove();
        d3.selectAll(".card")
          .data(topicSubset2)
          .style("color", "black")
          .style("display", "block");
        d3.select(".header-topic").text(" ");
        d3.select(".number-relevant").text(" ");
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
    protectedVis: function () {
      protectedVisible = !protectedVisible;
      // console.log("Default value of protectedVisible is", protectedVisible);
      // console.log("Toggled lv is", protectedVisible);
      if (protectedVisible) {
        d3.selectAll(".protectedNo")
          .transition()
          //.style("opacity", "1.0")
          .delay(500)
          .style("display", "block");
      } else {
        d3.selectAll(".protectedNo")
          .transition()
          //.style("opacity", "0.5")
          .delay(500)
          .style("display", "none");
      }
    },
    sortByYearAsc: function () {
      d3.selectAll(".card")
        .data(this.cases)
        .sort((a, b) => d3.ascending(a.term, b.term));
    },
    sortByYearDesc: function () {
      d3.selectAll(".card")
        .data(this.cases)
        .sort((a, b) => d3.descending(a.term, b.term));
    },
    sortByAlphaAsc: function () {
      d3.selectAll(".card")
        .data(this.cases)
        .sort((a, b) => d3.ascending(a.caseName, b.caseName));
    },
    sortByAlphaDesc: function () {
      d3.selectAll(".card")
        .data(this.cases)
        .sort((a, b) => d3.descending(a.caseName, b.caseName));
    },
    brush: function () {
      const width = window.innerWidth * 0.23;
      const height = 50;
      const marginLeft = 20;
      //var dispatch = d3.dispatch("arrayFinished");

      //make the scales and axes
      const x = d3
        .scaleLinear()
        .domain([1900, 2025])
        .range([marginLeft, width]);
      const x2 = d3
        .scaleLinear()
        .domain([1900, 2025])
        .range([marginLeft, width]);

      const xAxis = d3
        .axisBottom(x)
        .ticks(4)
        .tickFormat(d3.format("d"))
        .tickSize(0);
      const xAxis2 = d3
        .axisBottom(x2)
        .ticks(0)
        .tickFormat(d3.format("d"))
        .tickSize(0);

      // make the container
      this.svg = d3
        .select(".brush-container")
        .append("svg")
        .attr("width", width)
        .style("height", height * 0.75)
        .style("position", "absolute")
        .style("left", 10);

      //call both x axes (needed to position brush start and end)
      this.svg
        .append("g")
        .attr("class", "axis x-axis")
        .attr("transform", `translate(10, 25)`)
        .style("font-family", "Noto Sans")
        .call(xAxis);
      this.svg
        .append("g")
        .attr("class", "axis x-axis")
        .attr("transform", `translate(10, 25)`)
        .style("font-family", "Noto Sans")
        .call(xAxis2);
      //make the brush
      const brush = d3
        .brushX()
        .extent([
          [0, 7],
          [width, height * 0.6],
        ])
        .on("brush end", brushed);

      //add data points to the axis
      const dot = this.svg
        .append("g")
        .attr("stroke", "#3d6fee")
        .attr("fill", "none")
        // .attr("opacity", 0.5)
        // .attr("stroke-opacity", 1)
        .attr("stroke-width", 1)
        .selectAll("rect")
        .data(this.cases)
        .join("rect")
        .attr("x", (d) => x(d.term))
        .attr("y", 12)
        .attr("height", 12)
        .attr("width", 3);

      //call the brush
      this.svg.attr("class", "brush").call(brush);

      //make brushed function
      const data = this.cases;

      function brushed({ selection }) {
        if (selection) {
          const fx = d3
            .scaleLinear()
            .domain([1900, 2025])
            .range([marginLeft, width]);
          const fx2 = d3
            .scaleLinear()
            .domain([1900, 2025])
            .range([marginLeft, width]);
          const [x, x2] = selection;
          yearArray = dot
            .style("stroke", "#B5BBC0") //gray
            .filter((d) => x <= fx(d.term) && fx2(d.term) < x2)
            .style("stroke", "#3d6fee") //blue
            .style("opacity", 1)
            .data();
          startYear = yearArray[0].term;
          endYear = yearArray[yearArray.length - 1].term;

          const cards = d3
            .selectAll(".card")
            .style("display", "none")
            .data(data)
            .filter(function (d) {
              return d.term >= startYear && d.term <= endYear;
            })
            .style("display", "block");

          const display = d3
            .select(".yearDisplay")
            .text(startYear + "-" + endYear)
            .style("color", "#3d6fee") //blue
            .style("font-size", ".9em")
            .style("padding-right", "10%")
            .style("padding-bottom", "20%");

          cards;
          display;
        } else {
          //no selection de facto clears the brush: reset all cards and reset the year display
          const cards = d3
            .selectAll(".card")
            .style("display", "block")
            .data(data);

          const display = d3
            .select(".yearDisplay")
            .text("1900-2019")
            .style("color", "#2c3e50") //navy blue
            .style("font-size", ".9em")
            .style("padding-right", "10%")
            .style("padding-bottom", "20%");

          dot.style("stroke", "#3d6fee").attr("opacity", 1); //blue
          cards;
          display;
        }
      }
    },
    card: function () {
      /** select the .content-explore div and create a card for every case in the dataset,
       * give it a class based on Landmark status, set the background image and sizing
       */
      this.svg = d3
        .select(".content-explore")
        .selectAll("card")
        .data(this.cases)
        .join("div")
        .attr("class", function (d) {
          return "card landmark" + d.landmark + " protected" + d.protected;
        })
        .style("margin-top", "4%")
        .style("margin-bottom", "1%")
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
      this.svg
        .append("div")
        .style("position", "absolute")
        .style("top", "20%")
        .style("width", "80%")
        .style("left", "5%")
        .style("right", "5%")
        .style("margin", "auto")
        .attr("class", "text")
        .text(function (d) {
          return d.caseName + " (" + d.term + ")";
        })
        .style("color", "black")
        .style("font-size", "1.75vw");

      /** add the button to open the modal */
      this.svg
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
        .style("width", "39%")
        .style("height", "12%");

      /** add courthouse icon to landmark cases */
      d3.selectAll(".landmarkYes")
        .append("rect")
        .attr("class", "landmark")
        .style("position", "absolute")
        .style("border", "none")
        .style("background-image", function (d) {
          if (d.landmark === "No") return "none";
          else if (d.landmark === "Yes")
            return 'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/courthouse.svg")';
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

      /** add gavin icon to protected speech cases */
      d3.selectAll(".protectedYes")
        .append("rect")
        .attr("class", "protected")
        .style("position", "absolute")
        .style("border", "none")
        .style("background-image", function (d) {
          if (d.protected === "No") return "none";
          else if (d.protected === "Yes")
            return 'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/gavinblock.svg")';
        })
        .style("background-size", "contain")
        .style("background-repeat", "no-repeat")
        .style("align-content", "center")
        .style("right", "3%")
        .style("bottom", "10%")
        .style("width", "10%")
        .style("height", "15%")
        .on("mouseenter", function () {
          d3.select(this)
            .append("rect")
            .style("position", "absolute")
            .style("width", "90%")
            .style("right", "90%")
            .style("bottom", "30%")
            .attr("id", "text")
            .text("Speech was protected!")
            .style("font-size", "1.15vw")
            .style("color", "#0d3fd2");
        })
        .on("mouseleave", function () {
          d3.select("#text").remove();
        });

      // add topic to each case
      this.svg
        .append("div")
        .attr("class", "topicUgh")
        .style("position", "absolute")
        .style("top", "80%")
        .style("width", "80%")
        .style("left", "5%")
        .style("right", "5%")
        .style("margin", "auto")
        .data(this.topicSubset2)
        .text((d) => d.topTopic + ", " + (d.topicValue * 100).toFixed(1) + "%");

      this.svg;
    },
    caseModal: function () {
      console.log("show me the case");
    },
  },
  created() {
    Promise.all([
      d3.csv(
        "https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-joanne/data_and_processing/tmpvfull-05-03_09-59.csv",
        d3.autoType
      ),
      d3.csv(
        "https://raw.githubusercontent.com/freedom-of-speech-project/fos/draft-production/topicSubset2.csv",
        d3.autoType
      ),
    ]).then(([caseData, subsetData]) => {
      this.cases = caseData;
      console.log("cases: ", this.cases);
      // topic subset - honestly do I even need this
      this.topicSubset = caseData.map(function (d) {
        return {
          index: d.index,
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
      // 4 columns --> incl. top topic + value
      this.topicSubset2 = subsetData;
    });
  },
  computed: {},
  mounted() {
    // this.showTopics();
  },
  updated() {},
};
</script>
<style scoped>
.header-explore {
  height: 8vh; /* will this need a media query? */
  min-height: 30px;
  width: 100%;
  background-color: white;
  display: grid;
  grid-template-columns: 2fr 2fr 1fr 2fr; /*auto auto auto auto auto /* 150px auto auto 150px*/
  align-content: center;
}

.header-relevant {
  font-size: 1.5em;
  align-self: center; /** TODO: do this everything else that needs it */
  padding-left: 10px;
}
.header-topic {
  align-self: center;
  background-image: "../assets/Iconography/blank-topic-button.svg";
  /* 'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/blank-topic-button.svg")'
    50% 50% no-repeat; */

  /* background-image: "../assets/Iconography/blank-topic-button.svg"; */
  /* background-size: contain; */
  /* <img
        style="position: relative; height: 75%"
        src="../assets/Iconography/blank-topic-button.svg"
      />; */
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
#dropdown1-2,
#dropdown1-3,
#dropdown1-4 {
  position: absolute;
  bottom: 70%;
  left: -9px;
  /* border: 2px solid red; */
  width: 95%;
  height: 25%;
  background: transparent;
}
#dropdown1-2 {
  top: 18%;
  /* border: 2px solid purple; */
}
#dropdown1-3 {
  top: 42%;
  /* border: 2px solid blue; */
}
#dropdown1-4 {
  top: 65%;
  /* border: 2px solid green; */
}

#dropdown1-1:hover,
#dropdown1-2:hover,
#dropdown1-3:hover,
#dropdown1-4:hover {
  border: 2px solid #0d3fd2;
}

/* wrapper for sidebar and content */
.wrapper-explore {
  margin: 0;
  padding: 0;
  top: 16.23vh; /** .header height + .header-explore height // IDEALLY we could add min-height: 70px so it matches the min heights but not sure how to do that rn*/
  background-color: white;
  position: fixed;
  height: 84vh;
  width: 100%;
  overflow: auto;
  /* border: 1px solid gray; */
  display: grid;
  grid-template-columns: 3fr 8fr;
}

.sidebar {
  /* border: 1px solid pink; */
  min-width: 200px;
  /* max-width: 300px; */
  padding-top: 20px;
  padding-bottom: 20px;
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  max-height: 100%;
  align-content: flex-start;
  row-gap: 4px;
}

img.border-line {
  grid-column-start: 1;
  grid-column-end: 4;
}

/** sidebar list items */
.sidebar-item-1 {
  /* height: 40px; */
  /* border: 1px solid pink; */
}

#caret {
  /* margin-left: 50%; */
  /* border: 1px solid orange; */
  align-self: center;
  grid-column-start: 4;
  grid-column-end: 4;
}

/** full sidebar width */
#longer {
  width: 145%; /* TODO: figure this out */
  /* border: 1px solid red; */
  height: 25px;
}

#shorter {
  width: 0px;
  /* border: 1px solid purple; */
}

/** sidebar list items */
.sidebar-item {
  height: 40px;
  /* border: 1px solid pink; */
}

.sidebar-item.text {
  padding-top: 5%;
  /* border: 1px solid blue; */
  align-self: center;
  text-align: left;
  padding-left: 40px;
  grid-column-start: 1;
  grid-column-end: 4;
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
  align-self: center;
  justify-content: center;
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
  background-color: #53605f;
  border: 3px solid #7f8887;

  -webkit-transition: 0.4s;
  transition: 0.4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 2px;
  bottom: 1px;
  background-color: white;
  -webkit-transition: 0.7s;
  transition: 0.7s;
}

input:checked + .slider {
  background-color: #3d6fee;
  border: 3px solid #7ba6f1;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196f3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(24px);
  -ms-transform: translateX(24px);
  transform: translateX(24px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}

/** created topic divs */
/* div.wrapper {
  border: 2px solid green;
} */

.content-explore {
  background-color: #e6b996;
  overflow: scroll;
}

.card:hover {
  background-image: 'url("https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/utbh.svg")';
}

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
