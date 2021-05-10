<template>
  <div id="container">
    <div id="modal-container">
      <div class="content">
        <div class="modal-top">
          <div class="modal-intro">In this case, speech was...</div>
          <div class="modal-protected">
            {{ protectedSpeech() }}
          </div>
          <div class="modal-verdict">
            {{ verdict() }}
          </div>
          <div class="modal-caseName">
            {{ caseName() }}
          </div>
          <div class="modal-decision">
            <!-- v:if "landmark = Yes" -->
            {{ decision() }}
          </div>
        </div>
        <div class="modal-before">
          <div class="modal-keyIssue">
            <!-- v:if "landmark = Yes" -->
            {{ keyIssue() }}
          </div>
        </div>
        <div class="modal-during">
          <div class="modal-cleanSyl">
            <!-- v:if "landmark = No" -->
            {{ cleanSyl() }}
          </div>
        </div>
        <div class="modal-after">
          <div class="modal-significance">
            <!-- v:if "landmark = Yes" -->
            {{ significance() }}
          </div>
        </div>
        <div class="modal-related-cases">
          <div class="modal-related">
            <!-- v:if "landmark = Yes" -->
            {{ related() }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as d3 from "d3";

export default {
  name: "CaseModal",
  data() {
    return { title: "caseName", cases: [], topicSubset: {} };
  },
  methods: {
    protectedSpeech: function () {
      //  console.log("protex", this.cases[0].protected);
      d3.select(".modal-protected")
        .data(this.cases) // are we going to pass in the data for each case...? pre-load all modals?
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
        .data(this.cases) // are we going to pass in the data for each case...? pre-load all modals?
        .text(function (d) {
          return d.majVotes + " - " + d.minVotes;
        })
        .style("color", "black");
    },
    decision: function () {
      // waiting for landmarks JSON
      /** 
      d3.select(".modal-decision")
        .data(this.landmarks) // json dataset
        .text(function (d) {
          return d.decision;
        })
        .style("color", "black")
        .style("font-family", "Noto Sans")
        .style("font-size", ".75em");
    },
    */
    },
    caseName: function () {
      d3.select(".modal-caseName")
        .data(this.cases) // are we going to pass in the data for each case...? pre-load all modals?
        .text(function (d) {
          return d.caseName;
        })
        .style("color", "black");
    },
    cleanSyl: function () {
      d3.select(".modal-cleanSyl")
        .data(this.cases) // are we going to pass in the data for each case...? pre-load all modals?
        .text(function (d) {
          return d.cleansyl;
        })
        .style("color", "black")
        .style("font-family", "Noto Sans")
        .style("font-size", ".75em");
    },
    keyIssue: function () {
      // waiting for landmarks JSON
      /** 
      d3.select(".modal-keyIssue")
        .data(this.landmarks) // json dataset
        .text(function (d) {
          return d.keyissue;
        })
        .style("color", "black")
        .style("font-family", "Noto Sans")
        .style("font-size", ".75em");
       */
    },
    significance: function () {
      // waiting for landmarks JSON
      /** 
      d3.select(".modal-significance")
        .data(this.landmarks) // json dataset
        .text(function (d) {
          return d.significance;
        })
        .style("color", "black")
        .style("font-family", "Noto Sans")
        .style("font-size", ".75em");
       */
    },
    related: function () {
      // waiting for landmarks JSON
      /** 
      d3.select(".modal-related")
        .data(this.landmarks) // json dataset
        .text(function (d) {
          return d.related;
        })
        .style("color", "black")
        .style("font-family", "Noto Sans")
        .style("font-size", ".75em");
       */
    },
  },
  created() {
    Promise.all([
      d3.csv(
        "https://raw.githubusercontent.com/freedom-of-speech-project/fos-data/3f80e39e563c2073e93973a2f20367f0e4fa516d/tmpvfull-05-03_09-59.csv?token=ALBDZW3Y6ZUW26CZVKGV4WLATB66U",
        d3.autoType
      ),
      d3.csv(
        "https://raw.githubusercontent.com/freedom-of-speech-project/fos/draft-production/topicSubset2.csv",
        d3.autoType
      ),
    ]).then(([caseData, subsetData]) => {
      this.cases = caseData;
      console.log("new cases: ", this.cases);
      // 4 columns --> incl. top topic + value
      this.topicSubset2 = subsetData;
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
}
#modal-container {
  width: 700px;
  height: 900px;
  top: 20px;
  left: 0;
  bottom: 10;
  right: 0;
  margin: auto;
  padding: 5px 50px 25px 50px;
  border-radius: 15px;
  background-color: whitesmoke;
  position: fixed;
  overflow-y: auto;
  z-index: 99999;
}

.content {
  width: 699px;
  height: 699px;
  overflow-y: scroll;
  /* padding-right: 50px; */
  display: grid;
  display: grid;
  grid-template-rows: repeat(auto-fill);
  row-gap: 2px;
}
.modal-intro {
  margin-top: 2%;
  margin-bottom: 2%;
}
.modal-protected {
  font-family: Fredericka the Great, serif;
  font-size: 50px;
  font-weight: 400;
  color: "#C33C05";
}
.modal-verdict {
  margin-top: 2%;
  margin-bottom: 2%;
}
.modal-caseName {
  margin-top: 2%;
  margin-bottom: 2%;
  padding-left: 7%;
  padding-right: 7%;
}
.modal-cleanSyl {
  text-align: justify;
  padding-left: 7%;
  padding-right: 7%;
  margin-top: 2%;
  margin-bottom: 2%;
}
</style>