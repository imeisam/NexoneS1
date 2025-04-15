/*
    Author:github @jinpa-t

    To-Do list
-  [ ]Threefold repitition

*/

var piece_move_sound = new Audio('piece_move.wav');
var game_over_sound = new Audio('game_over.wav');
var low_time = new Audio("low_time.wav")
var forfeit_button = document.getElementById("flag");
var quit_button = document.getElementById("cross");
var in_play_text = document.getElementById("game-message-text");
var your_elo_delta = document.getElementById("self_elo_delta");
var opponent_elo_delta = document.getElementById("opponent_elo_delta");
var timer = null
var end_sound_played = false
const own_elo = document.getElementById("elo_self")
const opponent_elo = document.getElementById("elo_opponent")

var drawBar = document.getElementById("choiceBar");



var your_turn_text = "your turn"
var opponents_turn_text = "opponents turn"

var forfeit_button = document.getElementById("flag");
var quit_button = document.getElementById("cross");
var draw_button = document.getElementById("drawbutton")
var yesButton = document.getElementById("choiceYes");
var noButton = document.getElementById("choiceNo");

yesButton.addEventListener('click', () => {
    sendDrawResponse(true)
    drawBar.style.display = "none"
});

noButton.addEventListener('click', () => {
    sendDrawResponse(false)
    drawBar.style.display = "none"
});

forfeit_button.addEventListener('click', () => {
    if(player == "white") {
      sendGameWinner("black", "forfeit")
    } else {
      sendGameWinner("white", "forfeit")
    }
    draw_button.style.display = "none";
    forfeit_button.style.display = "none";
    quit_button.style.display = "block";
});

quit_button.addEventListener('click', () =>{
    sendQuitGame()
    location.reload()
})

draw_button.addEventListener("click", () =>{
    sendDrawOffer()
})

// Move box
var isDown = false
var coords = [0,0];
var mousePosition;
var offset = [0,0];

var upper_box = document.getElementById("bars");
var ui_box = document.getElementById("outer-wrapper");

upper_box.addEventListener('mousedown', function(e) {
  isDown = true;
  offset = [
      ui_box.offsetLeft - e.clientX,
      ui_box.offsetTop - e.clientY
  ];
}, true);

document.addEventListener('mouseup', function() {
  isDown = false;
}, true);

document.addEventListener('mousemove', function(event) {
  event.preventDefault();
  if (isDown) {
      mousePosition = {

          x : event.clientX,
          y : event.clientY

      };
      coords[0] = (mousePosition.x + offset[0]) + 'px';
      ui_box.style.left = coords[0];
      coords[1] = (mousePosition.y + offset[1]) + 'px';
      ui_box.style.top  = coords[1];
  }
}, true);




var elements = document.getElementsByClassName("timeChoice-button");


for (var i = 0; i < elements.length; i++) {
    elements[i].addEventListener('click', sendTimeChoice, false);
}

var running = false


const padZero = (number) => {
    if (number < 10) {
        return '0' + number;
    }
    return number;
}

class Timer {
    constructor(player, minutes) {
        this.player = player;
        this.minutes = minutes;
    }
    getMinutes(timeId) {
        return document.getElementById(timeId).textContent;
    }
}

// Create an instance of the timer for each player.

let p1time = new Timer('min1', document.getElementById('min1').textContent);
let p2time = new Timer('min2', document.getElementById('min2').textContent);

const swapPlayer = () => {
    if (!running) return;
    // Toggle the current player.
    currentPlayer = currentPlayer === "white" ? "black" : "white";
    // Play the click sound.
}


const startTimer = () => {
    running = true;
    let p1sec = 60;
    let p2sec = 60;
    
    window.addEventListener('message', (event) => {
      if (event.data.event == "updateGameText") {
        clearInterval(timerId)
        running = false;
      }
    })
    
    let timerId = setInterval(function() {
        // Player 1.
        if ((TURN === "white" && player == "black") || (TURN == "black" && player == "white")) {
            if (running) {
                in_play_text.innerHTML = opponents_turn_text
                p1sec = Number(document.getElementById('sec1').innerHTML)
                
                p1time.minutes = parseInt(p1time.getMinutes('min1'), 10);
                if (p1sec === 0) {
                  p1time.minutes = p1time.minutes - 1;
                  p1sec = 60
                }
  /*               if (p1sec === 60) {
                    p1time.minutes = p1time.minutes - 1;
                } */
                
                p1sec = p1sec - 1;
                
                if (p1sec === 0) {
                    // If minutes and seconds are zero stop timer with the clearInterval method.
                    if (p1sec === 0 && p1time.minutes === 0) {
                        // Play a sound effect.
                        p1sec = 1
                        clearInterval(timerId);
                    }
                }
                document.getElementById('sec1').textContent = padZero(p1sec);
                document.getElementById('min1').textContent = padZero(p1time.minutes);
            }
        } else {
            // Player 2.
            if (running) {
                in_play_text.innerHTML = your_turn_text
                p2time.minutes = parseInt(p2time.getMinutes('min2'), 10);
                p2sec = Number(document.getElementById('sec2').innerHTML)
                if (p2sec === 0) {
                  p2time.minutes = p2time.minutes - 1;
                  p2sec = 60
                }
                p2sec = p2sec - 1;

                if (p2time.minutes == 0 && p2sec == 30) {
                  low_time.play()
                }
                document.getElementById('sec2').textContent = padZero(p2sec);
                document.getElementById('min2').textContent = padZero(p2time.minutes);
                if (p2sec === 0) {
                    // If minutes and seconds are zero stop timer with the clearInterval method.
                    if (p2sec === 0 && p2time.minutes === 0) {
                        // Play a sound effect.
                        game_over_sound.play();
                        // Stop timer.
                        clearInterval(timerId);
                        running = false;
                        player = player === "white" ? "black" : "white";
                        sendGameWinner(player, "out_of_time")
                        GAME_OVER = true;
                    }
                }
            }
        }
    }, 1000);
}

var chessboard = document.getElementById("chessboard");


function sendTimeChoice() {
    document.getElementById("timeChoice").style.display = "none";
    fetch(`https://pd_chess/recieveTimeChoice`, {
        method: 'POST',
        body: JSON.stringify({id:this.id})
      })
}

function sendPawnPromotion(id, selected_id) {
    fetch(`https://pd_chess/recievePawnPromotion`, {
      method: 'POST',
      body: JSON.stringify({id:id, selected_id:selected_id})
    })
}

function sendHighlightPiece(piece_id, on) {
    fetch(`https://pd_chess/recieveHighlightedPiece`, {
      method: 'POST',
      body: JSON.stringify({piece_id:piece_id, on:on})
    })
}

function sendPieceMove(tile_id, piece_id, castles) {
    sendSyncTime()
    fetch(`https://pd_chess/recievePieceMove`, {
      method: 'POST',
      body: JSON.stringify({tile_id:tile_id, piece_id:piece_id, castles:castles})
    })
  }

function sendRemovePiece(piece_id) {
    fetch(`https://pd_chess/recieveRemovePiece`, {
        method: 'POST',
        body: JSON.stringify({piece_id:piece_id})
    })
}

function sendQuitGame() {
    fetch(`https://pd_chess/recieveQuitGame`, {
      method: 'POST',
      body: JSON.stringify({})
    })
  }

function sendGameWinner(winner, reason) {
    sendSyncTime() 
    fetch(`https://pd_chess/recieveGameWinner`, {
      method: 'POST',
      body: JSON.stringify({winner:winner, reason:reason})
    })
}

function sendDrawOffer() {
    fetch(`https://pd_chess/recieveDrawOffer`, {
      method: 'POST',
      body: JSON.stringify({})
    })
}

function sendDrawResponse(response) {
    fetch(`https://pd_chess/recieveDrawResponse`, {
      method: 'POST',
      body: JSON.stringify({response:response})
    })
}

function sendSyncTime() {
    var minutes = document.getElementById("min2").innerHTML
    var seconds = document.getElementById("sec2").innerHTML
    fetch(`https://pd_chess/recieveSyncTime`, {
      method: 'POST',
      body: JSON.stringify({minutes:minutes, seconds:seconds})
    })
  }


function setUpBoardDisplay(id) {
    if (id === 2) {
      //column_div.style.perspective = "74vw";
      chessboard.style.transform = "rotateX(30deg) rotate(180deg) translateX(0.5vw)";
    } else if (id === 1) {
      //column_div.style.perspective = "74vw";
      chessboard.style.transform = "rotate(0deg) rotateX(30deg) translateX(2.2vw) translateY(6vw)";
    }
}





window.addEventListener('message', (event) => {
    
    if (event.data.event == "toggleUI") {
        document.getElementById("outerboard").style.display = "block"
        document.getElementById("outer-wrapper").style.display = "block"
        document.getElementById("outerboard").style.display = "block"
        startTimer()
        if (player == "white") {
            in_play_text.innerHTML = your_turn_text
        } else {
            in_play_text.innerHTML = opponents_turn_text
        }

      
      
    } else if (event.data.event == "highlight") {
        var elem = document.getElementById(event.data.id)
        if (event.data.on) {
            selected = elem
            $(current_setup[elem.id]).classList.add("selected");
        } else {
            selected = null
            $(current_setup[elem.id]).classList.remove("selected");
        }   
    } else if (event.data.event == "promotePawn") {
        var selector = document.getElementById(event.data.id);
        recievePromotePawn(selector)
    } else if (event.data.event == "move") {
        recievePieceMove(event.data.tile_id, event.data.piece_id)
    } else if (event.data.event == "changeTurns") {
      Board.changePlayerTurn()

    } else if (event.data.event == "setPlayer") {
        setUpBoardDisplay(event.data.player_id)
        if (event.data.player_id == 1) {
            player = "white"
        }else {
            player = "black"
        }

    } else if (event.data.event == "remove") {
      var piece = pieces[event.data.piece_id -1]
      piece.remove()

    } else if (event.data.event == "setElo") {
      
      if (!event.data.show_elo) {
        own_elo.style.display = "none";
        opponent_elo.style.display = "none";
      } else { 
        own_elo.innerHTML = Number(event.data.own_elo).toFixed(0)
        opponent_elo.innerHTML = Number(event.data.opponent_elo).toFixed(0)
      }

    } else if (event.data.event == "updateGameText") {
      if (!end_sound_played) {
        game_over_sound.play()
        end_sound_played = true
      }
      in_play = false
      if (event.data.text.length > 15) {
        in_play_text.style.fontSize = "1vw"
      }
      in_play_text.innerHTML = event.data.text
      quit_button.style.backgroundColor = "rgba(40, 40, 40, 0.95)"
      forfeit_button.style.display = "none";
      draw_button.style.display = "none";
      quit_button.style.display = "block";

    } else if (event.data.event == "updateEloDelta") {
      if (Number(event.data.your_elo) < 0) {
        your_elo_delta.style.color = "red"
      }
      if (Number(event.data.opponent_elo) < 0) {
        opponent_elo_delta.style.color = "red"
      }
      opponent_elo_delta.style.display = "block";
      opponent_elo_delta.innerHTML = event.data.opponent_elo.toFixed(0)

      your_elo_delta.style.display = "block";
      your_elo_delta.innerHTML = event.data.your_elo.toFixed(0)

    } else if (event.data.event == "syncTime") {
      document.getElementById('sec1').innerHTML = padZero(Number(event.data.seconds));
      document.getElementById('min1').innerHTML = padZero(Number(event.data.minutes));

    } else if (event.data.event == "translations") {
      your_turn_text = event.data.your_turn
      opponents_turn_text = event.data.opponents_turn
      document.getElementById("player-text-right").innerHTML = event.data.opponent
      document.getElementById("player-text-left").innerHTML = event.data.you
      document.getElementById("drawOfferText").innerHTML = event.data.draw_offer
    } else if (event.data.event == "timeChoiceDisplay") {
        document.getElementById("timeChoice").style.display = "block";
    } else if (event.data.event == "setTimeChoices") {
        document.getElementById("timeChoice-textbox").innerHTML = event.data.headerTranslation
        document.getElementById("choice1").innerHTML = `${event.data.choice1} ${event.data.minTranslation}`
        document.getElementById("choice2").innerHTML = `${event.data.choice2} ${event.data.minTranslation}`
        document.getElementById("choice3").innerHTML = `${event.data.choice3} ${event.data.minTranslation}`
        document.getElementById("choice4").innerHTML = `${event.data.choice4} ${event.data.minTranslation}`
    } else if (event.data.event == "setPlayerTime") {
        var time = parseInt(event.data.time)
        if (time < 10) {
            time = `0${time}`
        }
        document.getElementById("min1").innerHTML = time
        document.getElementById("min2").innerHTML = time
    } else if (event.data.event == "drawRequest") {
        drawBar.style.display = "block";
    } else if (event.data.event == "drawResponse") {
        in_play_text.innerHTML = event.data.text
    }
})

function recievePromotePawn(selectedPiece) {
    if(selectedPiece.id == "b_R" || selectedPiece.id == "b_B" || selectedPiece.id == "b_K" ||
     selectedPiece.id == "b_Q") {
        
        var newPiece = selectedPiece.cloneNode();
        newPiece.setAttribute('onclick','moveBlack(this)');
        var id = selectedPiece.id+promoted_counter[selectedPiece.id][0];
        promoted_counter[selectedPiece.id][0]++;
        newPiece.setAttribute('id', id);
        newPiece.innerHTML = promoted_counter[selectedPiece.id][1];       
        newPiece.classList.remove(selectedPiece.id);
        $(promoteBlackPawnTo).appendChild(newPiece);

        // push the new piece name with positon in the list to the black_pieces
        black_pieces.push(id);
        //push the position in the board
        current_setup[id] = promoteBlackPawnTo;
        selected = undefined;
        document.querySelectorAll(".move:last-child")[0].getElementsByTagName('td')[1].innerHTML += "=";
        document.querySelectorAll(".move:last-child")[0].getElementsByTagName('td')[1].innerHTML += id;
    } else if(selectedPiece.id == "w_Q" || selectedPiece.id == "w_R" || selectedPiece.id == "w_K" ||
     selectedPiece.id == "w_Q") {
        
        var id = selectedPiece.id+promoted_counter[selectedPiece.id][0];
        promoted_counter[selectedPiece.id][0]++;
        var newPiece = selectedPiece.cloneNode();
        newPiece.setAttribute('onclick','moveWhite(this)');
        newPiece.setAttribute('id', id);
        newPiece.innerHTML = promoted_counter[selectedPiece.id][1];
        newPiece.classList.remove(selectedPiece.id);
        $(promoteWhitePawnTo).appendChild(newPiece);
        // push the new piece name with positon in the list to the white_pieces
        white_pieces.push(id);        
        //push the position in the board
        current_setup[id] = promoteWhitePawnTo;
        selected = undefined;

        document.querySelectorAll(".move:last-child")[0].getElementsByTagName('td')[0].innerHTML += "=";
        document.querySelectorAll(".move:last-child")[0].getElementsByTagName('td')[0].innerHTML += id;
    }
    $("prompt").style.display = "none";
}

