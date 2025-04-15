var args = {
    normal: ["background-color:rgb(39 , 42 , 53 ,0.7);border-left: 0.25vw solid rgb(255,255,255,07) ","color: rgb(255,255,255);"],
    warning: ["background-color:rgb(39 , 42 , 53,0.7);border-left: 0.30vw solid rgb(255, 133, 29,0.7)","color: rgb(255, 133, 29,0.92);"],
    error:["background-color:rgb(164,0,0,0.6);border-left: 0.30vw solid rgb(164,0,0,0.6)","color: rgb(255,255,255);"],
    system: ["background-color:rgb(183, 89, 0,0.7);border-left: 0.30vw solid rgb(255,190,0)","color: rgb(255,255,255);"],
    police: ["background-color:rgb(39 , 42 , 53 ,0.8);border-left: 0.30vw solid rgb(45,124,244)","color: rgb(45,124,244);"],
    report: ["background-color:rgb(39 , 42 , 53 ,0.8);border-left: 0.30vw solid rgb(163,208,23,0.8)","color: rgb(163,208,23);"],
    dispatch:  ["background-color:rgb(39 , 42 , 53 ,0.7);border-left: 0.30vw solid rgb(255,140,0)","color: rgb(255,140,0);"],
    ooc: ["background-color:rgb(39 , 42 , 53 ,0.7);border-left: 0.25vw solid rgb(255,255,255,0.7) ","color: rgb(255,255,255);"],
    reportr: ["background-color:rgb(39 , 42 , 53 ,0.8);border-left: 0.30vw solid rgb(163,208,23,0.8) ","color: rgb(163,208,23);"],
    reportradmin: ["background-color:rgb(39 , 42 , 53 ,0.8);border-left: 0.30vw solid rgb(163,208,23,0.8) ","color: rgb(163,208,23);"],
    staff: ["background-color:rgb(39 , 42 , 53 ,0.7);border-left: 0.30vw solid rgb(150,0,0,0.6) ","color:rgb(190,50,50);"],
}
var menuOpen = false;
var color = "rgb(255,255,255)";
var color2='';
var messageArr = {}
var totalmessage=[]
var lasttext=""
var tempmessage=[]
var timeOut = 5000;
var resivechat=false;
window.addEventListener("message", function (e) {
    e = e.data
    switch (e.type) {
      case "NXO_CHATMESSAGE":
        return chatMessage(e)
    case "NXO_OPEN":
        return open(e)
    case "NXO_ADDSUGGESTION":
        return addSuggestions(e)
    case "NXO_SUGGESTION_ADD":
        return newSuggestion(e)
    case "NXO_CLEAR":
        return clearChat()
    default:
        return;
    }
});

function chatMessage(e){
    resivechat=true;
    var typ='feed'
    var colortype=''
    colortype=e.message.color.toLowerCase();
    if (e.message.typ){
        typ=e.message.typ.toLowerCase()
    }
    if (args[colortype]){
        color = args[colortype][0];
        color2=args[colortype][1];
    }else{
        color = args['normal'][0];
        color2=args['normal'][1];
    }
 
    if(!messageArr.hasOwnProperty(typ)) {
        messageArr[typ] = [];
    }
   
    $('body , .message-box').fadeIn(200);
    messageArr[typ].push({color:color,color2:color2,typ:typ,header:e.message.args[0],text:e.message.args[1]});
    totalmessage.push({color:color,color2:color2,typ:typ,header:e.message.args[0],text:e.message.args[1]});

    var textObject = e.message.args[1];
    var hiddentitle=''
    if (typ.toUpperCase()==e.message.args[0].toUpperCase()){
        hiddentitle='hidden'
    }

    $('.message-box').append(`
    <div class=" message">
    <div class="item" style="${color}">
    <div class="row">
    <div class="type">${typ.toUpperCase()}</div>
    <div class="header ${hiddentitle}" style="${color2}">${e.message.args[0]}</div>
    </div>
 
      <div class="text">${textObject}</div>
    </div>
    </div>  
    `);
    var messageBox = $('.message-box');
    messageBox.scrollTop(messageBox[0].scrollHeight);
    // }

    setTimeout(function(){
        if (menuOpen === false) {
            $('.message-input , .select-box , .send-box , .suggestion-box').hide();
            $('body').fadeOut(200);
            resivechat=false;
        }              
    },timeOut)
    // $.post('https://qb-chat/load', JSON.stringify({}));


}

