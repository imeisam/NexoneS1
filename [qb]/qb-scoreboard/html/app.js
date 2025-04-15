let scoreboard = document.querySelector(".scoreboard-block");
let playerStatus = document.querySelector(".player-status-value");

document.addEventListener("DOMContentLoaded", function () {
  window.addEventListener("message", function (event) {
    switch (event.data.action) {
      case "open":
        openScoreboard(event.data);
        break;
      case "close":
        toggleScoreboard();
        break;
    }
  });
});

const openScoreboard = (data) => {
  // active scoreboard
  toggleScoreboard();
  //   player status
  playerStatus.innerHTML = `${data.players} <span style="font-size:0.7vw">/</span> ${data.maxPlayers}`;
};

// Toggle scoreboard
let toggleScoreboard = function () {
  scoreboard.classList.toggle("active");
};
