const $ = document;
const body = $.querySelector(".body");
const spawnParent = $.querySelector(".spawn-location-parent");
const spawnLoading = $.querySelector(".spawn-loading");
const weatherIconParent = $.querySelector(".weather-icon");
const weatherText = $.querySelector(".weather-text");
const windSpeedText = $.querySelector(".wind-speed-text");
const temperatureText = $.querySelector(".temp-text");
const timeText = $.querySelector(".time-text");
const dateText = $.querySelector(".date-text");

// wind speed condition
const windSpeedCondition = () => {
  switch (weatherCondition) {
    case "EXTRASUNNY":
    case "CLEAR":
    case "NEUTRAL":
    case "SMOG":
    case "CLEARING":
      return Math.floor(Math.random() * (15 - 5 + 1)) + 5;

    case "FOGGY":
    case "OVERCAST":
    case "CLOUDS":
      return Math.floor(Math.random() * (25 - 10 + 1)) + 10;

    case "RAIN":
    case "THUNDER":
      return Math.floor(Math.random() * (35 - 15 + 1)) + 15;

    case "SNOW":
    case "BLIZZARD":
    case "XMAS":
      return Math.floor(Math.random() * (20 - 5 + 1)) + 5;

    default:
      return Math.floor(Math.random() * (30 - 1 + 1)) + 1;
  }
};

// temperature condition
const temperatureCondition = (weather) => {
  switch (weather) {
    case "EXTRASUNNY":
    case "CLEAR":
    case "NEUTRAL":
    case "SMOG":
    case "CLEARING":
      return Math.floor(Math.random() * (35 - 25 + 1)) + 25;

    case "FOGGY":
    case "OVERCAST":
    case "CLOUDS":
      return Math.floor(Math.random() * (25 - 15 + 1)) + 15;

    case "RAIN":
    case "THUNDER":
      return Math.floor(Math.random() * (20 - 10 + 1)) + 10;

    case "SNOW":
    case "BLIZZARD":
    case "XMAS":
      return Math.floor(Math.random() * (-5 - -15 + 1)) + -15;

    default:
      return Math.floor(Math.random() * (30 - -10 + 1)) + -10;
  }
};

// Return the weather icon based on the data
const weatherCondition = (weather) => {
  switch (weather) {
    case "EXTRASUNNY":
    case "CLEAR":
    case "NEUTRAL":
    case "SMOG":
    case "CLEARING":
      return '<i class="fa-thin fa-sun-bright"></i>';
    case "FOGGY":
    case "OVERCAST":
    case "CLOUDS":
      return '<i class="fa-thin fa-clouds"></i>';
    case "RAIN":
    case "THUNDER":
      return '<i class="fa-thin fa-cloud-rain"></i>';
    case "SNOW":
    case "BLIZZARD":
    case "XMAS":
      return '<i class="fa-thin fa-snowflake"></i>';
    default:
      return '<i class="fa-thin fa-sun-bright"></i>';
  }
};

// get week days
const getWeekDay = (day) => {
  const daysOfWeek = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  return daysOfWeek[day];
};

function getDayOfWeekNameAndDate() {
  const today = new Date();
  const dayOfWeek = today.getDay();
  const month = today.toLocaleString("default", { month: "short" });
  const date = today.getDate();

  return `${getWeekDay(dayOfWeek)}, ${month} ${date}`;
}

window.addEventListener("message", (event) => {
  if (event.data.action === "open") {
    body.style.display = "block";

    // example event data response
    // let spawnData = {
    //   cityInfo: {
    //     time: "10:25",
    //     weather: "FOGGY",
    //   },
    //   locations: [
    //     {
    //       title: "apartment",
    //       image: "./building.png",
    //       top: "47%",
    //       left: "32.5%",
    //     },
    //     {
    //       title: "government",
    //       image: "./city-hall.png",
    //       top: "47%",
    //       left: "37.5%",
    //     },
    //     {
    //       title: "police station",
    //       image: "./policeman.png",
    //       top: "54%",
    //       left: "32.5%",
    //     },
    //     {
    //       title: "air port",
    //       image: "./travelling.png",
    //       top: "39%",
    //       left: "22%",
    //     },
    //     {
    //       title: "sandy shores",
    //       image: "",
    //       top: "68%",
    //       left: "62%",
    //     },
    //     {
    //       title: "paleto bay",
    //       image: "",
    //       top: "45%",
    //       left: "76%",
    //     },
    //   ],
    // };
    let spawnData = event.data.data;
    body.style.visibility = "visible";
    createSpawnElements(spawnData.locations);
    setWeatherBox(spawnData.cityInfo);
    setTimeout(() => {
      spawnLoading.style.opacity = "0";
      spawnLoading.style.visibility = "hidden";
      AOS.init();
    }, 300);
  } else {
    spawnParent.innerHTML = "";
    spawnLoading.style.opacity = "100";
    spawnLoading.style.visibility = "visible";
    setTimeout(() => {
      body.style.display = "none";
    }, 1000);
  }
});

// set city weather info box
const setWeatherBox = (info) => {
  timeText.innerHTML = info.time;

  dateText.innerHTML = getDayOfWeekNameAndDate();

  weatherIconParent.innerHTML = weatherCondition(info.weather);
  weatherText.innerHTML = info.weather;

  windSpeedText.innerHTML = windSpeedCondition(info.weather) + " m/s";

  temperatureText.innerHTML = temperatureCondition(info.weather) + " Celsius";
};

// select location
function selectLocation(location) {
  fetch("https://qb-spawn/spawn", {
    method: "POST",
    body: JSON.stringify({ data: location }),
  });
}

// create spawn locations
function createSpawnElements(locations) {
  let fadeUpDelay = 300;
  locations.map((item) => {
    fadeUpDelay = fadeUpDelay + 200;

    spawnParent.insertAdjacentHTML(
      "afterbegin",
      `<div class="absolute top-[${item.top}] left-[${
        item.left
      }] group z-10" onclick="selectLocation('${item.title.toLowerCase()}')" data-aos="zoom-in" data-aos-duration="800"  data-aos-delay="${fadeUpDelay}">
<div  data-tippy-content="${item.title}"
  class="duration-200 group-hover:-translate-y-[2px] text-white text-3xl w-[2vw] h-[2vw] cursor-pointer  flex items-center justify-center rounded-md rotate-45 group-hover:scale-105"
>
  <img src="./image/${
    item.image || "location.png"
  }" alt="" class="-rotate-45 w-full max-w-[1.8vw]">
</div>
</div>`
    );
    tippy(spawnParent.querySelector(`[data-tippy-content="${item.title}"]`), {
      theme: "tomato",
      animation: "scale",
    });
  });
}
