window.addEventListener("message", function (e) {
  e = e.data
  switch (e.type) {
    case "OPEN":
      return openMenu(e.data)
    case "CLOSE":
      return closeNUI()
    default:
      return;
  }
});

function openMenu(data){
  $("body").show()
  $(".online-list").empty()
  // robberylist=data.robberylist,
  // publiccooldown=publiccooldown,
  $(".onlineplayers").html(`${data.robberylist.length}`)
  $.each(data.robberylist, function (i, v) { 
    classstring=""
    if (v.cooldown && !data.publiccooldown){
      classstring='<div class="steam redcolor"><span><i class="fa fa-times" aria-hidden="true"></i></span></div></div>'
    }
    if (!v.cooldown && !data.publiccooldown){
      classstring='<div class="steam greencolor"><span><i class="fa fa-check" aria-hidden="true"></i></span></div></div>'
    }
    if (data.publiccooldown){
      classstring='<div class="steam orangecolor"><span><i class="fa fa-clock-o" aria-hidden="true"></i></span></div></div>'
    }
     $(".online-list").append(`
    <div class="online-box">
      <div class="left-box"><i class="fa fa-info"  aria-hidden="true"></i></div>
      <div class="right-box"><div class="name">${v.name}</div>${classstring}
    </div>
     `);
  });
}

function closeNUI() {
  $("body").hide()
  $.post("http://qb-cooldown/close", JSON.stringify({}));
}

$(document).on('click', '.exit', function (e) {
  closeNUI()
})

document.addEventListener('keydown', function(event) {

  if (event.key === 'Escape') {
      closeNUI();
  }
});
