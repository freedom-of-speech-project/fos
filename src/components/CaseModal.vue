<template>
  <div id="container">
    <div id="modal-container">
      <div class="content" :keyIndicator="keyIndicator">
        <button class="modal-close">
          <span @click="$emit('modalOff')" class="close">( X )</span>
        </button>
        <div class="modal-top">
          <div class="modal-intro">In this case, speech was...</div>
          <div class="modal-protected">
            {{ protectedSpeech() }}
          </div>

          <div class="modal-caseName">
            {{ caseName() }}
          </div>
          <div class="keyIndicator">
            {{ keyIndicator }}
          </div>
          <h4 v-if="landmark">key issue:</h4>
          <div class="modal-keyIssue">
            {{ keyIssue() }}
          </div>
        </div>
        <div class="modal-before"></div>
        <div class="modal-during">
          <h4 v-if="landmark">decision:</h4>
          <div class="modal-verdict">
            {{ verdict() }}
          </div>
          <div class="modal-decision">
            {{ decision() }}
          </div>
          <h4>case syllabus:</h4>
          <div class="modal-cleanSyl">
            <!-- v:if "landmark = No" -->
            {{ cleanSyl() }}
          </div>
        </div>
        <div class="modal-after">
          <h4 v-if="landmark">significance:</h4>
          <div class="modal-significance">
            <!-- v:if "landmark = Yes" -->
            {{ significance() }}
          </div>
        </div>
        <div class="modal-related-cases">
          <h4 v-if="landmark">related cases:</h4>
          <div class="modal-related">
            <!-- v:if "landmark = Yes" -->
            <!-- I'd go for v:if over v:show bc we don't want all the modals rendered but invisible on the whole site -- they can render as needed -->
            {{ related() }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as d3 from "d3";

// this.keyIndicator == null;
// console.log("key indiccator", this.keyIndicator);

export default {
  name: "CaseModal",
  props: ["keyIndicator"],
  data() {
    return {
      title: "caseName",
      cases: [],
      topicSubset: {},
      landmarkData: [],
      selectedData: {},
      selectedLandmark: [],
      landmark: null,
    };
  },
  methods: {
    protectedSpeech: function () {
      this.selectedData = this.cases.filter(
        (d) => d.usCite == this.keyIndicator
      );
      this.selectedLandmark = this.landmarkData.filter(
        (d) => d.usCite == this.keyIndicator
      );

      if (this.selectedData.map((d) => d.landmark) == "Yes") {
        this.landmark = true;
      } else {
        this.landmark = false;
      }
      console.log(this.keyIndicator);
      console.log("selectd data", this.selectedData);
      console.log("selectd land", this.selectedLandmark);

      //  console.log("protex", this.cases[0].protected);
      d3.select(".modal-protected")
        .data(this.selectedData) // are we going to pass in the data for each case...? pre-load all modals?
        .text(function (d) {
          if (d.protected == "No") {
            return "Not protected!";
          } else if (d.protected == "Yes") {
            return "Protected!";
          }
        })
        .style("color", "#C33C05");
    },
    verdict: function () {
      d3.select(".modal-verdict")
        .data(this.selectedData) // are we going to pass in the data for each case...? pre-load all modals?
        .text(function (d) {
          return d.majVotes + " - " + d.minVotes;
        })
        .style("color", "black");
    },
    decision: function () {
      d3.select(".modal-decision")
        .data(this.selectedLandmark) // json dataset
        .text(function (d) {
          return d.decision;
        })
        .style("color", "black")
        .style("font-family", "Noto Sans")
        .style("font-size", ".75em");
    },
    caseName: function () {
      d3.select(".modal-caseName")
        .data(this.selectedData) // are we going to pass in the data for each case...? pre-load all modals?
        .text(function (d) {
          return d.caseName;
        })
        .style("color", "black");
    },
    cleanSyl: function () {
      d3.select(".modal-cleanSyl")
        .data(this.selectedData) // are we going to pass in the data for each case...? pre-load all modals?
        .text(function (d) {
          return d.cleansyl;
        })
        .style("color", "black")
        .style("font-family", "Noto Sans")
        .style("font-size", ".75em");
    },
    keyIssue: function () {
      d3.select(".modal-keyIssue")
        .data(this.selectedLandmark) // json dataset
        .text(function (d) {
          return d.keyissue;
        })
        .style("color", "black")
        .style("font-family", "Noto Sans")
        .style("font-size", ".75em");
    },
    significance: function () {
      // waiting for landmarks JSON
      d3.select(".modal-significance")
        .data(this.selectedLandmark) // json dataset
        .text(function (d) {
          return d.significance;
        })
        .style("color", "black")
        .style("font-family", "Noto Sans")
        .style("font-size", ".75em");
    },
    related: function () {
      // waiting for landmarks JSON
      d3.select(".modal-related")
        .data(this.selectedLandmark) // json dataset
        .text(function (d) {
          return d.related;
        })
        .style("color", "black")
        .style("font-family", "Noto Sans")
        .style("font-size", ".75em");
    },
    modalOn: function () {
      console.log("things");
      // this.keyIndicator = null;
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
      d3.json(
        "https://dl.dropboxusercontent.com/s/vuu4wd1a5h8opus/landmarks.json?dl=0",

        //"https://dl.dropboxusercontent.com/s/vuu4wd1a5h8opus/landmarks.json?dl=0",
        d3.autoType
      ),
    ]).then(([caseData, subsetData, landmarkData]) => {
      this.cases = caseData;
      // console.log("new cases: ", this.cases);
      // 4 columns --> incl. top topic + value
      this.topicSubset2 = subsetData;
      this.landmarkData = landmarkData;
      console.log("Landmark json", this.landmarkData);
      // console.log("Landmark json1", Object.keys(this.landmarkData[0])[33]);
    });
  },
};
</script>

