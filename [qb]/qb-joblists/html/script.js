var players=[]
var jobname=[]
window.addEventListener("message", function (e) {
  e = e.data
  switch (e.type) {
    case "OPEN":
      players=e.players
      jobname=e.jobname
      if (jobname[e.playerjobname]){
        return openMenu(jobname[e.playerjobname])
      }else{
        return openMenu(jobname['police'])
      }
    case "CLOSE":
      return closeNUI()
  }
});


function openMenu(job){
  $(".header").html(`${job.jname}`)
  $("body").show()
  $(".online-list").empty()
var totlaplayers=0
var totaloffduty=0
var total=0
  $.each(players, function (i, v) { 
   
  if (v.duty && v.jobname==job.jobname) {
    $(".online-list").append(`
    <div class="online-box">
      <div class="left-box">${total+1}</div>
      <div class="right-box"><div class="name">${v.playername}  ( ${v.callsign} ) </div><div class="ondutty baction1"><span><i class="fa  fa-circle" aria-hidden="true"></i></span></div></div>
    </div>
     `);
     total=total+1
     totlaplayers=totlaplayers+1
  }
  });
  $.each(players, function (i, v) { 
    if (!v.duty && v.jobname==job.jobname) {
      $(".online-list").append(`
      <div class="online-box">
        <div class="left-box">${total+1}</div>
        <div class="right-box"><div class="name">${v.playername}  ( ${v.callsign} )</div><div class="baction1 offduty"><span><i class="fa fa-circle" aria-hidden="true"></i></span></div></div>
      </div>
       `);
       total=total+1
       totaloffduty=totaloffduty+1
    }
    });

  $(".onlineplayers").html(`${totlaplayers}`)
  $(".disconnectedplayers").html(`${totaloffduty}`)
}

function closeNUI() {
  $("body").hide()
  $.post("https://qb-joblists/close", JSON.stringify({}));
}



$(document).on('click', '.police', function (e) {
  openMenu(jobname['police'])
})
$(document).on('click', '.medic', function (e) {
  openMenu(jobname['ambulance'])
})
$(document).on('click', '.doj', function (e) {
  openMenu(jobname['justice'])
})
$(document).on('click', '.goverment', function (e) {
  openMenu(jobname['goverment'])
})

$(document).on('click', '.exit', function (e) {
  closeNUI()
})

document.addEventListener('keydown', function(event) {

  if (event.key === 'Escape') {
      closeNUI();
  }
});