function recievePieceMove(id, piece_id) {
    var elem = document.getElementById(id)
    selected = document.getElementById(piece_id)
    if(GAME_OVER) return;
    if( selected  && selected.nodeType )
    {
        var prevWKingPos = current_setup["wK"];
        var prevBKingPos = current_setup["bK"];        
        
        if(white_pieces.includes(selected.id,0) && TURN == "white" && canMoveTo(elem, true)){        
            
            TURN = "black";            
            var moveNote = selected.id;
            
            $('white-turn').style.display = "none";
            $('black-turn').style.display = "inline-block";
                        
            $(current_setup[selected.id]).classList.remove("selected");
            if(selected.id == "wK"){
                Moved_castle[selected.id] = true;
            }
            if(selected.id == "wRb" || selected.id == "wRw"){
                Moved_castle[selected.id] = true;
            }
            // promote pawn
            if(promoteWhitePawn){
                $("whiteTaken").appendChild(selected); 
                promoteWhitePawnTo = elem.id;
                current_setup[selected.id] = "x";
                promoteWhitePawn = false;
            } else {                
                removeHighlight(selected);
                elem.appendChild(selected);
                current_setup[selected.id] = elem.id;
                moveNote = moveNote + elem.id;
            }
            if(removePiece != "" && removePiece != "O-O-O" && removePiece != "O-O"){
                moveNote = moveNote +"x"+ removePiece;
                removePiece = "";
            }    
            if(IsKingInCheck(Object.assign({}, current_setup))){
                $(current_setup["bK"]).classList.add("danger");
                
                moveNote = moveNote +"+";
            } else {
                
                $(prevWKingPos).classList.remove("danger");
            }
            if(removePiece == "O-O-O" || removePiece == "O-O"){
                moveNote = removePiece;
                removePiece = "";
            }
            if(selected.id.substring(0,2) == "wP" || piece_capture ){
                fiftfy_move_count = 0;
                piece_capture = false;
            } else {
                fiftfy_move_count++;                
            }
            var newRow = document.getElementById("move-template").content.cloneNode(true);
            newRow.querySelectorAll("td")[0].innerHTML = moveNote;
            document.getElementById("move-history").appendChild(newRow);

        } 
        else if(black_pieces.includes(selected.id,0)  && TURN == "black" && canMoveTo(elem, true)){
            
            TURN = "white";
            var moveNote = selected.id;
            $('black-turn').style.display = "none";
            $('white-turn').style.display = "inline-block";
            
            $(current_setup[selected.id]).classList.remove("selected");
            if(selected.id == "bK"){
                Moved_castle[selected.id] = true;
            }
            if(selected.id == "bRb" || selected.id == "bRw"){
                Moved_castle[selected.id] = true;
            }
            if(promoteBlackPawn){
                $("whiteTaken").appendChild(selected); 
                promoteBlackPawnTo = elem.id;
                current_setup[selected.id] = "x";
                $("prompt").style.display = "grid";
                $("blackChoice").style.display = "block";
                $("whiteChoice").style.display = "none";
                promoteBlackPawn = false;
            } else {
                elem.appendChild(selected);
                current_setup[selected.id] = elem.id;
                moveNote = moveNote + elem.id;                 
            }
            if(removePiece != "" && removePiece != "O-O-O" && removePiece != "O-O"){
                moveNote = moveNote +"x"+ removePiece;
                removePiece = "";
            }
            
            if(IsKingInCheck(Object.assign({}, current_setup))){
                $(current_setup["wK"]).classList.add("danger");
                
                moveNote = moveNote + "+";
            } else {
                
                $(prevBKingPos).classList.remove("danger");                
            }
            if(removePiece == "O-O-O" || removePiece == "O-O"){
                moveNote = removePiece;
                removePiece = "";
            }
            if(selected.id.substring(0,2) == "bP" || piece_capture ){
                fiftfy_move_count = 0;
                piece_capture = false;
            } else {
                fiftfy_move_count++;                
            }
            document.querySelectorAll(".move:last-child")[0].getElementsByTagName('td')[1].innerHTML = moveNote;
        } 
        else {
        }
        
        
        
        
        // check if game is over after this move
        check_fifty_move_rule();
        checkIfGameOver();
        if(checkInsufficientMaterial()){
            GAME_OVER = true;
            $('gameOverNotice').style.display = "block";
            $('gameOverNotice').children[0].innerHTML = "Insufficient Material!";
            alert("Insufficient Material!");
        }
    }
    // else {
    // }    
}

var player = "";
var TURN = "white";
var GAME_OVER = false;
var fiftfy_move_count = 0;
var VALID_POSITIONS = [
    "a1","b1","c1","d1","e1","f1","g1","h1",
    "a2","b2","c2","d2","e2","f2","g2","h2",
    "a3","b3","c3","d3","e3","f3","g3","h3",
    "a4","b4","c4","d4","e4","f4","g4","h4",
    "a5","b5","c5","d5","e5","f5","g5","h5",
    "a6","b6","c6","d6","e6","f6","g6","h6",
    "a7","b7","c7","d7","e7","f7","g7","h7",
    "a8","b8","c8","d8","e8","f8","g8","h8"
];

// conditions for castling for both white and black.
var Moved_castle = {
    "wK": false,
    "wRw": false,
    "wRb": false,
    "bK": false,
    "bRw": false,
    "bRb": false
}
// used for keeping track of number of pieces for both black and white.
var black_pieces =["bP1","bP2","bP3","bP4","bP5","bP6","bP7","bP8",
                    "bRb","bKb","bBb","bQ","bK","bBw","bKw","bRw"];
var white_pieces =["wRw","wKw","wBw","wQ","wK","wBb",
                    "wKb","wRb","wP1","wP2","wP3","wP4","wP5","wP6","wP7","wP8"];

// all the default pieces and its position on the board
// and promoted pieces will be added if the pawn is promoted
var current_setup ={
    'wRb': "a1",
    "wKw": "b1",
    "wBb": "c1",
    "wQ": "d1",
    "wK": "e1",
    "wBw": "f1",
    "wKb": "g1",
    "wRw": "h1",
    
    'wP1': "a2",
    "wP2": "b2",
    "wP3": "c2",
    "wP4": "d2",
    "wP5": "e2",
    "wP6": "f2",
    "wP7": "g2",
    "wP8": "h2",

    'bP1': "a7",
    "bP2": "b7",
    "bP3": "c7",
    "bP4": "d7",
    "bP5": "e7",
    "bP6": "f7",
    "bP7": "g7",
    "bP8": "h7",
    
    'bRw': "a8",
    "bKb": "b8",
    "bBw": "c8",
    "bQ": "d8",
    "bK": "e8",
    "bBb": "f8",
    "bKw": "g8",
    "bRb": "h8"
};
// used for counting the number of pieces that got promoted for creating a unique id
// html codes for => Rook, Knight, Bishop, Queen.
var promoted_counter = {
 // promoted white pieces counter for id
    "w_R" : [0,"&#9814"],
    "w_K" : [0,"&#9816"],
    "w_B" : [0,"&#9815"],
    "w_Q" : [0,"&#9813"],
    // promoted black pieces counter for id
    "b_R" : [0, "&#9820"],
    "b_K" : [0, "&#9822"],
    "b_B" : [0, "&#9821"],
    "b_Q" : [0, "&#9819"]
};

////////////////////////// get element by id
var $ = function( id ) { return document.getElementById( id ); };
//$('black-turn').style.display = "none";
//////////////////////////

