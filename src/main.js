// on click, show flames

let asterisk = document.getElementById("asterisk");
console.log("asterisk", asterisk)
asterisk.addEventListener("click", makeFlames)
asterisk.addEventListener("mouseenter", takeFlames)
asterisk.addEventListener("mouseout", noFlames)



let text = document.getElementById("comingSoon");
console.log(text)


function makeFlames(e) {
    // here go the flamez //
    text.innerHTML = "hey"
}

function takeFlames(e) {
    // here go the flamez //
    text.innerHTML = "don't touch that :)"
}

function noFlames(e) {
    // here go the flamez //
    text.innerHTML = "coming soon..."
}