<style scoped>
#container {
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  margin: auto;
  position: fixed;
  width: 100%;
  background-color: rgba(0, 0, 0, 0.427);
  z-index: 999999999;
}

/* TODO: needs a media querey/ aspect ratio thing for mobile */
#modal-container {
  max-width: 750px;
  width: 70vw;
  height: 95vh;
  top: 20px;
  left: 0;
  bottom: 10;
  right: 0;
  margin: auto;
  padding: 5px 0px 0px 0px;
  border-radius: 15px;
  background-color: whitesmoke;
  position: fixed;
  overflow-y: scroll;
  z-index: 99999;
}

.content {
  max-width: 699px;
  height: 92vh;
  overflow-y: scroll;
  /* padding-right: 50px; */
  /* padding: 0px 50px 50px 0px; */
  padding-left: 3%;
  padding-right: 3%;
  display: grid;
  display: grid;
  grid-template-rows: repeat(auto-fill);
  row-gap: 2px;
}

h4 {
  margin-bottom: 0;
}
.modal-intro {
  margin-top: 2%;
}
.modal-protected {
  font-family: Fredericka the Great, serif;
  font-size: 50px;
  font-weight: 400;
  color: "#C33C05";
}
.modal-verdict {
  margin-top: 2%;
  /* margin-bottom: 2%; */
}

.keyIndicator {
  font-family: "Noto Sans";
}

.modal-caseName,
.modal-keyIssue,
.modal-decision,
.modal-cleanSyl,
.modal-significance,
.modal-related {
  margin-top: 2%;
  margin-bottom: 2%;
  padding-left: 7%;
  padding-right: 7%;
}
.modal-caseName {
  margin-top: 6%;
  font-size: 1.5em;
}

.modal-cleanSyl {
  text-align: justify;
}
.modal-related {
  margin-bottom: 5%;
}

/* MODAL CLOSE */
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