// does not check whether the move will stop or result in check.
// just shows all the moves
function addHighlight(piece){
    
    //
    ////// Rook
    if(piece.id == "bRw" || piece.id == "bRb" || piece.id == "wRw" || piece.id == "wRb"
        || piece.id.substring(0,3) == "w_R" || piece.id.substring(0,3) == "b_R"){
        var currPos = current_setup[piece.id];
        var temp = Number(currPos[1]);
        while(temp > 0 ){
            if(Number(currPos[1]) != temp){
                var id = currPos[0]+temp.toString();
                if($(id).children.length == 0)
                    $(id).classList.add("highlight");
                else 
                    break;
            }
            temp--;
        }
        var temp2 = Number(currPos[1]);
        while(temp2 < 9 ){
            if(Number(currPos[1]) != temp2){
                var id = currPos[0]+temp2.toString();
                if($(id).children.length == 0)
                    $(id).classList.add("highlight");
                else 
                    break;
            }
            temp2++;
         }
        var index = currPos[0].charCodeAt(0);
        while(index >96){
            if(currPos[0].charCodeAt(0) != index){
                var id =  String.fromCharCode(index)+currPos[1];
                if($(id).children.length == 0) 
                $(id).classList.add("highlight");
                else break;
            }            
            index--;
        }
        var index2 = currPos[0].charCodeAt(0);
        while(index2 < 105){
            if(currPos[0].charCodeAt(0) != index2){
                var id =  String.fromCharCode(index2)+currPos[1];
                if($(id).children.length == 0) 
                $(id).classList.add("highlight");
                else break;
            }            
            index2++;
        }        
    } 
    ///////// Knight
    else if(piece.id == "bKw" || piece.id == "bKb" || piece.id == "wKw" || piece.id == "wKb"
        || piece.id.substring(0,3) == "w_K" || piece.id.substring(0,3) == "b_K"){
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);
        // up left and right
        if(charIndex - 1 >= 97 && numIndex +2 <= 8 ){
            var id = String.fromCharCode(charIndex-1)+(numIndex +2);
            if($(id).children.length == 0) 
            $(id).classList.add("highlight");
        }
        if(charIndex + 1  <= 104 && numIndex + 2 <= 8){
            var id = String.fromCharCode(charIndex+1)+(numIndex+2);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        // down : left and right;
        if(charIndex - 1 >= 97 && numIndex - 2 >= 1 ){
            var id = String.fromCharCode(charIndex-1)+(numIndex-2);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        if(charIndex + 1  <= 104 && numIndex - 2 >= 1){
            var id = String.fromCharCode(charIndex+1)+(numIndex-2);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        //left:  up and down
        if(charIndex - 2 >= 97 && numIndex + 1 <= 8 ){
            var id = String.fromCharCode(charIndex-2)+(numIndex+1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        if(charIndex - 2  >= 97 && numIndex - 1 >= 1){
            var id = String.fromCharCode(charIndex-2)+(numIndex-1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        //right: up and down
        if(charIndex + 2 <= 104 && numIndex + 1 <= 8 ){
            var id = String.fromCharCode(charIndex+2)+(numIndex+1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        if(charIndex + 2  <= 104 && numIndex - 1 >= 1){
            var id = String.fromCharCode(charIndex+2)+(numIndex-1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
    } 
    ////// Black Pawns
    else if(piece.id == "bP1" || piece.id == "bP2" || piece.id == "bP3" || piece.id == "bP4" || piece.id == "bP5" || piece.id == "bP6" || piece.id == "bP7" || piece.id == "bP8"){        
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        if(numIndex == 7){
            var id = currPos[0] + (numIndex -1);
            var id2 = currPos[0] + (numIndex - 2);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
            if($(id).children.length == 0 && $(id2).children.length == 0)
            $(id2).classList.add("highlight");
        } else {
            var id = currPos[0] + (numIndex -1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
    } 
    ////// White Pawns
    else if(piece.id == "wP1" || piece.id == "wP2" || piece.id == "wP3" || piece.id == "wP4" || piece.id == "wP5" || piece.id == "wP6" || piece.id == "wP7" || piece.id == "wP8"){        
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        if(numIndex == 2){
            var id = currPos[0] + (numIndex +1);
            var id2 = currPos[0] + (numIndex + 2);
            if($(id).children.length == 0)
                $(id).classList.add("highlight");
            if($(id).children.length == 0 && $(id2).children.length == 0)
                $(id2).classList.add("highlight");
        } else {
            var id = currPos[0] + (numIndex +1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
    }
    ////// Bishop
    else if(piece.id == "bBw" || piece.id == "bBb" || piece.id == "wBb" || piece.id == "wBw" 
        || piece.id.substring(0,3) == "w_B" || piece.id.substring(0,3) == "b_B"){
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);        
        // left to downright
        while(charIndex < 104){
            if(numIndex == 1)break;
            charIndex++;
            numIndex--;            
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
            else break;
        }
        // left to upright
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex < 104){
            if(numIndex == 8)break;
            charIndex++;
            numIndex++;            
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
            else break;
        }
        // right to downleft
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 1)break;
            charIndex--;
            numIndex--;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
            else break;
        }
        //right to upleft
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 8 )break;
            charIndex--;
            numIndex++;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
            else break;
        }
    }
    ////// Queen
    else if(piece.id == "bQ" || piece.id == "wQ"
        || piece.id.substring(0,3) == "w_Q" || piece.id.substring(0,3) == "b_Q" ){
        var currPos = current_setup[piece.id];
        var temp = Number(currPos[1]);
        //straight lines 
        ////// down       
        while(temp > 0 ){
            if(Number(currPos[1]) != temp){
                var id = currPos[0]+temp.toString();
                if($(id).children.length == 0)
                $(id).classList.add("highlight");
                else break;
            }
            temp--;
        }
        ////// up
        var temp2 = Number(currPos[1]);
        while(temp2 < 9 ){
            if(Number(currPos[1]) != temp2){
                var id = currPos[0]+temp2.toString();
                if($(id).children.length == 0) 
                $(id).classList.add("highlight");
                else break;
            }
            temp2++;
        }
        ////// right
        var index = currPos[0].charCodeAt(0);
        while(index >96){
            if(currPos[0].charCodeAt(0) != index){
                var id =  String.fromCharCode(index)+currPos[1];
                if($(id).children.length == 0) 
                $(id).classList.add("highlight");
                else break;
            }            
            index--;
        }
        ////// left
        var index2 = currPos[0].charCodeAt(0);
        while(index2 < 105){
            if(currPos[0].charCodeAt(0) != index2){
                var id =  String.fromCharCode(index2)+currPos[1];
                if($(id).children.length == 0)
                $(id).classList.add("highlight");
                else break;
            }            
            index2++;
        }
        //diagonal
        
         numIndex = Number(currPos[1]);
         charIndex = currPos[0].charCodeAt(0);
        
        // left to downright
        while(charIndex < 104){
            if(numIndex == 1)break;
            charIndex++;
            numIndex--;                     
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
            else break;
        }
        // left to upright
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex < 104){
            if(numIndex == 8)break;
            charIndex++;
            numIndex++;                      
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
            else break;
        }
        // right to downleft
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 1)break;
            charIndex--;
            numIndex--;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
            else break;
        }
        //right to upleft
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 8 )break;
            charIndex--;
            numIndex++;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
            else break;
        }
    }
    ////// King
    else if(piece.id == "bK" || piece.id == "wK" ){
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);
        if(charIndex + 1 <= 104){
            var id =  String.fromCharCode(charIndex+1) + (numIndex);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        if(charIndex - 1 >= 97){
            var id =  String.fromCharCode(charIndex-1) + (numIndex);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        if(numIndex + 1 <= 8){
            var id =  String.fromCharCode(charIndex) + (numIndex+1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }        
        if(numIndex - 1 >= 1){
            var id =  String.fromCharCode(charIndex) + (numIndex-1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        if(charIndex + 1 <= 104 && numIndex+1 <= 8){
            var id =  String.fromCharCode(charIndex+1) + (numIndex+1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        if(charIndex + 1 <= 104 && numIndex-1 >= 1){
            var id =  String.fromCharCode(charIndex+ 1) + (numIndex-1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        if(charIndex - 1  >= 97  && numIndex+1 <= 8){
            var id =  String.fromCharCode(charIndex-1) + (numIndex+1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        }
        if(charIndex - 1 >= 97 && numIndex-1 >= 1){
            var id =  String.fromCharCode(charIndex-1) + (numIndex-1);
            if($(id).children.length == 0)
            $(id).classList.add("highlight");
        } 
        if(piece.id == "bK" && !Moved_castle["bK"]){
            
            if(!Moved_castle["bRb"] && current_setup["bRb"]!= "x"){
                
                if($("f8").children.length == 0 && $("g8").children.length==0){
                    var id =  String.fromCharCode(charIndex+2) + (numIndex);
                    
                    $(id).classList.add("highlight");
                }
            } 
            if(!Moved_castle["bRw"] && current_setup["bRw"]!= "x"){
                
                if($("d8").children.length == 0 && $("c8").children.length ==0 && $("b8").children.length ==0){
                    var id =  String.fromCharCode(charIndex-2) + (numIndex); 
                    
                    $(id).classList.add("highlight");
                }
            }
        } else if(piece.id == "wK" && !Moved_castle["wK"]){
            
            if(!Moved_castle["wRw"]&& current_setup["wRw"]!= "x"){
                
                if($("f1").children.length == 0 && $("g1").children.length==0){
                    var id =  String.fromCharCode(charIndex+2) + (numIndex);                    
                    $(id).classList.add("highlight");
                }
            } 
            if(!Moved_castle["wRb"] && current_setup["wRb"]!= "x"){
                
                if($("d1").children.length == 0 && $("c1").children.length ==0 && $("b1").children.length ==0){
                    var id =  String.fromCharCode(charIndex-2) + (numIndex);                    
                    $(id).classList.add("highlight");
                }
            }
        }    
    }
}

/* /////////////////////// Remove moves Highlight //////////////////// */
function removeHighlight(piece){
    sendHighlightPiece(piece.id, false)
    ////// Rook
    if(!current_setup[selected.id]) {
        return
    }
    $(current_setup[selected.id]).classList.remove("selected");
    if(piece.id == "bRw" || piece.id == "bRb" || piece.id == "wRw" || piece.id == "wRb"
        || piece.id.substring(0,3) == "w_R" || piece.id.substring(0,3) == "b_R"){
        var currPos = current_setup[piece.id];
        var temp = Number(currPos[1]);
        ////// down
        while(temp > 0 ){
            if(Number(currPos[1]) != temp){
                var id = currPos[0]+temp.toString();
                if($(id).children.length != 0) break;
                $(id).classList.remove("highlight");
            }
            temp--;
        }
        ////// up
        var temp2 = Number(currPos[1]);
        while(temp2 < 9 ){
            if(Number(currPos[1]) != temp2){
                var id = currPos[0]+temp2.toString();
                if($(id).children.length != 0) break;
                $(id).classList.remove("highlight");
            }
            temp2++;
        }
         ////// left
        var index = currPos[0].charCodeAt(0);
        while(index >96){
            if(currPos[0].charCodeAt(0) != index){
                var id =  String.fromCharCode(index)+currPos[1];
                if($(id).children.length != 0) break;
                $(id).classList.remove("highlight");
            }
            index--;
        }
        ////// right
        var index2 = currPos[0].charCodeAt(0);
        while(index2 < 105){
            if(currPos[0].charCodeAt(0) != index2){
                var id =  String.fromCharCode(index2)+currPos[1];
                if($(id).children.length != 0) break;
                $(id).classList.remove("highlight");
            }
            index2++;
        }        
    } 
    ////// Knight
    else if(piece.id == "bKw" || piece.id == "bKb" || piece.id == "wKw" || piece.id == "wKb"
        || piece.id.substring(0,3) == "w_K" || piece.id.substring(0,3) == "b_K"){
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);
        // up left and right
        if(charIndex - 1 >= 97 && numIndex +2 <= 8 ){
            var id = String.fromCharCode(charIndex-1)+(numIndex +2);
            $(id).classList.remove("highlight");
        }
        if(charIndex + 1  <= 104 && numIndex + 2 <= 8){
            var id = String.fromCharCode(charIndex+1)+(numIndex+2);
            $(id).classList.remove("highlight");
        }
        // down : left and right;
        if(charIndex - 1 >= 97 && numIndex - 2 >= 1 ){
            var id = String.fromCharCode(charIndex-1)+(numIndex-2);
            $(id).classList.remove("highlight");
        }
        if(charIndex + 1  <= 104 && numIndex - 2 >= 1){
            var id = String.fromCharCode(charIndex+1)+(numIndex-2);
            $(id).classList.remove("highlight");
        }
        //left:  up and down
        if(charIndex - 2 >= 97 && numIndex + 1 <= 8 ){
            var id = String.fromCharCode(charIndex-2)+(numIndex+1);
            $(id).classList.remove("highlight");
        }
        if(charIndex - 2  >= 97 && numIndex - 1 >= 1){
            var id = String.fromCharCode(charIndex-2)+(numIndex-1);
            $(id).classList.remove("highlight");
        }
        //right: up and down
        if(charIndex + 2 <= 104 && numIndex + 1 <= 8 ){
            var id = String.fromCharCode(charIndex+2)+(numIndex+1);
            $(id).classList.remove("highlight");
        }
        if(charIndex + 2  <= 104 && numIndex - 1 >= 1){
            var id = String.fromCharCode(charIndex+2)+(numIndex-1);
            $(id).classList.remove("highlight");
        }
    }
    ////// Black Pawns
    else if(piece.id == "bP1" || piece.id == "bP2" || piece.id == "bP3" || piece.id == "bP4" || piece.id == "bP5" || piece.id == "bP6" || piece.id == "bP7" || piece.id == "bP8"){        
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        if(numIndex == 7){
            var id = currPos[0] + (numIndex -1);
            var id2 = currPos[0] + (numIndex - 2);
            $(id).classList.remove("highlight");
            $(id2).classList.remove("highlight");
        } else {
            var id = currPos[0] + (numIndex -1);
            $(id).classList.remove("highlight");
        }
    } 
    ////// White Pawns
    else if(piece.id == "wP1" || piece.id == "wP2" || piece.id == "wP3" || piece.id == "wP4" || piece.id == "wP5" || piece.id == "wP6" || piece.id == "wP7" || piece.id == "wP8"){        
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        if(numIndex == 2){
            var id = currPos[0] + (numIndex +1);
            var id2 = currPos[0] + (numIndex + 2);
            $(id).classList.remove("highlight");
            $(id2).classList.remove("highlight");
        } else {
            var id = currPos[0] + (numIndex +1);
            $(id).classList.remove("highlight");
        }
    } 
    ////// Bishop
    else if(piece.id == "bBw" || piece.id == "bBb" || piece.id == "wBb" || piece.id == "wBw"
    || piece.id.substring(0,3) == "w_B" || piece.id.substring(0,3) == "b_B"){
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);
        
        // left to downright
        while(charIndex < 104){
            if(numIndex == 1)break;
            charIndex++;
            numIndex--;            
            var id =  String.fromCharCode(charIndex) + (numIndex);
            $(id).classList.remove("highlight");
        }
        // left to upright
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex < 104){
            if(numIndex == 8)break;
            charIndex++;
            numIndex++;            
            var id =  String.fromCharCode(charIndex) + (numIndex);
            $(id).classList.remove("highlight");
        }
        // right to downleft
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 1)break;
            charIndex--;
            numIndex--;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            $(id).classList.remove("highlight");
        }
        //right to upleft
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 8 )break;
            charIndex--;
            numIndex++;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            $(id).classList.remove("highlight");
        }
    } 
    ////// Queen
    else if(piece.id == "bQ" || piece.id == "wQ" || piece.id.substring(0,3) == "w_Q" || piece.id.substring(0,3) == "b_Q"){
        var currPos = current_setup[piece.id];
        var temp = Number(currPos[1]);
        //diagonal  
        ////// down      
        while(temp > 0 ){
            if(Number(currPos[1]) != temp){
                var id = currPos[0]+temp.toString();
                if($(id).children.length != 0) break;
                $(id).classList.remove("highlight");
            }
            temp--;
        }
        var temp2 = Number(currPos[1]);
        ////// up
        while(temp2 < 9 ){
            if(Number(currPos[1]) != temp2){
                var id = currPos[0]+temp2.toString();
                if($(id).children.length != 0) break;
                $(id).classList.remove("highlight");
            }
            temp2++;
         }
        var index = currPos[0].charCodeAt(0);
        ////// left
        while(index >96){
            if(currPos[0].charCodeAt(0) != index){
                var id =  String.fromCharCode(index)+currPos[1];
                if($(id).children.length != 0) break;
                $(id).classList.remove("highlight");
            }            
            index--;
        }
        var index2 = currPos[0].charCodeAt(0);
        ////// right
        while(index2 < 105){
            if(currPos[0].charCodeAt(0) != index2){
                var id =  String.fromCharCode(index2)+currPos[1];
                if($(id).children.length != 0) break;
                $(id).classList.remove("highlight");
            }            
            index2++;
        }

        //lines        
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);        
        // left to downright
        while(charIndex < 104){
            if(numIndex == 1)break;
            charIndex++;
            numIndex--;            
            var id =  String.fromCharCode(charIndex) + (numIndex);
            $(id).classList.remove("highlight");
        }
        // left to upright
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex < 104){
            if(numIndex == 8)break;
            charIndex++;
            numIndex++;            
            var id =  String.fromCharCode(charIndex) + (numIndex);
            $(id).classList.remove("highlight");
        }
        // right to downleft
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 1)break;
            charIndex--;
            numIndex--;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            $(id).classList.remove("highlight");
        }
        //right to upleft
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 8 )break;
            charIndex--;
            numIndex++;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            $(id).classList.remove("highlight");
        }
    } 
    ////// King
    else if(piece.id == "bK" || piece.id == "wK" ){
         var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);
        if(charIndex + 1 <= 104){
            var id =  String.fromCharCode(charIndex+1) + (numIndex);
            $(id).classList.remove("highlight");
        }        
        if(charIndex - 1 >= 97){
            var id =  String.fromCharCode(charIndex-1) + (numIndex);
            $(id).classList.remove("highlight");
        }
        if(numIndex + 1 <= 8){
            var id =  String.fromCharCode(charIndex) + (numIndex+1);
            $(id).classList.remove("highlight");
        }        
        if(numIndex - 1 >= 1){
            var id =  String.fromCharCode(charIndex) + (numIndex-1);
            $(id).classList.remove("highlight");
        }
        if(charIndex + 1 <= 104 && numIndex+1 <= 8){
            var id =  String.fromCharCode(charIndex+1) + (numIndex+1);
            $(id).classList.remove("highlight");
        }
        if(charIndex + 1 <= 104 && numIndex-1 >= 1){
            var id =  String.fromCharCode(charIndex+ 1) + (numIndex-1);
            $(id).classList.remove("highlight");
        }
        if(charIndex - 1  >= 97  && numIndex+1 <= 8){
            var id =  String.fromCharCode(charIndex-1) + (numIndex+1);
            $(id).classList.remove("highlight");
        }
        if(charIndex - 1 >= 97 && numIndex-1 >= 1){
            var id =  String.fromCharCode(charIndex-1) + (numIndex-1);
            $(id).classList.remove("highlight");
        }
        if(piece.id == "bK" && !Moved_castle["bK"] && current_setup["bK"] == "e8"){
            if(!Moved_castle["bRb"]){
                if($("f8").children.length == 0 && $("g8").children.length==0){
                    var id =  String.fromCharCode(charIndex+2) + (numIndex);                    
                    $(id).classList.remove("highlight");
                }
            } 
            if(!Moved_castle["bRw"]){
                if($("d8").children.length == 0 && $("c8").children.length ==0 && $("b8").children.length ==0){
                    var id =  String.fromCharCode(charIndex-2) + (numIndex);                    
                    $(id).classList.remove("highlight");
                }
            }
        } else if(piece.id == "wK" && !Moved_castle["wK"] && current_setup["wK"] == "e1"){
            if(!Moved_castle["wRw"] && current_setup["wRw"] != "x"){
                if($("f1").children.length == 0 && $("g1").children.length==0){
                    var id =  String.fromCharCode(charIndex+2) + (numIndex);                    
                    $(id).classList.remove("highlight");
                }
            }
            if(!Moved_castle["wRb"] && current_setup["wRb"] != "x"){
                if($("d1").children.length == 0 && $("c1").children.length ==0 && $("b1").children.length ==0){
                    var id =  String.fromCharCode(charIndex-2) + (numIndex);                    
                    $(id).classList.remove("highlight");
                }
            }
        }        
    }
    
}

// If the square is protected by the other king.
function isKingProtectingTheSquare(posId){
        // check the white or black king's covered squares
        var currPos;
        if(TURN == "white"){
            currPos = current_setup["bK"];
        } else if(TURN == "black"){
            currPos = current_setup["wK"];
        }
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);
        if(charIndex + 1 <= 104){
            var id =  String.fromCharCode(charIndex+1) + (numIndex);
            if(id == posId)
                return true;
        }        
        if(charIndex - 1 >= 97){
            var id =  String.fromCharCode(charIndex-1) + (numIndex);
            if(id == posId)
                return true;
        }
        if(numIndex + 1 <= 8){
            var id =  String.fromCharCode(charIndex) + (numIndex+1);
            if(id == posId)
                return true;
        }        
        if(numIndex - 1 >= 1){
            var id =  String.fromCharCode(charIndex) + (numIndex-1);
            if(id == posId)
                return true;
        }
        if(charIndex + 1 <= 104 && numIndex+1 <= 8){
            var id =  String.fromCharCode(charIndex+1) + (numIndex+1);
            if(id == posId)
                return true;
        }
        if(charIndex + 1 <= 104 && numIndex-1 >= 1){
            var id =  String.fromCharCode(charIndex+ 1) + (numIndex-1);
            if(id == posId)
                return true;
        }
        if(charIndex - 1  >= 97  && numIndex+1 <= 8){
            var id =  String.fromCharCode(charIndex-1) + (numIndex+1);
            if(id == posId)
                return true;
        }
        if(charIndex - 1 >= 97 && numIndex-1 >= 1){
            var id =  String.fromCharCode(charIndex-1) + (numIndex-1);
            if(id == posId)
                return true;
        }
    
    return false;
}

