<template>
  <!-- CASE OVERLAY -->
  <div id="case-cont">
    <div id="case-bubble-cont">
      {{ caseInfo() }}
      <button class="case-modal-close">
        <span @click="$emit('caseOff')" class="case-close">( X )</span>
      </button>
      <h2 id="case-h2">{{ caseTitle }}</h2>
      <p id="case-p">{{ caseIssue }}</p>
      <button id="case-button" @click="modal = true">
        <img
          src="https://dl.dropboxusercontent.com/s/vv78qkpz6jr0j1o/courtruledbutton.svg?dl=0"
        />
      </button>
      <p></p>
    </div>
  </div>
  <!-- END CASE OVERLAY -->
  <CaseModal
    v-if="modal"
    :keyIndicator="keyIndicator"
    @modalOff="modal = false"
  />
</template>
<script>
import * as d3 from "d3";
import CaseModal from "../components/CaseModal.vue";

export default {
  name: "CaseBubble",
  components: { CaseModal },
  props: ["landmarkSelection", "landmarks", "lmContent", "coords"],
  emits: ["caseOff"],
  data() {
    return {
      caseTitle: null,
      caseIssue: null,
      caseTopics: [],
      modal: false,
      keyIndicator: null,
    };
  },
  methods: {
    caseInfo() {
      const selectedCase = this.landmarks.filter(
        (d) => d.usCite == this.landmarkSelection
      );
      const content = this.lmContent.filter(
        (d) => d.usCite == this.landmarkSelection
      );
      this.caseTitle = selectedCase[0].caseName;
      this.caseIssue = content[0].keyissue;
      this.keyIndicator = selectedCase[0].usCite;
      d3.select("#case-bubble-cont").attr(
        "transform",
        `translate(${this.coords.x},${this.coords.y})`
      );
      console.log(this.coords.x);
    },
  },
};
</script>
<style scoped>
/* CASE POPUP OVERLAY */

#case-cont {
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  margin: auto;
  position: fixed;
  width: 100%;
  background-color: rgba(255, 255, 255, 0.495);
  z-index: 999999;
}

#case-bubble-cont {
  position: fixed;
  z-index: 1;
  background-image: url("../assets/Iconography/speechbubble.svg");
  background-size: contain;
  background-repeat: no-repeat;
  width: 532px;
  height: 375px;
  padding: 25px;
  margin: auto;
  display: grid;
  grid-template-columns: auto;
  grid-template-rows: 10% auto;
}

h2 {
  padding: 0px 60px 0px 20px;
}

p {
  padding-right: 50px;
}

button {
  margin-right: 40px;
}

.case-close {
  color: #aaa;
  font-size: 14px;
  font-weight: bold;
}

.case-close:hover,
.case-close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
</style>
