<template>
  <!-- <img alt="Vue logo" src="./assets/logo.png" /> -->
  <div class="header">
    <span class="title">Freedom of Speech* </span>
    <span></span>
    <button @click="about = !about" class="about-button">
      <img class="info" src="./assets/Info.svg" />
    </button>
  </div>
  <div v-show="about" id="about">
    <div class="about">
      <h1>About</h1>

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
      <div class="team">
        <p class="h2" id="team">Team</p>
        <p>
          <strong>Eva Sibinga</strong> is in her final semester of the Grad
          Center’s Data Analysis & Visualization program. Her research interests
          include data ethics, the intersection of race and technology, and the
          application of feminist theory to contemporary data questions. With a
          background in English Literature and Visual Art, her approach to data
          analysis and visualization is motivated by a desire to expand the way
          we tell stories and understand the world through our own eyes and
          others’. Eva is one half of Freedom of Speech*’s core data and
          developer team. She will also support the project’s outreach effort,
          and hopes to improve her understanding and skills in UX/UI design by
          applying some time and effort there as well.
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
  <!-- <Intro /> -->
  <Guided />
</template>

<script>
// import * as d3 from "d3"
// import Intro from "./pages/Intro.vue";
import Guided from "./pages/Guided.vue";

export default {
  name: "App",
  components: {
    // Intro,
    Guided,
  },
  data() {
    return {
      guidedtext: "-> Guided Mode",
      exploretext: "-> Explore Mode",
      about: false,
    };
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

.about {
  width: 699px;
  height: 699px;
  overflow-y: scroll;
  padding-right: 50px;
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
}

.header {
  height: 8vh;
  background-color: #0022d9;
  color: white;
  display: grid;
  grid-template-columns: 200px auto 60px;
  align-content: center;
}

.title {
  justify-self: center;
}
.info {
  justify-self: start;
}

.h2#team {
  font-family: Caveat Brush;
  font-style: normal;
  font-weight: normal;
  font-size: 30px;
  line-height: 32px;
  color: #000000;
}
</style>