// returns a number of possible moves
// used for cheking if the game is over or stalemate
function getAllPossibleMove(){
    // check all the possible legal moves and see if it can stop the check
    // add it to taotalMoves and return it
    var TotalMoves = 0;
    if(TURN == "black")
    {
        for (const piece of black_pieces) {
            if(current_setup[piece] == "x") continue;            
            ////// Rook

            if(piece == "bRw" || piece == "bRb" || piece.substring(0,3) == "b_R"){
                var currPos = current_setup[piece];
                var temp = Number(currPos[1]);
                while(temp > 0 ){
                    if(Number(currPos[1]) != temp){
                        var id = currPos[0]+temp.toString();
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a white piece except black king
                        else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                            // remove the piece, and see, then stop don't go further
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        }  else {
                            break;
                        }
                    }
                    temp--;
                }
                var temp2 = Number(currPos[1]);
                while(temp2 < 9 ){
                    if(Number(currPos[1]) != temp2){
                        var id = currPos[0]+temp2.toString();
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a white piece except black king
                        else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                            // remove the piece, and see, then stop don't go further
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        }  else {
                            break;
                        }
                    }
                    temp2++;
                 }
                var index = currPos[0].charCodeAt(0);
                while(index >96){
                    if(currPos[0].charCodeAt(0) != index){
                        var id =  String.fromCharCode(index)+currPos[1];
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a white piece except black king
                        else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                            // remove the piece, and see, then stop don't go further
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        }  else {
                            break;
                        }
                    }            
                    index--;
                }
                var index2 = currPos[0].charCodeAt(0);
                while(index2 < 105){
                    if(currPos[0].charCodeAt(0) != index2){
                        var id =  String.fromCharCode(index2)+currPos[1];
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a white piece except black king
                        else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                            // remove the piece, and see, then stop don't go further
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        }  else {
                            break;
                        }
                    }            
                    index2++;
                }        
            } 
            ///////// Knight
            else if(piece == "bKw" || piece == "bKb" || piece.substring(0,3) == "b_K"){
                var currPos = current_setup[piece];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);
                // up left and right
                if(charIndex - 1 >= 97 && numIndex +2 <= 8 ){
                    var id = String.fromCharCode(charIndex-1)+(numIndex +2);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex + 1  <= 104 && numIndex + 2 <= 8){
                    var id = String.fromCharCode(charIndex+1)+(numIndex+2);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                // down : left and right;
                if(charIndex - 1 >= 97 && numIndex - 2 >= 1 ){
                    var id = String.fromCharCode(charIndex-1)+(numIndex-2);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex + 1  <= 104 && numIndex - 2 >= 1){
                    var id = String.fromCharCode(charIndex+1)+(numIndex-2);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                //left:  up and down
                if(charIndex - 2 >= 97 && numIndex + 1 <= 8 ){
                    var id = String.fromCharCode(charIndex-2)+(numIndex+1);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex - 2  >= 97 && numIndex - 1 >= 1){
                    var id = String.fromCharCode(charIndex-2)+(numIndex-1);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                //right: up and down
                if(charIndex + 2 <= 104 && numIndex + 1 <= 8 ){
                    var id = String.fromCharCode(charIndex+2)+(numIndex+1);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex + 2  <= 104 && numIndex - 1 >= 1){
                    var id = String.fromCharCode(charIndex+2)+(numIndex-1);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
            } 
            ////// Black Pawns
            else if(piece == "bP1" || piece == "bP2" || piece == "bP3" || piece == "bP4" 
                || piece == "bP5" || piece == "bP6" || piece == "bP7" || piece == "bP8"){        
                var currPos = current_setup[piece];
                var numIndex = Number(currPos[1]);
                
                var id = currPos[0] + (numIndex -1);
                var id2 = currPos[0] + (numIndex - 2);
                if($(id).children.length == 0)
                {   
                    var dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece] = id;
                    if(!IsKingInCheck(dummyBoard)){
                        TotalMoves++;
                    }
                }
                if($(id).children.length == 0 && numIndex == 7 && $(id2).children.length == 0)
                {   
                    var dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece] = id;
                    if(!IsKingInCheck(dummyBoard)){
                        TotalMoves++;
                    }
                }
                // left
                var charIndex = currPos[0].charCodeAt(0);
                if(charIndex - 1 >=97) {
                    var id = String.fromCharCode(charIndex-1) + (numIndex - 1);
                    var dummyBoard = Object.assign({}, current_setup);
                    if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";                        
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }                    
                }
                //right
                if(charIndex + 1 <=104){
                    var id = String.fromCharCode(charIndex+1) + (numIndex - 1);
                    var dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece] = id;
                    if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";                        
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
            }
            ////// Bishop
            else if(piece == "bBw" || piece == "bBb" || piece.substring(0,3) == "b_B"){
                var currPos = current_setup[piece];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);        
                // left to downright
                while(charIndex < 104){
                    if(numIndex == 1)break;
                    charIndex++;
                    numIndex--;            
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                // left to upright
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex < 104){
                    if(numIndex == 8)break;
                    charIndex++;
                    numIndex++;            
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                // right to downleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 1)break;
                    charIndex--;
                    numIndex--;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                //right to upleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 8 )break;
                    charIndex--;
                    numIndex++;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
            }
            ////// Queen
            else if(piece == "bQ" || piece.substring(0,3) == "b_Q"){
                var currPos = current_setup[piece];
                var temp = Number(currPos[1]);
                //straight lines 
                ////// down       
                while(temp > 0 ){
                    if(Number(currPos[1]) != temp){
                        var id = currPos[0]+temp.toString();
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a white piece
                        else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                            // remove the piece, and see, then stop, don't go any further.
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        } else {
                            break;
                        }
                    }
                    temp--;
                }
                ////// up
                var temp2 = Number(currPos[1]);
                while(temp2 < 9 ){
                    if(Number(currPos[1]) != temp2){
                        var id = currPos[0]+temp2.toString();
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a white piece
                        else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                            // remove the piece, and see, then stop, don't go any further.
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        } else {
                            break;
                        }
                    }
                    temp2++;
                }
                ////// right
                var index = currPos[0].charCodeAt(0);
                while(index >96){
                    if(currPos[0].charCodeAt(0) != index){
                        var id =  String.fromCharCode(index)+currPos[1];
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a white piece
                        else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                            // remove the piece, and see, then stop, don't go any further.
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        } else {
                            break;
                        }
                    }            
                    index--;
                }
                ////// left
                var index2 = currPos[0].charCodeAt(0);
                while(index2 < 105){
                    if(currPos[0].charCodeAt(0) != index2){
                        var id =  String.fromCharCode(index2)+currPos[1];
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a white piece
                        else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                            // remove the piece, and see, then stop, don't go any further.
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        } else {
                            break;
                        }
                    }            
                    index2++;
                }
                //diagonal
                
                 numIndex = Number(currPos[1]);
                 charIndex = currPos[0].charCodeAt(0);
                
                // left to downright
                while(charIndex < 104){
                    if(numIndex == 1)break;
                    charIndex++;
                    numIndex--;                     
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                // left to upright
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex < 104){
                    if(numIndex == 8)break;
                    charIndex++;
                    numIndex++;                      
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                // right to downleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 1)break;
                    charIndex--;
                    numIndex--;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                //right to upleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 8 )break;
                    charIndex--;
                    numIndex++;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) && $(id).children[0].id != "wK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
            }
            ////// King
            else if(piece == "bK"){
                var currPos = current_setup[piece];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);
                if(charIndex + 1 <= 104){
                    var id =  String.fromCharCode(charIndex+1) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) 
                        && $(id).children[0].id != "wK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }        
                if(charIndex - 1 >= 97){
                    var id =  String.fromCharCode(charIndex-1) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) 
                        && $(id).children[0].id != "wK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard) ){
                            TotalMoves++;
                        }
                    }
                }
                if(numIndex + 1 <= 8){
                    var id =  String.fromCharCode(charIndex) + (numIndex+1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) 
                        && $(id).children[0].id != "wK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }        
                if(numIndex - 1 >= 1){
                    var id =  String.fromCharCode(charIndex) + (numIndex-1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) 
                        && $(id).children[0].id != "wK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex + 1 <= 104 && numIndex+1 <= 8){
                    var id =  String.fromCharCode(charIndex+1) + (numIndex+1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id) 
                        && $(id).children[0].id != "wK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex + 1 <= 104 && numIndex-1 >= 1){
                    var id =  String.fromCharCode(charIndex+ 1) + (numIndex-1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id)
                        && $(id).children[0].id != "wK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex - 1  >= 97  && numIndex+1 <= 8){
                    var id =  String.fromCharCode(charIndex-1) + (numIndex+1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id)
                    && $(id).children[0].id != "wK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex - 1 >= 97 && numIndex-1 >= 1){
                    var id =  String.fromCharCode(charIndex-1) + (numIndex-1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a white piece
                    else if($(id).children.length != 0 && white_pieces.includes($(id).children[0].id)
                        && $(id).children[0].id != "wK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                // check if the square is seen by other king
            }
        }
    }
    else if(TURN == "white")
    {
        for (const piece of white_pieces) {
            if(current_setup[piece] == "x") continue;
            ////// Rook
            if(piece == "wRw" || piece == "wRb" || piece.substring(0,3) == "w_R") {
                var currPos = current_setup[piece];
                var temp = Number(currPos[1]);
                // rook down
                while(temp > 0 ){
                    if(Number(currPos[1]) != temp){
                        var id = currPos[0]+temp.toString();
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a black piece except black king
                        else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                            // remove the piece, and see, then stop don't go further
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        }  else {
                            break;
                        }
                    }
                    temp--;
                }
                // rook up
                var temp2 = Number(currPos[1]);
                while(temp2 < 9 ) {
                    if(Number(currPos[1]) != temp2) {
                        var id = currPos[0]+temp2.toString();
                        if($(id).children.length == 0){
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a black piece
                        else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                            // remove the piece, and see, then stop don't go further
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        } else {
                            break;
                        }
                    }
                    temp2++;
                }
                // rook left
                var index = currPos[0].charCodeAt(0);
                while(index >96){
                    if(currPos[0].charCodeAt(0) != index){
                        var id =  String.fromCharCode(index)+currPos[1];
                        if($(id).children.length == 0) 
                        {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a black piece
                        else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                            // remove the piece, and see, then stop don't go further
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        }  else {
                            break;
                        }
                    }            
                    index--;
                }
                // rook right
                var index2 = currPos[0].charCodeAt(0);
                while(index2 < 105){
                    if(currPos[0].charCodeAt(0) != index2){
                        var id =  String.fromCharCode(index2)+currPos[1];
                        if($(id).children.length == 0){
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        }
                        else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                            // remove the piece, and see, then stop don't go further
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        }  else {
                            // white piece is on the way
                            break;
                        }
                    }            
                    index2++;
                }        
            } 
            ///////// Knight
            else if(piece == "wKw" || piece == "wKb" || piece.substring(0,3) == "w_K" ) {
                var currPos = current_setup[piece];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);
                // up left and right
                if(charIndex - 1 >= 97 && numIndex +2 <= 8 ){
                    var id = String.fromCharCode(charIndex-1)+(numIndex +2);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex + 1  <= 104 && numIndex + 2 <= 8){
                    var id = String.fromCharCode(charIndex+1)+(numIndex+2);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                // down : left and right;
                if(charIndex - 1 >= 97 && numIndex - 2 >= 1 ){
                    var id = String.fromCharCode(charIndex-1)+(numIndex-2);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex + 1  <= 104 && numIndex - 2 >= 1){
                    var id = String.fromCharCode(charIndex+1)+(numIndex-2);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                //left:  up and down
                if(charIndex - 2 >= 97 && numIndex + 1 <= 8 ){
                    var id = String.fromCharCode(charIndex-2)+(numIndex+1);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex - 2  >= 97 && numIndex - 1 >= 1){
                    var id = String.fromCharCode(charIndex-2)+(numIndex-1);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                //right: up and down
                if(charIndex + 2 <= 104 && numIndex + 1 <= 8 ){
                    var id = String.fromCharCode(charIndex+2)+(numIndex+1);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex + 2  <= 104 && numIndex - 1 >= 1){
                    var id = String.fromCharCode(charIndex+2)+(numIndex-1);
                    if($(id).children.length == 0) 
                    {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK") {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[$(id).children[0].id] = "x";
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
            }             
            ////// White Pawns
            else if(piece == "wP1" || piece == "wP2" || piece == "wP3" || piece == "wP4" ||
             piece == "wP5" || piece == "wP6" || piece == "wP7" || piece == "wP8"){        
                // check left, up 1 or 2, right, en passant
                var currPos = current_setup[piece];
                var numIndex = Number(currPos[1]);
                // up 1
                var id = currPos[0] + (numIndex +1);
                if($(id).children.length == 0)
                {   
                    var dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece] = id;
                    if(!IsKingInCheck(dummyBoard)){
                        TotalMoves++;
                    }
                }
                // up 2
                var id2 = currPos[0] + (numIndex + 2);
                if(numIndex == 2 && $(id).children.length == 0 && $(id2).children.length == 0)
                {
                    var dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece] = id;
                    if(!IsKingInCheck(dummyBoard)){
                        TotalMoves++;
                    }
                }
                // left    
                var charIndex = currPos[0].charCodeAt(0);
                if(charIndex - 1 >=97) {
                    var id = String.fromCharCode(charIndex-1) + (numIndex + 1);
                    var dummyBoard = Object.assign({}, current_setup);
                    if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";                        
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }                    
                }
                //right
                if(charIndex + 1 <=104){
                    var id = String.fromCharCode(charIndex+1) + (numIndex + 1);
                    var dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece] = id;
                    if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";                        
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                //en passant 
                
            }
            ////// Bishop
            else if(piece == "wBb" || piece  == "wBw" || piece.substring(0,3) == "w_B"){
                
                var currPos = current_setup[piece];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);        
                // left to downright
                while(charIndex < 104){
                    if(numIndex == 1)break;
                    charIndex++;
                    numIndex--;            
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                // left to upright
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex < 104){
                    if(numIndex == 8)break;
                    charIndex++;
                    numIndex++;            
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                // right to downleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 1)break;
                    charIndex--;
                    numIndex--;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                //right to upleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 8 )break;
                    charIndex--;
                    numIndex++;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
            }
            ////// Queen
            else if(piece == "wQ" || piece.substring(0,3) == "w_Q"){
                var currPos = current_setup[piece];
                var temp = Number(currPos[1]);
                //straight lines 
                ////// down       
                while(temp > 0 ){
                    if(Number(currPos[1]) != temp){
                        var id = currPos[0]+temp.toString();
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a black piece
                        else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                            // remove the piece, and see, then stop, don't go any further.
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        } else {
                            break;
                        }
                    }
                    temp--;
                }
                ////// up
                var temp2 = Number(currPos[1]);
                while(temp2 < 9 ){
                    if(Number(currPos[1]) != temp2){
                        var id = currPos[0]+temp2.toString();
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a black piece
                        else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                            // remove the piece, and see, then stop, don't go any further.
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        } else {
                            break;
                        }
                    }
                    temp2++;
                }
                ////// right
                var index = currPos[0].charCodeAt(0);
                while(index >96){
                    if(currPos[0].charCodeAt(0) != index){
                        var id =  String.fromCharCode(index)+currPos[1];
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a black piece
                        else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                            // remove the piece, and see, then stop, don't go any further.
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        } else {
                            break;
                        }
                    }            
                    index--;
                }
                ////// left
                var index2 = currPos[0].charCodeAt(0);
                while(index2 < 105){
                    if(currPos[0].charCodeAt(0) != index2){
                        var id =  String.fromCharCode(index2)+currPos[1];
                        if($(id).children.length == 0) {
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                        } // must be a black piece
                        else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                            // remove the piece, and see, then stop, don't go any further.
                            var dummyBoard = Object.assign({}, current_setup);
                            dummyBoard[piece] = id;
                            dummyBoard[$(id).children[0].id] = "x";
                            if(!IsKingInCheck(dummyBoard)){
                                TotalMoves++;
                            }
                            break;
                        } else {
                            break;
                        }
                    }            
                    index2++;
                }
                //diagonal
                
                 numIndex = Number(currPos[1]);
                 charIndex = currPos[0].charCodeAt(0);
                
                // left to downright
                while(charIndex < 104){
                    if(numIndex == 1)break;
                    charIndex++;
                    numIndex--;                     
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                // left to upright
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex < 104){
                    if(numIndex == 8)break;
                    charIndex++;
                    numIndex++;                      
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                // right to downleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 1)break;
                    charIndex--;
                    numIndex--;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
                //right to upleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 8 )break;
                    charIndex--;
                    numIndex++;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) && $(id).children[0].id != "bK"){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                        break;
                    } else {
                        break;
                    }
                }
            }
            ////// King
            else if(piece == "wK" ){

                var currPos = current_setup[piece];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);
                if(charIndex + 1 <= 104){
                    var id =  String.fromCharCode(charIndex+1) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id)
                        && $(id).children[0].id != "bK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }        
                if(charIndex - 1 >= 97){
                    var id =  String.fromCharCode(charIndex-1) + (numIndex);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id)
                        && $(id).children[0].id != "bK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(numIndex + 1 <= 8){
                    var id =  String.fromCharCode(charIndex) + (numIndex+1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id)
                        && $(id).children[0].id != "bK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }        
                if(numIndex - 1 >= 1){
                    var id =  String.fromCharCode(charIndex) + (numIndex-1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id)
                        && $(id).children[0].id != "bK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex + 1 <= 104 && numIndex+1 <= 8){
                    var id =  String.fromCharCode(charIndex+1) + (numIndex+1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id)
                        && $(id).children[0].id != "bK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex + 1 <= 104 && numIndex-1 >= 1){
                    var id =  String.fromCharCode(charIndex+ 1) + (numIndex-1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id) 
                        && $(id).children[0].id != "bK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex - 1  >= 97  && numIndex+1 <= 8){
                    var id =  String.fromCharCode(charIndex-1) + (numIndex+1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id)
                        && $(id).children[0].id != "bK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                if(charIndex - 1 >= 97 && numIndex-1 >= 1){
                    var id =  String.fromCharCode(charIndex-1) + (numIndex-1);
                    if($(id).children.length == 0) {
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            TotalMoves++;
                        }
                    } // must be a black piece
                    else if($(id).children.length != 0 && black_pieces.includes($(id).children[0].id)
                        && $(id).children[0].id != "bK" && !isKingProtectingTheSquare(id)){
                        // remove the piece, and see, then stop, don't go any further.
                        var dummyBoard = Object.assign({}, current_setup);
                        dummyBoard[piece] = id;
                        dummyBoard[$(id).children[0].id] = "x";
                        if(!IsKingInCheck(dummyBoard)){
                            TotalMoves++;
                        }
                    }
                }
                // can't castle out of check!                    
            }
        }
    }

    return TotalMoves; 
}

