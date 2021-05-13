<template>
  <!-- <img alt="Vue logo" src="./assets/logo.png" /> -->

  <div class="header">
    <span @click="whereAmI" class="title">Freedom of Speech* </span>
    <span></span>
    <button @click="about = !about" class="about-button">
      <img class="info" src="./assets/Info.svg" />
    </button>
  </div>

  <div id="intro-wrapper" v-show="introtoggle">
    <div class="title-header">
      <div class="friends">
        <div class="gavin-container">
          <button @click="gavinBubble = !gavinBubble" class="gavin-intro">
            <img class="gavin" src="./assets/Iconography/gavinblock.svg" />
          </button>
          <img
            v-show="gavinBubble"
            class="gavin-bubble"
            @click="gavinBubble = !gavinBubble"
            src="https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/intro-speech.svg"
          />
          <div
            v-show="gavinBubble"
            class="gavin-bubble-text"
            @click="gavinBubble = !gavinBubble"
          >
            Freedom of speech is sooo easy! "Congress shall make no law
            abrdiging the freedom of speech" <br />
            <br />
            *nailed it*
          </div>
        </div>
      </div>

      <h1 class="“title”">{{ title }}</h1>
      <div class="friends">
        <!-- <img class="aster" src="./assets/Iconography/asterrisk.svg" /> -->

        <div class="aster-container">
          <button @click="asterBubble = !asterBubble" class="aster-intro">
            <img class="aster" src="./assets/Iconography/asterrisk.svg" />
          </button>
          <img
            v-show="asterBubble"
            class="aster-bubble"
            @click="asterBubble = !asterBubble"
            src="https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/src/assets/Iconography/intro-speech.svg"
          />
          <div
            v-show="asterBubble"
            class="aster-bubble-text"
            @click="asterBubble = !asterBubble"
          >
            *full body eye roll* <br /><br />
            Freedom of speech protection is <i>constantly</i> changing in
            relation to american values and anxieties
          </div>
        </div>
      </div>
      <!-- 
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
 -->
    </div>
    <div class="mode-wrapper">
      <div class="explore">
        <div class="guide">
          <button @click="takeMeToExplore">explore</button>
        </div>
        <div class="suptext">
          Want to explore all the cases on your own? Click through to <br />sort
          by year or filter by a topic like
          <span id="topicShift">{{ " " + topicShift() }}</span
          >:
        </div>
      </div>
      <div class="guided">
        <div class="guide">
          <button @click="takeMeToGuided">guide me through</button>
        </div>
        <div class="suptext">
          Interested in a bit more context on how speech protection has changed
          over time? For a guided experience, click the button below:
        </div>
      </div>
    </div>
    <div class="footer">
      <div class="ticker ticker-animated">
        <span class="highlighted">Congress shall make no law</span> respecting
        an establishment of religion, or prohibiting the free exercise thereof;
        or <span class="highlighted"> abridging the freedom of speech,</span> or
        of the press; or the right of the people peaceably to assemble, and to
        petition the Government for a redress of grievances.
      </div>
    </div>
    <div></div>
  </div>

  <div v-show="about" id="about">
    <div class="about">
      <h1>About</h1>
      <p class="h2" id="team">Using the Site</p>
      <div class="disclaimerLol">
        This site is a labor of love, and an ambitious project for one semester
        and four people with moderate-to-no legal background. Some parts of it
        are broken, which, in the spirit of free speech, we'll call a charming
        reminder of the fallibility of technology. (By the way, that's exactly
        what "Freedom of Speech" doesn't mean, and what inspired us to make this
        whole site in the first place.)
        <p>
          That being said, we're proud of the site's progress from an idea to a
          very clickable thing in about three months and want it to be as
          functional and beautiful as possible. This is the beta version --
          we're excited for you to try it out and would value any feedback you
          might have! If you're interested, you can check out our Github
          documentation and white paper for more information on functionality
          and foibles (to be finalized by end of May 2021) and submit feedback
          to our
          <a href="mailto:DHFreedomOfSpeechproject@gmail.com ">project email</a
          >.
        </p>
      </div>
      <p class="h2" id="team">Project Abstract</p>
      <div class="abstract">
        <p>
          Freedom of Speech* is a web project that helps users to understand the
          First Amendment right to freedom of speech through interactive
          visualizations of Supreme Court verdicts that have expanded or
          contracted the definition of “free speech” over the history of the
          United States. The project aims to dispel misconceptions about the
          First Amendment (specifically its blanket protection of freedom of
          speech) as static and limitless, and to illustrate how historical
          circumstances, diplomatic relationships, or the realities of race,
          class, religion, and other aspects affect whether and how free speech
          has been protected by the U.S. government.
        </p>
        <p>
          We’ll focus on an effective combination of clean user interface and an
          entry-level approach to the gargantuan field of Supreme Court case
          precedent within the issue of First Amendment freedom of speech in
          order to capture a user’s attention for educational purposes. With
          those two foundations — clean UI and digestible content — in mind,
          this web project aims to offer a humanistic inquiry of the sticky
          relationship between the letter of the law and the cases that define
          its actual implementation through a robust, beautiful, functional,
          data-driven web app. Its focus on the goal of improving critical
          thinking skills, and fostering a better-informed civic populace around
          a topic that is today largely synonymous with social media, makes it
          poised to be an effective Digital Humanities tool.
        </p>
        <p>
          As the U.S. comes to terms with what free speech means in the internet
          age, a baseline literacy and understanding of the concept becomes
          increasingly important; leaving the populace with a question that this
          project will be built to answer: What does ‘freedom of speech’ really
          mean?
        </p>
      </div>
      <p class="h2" id="team">Team</p>
      <div class="team">
        <p>
          <strong>Eva Sibinga</strong> is in her final semester of the Grad
          Center’s Data Analysis & Visualization program. Her research interests
          include data ethics, the intersection of race and technology, and the
          application of feminist theory to contemporary data questions. With a
          background in English Literature and Visual Art, her approach to data
          analysis and visualization is motivated by a desire to expand the way
          we tell stories and understand the world through our own eyes and
          others’. Eva is one half of Freedom of Speech*’s core data and
          developer team, focusing on the statistical topic model and... a
          lot... of web development.
        </p>
        <p>
          <b>Joanne Ramadani</b> is an information designer, data analyst, and
          web developer. She is currently a candidate for a Master’s degree in
          Data Analytics & Visualization at the CUNY Graduate Center. A
          “reformed” law nerd, she majored in English and Political Science in
          undergrad, training her attention to detail and developing her logic
          skills, which she now uses to scrutinize data and create fun
          visualizations that seek the best way to deliver information to as
          many people as possible. As the other half of the core data and
          developer team on Freedom of Speech*, Joanne’s responsibilities
          include cleaning and processing legal data, ideating visualizations on
          the design end, and co-building the code structure of the website,
          including the technical aspect of visualizing content.
        </p>
        <p>
          <b>Kevin Pham</b> is a first-year MA in Digital Humanities student,
          and holds a B.A. in Interdisciplinary Studies from UC Berkeley. Kevin
          leads Freedom of Speech*’s design team, and is also a part of the
          research team. He primarily leads design ideation, produces
          high-fidelity wireframes for the website, and creates the project’s
          key pieces of branding. Kevin’s personal research generally sits at
          the intersection of race, critical theory, and the history of digital
          culture and media, with hopes of exploring theoretical interventions
          within the Digital Humanities.
        </p>
        <p>
          <b>Martin Glick</b> is a Graduate Student at the CUNY Graduate Center
          pursuing an M.A. in Digital Humanities. He has a B.A. in Philosophy
          from City College (CUNY), an M.A. in Philosophy at Birkbeck College
          (University of London), and conducted independent research at the
          University of Göttingen from 2013-2017. His favorite movie is Alien,
          and he wrote a chapter about it in a volume for the Blackwell
          Philosophy and Pop Culture series. He is the project manager and
          contributes to the Outreach program.
        </p>
      </div>
    </div>
  </div>

  <!-- <Intro v-if="explore == false && guided == false" /> -->
  <Explore v-if="explore" />
  <Guided v-if="guided" />
  <!-- <CaseModal /> -->
  <!--Explore :data="loadData"/-->

  <!-- <USMap /> -->
  <!-- <HelloWorld msg="Welcome to Your Vue.js App" /> -->