function newSuggestion(e) {
    if (e.suggestion === undefined) {
        return;
    }

    $.each(e, function (i, v) { 
        if (v.name === undefined) {
            return;
        }

        if (v.help === undefined || v.help.trim() === '') {
            return;
        }

        if (v.params === undefined || v.params.length === 0) {
            return;
        }

        var existingSuggestion = $('.suggestion-box').find('.suggestion-item').filter(function() {
            return $(this).find('.command').text().trim() === v.name;
        });

        if (existingSuggestion.length > 0) {
            existingSuggestion.find('.desc').text(v.help);
        } else {
            if (Array.isArray(v.params) && v.params.length > 0 && v.params[0].hasOwnProperty('help')) {
                var prm=""
                $.each(v.params, function (j, b) { 
                    var helpText = JSON.stringify(b.help).replace(/^"(.*)"$/, '$1');
                    prm=prm+" | "+helpText
                })
                $('.suggestion-box').append(`
                <div class="suggestion-item">
                    <div class="command"> <span> ${v.name} </span> <span class="suggestcolor" style="margin-left:0.5%">  ${prm}  </span> </div>
                    <div class="desc">${v.help}</div>
                </div>
            `);
            }
        }
    });
}



function addSuggestions(e) {
    if (e.suggestion === undefined) {
        return;
    }

    $.each(e, function (i, v) { 
        if (v.name === undefined || v.help === undefined || v.help.trim() === '' || v.name.trim() === '' ){
            return;
        } else {
            if (Array.isArray(v.params) && v.params.length > 0 && v.params[0].hasOwnProperty('help')) {
                var prm=""
                $.each(v.params, function (j, b) { 
                    var helpText = JSON.stringify(b.help).replace(/^"(.*)"$/, '$1');
                    prm=prm+" | "+helpText
                })

                $('.suggestion-box').append(`
                    <div class="suggestion-item">
                    <div class="command"><span style="color:rgb(71, 27, 27);text-shadow: 0 0 0.2vw rgb(117, 20, 20)"> ${v.name} </span> <span class="suggestcolor" style="margin-left:0.5%">  ${prm} </span></div>
                    <div class="desc">${v.help}</div>
                    </div>
                `);
            }
        }
    });
    

}


function open(e){
    timeOut = e.timeOut;
    if (menuOpen === false) {
        menuOpen = true;
        $('body , .message-box , .send-box , .select-box , .message-input').fadeIn(200);  
    }
    $('.message-input').focus();
    $.post('https://qb-chat/load', JSON.stringify({}));
}

function clearChat() {
    $(".message-box").empty();
    messageArr={}
    totalmessage=[]
}

function sendMessage() { 
    let text = $(".message-input").val();
    let command = $(".select-item.active").text();
  let closenui=true
    
    if (text === undefined || text === "") {
        return;
    }

    var words = text.split(" ");
    var firstWord = words.shift().toLowerCase();
 
    if (firstWord.startsWith("/")) {
        firstWord = firstWord.substring(1);
    }
   
    tempmessage[tempmessage.length]={text: text};
    cIndex=tempmessage.length

    $('.suggestion-box').hide();

    if (text.startsWith("/")) {
        text = text.substring(1);
    }
    lasttext=text;

    if (closenui){
        $('.message-input , .select-box , .send-box , .suggestion-box').hide();
        menuOpen=false
       

        setTimeout(function(){
            if (menuOpen === false && !resivechat) {
                $('body').fadeOut(200);
            }              
        },timeOut)

    }

    $.post('https://qb-chat/send', JSON.stringify({text: text, command: command,close:closenui}));
    $(".message-input").val('');
    var messageBox = $('.message-box');
    messageBox.scrollTop(messageBox[0].scrollHeight);
    resivechat=false;
}



