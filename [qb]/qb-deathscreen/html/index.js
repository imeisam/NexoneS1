resourceName = null;
deathScreenOpen = false;
clickTimer = 5;
timerInt=0
window.addEventListener('message', function(event) {
    ed = event.data;
	if (ed.action === "DSMenu") {
		if (ed.open === true) {
			resourceName = ed.resourceName;
			deathScreenOpen = true;
            document.getElementById("MDDeathText").innerHTML="You are incapacitated. Please wait for doctors, everything will be fine.";
            document.getElementById("body").style.display = "block";
            startTimer(ed.time);
		} else {
			deathScreenOpen = false;
            document.getElementById("body").style.display = "none";
            document.getElementById("MDDeathText").innerHTML="You are incapacitated. Please wait for doctors, everything will be fine.";
            clearInterval(timerInt);
		}
    } else if (ed.action === "UpdateTime") {
        document.getElementById("MDDeathText").innerHTML="Hold <span style='color: #E0606E;'>E</span> <span id='MDDTResText' style='color: #E0606E;'>("+ed.time+")</span> to respawn or wait for the <span style='color: #E0606E;'>EMS</span>";
    }
})

function startTimer(duration) {
    var timer = duration, minutes, seconds;
    timerInt = setInterval(function() {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);
        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;
        document.getElementById("MDCDivMinuteFirst").innerHTML=minutes.toString()[0];
        document.getElementById("MDCDivMinuteSecond").innerHTML=minutes.toString()[1];
        document.getElementById("MDCDivSecondFirst").innerHTML=seconds.toString()[0];
        document.getElementById("MDCDivSecondSecond").innerHTML=seconds.toString()[1];
        if (--timer < 0) {
            clearInterval(timerInt);
            document.getElementById("MDDeathText").innerHTML="Hold <span style='color: #E0606E;'>E</span> <span id='MDDTResText' style='color: #E0606E;'>(5)</span> to respawn or wait for the <span style='color: #E0606E;'>EMS</span>";
        }
    }, 1000);
}