</template>

<script>
import * as d3 from "d3";

// import Intro from "./pages/Intro.vue";
import Explore from "./pages/Explore.vue";
import Guided from "./pages/Guided.vue";
// import CaseModal from "./components/CaseModal.vue";

export default {
  name: "App",
  components: {
    // Intro,
    Guided,
    Explore,
    //USMap,
    // CaseModal,
  },
  data() {
    return {
      explore: false,
      guided: false,
      guidedtext: "-> Guided Mode",
      exploretext: "-> Explore Mode",
      about: false,
      loadData: {},
      introtoggle: true,
      title: "Freedom of Speech* Project",
      topic: "",
      topicSubset: [],
      topicSubset2: [],
      cases: [],
      caseModal: false,
      gavinBubble: false,
      asterBubble: false,
    };
  },
  mounted() {
    console.log("App loaded");
  },
  methods: {
    takeMeToGuided: function () {
      this.guided = !this.guided;
      this.introtoggle = !this.introtoggle;
      d3.select(".title")
        .append("span")
        .attr("class", "breadcrumb")
        .text(" →  Guided mode");
    },
    takeMeToExplore: function () {
      this.explore = !this.explore;
      this.introtoggle = !this.introtoggle;

      d3.select(".title")
        .append("span")
        .attr("class", "breadcrumb")
        .text(" →  Explore mode");
    },
    whereAmI: function () {
      this.introtoggle = true;
      if (this.guided) {
        this.guided = false;
      }
      if (this.explore) {
        this.explore = false;
      }
      d3.select(".breadcrumb").remove();
    },
    topicShift: function () {
      const topicRollup = d3.rollup(
        this.topicSubset2,
        (v) => v.length,
        (d) => d.topTopic
      );

      var t = d3.transition().duration(1500);

      var topic = d3
        .select("#topicShift")
        .data([...topicRollup.keys()])
        .transition(t)
        .text("obscenity")
        .transition(t)
        .text("communism")
        .transition(t)
        .text("flag-burning")
        .transition(t)
        .text("campaign finance")
        .transition(t)
        .text("money speech")
        .transition(t)
        .text("labor unions")
        .transition(t)
        .text("libel")
        .transition(t)
        .text("broadcasting")
        .transition(t)
        .text("public schools")
        .transition(t);

      topic;
    },
  },
  created() {
    Promise.all([
      d3.csv(
        "https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/public/full-merged-tm-10-by-20-3.csv",
        d3.autoType
      ),
      d3.csv(
        "https://raw.githubusercontent.com/freedom-of-speech-project/fos/vue-eva/public/topicSubset2.csv",
        d3.autoType
      ),
    ]).then(([caseData, subsetData]) => {
      this.cases = caseData;
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
};
</script>

<style>
body {
  margin: 0px;
  padding: 0px;
  overflow-x: hidden;
  overflow-y: hidden;
}

h1 {
  font-family: Fredericka the Great, serif;
  font-size: 50px;
  font-weight: 400;
}

#app {
  font-family: Caveat Brush;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  display: grid;
}

#about {
  width: 700px;
  height: 700px;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  margin: auto;
  padding: 5px 50px 25px 50px;
  border-radius: 15px;
  background-color: whitesmoke;
  position: fixed;
  overflow-y: auto;
  z-index: 99999;
}
.gavin-container {
  position: relative;
}
.gavin-intro {
  cursor: pointer;
}

.gavin-bubble {
  height: 250px;
  width: 250px;
  position: absolute;
  top: 6px;
  left: 7px;
  cursor: pointer;
}
.gavin-bubble-text {
  height: 100px;
  width: 225px;
  position: absolute;
  top: 90px;
  left: 18px;
  color: #c33c05;
  cursor: pointer;
}
.aster-container {
  position: relative;
}
.aster-intro {
  cursor: pointer;
}

.aster-bubble {
  height: 250px;
  width: 250px;
  position: absolute;
  top: 15px;
  right: 15px;
  transform: scaleX(-1) scaleY(1);
  cursor: pointer;
}
.aster-bubble-text {
  height: 100px;
  width: 225px;
  position: absolute;
  top: 80px;
  right: 25px;
  color: #3d6fee;
  cursor: pointer;
}

#topicShift {
  /* text-decoration: underline;*/
  color: #c33c05;
}

