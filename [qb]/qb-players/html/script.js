var warnlist=[]
var banslist=[]
window.addEventListener("message", function (e) {
  e = e.data
  switch (e.type) {
    case "OPEN":
      warnlist=e.warnlist
      banslist=e.bans
      return openMenu(e.players)
    case "loadwarns":
      return loadwarns(e.warnslist)
    case "CLOSE":
      return closeNUI()
  }
});

function loadwarns(data){
  $(".online-list").empty()
  $.each(data, function (i, v) { 
     $(".online-list").append(`
    <div class="online-box">
      <div data-warnid="${v.id}" class="removewarn pointer left-box"><i class="fa fa-times" aria-hidden="true"></i></div>
      <div class="right-box"><div class="name">${v.name} (${v.Discord.replace("discord:","")}) - Reson: ${v.Reason}</div></div>
    </div>
     `);
  });

}


function openMenu(players){
  $("body").show()
  $(".online-list").empty()
  $(".onlineplayers").html(`${warnlist.length}`)
  $(".disconnectedplayers").html(`${0}`)
  // ${v.identifier.substring(0,12)}
  $.each(players, function (i, v) { 
    // console.log( JSON.stringify({players}))
     $(".online-list").append(`
    <div class="online-box">
      <div class="left-box">${v.PlayerData.source}</div>
      <div class="right-box"><div class="name">${v.PlayerData.charinfo.firstname} ${v.PlayerData.charinfo.lastname} (${v.PlayerData.discord.replace("discord:","")})</div><div class="baction3 playerwarns" data-playerid="${v.PlayerData.source}"><span><i class="fa fa-list" aria-hidden="true"></i></span></div><div class="baction1 btnban" data-discord="${v.PlayerData.discord}" data-playerid="${v.PlayerData.source}"><span><i class="fa fa-ban" aria-hidden="true"></i></span></div><div data-playerid="${v.PlayerData.source}" class="baction2 addwarn"><span><i class="fa fa-exclamation-triangle" ></i></span></div></div>
    </div>
     `);
  });

}


function loadwarns(data){
  $(".online-list").empty()
  $.each(data, function (i, v) { 
     $(".online-list").append(`
    <div class="online-box">
      <div data-warnid="${v.id}" class="removewarn pointer left-box"><i class="fa fa-times" aria-hidden="true"></i></div>
      <div class="right-box"><div class="name">${v.name} (${v.Discord.replace("discord:","")}) - Reson: ${v.Reason}</div></div>
    </div>
     `);
  });

}
 
function loadbans(){
  $(".online-list").empty()
  $.each(banslist, function (i, v) { 
     $(".online-list").append(`
    <div class="online-box">
      <div data-warnid="${v.id}" class="removewarn pointer left-box"><i class="fa fa-times" aria-hidden="true"></i></div>
      <div class="right-box"><div class="name">Discord: ${v.Discord.replace("discord:","")} | Reson: ${v.Reason} | Ban by: ${v.bannedby} | Expire: ${v.expiretime}</div></div>
    </div>
     `);
  });
}


$(document).on('click', '.btnban', function (e) {
  playerid = $(this).data("playerid");
  discord = $(this).data("discord");
  $.post("https://qb-players/banplayer", JSON.stringify({discord:discord,playerid:playerid}));
})

$(document).on('click', '.addwarn', function (e) {
  playerid = $(this).data("playerid");
  $.post("https://qb-players/warnplayer", JSON.stringify({playerid:playerid}));
})

$(document).on('click', '.warns', function (e) {
  $.post("https://qb-players/loadwarn", JSON.stringify({}));
})

$(document).on('click', '.bans', function (e) {
  loadbans()
})


$(document).on('click', '.playerwarns', function (e) {
  playerid = $(this).data("playerid");
  $.post("https://qb-players/loadwarn", JSON.stringify({playerid:playerid}));
})

$(document).on('click', '.online', function (e) {
  $.post("https://qb-players/loadplayer", JSON.stringify({}));
})
$(document).on('click', '.removewarn', function (e) {
  warnid = $(this).data("warnid");
  $.post("https://qb-players/removewarn", JSON.stringify({warnid:warnid}));
})

function closeNUI() {
  $("body").hide()
  $.post("https://qb-players/close", JSON.stringify({}));
}

function update() { 
  append("online")
  append("disconnected")
}

// $(document).on('click', '.online', function (e) {
//   type = $(this).data("type");
//   append(type)
//   $(".online").css({color: "rgb(154 87 89)",textShadow: "0px 0px 10px rgb(122, 118, 118)",backgroundColor: "rgb(53 54 63)",border: "none"})
//   $(this).css({color: "rgb(66, 201, 176)",textShadow: "0px 0px 10px rgba(66, 201, 176)",backgroundColor: "rgba(10,242,184,0.1)",border: "1px solid rgb(42 117 108)" })
// })

$(document).on('click', '.exit', function (e) {
  closeNUI()
})

document.addEventListener('keydown', function(event) {

  if (event.key === 'Escape') {
      closeNUI();
  }
});