// checking if the opponent is giving a check
// also, for checking in the background if the move will stop a incoming check and is a legal move.
function IsKingInCheck(board) {
    if(TURN == "white"){ 
        // check if there is check from black; and after move
        //  pawns
        var pawns = ["bP1","bP2","bP3","bP4","bP5","bP6","bP7","bP8"];
        var pos = board["wK"];
        for(var i = 0 ; i < pawns.length;i++){
            if(board[pawns[i]] != "x"){ // check if pawn is still in the game
                var currPos = board[pawns[i]];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);
                
                if(charIndex + 1 <=104){
                    var id = String.fromCharCode(charIndex+1) + (numIndex - 1);
                    if(id== pos)
                        return true;
                } 
                if(charIndex - 1 >=97) {
                    var id = String.fromCharCode(charIndex-1) + (numIndex - 1);
                    if(id == pos)
                        return true;
                }                
            }           
        }
        //  Rook        
        var rook = ["bRw","bRb"];
        rook = rook.concat(black_pieces.filter(elem => elem.substring(0,3) === "b_R"));
        for(var i = 0 ; i < rook.length;i++) {
            if(board[rook[i]] != "x"){
                var currPos = board[rook[i]];
                var temp = Number(currPos[1]);
                while(temp > 0 ){
                    if(Number(currPos[1]) != temp){
                        var id = currPos[0]+temp.toString();
                        if(Object.values(board).includes(id) && id != pos) break;
                        if(id == pos)
                            return true;
                    }
                    temp--;
                }
                var temp2 = Number(currPos[1]);
                while(temp2 < 9 ){
                    if(Number(currPos[1]) != temp2){
                        var id = currPos[0]+temp2.toString();
                        if(Object.values(board).includes(id) && id != pos) break;
                        if(id == pos)
                            return true;
                    }
                    temp2++;
                }
                var index = currPos[0].charCodeAt(0);
                while(index >96){
                    if(currPos[0].charCodeAt(0) != index){
                        var id =  String.fromCharCode(index)+currPos[1];
                        if(Object.values(board).includes(id) && id != pos) break;         
                        if(id == pos)
                            return true;
                    }   
                    index--;
                }
                var index2 = currPos[0].charCodeAt(0);
                while(index2 < 105){
                    if(currPos[0].charCodeAt(0) != index2){
                        var id =  String.fromCharCode(index2)+currPos[1];
                        if(Object.values(board).includes(id) && id != pos) break;             
                        if(id == pos)
                            return true;
                    }            
                    index2++;
                }
            }
        }
        //   knights
        var knights = ["bKw","bKb"];
        knights = knights.concat(black_pieces.filter(elem => elem.substring(0,3) === "b_K"));
        for(var i = 0 ; i < knights.length; i++){
            if(board[knights[i]] != "x"){
                var currPos = board[knights[i]];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);
                // up left and right
                if(charIndex - 1 >= 97 && numIndex +2 <= 8 ){
                    var id = String.fromCharCode(charIndex-1)+(numIndex +2);
                    if(id == pos)
                        return true;
                }
                if(charIndex + 1  <= 104 && numIndex + 2 <= 8){
                    var id = String.fromCharCode(charIndex+1)+(numIndex+2);
                    if(id == pos)
                        return true;
                }
                // down : left and right;
                if(charIndex - 1 >= 97 && numIndex - 2 >= 1 ){
                    var id = String.fromCharCode(charIndex-1)+(numIndex-2);
                    if(id == pos)
                        return true;
                }
                if(charIndex + 1  <= 104 && numIndex - 2 >= 1){
                    var id = String.fromCharCode(charIndex+1)+(numIndex-2);
                    if(id == pos)
                        return true;
                }
                //left:  up and down
                if(charIndex - 2 >= 97 && numIndex + 1 <= 8 ){
                    var id = String.fromCharCode(charIndex-2)+(numIndex+1);
                    if(id == pos)
                        return true;
                }
                if(charIndex - 2  >= 97 && numIndex - 1 >= 1){
                    var id = String.fromCharCode(charIndex-2)+(numIndex-1);
                    if(id == pos)
                        return true;
                }
                //right: up and down
                if(charIndex + 2 <= 104 && numIndex + 1 <= 8 ){
                    var id = String.fromCharCode(charIndex+2)+(numIndex+1);
                    if(id == pos)
                        return true;
                }
                if(charIndex + 2  <= 104 && numIndex - 1 >= 1){
                    var id = String.fromCharCode(charIndex+2)+(numIndex-1);
                    if(id == pos)
                        return true;
                }
            }
        }
        //  Bishop
        var bishop = ["bBb","bBw"];
        bishop = bishop.concat(black_pieces.filter(elem => elem.substring(0,3) === "b_B"));
        for(var i = 0 ; i < bishop.length;i++){
            if(board[bishop[i]] != "x"){
                var currPos = board[bishop[i]];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);        
                // left to downright
                while(charIndex < 104){
                    if(numIndex == 1)break;
                    charIndex++;
                    numIndex--;            
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;     
                    if(id == pos)
                        return true;     
                }
                // left to upright
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex < 104){
                    if(numIndex == 8)break;
                    charIndex++;
                    numIndex++;            
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;           
                    if(id == pos)
                        return true;
                }
                // right to downleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 1)break;
                    charIndex--;
                    numIndex--;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;     
                    if(id == pos)
                        return true;  
                }
                //right to upleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 8 )break;
                    charIndex--;
                    numIndex++;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;             
                    if(id == pos)
                        return true;
                }
            }
        }
        // Queen
        var queens = ["bQ"];
        queens = queens.concat(black_pieces.filter(elem => elem.substring(0,3) === "b_Q"));
        for(var i = 0 ; i < queens.length;i++) {
            //straight lines 
            ////// down    
            if(board[queens[i]] != "x"){
                var currPos = board[queens[i]];
                var temp = Number(currPos[1]);
                while(temp > 0 ){
                    if(Number(currPos[1]) != temp){
                        var id = currPos[0]+temp.toString();
                        if(Object.values(board).includes(id) && id != pos) break;              
                        if(id == pos)
                            return true;
                    }
                    temp--;
                }
                ////// up
                var temp2 = Number(currPos[1]);
                while(temp2 < 9 ){
                    if(Number(currPos[1]) != temp2){
                        var id = currPos[0]+temp2.toString();
                        if(Object.values(board).includes(id) && id != pos) break;       
                        if(id == pos)
                            return true; 
                    }
                    temp2++;
                }
                ////// right
                var index = currPos[0].charCodeAt(0);
                while(index >96){
                    if(currPos[0].charCodeAt(0) != index){
                        var id =  String.fromCharCode(index)+currPos[1];
                        if(Object.values(board).includes(id) && id != pos) break;                 
                        if(id == pos)
                            return true;
                    }            
                    index--;
                }
                ////// left
                var index2 = currPos[0].charCodeAt(0);
                while(index2 < 105){
                    if(currPos[0].charCodeAt(0) != index2){
                        var id =  String.fromCharCode(index2)+currPos[1];
                        if(Object.values(board).includes(id) && id != pos) break; 
                        if(id == pos)
                            return true;  
                    }            
                    index2++;
                }
                //diagonal
                
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                
                // left to downright
                while(charIndex < 104){
                    if(numIndex == 1)break;
                    charIndex++;
                    numIndex--;                     
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true; 
                }
                // left to upright
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex < 104){
                    if(numIndex == 8)break;
                    charIndex++;
                    numIndex++;                      
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true;  
                }
                // right to downleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 1)break;
                    charIndex--;
                    numIndex--;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true; 
                }
                //right to upleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 8 )break;
                    charIndex--;
                    numIndex++;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true;
                }
            }
        }
    } else if(TURN == "black") { 
        // check if there is check from black; and after move
        var pos = board["bK"];
        // pawns
        var pawns = ["wP1","wP2","wP3","wP4","wP5","wP6","wP7","wP8"];
        for(var i = 0 ; i < pawns.length;i++){
            if(board[pawns[i]] != "x"){ //pawn still in the game
                var currPos = board[pawns[i]];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);
                
                if(charIndex + 1 <=104){
                    var id2 = String.fromCharCode(charIndex+1) + (numIndex + 1);
                    if(id2 == pos)
                        return true;
                } 
                if(charIndex - 1 >=97) {
                    var id = String.fromCharCode(charIndex-1) + (numIndex + 1);
                    if(id == pos)
                        return true;
                }               
            }            
        }
        ////////  Rook
        var rook = ["wRw","wRb"];
        rook = rook.concat(white_pieces.filter(elem => elem.substring(0,3) === "w_R"));
        for(var i = 0 ; i < rook.length;i++) {
            if(board[rook[i]] != "x"){
                var currPos = board[rook[i]];
                var temp = Number(currPos[1]);
                while(temp > 0 ){
                    if(Number(currPos[1]) != temp){
                        var id = currPos[0]+temp.toString();
                        if(Object.values(board).includes(id) && id != pos) break;                
                        if(id == pos)
                            return true;
                    }
                    temp--;
                }
                var temp2 = Number(currPos[1]);
                while(temp2 < 9 ){
                    if(Number(currPos[1]) != temp2){
                        var id = currPos[0]+temp2.toString();
                        if(Object.values(board).includes(id) && id != pos) break;
                        if(id == pos)
                            return true;
                    }
                    temp2++;
                }
                var index = currPos[0].charCodeAt(0);
                while(index >96){
                    if(currPos[0].charCodeAt(0) != index){
                        var id =  String.fromCharCode(index)+currPos[1];
                        if(Object.values(board).includes(id) && id != pos) break;
                        if(id == pos)
                            return true;  
                    }            
                    index--;
                }
                var index2 = currPos[0].charCodeAt(0);
                while(index2 < 105){
                    if(currPos[0].charCodeAt(0) != index2){
                        var id =  String.fromCharCode(index2)+currPos[1];
                        if(Object.values(board).includes(id) && id != pos) break;
                        if(id == pos)
                            return true; 
                    }            
                    index2++;
                }
            }
        }
        //  knights
        var knights = ["wKw","wKb"];
        knights = knights.concat(white_pieces.filter(elem => elem.substring(0,3) === "w_K"));
        for(var i = 0 ; i < knights.length; i++){
            if(board[knights[i]] != "x"){
                var currPos = board[knights[i]];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);
                // up left and right
                if(charIndex - 1 >= 97 && numIndex +2 <= 8 ){
                    var id = String.fromCharCode(charIndex-1)+(numIndex +2);
                    if(id == pos)
                        return true;
                }
                if(charIndex + 1  <= 104 && numIndex + 2 <= 8){
                    var id = String.fromCharCode(charIndex+1)+(numIndex+2);
                    if(id == pos)
                        return true;
                }
                // down : left and right;
                if(charIndex - 1 >= 97 && numIndex - 2 >= 1 ){
                    var id = String.fromCharCode(charIndex-1)+(numIndex-2);
                    if(id == pos)
                        return true;
                }
                if(charIndex + 1  <= 104 && numIndex - 2 >= 1){
                    var id = String.fromCharCode(charIndex+1)+(numIndex-2);
                    if(id == pos)
                        return true;
                }
                //left:  up and down
                if(charIndex - 2 >= 97 && numIndex + 1 <= 8 ){
                    var id = String.fromCharCode(charIndex-2)+(numIndex+1);
                    if(id == pos)
                        return true;
                }
                if(charIndex - 2  >= 97 && numIndex - 1 >= 1){
                    var id = String.fromCharCode(charIndex-2)+(numIndex-1);
                    if(id == pos)
                        return true;
                }
                //right: up and down
                if(charIndex + 2 <= 104 && numIndex + 1 <= 8 ){
                    var id = String.fromCharCode(charIndex+2)+(numIndex+1);
                    if(id == pos)
                        return true;
                }
                if(charIndex + 2  <= 104 && numIndex - 1 >= 1){
                    var id = String.fromCharCode(charIndex+2)+(numIndex-1);
                    if(id == pos)
                        return true;
                }
            }
        }
        //  Bishop
        var bishop = ["wBb","wBw"];
        bishop = bishop.concat(white_pieces.filter(elem => elem.substring(0,3) === "w_B"));
        for(var i = 0 ; i < bishop.length;i++){
            if(board[bishop[i]] != "x"){
                var currPos = board[bishop[i]];
                var numIndex = Number(currPos[1]);
                var charIndex = currPos[0].charCodeAt(0);        
                // left to downright
                while(charIndex < 104){
                    if(numIndex == 1)break;
                    charIndex++;
                    numIndex--;            
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true; 
                }
                // left to upright
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex < 104){
                    if(numIndex == 8)break;
                    charIndex++;
                    numIndex++;            
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true;       
                }
                // right to downleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 1)break;
                    charIndex--;
                    numIndex--;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true;       
                }
                //right to upleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 8 )break;
                    charIndex--;
                    numIndex++;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true;      
                }
            }
        }
        //  Queen
        var queens = ["wQ"];
        queens = queens.concat(white_pieces.filter(elem => elem.substring(0,3) === "w_Q"));
        for(var i = 0 ; i < queens.length;i++){
            if(board[queens[i]] != "x") {
                var currPos = board[queens[i]];
                var temp = Number(currPos[1]);
                //straight lines 
                ////// down               
                while(temp > 0 ){
                    if(Number(currPos[1]) != temp){
                        var id = currPos[0]+temp.toString();
                        if(Object.values(board).includes(id) && id != pos) break;
                        if(id == pos)
                            return true; 
                    }
                    temp--;
                }
                ////// up
                var temp2 = Number(currPos[1]);
                while(temp2 < 9 ){
                    if(Number(currPos[1]) != temp2){
                        var id = currPos[0]+temp2.toString();
                        if(Object.values(board).includes(id) && id != pos) break;
                        if(id == pos)
                            return true;  
                    }
                    temp2++;
                }
                ////// right
                var index = currPos[0].charCodeAt(0);
                while(index >96){
                    if(currPos[0].charCodeAt(0) != index){
                        var id =  String.fromCharCode(index)+currPos[1];
                        if(Object.values(board).includes(id) && id != pos) break;
                        if(id == pos)
                            return true; 
                    }            
                    index--;
                }
                ////// left
                var index2 = currPos[0].charCodeAt(0);
                while(index2 < 105){
                    if(currPos[0].charCodeAt(0) != index2){
                        var id =  String.fromCharCode(index2)+currPos[1];
                        if(Object.values(board).includes(id) && id != pos) break;
                        if(id == pos)
                            return true; 
                    }            
                    index2++;
                }
                //diagonal
                
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                
                // left to downright
                while(charIndex < 104){
                    if(numIndex == 1)break;
                    charIndex++;
                    numIndex--;                     
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true;    
                }
                // left to upright
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex < 104){
                    if(numIndex == 8)break;
                    charIndex++;
                    numIndex++;                      
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;             
                    if(id == pos){
                        
                        return true;
                    }
                }
                // right to downleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 1)break;
                    charIndex--;
                    numIndex--;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true;         
                }
                //right to upleft
                numIndex = Number(currPos[1]);
                charIndex = currPos[0].charCodeAt(0);
                while(charIndex > 97){
                    if(numIndex == 8 )break;
                    charIndex--;
                    numIndex++;
                    var id =  String.fromCharCode(charIndex) + (numIndex);
                    if(Object.values(board).includes(id) && id != pos) break;
                    if(id == pos)
                        return true; 
                }
            }
        }
    }
    
    return false;
}

