let progress = 0;
let progressInterval;
let currentDifficulty;
let isHolding = false;

window.addEventListener("message", function (event) {
  const data = event.data;

  if (data.action === "startMinigame") {
    document.getElementById("minigame-container").classList.remove("hidden");
    currentDifficulty = data.difficulty;
    startProgress(data.time);
  }
});

function startProgress(time) {
  progress = 0;
  const progressBar = document.querySelector(".progress-bar");
  const difficultyIndicator = document.querySelector(".difficulty-indicator");

  // Set difficulty indicator color
  switch (currentDifficulty) {
    case "Easy":
      difficultyIndicator.style.background = "#4CAF50";
      break;
    case "Medium":
      difficultyIndicator.style.background = "#FFC107";
      break;
    case "Hard":
      difficultyIndicator.style.background = "#F44336";
      break;
  }

  progressInterval = setInterval(() => {
    if (isHolding) {
      progress += 1;
      progressBar.style.width = progress + "%";

      if (progress >= 100) {
        clearInterval(progressInterval);
        finishMinigame(true);
      }
    } else {
      progress = Math.max(0, progress - 2);
      progressBar.style.width = progress + "%";
    }
  }, time / 100);
}

function finishMinigame(success) {
  clearInterval(progressInterval);
  document.getElementById("minigame-container").classList.add("hidden");

  fetch(`https://${GetParentResourceName()}/minigameResult`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      success: success,
      difficulty: currentDifficulty,
    }),
  });
}

document.getElementById("action-button").addEventListener("mousedown", () => {
  isHolding = true;
});

document.getElementById("action-button").addEventListener("mouseup", () => {
  isHolding = false;
});

document.getElementById("action-button").addEventListener("mouseleave", () => {
  isHolding = false;
});