$(document).on('click', '.send-box', function (e) {
    sendMessage()
});



$(document).on('click', '.select-box .select-item', function (e) {
    $(this).closest('.select-box').find('.select-item').removeClass('active');
    $(this).addClass('active');
    let command = $(this).text().toLowerCase();
    $(".message-box").empty();
    if (command == "feed") {
        $.each(totalmessage, function (indexInArray, valueOfElement) { 
            var hiddentitle=''
            if (valueOfElement.typ.toUpperCase()==valueOfElement.header.toUpperCase()){
                hiddentitle='hidden'
            }
            
            $('.message-box').append(`
                <div class="message">
              
                    <div class="item" style="${valueOfElement.color}">
                    <div class="row">
                    <div class="type " >${valueOfElement.typ.toUpperCase()}</div>
                
                        <div class="header ${hiddentitle}" style="${valueOfElement.color2}">${valueOfElement.header}</div>
                        </div>
                        <div class="text">${valueOfElement.text}</div>
                    </div>
                </div>
            `);
           
        });
    } else if (messageArr.hasOwnProperty(command)) {
        $.each(messageArr[command], function (indexInArray, valueOfElement) { 
            var hiddentitle=''
            if (valueOfElement.typ.toUpperCase()==valueOfElement.header.toUpperCase()){
                hiddentitle='hidden'
            }
            $('.message-box').append(`
                <div class="message">
              
                    <div class="item" style="${valueOfElement.color}">
                    <div class="row">
                    <div class="type " >${valueOfElement.typ.toUpperCase()}</div>
                        <div class="header ${hiddentitle}" style="${valueOfElement.color2}">${valueOfElement.header}</div>
                </div>
                        <div class="text">${valueOfElement.text}</div>
                    </div>
                </div>
            `);
        });
    }
});



$(".message-input").on('input', function () {
    let searchValue = $(".message-input").val().toLowerCase(); 
    if (searchValue.length > 0) {
        $(".suggestion-box").css('display', 'flex');
    }else{
        $(".suggestion-box").hide();
    }

    $(".command").each(function () {
      let memName = $(this).text().toLowerCase(); 
      if (memName.includes(searchValue)) {
        $(this).parent().show(); 
      } else {
        $(this).parent().hide(); 
        }
    })
});

var cIndex = -1;

$(".message-input").keydown(function(e) {

    if (e.keyCode==33) {
        e.preventDefault();
        var buf = document.getElementsByClassName('message-box')[0];
        buf.scrollTop = buf.scrollTop - 100;
    
    }
    if (e.keyCode==34) {
        e.preventDefault();
        var buf = document.getElementsByClassName('message-box')[0];
        buf.scrollTop = buf.scrollTop + 100;
    }

    if (e.keyCode==40) {
    //   keyup
        e.preventDefault();
        if (cIndex < tempmessage.length-1) {
            cIndex++
            // var message = Object.keys(tempmessage)[cIndex];
            var text = tempmessage[cIndex].text;    
            $(".message-input").val(text);

        }else{
            cIndex=-1
            $(".message-input").val('');
        }
    }

    if (e.keyCode==38) {
    //   keydown
  
        e.preventDefault();
        if (cIndex > 0) {
            cIndex--
            var text = tempmessage[cIndex].text;       
            $(".message-input").val(text);
        }else{
            cIndex=tempmessage.length
            $(".message-input").val('');
        }
    }

});


$(".message-input").keypress(function(e) {
    if (e.keyCode === 13) {
        sendMessage()
    }
});


var currentIndex = 0;
$(document).ready(function() {
    $(document).on('keydown', function (e) {
        $('.message-input').focus();
        
        if (e.keyCode === 9) {
          $('.select-item').removeClass('active');
        e.preventDefault(); 
        currentIndex=currentIndex+1
        $(`.${currentIndex}`).addClass('active');
        if (currentIndex === 6) {
            currentIndex = 0;
        }
        $(this).removeClass('active');
      }

      if (e.keyCode == 27) {
        menuOpen = false;
        $('body').fadeOut(200);
        $.post('https://qb-chat/close', JSON.stringify({}));
      }

    });
  });