//bool: check if the game is over for black or white
function checkIfGameOver() {
    if(TURN == "black" && IsKingInCheck(Object.assign({}, current_setup))){
        // check if check from white
        // test all the possible moves on the remaining black pieces
        var total = getAllPossibleMove();
        
        if(total == 0){
            GAME_OVER = true;
            sendGameWinner("white", "won")
        }
    } else if (TURN == "white" && IsKingInCheck(Object.assign({}, current_setup))){
        // check if check is from black
        // test all the possible moves on the remaining white pieces
        var total = getAllPossibleMove();
        
        if(total == 0){
            GAME_OVER = true;
            sendGameWinner("black", "won")
        }
    } else if(TURN == "black" && !IsKingInCheck(Object.assign({}, current_setup))){
        // check if check from white
        // test all the possible moves on the remaining black pieces
        var total = getAllPossibleMove();
        
        if(total == 0){
            GAME_OVER = true;
            sendGameWinner("draw", "stalemate")
        }
    } else if (TURN == "white" && !IsKingInCheck(Object.assign({}, current_setup))){
        // check if check is from black
        // test all the possible moves on the remaining white pieces
        var total = getAllPossibleMove();
        
        if(total == 0){
            GAME_OVER = true;
            sendGameWinner("draw", "stalemate")
        }
    }
    return false;
}

function checkInsufficientMaterial() {
    var bp = [];
    var wp =[];
    for(var i = 0; i < black_pieces.length;i++){
        if(current_setup[black_pieces[i]] != "x"){
            bp.push(black_pieces[i]);
        }
    }
    for(var i = 0; i < white_pieces.length;i++){
        if(current_setup[white_pieces[i]] != "x"){
            wp.push(white_pieces[i]);
        }
    }
    
    if(bp.length == 1 && wp.length == 1) return true;
    if(bp.length == 2 && wp.length == 1){
        // knight or bishop and king
        if(wp[0] == "bK" && (wp[1] == "bBw" || wp[1] == "bBb"|| wp[1] == "bKw" || wp[1] == "bKb"|| 
        wp[1].substring(0,3) == "b_K" || wp[1].substring(0,3) == "b_B")){
            return true;
        } 
        if(wp[1] == "bK" && (wp[0] == "bBw" || wp[0] == "bBb"|| wp[0] == "bKw" || wp[0] == "bKb"|| 
        wp[0].substring(0,3) == "b_K" || wp[0].substring(0,3) == "b_B")){
            return true;
        } 
    } else if(wp.length == 2 && bp.length == 1) {
        if(wp[0] == "wK" && (wp[1] == "wBw" || wp[1] == "wBb"|| wp[1] == "wKw" || wp[1] == "wKb"|| 
        wp[1].substring(0,3) == "w_K" || wp[1].substring(0,3) == "w_B")){
            return true;
        } 
        if(wp[1] == "wK" && (wp[0] == "wBw" || wp[0] == "wBb"|| wp[0] == "wKw" || wp[0] == "wKb"|| 
        wp[0].substring(0,3) == "w_K" || wp[0].substring(0,3) == "w_B")){
            return true;
        } 
    }
    return false;
}
/* /////////////////////// Move Pieces  //////////////////// */
var selected;
var previousBlackMove;
var previousWhiteMove;
var enPassant = false;
var blackCastle = false;
var whiteCastle = false;
var bcRight = false;
var bcLeft = false;
var wcRight = false;
var wcLeft = false;
var promoteBlackPawn = false;
var promoteWhitePawn = false;