.about {
  width: 699px;
  height: 699px;
  overflow-y: scroll;
  padding-right: 50px;
}
.disclaimerLol {
  font-family: Noto Sans, sans-serif;
  text-align: left;
  line-height: 20px;
}

.abstract p,
.team p {
  font-family: Noto Sans, sans-serif;
  text-align: left;
  line-height: 20px;
}

.about-button {
  -webkit-appearance: none;
  appearance: none;
  border: 0px;
  background-color: rgba(0, 0, 0, 0);
  justify-self: right;
  padding-right: 20px;
}

.header {
  height: 8vh;
  min-height: 40px;
  background-color: #0d3fd2;
  color: white;
  display: grid;
  grid-template-columns: 3fr 1fr 1fr;
  align-content: center;
  /** drop shadow?? */
}

.title {
  justify-self: left;
  align-self: center;
  cursor: pointer;
  padding-left: 20px;
}
.info {
  justify-self: center;
  cursor: pointer;
}

.h2#team {
  font-family: Caveat Brush;
  font-style: normal;
  font-weight: normal;
  font-size: 30px;
  line-height: 32px;
  color: #000000;
}

/** INTRO */
.title-header {
  display: grid;
  grid-template-columns: 200px auto 200px;
  margin: auto;
  padding: 30px 0px 50px 0px;
}

