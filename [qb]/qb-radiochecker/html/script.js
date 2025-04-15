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
var tempdata={}
function openMenu(data){
  tempdata=data.radiodata
  $("body").show()
  $(".online-list").empty()
  $(".onlineplayers").html(`${data.radiodata.length}`)
  $.each(data.radiodata, function (i, v) { 
     $(".online-list").append(`
    <div class="online-box">
      <div class="left-box"><i class="fa fa-info" aria-hidden="true"></i></div>
      <div class="right-box"><div class="name">${v.id} - Freq: ${v.freq}</div> <div  data-coords="${v.coords}" class="steam marklocation redcolor"><span><i class="fa fa-map-marker" aria-hidden="true"></i></span></div>
    </div>
     `);
  });
}

function closeNUI() {
  $("body").hide()
  $.post("https://qb-radiochecker/close", JSON.stringify({}));
}

$(document).on('click', '.marklocation', function (e) {
  closeNUI() 
  $.post("https://qb-radiochecker/marklocation", JSON.stringify({coord:$(this).data('coords')}));
})


$(document).on('click', '.exit', function (e) {
  closeNUI()
})

document.addEventListener('keydown', function(event) {
  if (event.key === 'Escape') {
      closeNUI();
  }
});