// check whether moving a piece will stop incoming check if there is any and
// piece can be taken by you without resulting in incoming check
// called from canMoveTo() returns bool
function canBeTaken(pos){
    // stop pieces from taking king
    var piece = selected;
    if($(pos.id).children.length != 0){
        if($(pos.id).children[0].id == "bK" || $(pos.id).children[0].id == "wK") {
            return false;
        } else if(black_pieces.includes(pos.children[0].id) && TURN == "black"){
            return false;
        } else if(white_pieces.includes(pos.children[0].id) && TURN == "white"){
            return false;
        }
    }
    ////// Rook
    var dummyBoard = Object.assign({}, current_setup);
    if(piece.id == "bRw" || piece.id == "bRb" || piece.id == "wRw" || piece.id == "wRb"
        || piece.id.substring(0,3) == "b_R" || piece.id.substring(0,3) == "w_R"){
        previousBlackMove = undefined;
        previousWhiteMove = undefined;
        var currPos = current_setup[piece.id];
        var temp = Number(currPos[1]);
        while(temp > 0 ){
            if(Number(currPos[1]) != temp){
                var id = currPos[0]+temp.toString();
                if(id != pos.id && $(id).children.length != 0)
                    break;
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(pos.children.length != 0)
                        dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        return true;                 
                    }
                }
            }
            temp--;
        }
        dummyBoard = Object.assign({}, current_setup);
        var temp2 = Number(currPos[1]);
        while(temp2 < 9 ){
            if(Number(currPos[1]) != temp2){
                var id = currPos[0]+temp2.toString();
                if(id != pos.id && $(id).children.length != 0)
                    break;
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(pos.children.length != 0)
                        dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        return true;
                    }
                }
            }
            temp2++;
         }
        dummyBoard = Object.assign({}, current_setup);
        var index = currPos[0].charCodeAt(0);
        while(index > 96){
            if(currPos[0].charCodeAt(0) != index){
                var id =  String.fromCharCode(index)+currPos[1];
                if(id != pos.id && $(id).children.length != 0)
                    break;
                
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(pos.children.length != 0)
                        dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        return true;
                    }
                }
            }            
            index--;
        }
        dummyBoard = Object.assign({}, current_setup);
        var index2 = currPos[0].charCodeAt(0);
        while(index2 < 105){
            if(currPos[0].charCodeAt(0) != index2){
                var id =  String.fromCharCode(index2)+currPos[1];
                if(id != pos.id && $(id).children.length != 0)
                    break;
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(pos.children.length != 0)
                        dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        return true;
                    }
                }                     
            }            
            index2++;
        }
                
        return false;      
    } 
    ///////// Knight or Horse
    else if(piece.id == "bKw" || piece.id == "bKb" || piece.id == "wKw" || piece.id == "wKb"
        || piece.id.substring(0,3) == "b_K" || piece.id.substring(0,3) == "w_K"){
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);
        previousBlackMove = undefined;
        previousWhiteMove = undefined;
        // up left and right
        dummyBoard = Object.assign({}, current_setup);
        if(charIndex - 1 >= 97 && numIndex +2 <= 8 ){
            var id = String.fromCharCode(charIndex-1)+(numIndex +2);            
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                if(!IsKingInCheck(dummyBoard)){
                    return true;
                }
            }
        }
        dummyBoard = Object.assign({}, current_setup);
        if(charIndex + 1  <= 104 && numIndex + 2 <= 8){
            var id = String.fromCharCode(charIndex+1)+(numIndex+2);
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";       
                if(!IsKingInCheck(dummyBoard)){
                    return true;
                }
            }
        }

        // down : left and right;
        dummyBoard = Object.assign({}, current_setup);
        if(charIndex - 1 >= 97 && numIndex - 2 >= 1 ){
            var id = String.fromCharCode(charIndex-1)+(numIndex-2);
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                if(!IsKingInCheck(dummyBoard)){
                    return true;
                }
            }
        }
        dummyBoard = Object.assign({}, current_setup);
        if(charIndex + 1  <= 104 && numIndex - 2 >= 1){
            var id = String.fromCharCode(charIndex+1)+(numIndex-2);
            if(id == pos.id){
                
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                
                if(!IsKingInCheck(dummyBoard)){
                    return true;
                }
            }
        }

        //left:  up and down
        dummyBoard = Object.assign({}, current_setup);
        if(charIndex - 2 >= 97 && numIndex + 1 <= 8 ){
            var id = String.fromCharCode(charIndex-2)+(numIndex+1);
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                if(!IsKingInCheck(dummyBoard)){
                    return true;
                }
            }
        }
        dummyBoard = Object.assign({}, current_setup);
        if(charIndex - 2  >= 97 && numIndex - 1 >= 1){
            var id = String.fromCharCode(charIndex-2)+(numIndex-1);
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";          
                if(!IsKingInCheck(dummyBoard)){
                    return true;                 
                }
            }
        }
        //right: up and down
        dummyBoard = Object.assign({}, current_setup);
        if(charIndex + 2 <= 104 && numIndex + 1 <= 8 ){
            var id = String.fromCharCode(charIndex+2)+(numIndex+1);
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";       
                if(!IsKingInCheck(dummyBoard)){
                    return true;                 
                }
            }
        }
        dummyBoard = Object.assign({}, current_setup);
        if(charIndex + 2  <= 104 && numIndex - 1 >= 1){
            var id = String.fromCharCode(charIndex+2)+(numIndex-1);
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                if(!IsKingInCheck(dummyBoard)){
                    return true;
                }
            }
        }
        return false;
    } 
    ////// Black Pawns
    else if(piece.id == "bP1" || piece.id == "bP2" || piece.id == "bP3" || piece.id == "bP4" ||
     piece.id == "bP5" || piece.id == "bP6" || piece.id == "bP7" || piece.id == "bP8"){        
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);
        previousBlackMove = undefined;
        if(pos.children.length != 0){
            dummyBoard = Object.assign({}, current_setup);
            if(charIndex + 1 <=104){
                var id2 = String.fromCharCode(charIndex+1) + (numIndex - 1);
                if(id2 == pos.id){
                    dummyBoard[piece.id] = id2;
                    dummyBoard[pos.children[0].id] = "x";
                    if(numIndex - 1 == 1)
                        promoteBlackPawn = true;
                    if(!IsKingInCheck(dummyBoard)){
                        return true;
                    }
                }
            } 
            dummyBoard = Object.assign({}, current_setup);
            if(charIndex - 1 >=97) {
                var id = String.fromCharCode(charIndex-1) + (numIndex - 1);
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        if(numIndex - 1 == 1)
                            promoteBlackPawn = true;
                        return true;                 
                    }
                }
            }
        } else {
            if(numIndex == 7){
                var id = currPos[0] + (numIndex -1);
                var id2 = currPos[0] + (numIndex - 2);
                dummyBoard = Object.assign({}, current_setup);
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(!IsKingInCheck(dummyBoard)){
                        return true;                 
                    }
                }
                dummyBoard = Object.assign({}, current_setup);
                dummyBoard[piece.id] = id2;
                if($(id).children.length == 0 && $(id2).children.length == 0 && id2 == pos.id && !IsKingInCheck(dummyBoard))
                {
                    previousBlackMove = pos;
                    return true;
                }
            } else if(numIndex == 4 && previousWhiteMove  && previousWhiteMove.nodeType && Number(previousWhiteMove.id[1]) == 4 ){
                
                var id = String.fromCharCode(charIndex-1) + (numIndex - 1);
                var id2 = previousWhiteMove.id[0] + (numIndex - 1);
                var id3 = String.fromCharCode(charIndex+1) + (numIndex - 1);
                
                dummyBoard = Object.assign({}, current_setup);
                if(pos.id == id2 && id == pos.id){
                    dummyBoard[piece.id] = id;
                    dummyBoard[previousWhiteMove.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        // only set true if the move will not result in check from white
                        enPassant = true;
                        return true;                 
                    }
                }
                dummyBoard = Object.assign({}, current_setup);
                if(id3 == id2 && id2 == pos.id){
                    dummyBoard[piece.id] = id;
                    dummyBoard[previousWhiteMove.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        enPassant = true;
                        return true;                 
                    }
                }
                //enPassant did not pass check for move forward.
                dummyBoard = Object.assign({}, current_setup);
                var id4 = currPos[0] + (numIndex - 1);
                if(id4 == pos.id && pos.children.length == 0) {
                    dummyBoard[piece.id] = id4;
                    if(!IsKingInCheck(dummyBoard)){                        
                        return true;                 
                    }
                }
            }            
            else {
                //promote pawn
                var id = currPos[0] + (numIndex -1);
                if(numIndex-1 == 1){
                    
                    dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece.id] = id;
                    if(!IsKingInCheck(dummyBoard)){
                        promoteBlackPawn = true;
                    }
                }
                dummyBoard = Object.assign({}, current_setup);
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(!IsKingInCheck(dummyBoard)){
                        return true;                 
                    }
                }
            }
        }

        return false;
    }
    ////// White Pawns
    else if(piece.id == "wP1" || piece.id == "wP2" || piece.id == "wP3" || piece.id == "wP4" ||
     piece.id == "wP5" || piece.id == "wP6" || piece.id == "wP7" || piece.id == "wP8"){        
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);
        previousWhiteMove = undefined;
        if(pos.children.length != 0){
            dummyBoard = Object.assign({}, current_setup);
            if(charIndex + 1 <=104){
                var id2 = String.fromCharCode(charIndex+1) + (numIndex + 1);
                if(id2 == pos.id){
                    dummyBoard[piece.id] = pos.id;
                    dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        if(numIndex + 1 == 8)
                            promoteWhitePawn = true;
                        return true;                 
                    }
                }
            } 
            dummyBoard = Object.assign({}, current_setup);
            if(charIndex - 1 >=97) {
                var id = String.fromCharCode(charIndex-1) + (numIndex + 1);
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        if(numIndex + 1 == 8)
                            promoteWhitePawn = true;
                        return true;                 
                    }
                }
            }
        } else {
            
            if(numIndex == 2){
                var id = currPos[0] + (numIndex +1);
                var id2 = currPos[0] + (numIndex + 2);
                dummyBoard = Object.assign({}, current_setup);
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(!IsKingInCheck(dummyBoard)){
                        return true;                 
                    }
                }
                dummyBoard = Object.assign({}, current_setup);
                
                dummyBoard[piece.id] = id2;
                
                if($(id).children.length == 0 && $(id2).children.length == 0 && id2 == pos.id && !IsKingInCheck(dummyBoard))
                {
                    
                    previousWhiteMove = pos;
                    return true;
                }
            } 
            else if(numIndex == 5 && previousBlackMove  && previousBlackMove.nodeType && Number((previousBlackMove.id)[1]) == 5){
                
                var id = String.fromCharCode(charIndex-1) + (numIndex + 1); //left
                var id2 = previousBlackMove.id[0] + (numIndex + 1);
                var id3 = String.fromCharCode(charIndex+1) + (numIndex + 1); //right
                
                dummyBoard = Object.assign({}, current_setup);
                if(id == id2 && id == pos.id){
                    dummyBoard[piece.id] = id;
                    dummyBoard[previousBlackMove.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        enPassant = true;
                        return true;             
                    }                    
                }
                dummyBoard = Object.assign({}, current_setup);
                if(id3 == id2 && id2 == pos.id){
                    dummyBoard[piece.id] = id;
                    dummyBoard[previousBlackMove.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        enPassant = true;
                        return true;                 
                    }
                }
                //enPassant did not pass check for move forward.
                dummyBoard = Object.assign({}, current_setup);
                var id4 = currPos[0] + (numIndex +1);
                if(id4 == pos.id && pos.children.length == 0) {
                    dummyBoard[piece.id] = id4;
                    if(!IsKingInCheck(dummyBoard)){                        
                        return true;                 
                    }
                }
            } 
            else {
                var id = currPos[0] + (numIndex + 1);
                if(numIndex+1 == 8){
                    
                    dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece.id] = id;
                    if(!IsKingInCheck(dummyBoard)){
                        promoteWhitePawn = true;          
                    }
                }
                //only move forward.
                dummyBoard = Object.assign({}, current_setup);
                
                if(id == pos.id) {
                    dummyBoard[piece.id] = id;
                    if(!IsKingInCheck(dummyBoard)){
                        if(numIndex + 1 == 8)
                            promoteWhitePawn = true;
                        return true;                 
                    }
                }
            }
        }
        
        return false;        
    }
    ////// Bishop
    else if(piece.id == "bBw" || piece.id == "bBb" || piece.id == "wBb" || piece.id == "wBw" 
            || piece.id.substring(0,3) == "b_B" || piece.id.substring(0,3) == "w_B"){
        previousBlackMove = undefined;
        previousWhiteMove = undefined;
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);        
        // left to downright
        dummyBoard = Object.assign({}, current_setup);
        while(charIndex < 104){
            if(numIndex == 1)break;
            charIndex++;
            numIndex--;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if(id != pos.id && $(id).children.length != 0)
                    break;
            if(id == pos.id){
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard)){
                    return true;                 
                }
            }
        }

        // left to upright
        dummyBoard = Object.assign({}, current_setup);
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex < 104){
            if(numIndex == 8) break;
            charIndex++;
            numIndex++;            
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if(id != pos.id && $(id).children.length != 0)
                break;
            if(id == pos.id){
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard)){
                    return true;                 
                }
            }             
        }

        // right to downleft
        dummyBoard = Object.assign({}, current_setup);
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 1) break;
            charIndex--;
            numIndex--;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if(id != pos.id && $(id).children.length != 0)
                    break;
            if(id == pos.id){
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard)){
                    return true;                 
                }
            }             
        }

        //right to upleft
        dummyBoard = Object.assign({}, current_setup);
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 8 ) break;
            charIndex--;
            numIndex++;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            
            if(id == pos.id){
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard)){
                    return true;                 
                }
            }             
            if(id != pos.id && $(id).children.length != 0)
                break;
        }
        
        return false;
    }
    ////// Queen
    else if(piece.id == "bQ" || piece.id == "wQ" ||
            piece.id.substring(0,3) == "b_Q" || piece.id.substring(0,3) == "w_Q"){
        previousBlackMove = undefined;
        previousWhiteMove = undefined;
        var currPos = current_setup[piece.id];
        var temp = Number(currPos[1]);
        //straight lines 
        ////// down 
        dummyBoard = Object.assign({}, current_setup);      
        while(temp > 0 ){
            if(Number(currPos[1]) != temp){
                var id = currPos[0]+temp.toString();
                if(id != pos.id && $(id).children.length != 0)
                    break;
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(pos.children.length != 0)
                        dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        return true;                 
                    }
                }                 
            }
            temp--;
        }
        ////// up
        dummyBoard = Object.assign({}, current_setup);
        var temp2 = Number(currPos[1]);
        while(temp2 < 9 ){
            if(Number(currPos[1]) != temp2){
                var id = currPos[0]+temp2.toString();
                if(id != pos.id && $(id).children.length != 0)
                    break;
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(pos.children.length != 0)
                        dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        return true;                 
                    }
                }                 
            }
            temp2++;
        }
        ////// right
        dummyBoard = Object.assign({}, current_setup);
        var index = currPos[0].charCodeAt(0);
        while(index >96){
            if(currPos[0].charCodeAt(0) != index){
                var id =  String.fromCharCode(index)+currPos[1];
                if(id != pos.id && $(id).children.length != 0)
                    break;
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(pos.children.length != 0)
                        dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        return true;                 
                    }
                }
                 
            }            
            index--;
        }
        ////// left
        dummyBoard = Object.assign({}, current_setup);
        var index2 = currPos[0].charCodeAt(0);
        while(index2 < 105){
            if(currPos[0].charCodeAt(0) != index2){
                var id =  String.fromCharCode(index2)+currPos[1];
                if(id != pos.id && $(id).children.length != 0)
                    break;
                if(id == pos.id){
                    dummyBoard[piece.id] = id;
                    if(pos.children.length != 0)
                        dummyBoard[pos.children[0].id] = "x";
                    if(!IsKingInCheck(dummyBoard)){
                        return true;                 
                    }
                }                 
            }            
            index2++;
        }
        //diagonal
        dummyBoard = Object.assign({}, current_setup);
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        
        // left to downright
        while(charIndex < 104){
            if(numIndex == 1)break;
            charIndex++;
            numIndex--;                     
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if(id != pos.id && $(id).children.length != 0)
                break;
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                if(!IsKingInCheck(dummyBoard)){
                    return true;                 
                }
            }
             
        }
        // left to upright
        dummyBoard = Object.assign({}, current_setup);
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex < 104){
            if(numIndex == 8)break;
            charIndex++;
            numIndex++;                      
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if(id != pos.id && $(id).children.length != 0)
                break;
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                if(!IsKingInCheck(dummyBoard)){
                    return true;                 
                }
            }
             
        }
        // right to downleft
        dummyBoard = Object.assign({}, current_setup);
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 1)break;
            charIndex--;
            numIndex--;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if(id != pos.id && $(id).children.length != 0)
                break;
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                if(!IsKingInCheck(dummyBoard)){
                    return true;                 
                }
            }             
        }
        //right to upleft
        dummyBoard = Object.assign({}, current_setup);
        numIndex = Number(currPos[1]);
        charIndex = currPos[0].charCodeAt(0);
        while(charIndex > 97){
            if(numIndex == 8 )break;
            charIndex--;
            numIndex++;
            var id =  String.fromCharCode(charIndex) + (numIndex);
            if(id != pos.id && $(id).children.length != 0)
                break;
            if(id == pos.id){
                dummyBoard[piece.id] = id;
                if(pos.children.length != 0)
                    dummyBoard[pos.children[0].id] = "x";
                if(!IsKingInCheck(dummyBoard)){
                    return true;                 
                }
            }             
        }
        return false;
    }
    ////// King
    else if(piece.id == "bK" || piece.id == "wK" ){
        previousBlackMove = undefined;
        previousWhiteMove = undefined;
        var currPos = current_setup[piece.id];
        var numIndex = Number(currPos[1]);
        var charIndex = currPos[0].charCodeAt(0);
        dummyBoard = Object.assign({}, current_setup);
        if(charIndex + 1 <= 104){
            var id =  String.fromCharCode(charIndex+1) + (numIndex);            
            if(id == pos.id) {
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id))
                    return true;
            }
        }        
        if(charIndex - 1 >= 97){
            var id =  String.fromCharCode(charIndex-1) + (numIndex);
            dummyBoard = Object.assign({}, current_setup);
            if(id == pos.id) {
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id))
                    return true;
            }
        }
        if(numIndex + 1 <= 8){
            var id =  String.fromCharCode(charIndex) + (numIndex+1);
            dummyBoard = Object.assign({}, current_setup);
            if(id == pos.id) {
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id))
                    return true;
            }
        }        
        if(numIndex - 1 >= 1){
            var id =  String.fromCharCode(charIndex) + (numIndex-1);
            dummyBoard = Object.assign({}, current_setup);
            if(id == pos.id) {
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id))
                    return true;
            }
        }
        if(charIndex + 1 <= 104 && numIndex+1 <= 8){
            var id =  String.fromCharCode(charIndex+1) + (numIndex+1);
            dummyBoard = Object.assign({}, current_setup);
            if(id == pos.id) {
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id))
                    return true;
            }
        }
        if(charIndex + 1 <= 104 && numIndex-1 >= 1){
            var id =  String.fromCharCode(charIndex+ 1) + (numIndex-1);
            dummyBoard = Object.assign({}, current_setup);
            if(id == pos.id) {
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id))
                    return true;
            }
        }
        if(charIndex - 1  >= 97  && numIndex+1 <= 8){
            var id =  String.fromCharCode(charIndex-1) + (numIndex+1);
            dummyBoard = Object.assign({}, current_setup);
            if(id == pos.id) {
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id))
                    return true;
            } 
        }
        if(charIndex - 1 >= 97 && numIndex-1 >= 1){
            var id =  String.fromCharCode(charIndex-1) + (numIndex-1);
            dummyBoard = Object.assign({}, current_setup);
            if(id == pos.id) {
                dummyBoard[piece.id] = id;
                if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id))
                    return true;
            }
        }
        // castling check
        if(piece.id == "bK" && !Moved_castle["bK"]){
            if(!Moved_castle["bRb"]){
                if($("f8").children.length == 0 && $("g8").children.length==0){
                    var id2 =  String.fromCharCode(charIndex+1) + (numIndex);
                    dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece.id] = id2;
                    if(IsKingInCheck(dummyBoard)) return false;
                    var id =  String.fromCharCode(charIndex+2) + (numIndex);
                    dummyBoard = Object.assign({}, current_setup);
                    
                    if(id == pos.id){
                        if(IsKingInCheck(dummyBoard)) return false;
                        dummyBoard["bK"] = id;
                        dummyBoard["bRb"] = "f8";
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            blackCastle = true;
                            bcRight = true;
                            return true;
                        }
                    }                                
                }
            } 
            if(!Moved_castle["bRw"]){
                if($("d8").children.length == 0 && $("c8").children.length ==0 && $("b8").children.length ==0){
                    var id2 =  String.fromCharCode(charIndex-1) + (numIndex);
                    dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece.id] = id2;
                    if(IsKingInCheck(dummyBoard)) return false;
                    var id =  String.fromCharCode(charIndex-2) + (numIndex);
                    dummyBoard = Object.assign({}, current_setup);
                    if(id == pos.id){
                        if(IsKingInCheck(dummyBoard)) return false;
                        dummyBoard["bK"] = id;
                        dummyBoard["bRw"] = "d8";
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            blackCastle = true;
                            bcLeft = true;
                            return true;
                        }
                    }                      
                }
            }
        } else if(piece.id == "wK" && !Moved_castle["wK"]){
            if(!Moved_castle["wRw"]){
                if($("f1").children.length == 0 && $("g1").children.length==0){
                    var id2 =  String.fromCharCode(charIndex+1) + (numIndex);
                    dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece.id] = id2;
                    if(IsKingInCheck(dummyBoard)) return false;
                    var id =  String.fromCharCode(charIndex+2) + (numIndex); 
                    dummyBoard = Object.assign({}, current_setup);
                    if(id == pos.id){
                        if(IsKingInCheck(dummyBoard)) return false;
                        dummyBoard["wK"] = id;
                        dummyBoard["wRw"] = "f1";
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            whiteCastle = true;
                            wcRight = true;
                            return true;
                        }
                    }                    
                }
            }
            if(!Moved_castle["wRb"]){
                if($("d1").children.length == 0 && $("c1").children.length ==0 && $("b1").children.length ==0){
                    var id2 =  String.fromCharCode(charIndex-1) + (numIndex);
                    dummyBoard = Object.assign({}, current_setup);
                    dummyBoard[piece.id] = id2;
                    if(IsKingInCheck(dummyBoard)) return false;
                    var id =  String.fromCharCode(charIndex-2) + (numIndex);
                    dummyBoard = Object.assign({}, current_setup);
                    if(id == pos.id){
                        if(IsKingInCheck(dummyBoard)) return false;
                        dummyBoard["wK"] = id;
                        dummyBoard["wRb"] = "d1";
                        if(!IsKingInCheck(dummyBoard) && !isKingProtectingTheSquare(id)){
                            whiteCastle = true;
                            wcLeft = true;
                            return true;
                        }
                    }
                }
            }
        } 
        return false;        
    }
    
    return false;    
}

/////// check if piece can be taken or move there ////////////
var removePiece = "";
var piece_capture = false;
function canMoveTo(elem, recieved){
    // check if the spot is empty && can move there
    if(elem.children.length == 0 && canBeTaken(elem) ){
        if(enPassant == true){
            if(TURN == "white"){
                current_setup[previousBlackMove.children[0].id] = "x";
                $("blackTaken").appendChild(previousBlackMove.children[0]);
                previousBlackMove = undefined;
                previousWhiteMove = undefined;
            } else {
                current_setup[previousWhiteMove.children[0].id] = "x";
                $("whiteTaken").appendChild(previousWhiteMove.children[0]);
                previousBlackMove = undefined;
                previousWhiteMove = undefined;
            }
            enPassant = false;            
        }
        if(whiteCastle){
            if(wcLeft){
                $("d1").appendChild($("wRb"));
                Moved_castle["wRb"] = true;
                current_setup["wRb"] = "d1";
                if (!recieved) {
                    sendPieceMove("d1", "wRb", true)
                }
                removePiece = "O-O-O";
            } else if(wcRight){
                $("f1").appendChild($("wRw"));
                current_setup["wRw"] = "f1";
                Moved_castle["wRw"] = true;
                if (!recieved) {
                    sendPieceMove("f1", "wRw", true)
                }
                removePiece = "O-O";
            }
            whiteCastle = false;            
        }
        if(blackCastle){
            if(bcLeft){
                $("d8").appendChild($("bRw"));
                current_setup["bRw"] = "d8";
                Moved_castle["bRw"] = true;
                
                if (!recieved) {
                    sendPieceMove("d8", "bRw", true)
                }
                removePiece = "O-O-O";
            } else if(bcRight){
                $("f8").appendChild($("bRb"));
                current_setup["bRb"] = "f8";
                Moved_castle["bRb"] = true;
                if (!recieved) {
                    sendPieceMove("f8", "bRb", true)
                }
                removePiece = "O-O";
            }
            blackCastle = false;
        }
        return true;
    }
    else if(elem.children.length != 0 ) {
        if(white_pieces.includes(elem.children[0].id,0) && TURN == "white"){
            return false;
        } else if(white_pieces.includes(elem.children[0].id,0) && TURN == "black" && canBeTaken(elem)){
            removePiece = elem.children[0].id;

            if (!recieved) {
                sendRemovePiece(removePiece)
            }
            current_setup[elem.children[0].id] = "x"; 
            $("whiteTaken").appendChild(elem.children[0]);
            piece_capture = true;
            return true;
        } else if(black_pieces.includes(elem.children[0].id,0) && TURN == "black"){
            return false;
        } else if(black_pieces.includes(elem.children[0].id,0) && TURN == "white" && canBeTaken(elem)){
            removePiece = elem.children[0].id;
            if (!recieved) {
                sendRemovePiece(removePiece)
            }
            current_setup[elem.children[0].id] = "x"; 
            $("blackTaken").appendChild(elem.children[0]);
            piece_capture = true;
            return true;           
        }
    } 
    else {
    }
    
    return false;
}