.friends {
  width: 100px;
  padding: 10px;
  align-content: center;
  margin-left: 30px;
}

.gavin {
  height: 4.5em;
  transform: scaleX(-1);
}

.aster {
  height: 4em;
}

/*navigation buttons style*/

.mode-wrapper {
  display: grid;
  /* grid-template-columns: 1fr 1fr; */
  /* column-gap: 2.5%; */
  /* padding: 0% 5% 0% 5%; */
  height: 30vh;
  grid-template-columns: 500px 500px;
  justify-content: center;
}
/* 
div.explore,
div.guided {
  border: 1px solid black;
  color: red;
  height: 200px;
} */

.explore,
.guided {
  display: flex;
  justify-content: center;
  width: 500px;
}

button {
  -webkit-appearance: none;
  appearance: none;
  border: 0px;
  background-color: rgba(0, 0, 0, 0);
  font-family: Caveat Brush, sans-serif;
  font-size: 18px;
  position: relative;
  /* margin: 10px; */
}

.guide {
  background-image: url("./assets/Iconography/button1guide.svg");
  background-size: contain;
  /* padding: 0px 30px 15px 40px; */
  margin-top: 80px;
  padding-top: 5px;
  background-repeat: no-repeat;
  position: absolute;
  cursor: pointer;
  height: 30vh;
  width: 200px;
  justify-content: center;
  display: flex;
  align-items: flex-start;
}

.suptext {
  padding: 0 9% 0 9%;
}

.footer {
  height: 30vh;
  box-sizing: content-box;
  padding-top: 10px;
  /* line-height: 22px; */
  width: 50vw;
  overflow: hidden;
  display: inline-block;
  box-sizing: content-box;
  text-align: justify;

  /* text-transform: uppercase; */
}

.ticker {
  font-family: Fredericka the Great, serif;
  /* white-space: nowrap; */
  /* -webkit-animation: ticker 60s linear 0s infinite normal; */
  /* animation: ticker 60s linear 0s infinite normal; */
}

@keyframes ticker {
  from {
    -webkit-transform: translate(100%, 0);
  }
  to {
    -webkit-transform: translate(-100%, 0);
  }
  90% {
  }
}

.highlighted {
  color: #c33c05;
}
</style>
