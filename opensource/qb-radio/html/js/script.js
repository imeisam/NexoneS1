 radiostate=false 
$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "open") {
            QBRadio.SlideUp()
            if (event.data.radiochannel!=0)
            $("#channel").val(event.data.radiochannel) 
         else 
           $("#channel").val('') 
            QBRadio.radiostate(event.data.radiostate)
        }

        if (event.data.type == "close") {
            QBRadio.SlideDown()
        }
        if (event.data.type == "radiostate") {
            QBRadio.radiostate(event.data.radiostate)
        }
        if (event.data.type == "changefreq") {
            var chan=event.data.freq.toString(1);
            $("#channel").val(chan);
        }
        
    });

    document.onkeyup = function (data) {
        if (data.key == "Escape") { // Escape key
            $.post('https://qb-radio/escape', JSON.stringify({}));
        } else if (data.key == "Enter") { // Enter key
            $.post('https://qb-radio/joinRadio', JSON.stringify({
                channel: $("#channel").val()
            }));
        }
    };
});

QBRadio = {}

$(document).on('click', '#submit', function(e){
    e.preventDefault();

    $.post('https://qb-radio/joinRadio', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#disconnect', function(e){
    e.preventDefault();

    $.post('https://qb-radio/leaveRadio');
});

$(document).on('click', '#volumeUp', function(e){
    e.preventDefault();

    $.post('https://qb-radio/volumeUp', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#volumeDown', function(e){
    e.preventDefault();

    $.post('https://qb-radio/volumeDown', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#decreaseradiochannel', function(e){
    e.preventDefault();
    $.post('https://qb-radio/decreaseradiochannel', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#increaseradiochannel', function(e){
    e.preventDefault();
    $.post('https://qb-radio/increaseradiochannel', JSON.stringify({
        channel: $("#channel").val()
    }));
});

$(document).on('click', '#poweredOff', function(e){
    e.preventDefault();
    if (radiostate){
        $.post('https://qb-radio/poweredOff', JSON.stringify({
            channel: $("#channel").val()
        }));
        // $("#channel").val('')
    } else{
        $("#channel").attr('hidden',false)
        $("#submit").attr('hidden',false)
        $("#mhz").attr('hidden',false)
        $("#increaseradiochannel").attr("disabled", false);
        $("#decreaseradiochannel").attr("disabled", false);
        $("#volumeDown").attr("disabled", false);
        $("#volumeUp").attr("disabled", false);
        $("#bg").attr('src','./img/radio.png')
        $("#volumeUp").removeClass('deactive');
        $("#volumeDown").removeClass('deactive');
        radiostate=true
        $("#poweredOff").removeClass("off");
        $("#poweredOff").addClass("on");
        $("#poweredOff").html('ON');
      
    }
});

QBRadio.SlideUp = function() {
    $(".container").css("display", "block");
    $(".radio-container").animate({bottom: "6vh",}, 250);
}

QBRadio.SlideDown = function() {
    $(".radio-container").animate({bottom: "-110vh",}, 400, function(){
        $(".container").css("display", "none");
    });
}

QBRadio.radiostate = function(rstate) {
    radiostate=rstate
     if (radiostate){
        $("#channel").attr('hidden',false)
        $("#submit").attr('hidden',false)
        $("#mhz").attr('hidden',false)
        $("#increaseradiochannel").attr("disabled", false);
        $("#decreaseradiochannel").attr("disabled", false);
        $("#volumeDown").attr("disabled", false);
        $("#volumeUp").attr("disabled", false);
        $("#bg").attr('src','./img/radio.png')
        $("#volumeUp").removeClass('deactive');
        $("#volumeDown").removeClass('deactive');
        $("#poweredOff").removeClass("off");
        $("#poweredOff").addClass("on");
        $("#poweredOff").html('ON');
     
    }else{
        $("#channel").val('') 
        $("#bg").attr('src','./img/radiooff.png')
        $("#channel").attr('hidden',true)
        $("#submit").attr('hidden',true)
        $("#mhz").attr('hidden',true)
        $("#increaseradiochannel").attr("disabled",'true')
        $("#decreaseradiochannel").attr("disabled",'true')
        $("#volumeUp").addClass('deactive');
        $("#volumeDown").addClass('deactive');
        $("#volumeDown").attr('disabled','true')
        $("#volumeUp").attr('disabled','true')
        $("#poweredOff").removeClass("on");
        $("#poweredOff").addClass("off");
        $("#poweredOff").html('OFF');;
    }
}