var Black_KingInCheck = false;
var White_KingInCheck = false;

var promoteBlackPawnTo;
var promoteWhitePawnTo;

// called when square in chess board is clicked.
function movePiece(elem) {
    if(GAME_OVER) return;
    if( selected  && selected.nodeType )
    { 
        if(TURN == "white" && player == "black") return;
        if(TURN == "black" && player == "white") return;
        if(elem.id == current_setup[selected.id]) return;      
        removeHighlight(selected);
        var prevWKingPos = current_setup["wK"];
        var prevBKingPos = current_setup["bK"];        
        
        if(white_pieces.includes(selected.id,0) && (TURN == "white" && player == "white") && canMoveTo(elem, false)){        
            
            TURN = "black";            
            var moveNote = selected.id;
            
            $('white-turn').style.display = "none";
            $('black-turn').style.display = "inline-block";
                        
            $(current_setup[selected.id]).classList.remove("selected");
            if(selected.id == "wK"){
                Moved_castle[selected.id] = true;
            }
            if(selected.id == "wRb" || selected.id == "wRw"){
                Moved_castle[selected.id] = true;
            }
            // promote pawn
            if(promoteWhitePawn){
                $("whiteTaken").appendChild(selected);                
                promoteWhitePawnTo = elem.id;
                current_setup[selected.id] = "x";
                $("prompt").style.display = "grid";
                $("whiteChoice").style.display = "block";
                $("blackChoice").style.display = "none";
                promoteWhitePawn = false;
            } else {                
                removeHighlight(selected);
                elem.appendChild(selected);
                current_setup[selected.id] = elem.id;
                moveNote = moveNote + elem.id;
            }
            if(removePiece != "" && removePiece != "O-O-O" && removePiece != "O-O"){
                moveNote = moveNote +"x"+ removePiece;
                removePiece = "";
            }
            sendPieceMove(elem.id, selected.id, false)        
            if(IsKingInCheck(Object.assign({}, current_setup))){
                $(current_setup["bK"]).classList.add("danger");
                
                moveNote = moveNote +"+";
            } else {
                
                $(prevWKingPos).classList.remove("danger");
            }
            if(removePiece == "O-O-O" || removePiece == "O-O"){
                moveNote = removePiece;
                removePiece = "";
            }
            if(selected.id.substring(0,2) == "wP" || piece_capture ){
                fiftfy_move_count = 0;
                piece_capture = false;
            } else {
                fiftfy_move_count++;                
            }
            var newRow = document.getElementById("move-template").content.cloneNode(true);
            newRow.querySelectorAll("td")[0].innerHTML = moveNote;
            document.getElementById("move-history").appendChild(newRow);

        } 
        else if(black_pieces.includes(selected.id,0)  && (TURN == "black" && player == "black") && canMoveTo(elem, false)){
            
            TURN = "white";
            var moveNote = selected.id;
            $('black-turn').style.display = "none";
            $('white-turn').style.display = "inline-block";
            
            $(current_setup[selected.id]).classList.remove("selected");
            if(selected.id == "bK"){
                Moved_castle[selected.id] = true;
            }
            if(selected.id == "bRb" || selected.id == "bRw"){
                Moved_castle[selected.id] = true;
            }
            if(promoteBlackPawn){

                $("whiteTaken").appendChild(selected); 
                promoteBlackPawnTo = elem.id;
                current_setup[selected.id] = "x";
                $("prompt").style.display = "grid";
                $("blackChoice").style.display = "block";
                $("whiteChoice").style.display = "none";
                promoteBlackPawn = false;
            } else {
                elem.appendChild(selected);
                current_setup[selected.id] = elem.id;
                moveNote = moveNote + elem.id;                 
            }
            if(removePiece != "" && removePiece != "O-O-O" && removePiece != "O-O"){
                moveNote = moveNote +"x"+ removePiece;
                removePiece = "";
            }
            sendPieceMove(elem.id, selected.id, false)
            
            if(IsKingInCheck(Object.assign({}, current_setup))){
                $(current_setup["wK"]).classList.add("danger");
                
                moveNote = moveNote + "+";
            } else {
                
                $(prevBKingPos).classList.remove("danger");                
            }
            if(removePiece == "O-O-O" || removePiece == "O-O"){
                moveNote = removePiece;
                removePiece = "";
            }
            if(selected.id.substring(0,2) == "bP" || piece_capture ){
                fiftfy_move_count = 0;
                piece_capture = false;
            } else {
                fiftfy_move_count++;                
            }
            document.querySelectorAll(".move:last-child")[0].getElementsByTagName('td')[1].innerHTML = moveNote;
        } 
        else {
        }
        
        
        
        
        // check if game is over after this move
        check_fifty_move_rule();
        checkIfGameOver();
        if(checkInsufficientMaterial()){
            GAME_OVER = true;
            $('gameOverNotice').style.display = "block";
            $('gameOverNotice').children[0].innerHTML = "Insufficient Material!";
            alert("Insufficient Material!");
        }
    }
    // else {
    // }    
}

// called from click on whitePiece
// function defines the piece to move
function moveWhite(elem)
{
    if(GAME_OVER) return;
    if(TURN == "black") return;
    if(player == "black") return;

    //remove same piece move highlights
    if(selected  && selected.nodeType )
    {
        if(selected.id == elem.id) {
            
            removeHighlight(selected);
            $(current_setup[selected.id]).classList.remove("selected");
            selected = undefined;  
            return;
        }
    }
    if(TURN == "white" && player == "white") {
        if( selected  && selected.nodeType ) {
            $(current_setup[selected.id]).classList.remove("selected");
            removeHighlight(selected);                   
        }
        selected = elem;
        $(current_setup[elem.id]).classList.add("selected");
        sendHighlightPiece(elem.id, true)                
        addHighlight(elem);
    }       
}

// called from click on blackPiece
// function defines the piece to move
function moveBlack(elem)
{
    if(GAME_OVER) return;
    if(TURN == "white") return;
    if(player == "white") return;

    //remove same piece move highlights
    if( selected  && selected.nodeType ){
        if(selected.id == elem.id){
            
            removeHighlight(selected);
            $(current_setup[selected.id]).classList.remove("selected");
            selected = undefined;    
            return;
        }
    }
    if(TURN == "black" && player == "black"){
        //TURN = "white";
        if(selected  && selected.nodeType ) {
            $(current_setup[selected.id]).classList.remove("selected");
            removeHighlight(selected);                   
        }
        selected = elem;
        sendHighlightPiece(elem.id, true)
        addHighlight(elem);
        $(current_setup[elem.id]).classList.add("selected");
    }
}

// This function is called after user has selected the choice for promoting a pawn
function promotePawn(selectedPiece){
    if(selectedPiece.id == "b_R" || selectedPiece.id == "b_B" || selectedPiece.id == "b_K" ||
     selectedPiece.id == "b_Q") {
        
        var newPiece = selectedPiece.cloneNode();
        newPiece.setAttribute('onclick','moveBlack(this)');
        var id = selectedPiece.id+promoted_counter[selectedPiece.id][0];
        promoted_counter[selectedPiece.id][0]++;
        newPiece.setAttribute('id', id);
        newPiece.innerHTML = promoted_counter[selectedPiece.id][1];       
        newPiece.classList.remove(selectedPiece.id);
        $(promoteBlackPawnTo).appendChild(newPiece);

        // push the new piece name with positon in the list to the black_pieces
        black_pieces.push(id);
        //push the position in the board
        current_setup[id] = promoteBlackPawnTo;
        document.querySelectorAll(".move:last-child")[0].getElementsByTagName('td')[1].innerHTML += "=";
        document.querySelectorAll(".move:last-child")[0].getElementsByTagName('td')[1].innerHTML += id;
    } else if(selectedPiece.id == "w_Q" || selectedPiece.id == "w_R" || selectedPiece.id == "w_K" ||
     selectedPiece.id == "w_Q") {
        
        var id = selectedPiece.id+promoted_counter[selectedPiece.id][0];
        promoted_counter[selectedPiece.id][0]++;
        var newPiece = selectedPiece.cloneNode();
        newPiece.setAttribute('onclick','moveWhite(this)');
        newPiece.setAttribute('id', id);
        newPiece.innerHTML = promoted_counter[selectedPiece.id][1];
        newPiece.classList.remove(selectedPiece.id);
        $(promoteWhitePawnTo).appendChild(newPiece);
        // push the new piece name with positon in the list to the white_pieces
        white_pieces.push(id);        
        //push the position in the board
        current_setup[id] = promoteWhitePawnTo;
        

        document.querySelectorAll(".move:last-child")[0].getElementsByTagName('td')[0].innerHTML += "=";
        document.querySelectorAll(".move:last-child")[0].getElementsByTagName('td')[0].innerHTML += id;
    }
    $("prompt").style.display = "none";
    sendPawnPromotion(selectedPiece.id, selected.id)
    selected = undefined;
}

// 50 move rule: 50 move without capture or pawn move from both players
function check_fifty_move_rule(){
    if(fiftfy_move_count == 50){
        GAME_OVER = true;
        $('gameOverNotice').style.display = "block";
        $('gameOverNotice').children[0].innerHTML = "Game draw! by 50 move rule.";
        alert("Game draw! by 50 move rule.");
    }
}

const restart_game = $('restart');
/* 
// resign and agree draw between two player
const black_resign = $('black-resign');
const white_resign = $('white-resign');
const black_draw = $('black-draw');
const white_draw = $('white-draw');
const agree_draw = $('agree-draw');
const disagree_draw = $('disagree-draw');


var white_wants_draw = false;
var black_wants_draw = false;

black_resign.onclick = function() {
    if(GAME_OVER) return;
    
    GAME_OVER = true;
    $('gameOverNotice').style.display = "block";
    $('gameOverNotice').children[0].innerHTML = "Player Resigned!";
    alert("Game over! Black Player resigned!");    
}

white_resign.onclick = function() {
    if(GAME_OVER) return;
    
    GAME_OVER = true;
    $('gameOverNotice').style.display = "block";
    $('gameOverNotice').children[0].innerHTML = "White Player Resigned!";
    alert("Game over! White Player resigned!");    
}

black_draw.onclick = function() {
    if(GAME_OVER) return;
    
    if(!black_wants_draw){
        black_wants_draw = true;
        // notify other player
        $('draw-notice').style.display = "block"; 
        $('resigning-player').innerHTML = "Black wants a draw?"; 
    }
}

white_draw.onclick = function() {
    if(GAME_OVER) return;
    if(!white_wants_draw){
        white_wants_draw = true;
        // notify other player
        $('draw-notice').style.display = "block"; 
        $('resigning-player').innerHTML = "White wants to draw?"; 
    }
}

agree_draw.onclick = function() {
    if(GAME_OVER) return;
    $('draw-notice').style.display = "none"; 
    if(white_wants_draw || black_wants_draw){
        GAME_OVER = true;
        alert("Game drawn by agreement!");
    }
}

disagree_draw.onclick = function() {
    if(GAME_OVER) return;
    $('draw-notice').style.display = "none"; 
    white_wants_draw = false;
    black_wants_draw = false;
    alert("Draw request declined.");
} */

// -------------- RESET THE GAME --------- //
// alot of variables to rest
restart_game.onclick = function() {

    TURN = "white";
    $('black-turn').style.display = "none";
    GAME_OVER = false;
    fiftfy_move_count = 0;

    // conditions for castling for both white and black.
    Moved_castle = {
        "wK": false,
        "wRw": false,
        "wRb": false,
        "bK": false,
        "bRw": false,
        "bRb": false
    }
    // used for keeping track of number of pieces for both black and white.
    black_pieces =["bP1","bP2","bP3","bP4","bP5","bP6",
                    "bP7","bP8","bRb","bKb","bBb","bQ","bK","bBw","bKw","bRw"];
    white_pieces =["wRw","wKw","wBw","wQ","wK","wBb",
                    "wKb","wRb","wP1","wP2","wP3","wP4","wP5","wP6","wP7","wP8"];
    
    // all the default pieces and its position on the board
    // and promoted pieces will be added if the pawn is promoted
    current_setup ={
        'wRb': "a1",
        "wKw": "b1",
        "wBb": "c1",
        "wQ": "d1",
        "wK": "e1",
        "wBw": "f1",
        "wKb": "g1",
        "wRw": "h1",
        
        'wP1': "a2",
        "wP2": "b2",
        "wP3": "c2",
        "wP4": "d2",
        "wP5": "e2",
        "wP6": "f2",
        "wP7": "g2",
        "wP8": "h2",
    
        'bP1': "a7",
        "bP2": "b7",
        "bP3": "c7",
        "bP4": "d7",
        "bP5": "e7",
        "bP6": "f7",
        "bP7": "g7",
        "bP8": "h7",
        
        'bRw': "a8",
        "bKb": "b8",
        "bBw": "c8",
        "bQ": "d8",
        "bK": "e8",
        "bBb": "f8",
        "bKw": "g8",
        "bRb": "h8"
    };
    // used for counting the number of pieces that got promoted for creating a unique id
    // html codes for => Rook, Knight, Bishop, Queen.
    promoted_counter = {
        // promoted white pieces counter for id
        "w_R" : [0,"&#9814"],
        "w_K" : [0,"&#9816"],
        "w_B" : [0,"&#9815"],
        "w_Q" : [0,"&#9813"],
        // promoted black pieces counter for id
        "b_R" : [0, "&#9820"],
        "b_K" : [0, "&#9822"],
        "b_B" : [0, "&#9821"],
        "b_Q" : [0, "&#9819"]
    };

    selected = undefined;
    previousBlackMove = undefined;
    previousWhiteMove = undefined;
    enPassant = false;
    blackCastle = false;
    whiteCastle = false;
    bcRight = false;
    bcLeft = false;
    wcRight = false;
    wcLeft = false;
    promoteBlackPawn = false;
    promoteWhitePawn = false;

    removePiece = "";
    piece_capture = false;
    Black_KingInCheck = false;
    White_KingInCheck = false;

    promoteBlackPawnTo = undefined;
    promoteWhitePawnTo = undefined;
    $('prompt').style.display = "none";
    $('gameOverNotice').style.display = "none";
    $('draw-notice').style.display = "none"; 
    white_wants_draw = false;
    black_wants_draw = false;

    //rebuild the board
    //clear the board
    for(var pos of VALID_POSITIONS){
        if($(pos).children.length != 0){
            $('whiteTaken').appendChild($(pos).children[0]);
            $(pos).classList.remove("select");
            $(pos).classList.remove("highlight");
            $(pos).classList.remove("danger");
        }
    }
    // add pieces
    for(var key in current_setup){
        $(current_setup[key]).appendChild($(key));
    }
    // remove promoted pieces
    $('whiteTaken').replaceChildren();
    $('blackTaken').replaceChildren();
    alert("Resetting game");
    // we are done resetting the game
}


