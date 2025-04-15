const openbadge = (data) => {
  $('#name').css('color', '#282828');

  $('#name').text(data.name);
  $('#grade').text(data.job.grade.name);
  $('#callsign').text('#'+data.callsign);
  if (data.job.name == "police") {
    if (data.job.dep == 'police') {
      $('#dep').attr('src', 'assets/images/lspd.png');
    } else if (data.job.dep == 'sheriff') {
      $('#dep').attr('src', 'assets/images/sheriff.png');
    } else if (data.job.dep == 'ranger') {
      $('#dep').attr('src', 'assets/images/ranger.png');
    } else if (data.job.dep == 'state') {
      $('#dep').attr('src', 'assets/images/state.png');
    }
  } else if (data.job.name == "justice") {
    if (data.job.dep == 'marshal') {
      $('#dep').attr('src', 'assets/images/marshall.png');
    } else  {
      $('#dep').attr('src', 'assets/images/doj.png');
    }
  }
  $('#photolink').attr('src', data.photolink);

  $('#badge').show();
}

const closebadge = () => {
  $('#name').text('');
  $('#dob').text('');
  $('#height').text('');
  $('#signature').text('');
  $('#sex').text('');
  $('#badge').hide();
  $('#licenses').html('');
}

$(document).ready(function(){
  window.addEventListener('message', function(event) {
    switch(event.data.action) {
      case "openbadge":
        openbadge(event.data);
        break;
      }
  })
});

document.onkeyup = function(event) {
  event = event || window.event;
  var charCode = event.keyCode || event.which;
  if (charCode == 8 || charCode == 27) {
    closebadge();
    $.post(`https://qb-policebadge/escape`)
  }
};