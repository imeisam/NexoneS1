window.addEventListener("message", function (e) {
  e = e.data
  switch (e.action) {
    case "OPEN":
      return openMenu(e)
    case "CLOSE":
      return closeNUI()
    default:
      return;
  }
});
var  players=[]
function openMenu(data){
  $("body").show()
  $(".online-list").empty()
  $(".onlineplayers").html(`${data.ankletlist.length}`)
  players=data.ankletlist
  $.each(data.ankletlist, function (i, v) { 
    var colortoggle=""
    if (v.gpsEnabled){
      colortoggle='orangecolor'
    }else{
      colortoggle='greencolor'
    }
    var toggle="",unlock="",shock=""
    if (v.id){
      toggle=`<div data-id="${v.identifier}" class="steam onebutton pointer tooglegps ${colortoggle}"><span ><i class="fa fa-location-arrow" aria-hidden="true"></i></span></div>`
      shock=`<div data-id="${v.identifier}" class="steam towbutton pointer shock bluecolor"><span ><i class="fa fa-bolt" aria-hidden="true"></i></span></div>`
    }
    unlock=` <div data-id=${v.identifier} class="steam pointer threebutton redcolor unlock"><span><i class="fa fa-unlock" aria-hidden="true"></i></span> </div>`
   
     $(".online-list").append(`
    <div class="online-box">
      <div class="left-box"><i class="fa fa-info"  aria-hidden="true"></i></div>
      <div class="right-box"><div class="name">${v.identifier} | ${v.name} </div><div>${toggle}${shock}${unlock}</div>
    </div>
     `);
     
  });
}

function closeNUI() {
  $("body").hide()
  $.post("http://nxo-anklet/close", JSON.stringify({}));
}

$(document).on('click', '.tooglegps', function (e) {
  
  cid=$(this).data('id')
  var playerdata=[]
  for (let i = 0; i < players.length; i++) {
    if (players[i].identifier == cid) {
      playerdata[playerdata.length]=players[i]
    }
  }
  $.post("http://nxo-anklet/toggleGPS", JSON.stringify({playerdata}));
  closeNUI()
})
$(document).on('click', '.toggleall', function (e) {
  var playerdata=[]
  for (let i = 0; i < players.length; i++) {
    if (players[i].id ) {
      playerdata[playerdata.length]=players[i]
    }
  }
  $.post("http://nxo-anklet/toggleGPS", JSON.stringify({playerdata}));
  closeNUI()
})

$(document).on('click', '.unlock', function (e) {
  cid=$(this).data('id')
  var playerdata
  for (let i = 0; i < players.length; i++) {
    if (players[i].identifier == cid) {
      playerdata=players[i]
    }
  }
  $.post("http://nxo-anklet/unlockPlayer", JSON.stringify({playerdata}));
})


$(document).on('click', '.shock', function (e) {
  cid=$(this).data('id')
  var playerdata
  for (let i = 0; i < players.length; i++) {
    if (players[i].identifier == cid) {
      playerdata=players[i]
    }
  }
  $.post("http://nxo-anklet/shockPlayer", JSON.stringify({playerdata}));
  closeNUI()
})

$(document).on('click', '.exit', function (e) {
  closeNUI()
})
document.addEventListener('keydown', function(event) {

  if (event.key === 'Escape') {
      closeNUI();
  }
});
