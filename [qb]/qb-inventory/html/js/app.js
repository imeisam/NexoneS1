const { useQuasar } = Quasar
const { ref } = Vue
var ThrowAllow={};
var clips={};
const app = Vue.createApp({
  setup () {
    return {
        options: ref(false),
        help: ref(false),
        showblur: ref(true),
    }
  },
  methods: {
    select: function(event) {
        targetId = event.currentTarget.id;
        showBlur()
    }
}
})

app.use(Quasar, { config: {} })
app.mount('#inventory-menus')

function showBlur() {
    $.post('https://qb-inventory/showBlur');
}

function updateTextInput(value) {
    document.getElementById('item-amount-text').value = value;
}

var InventoryOption = "0, 0, 0";

var totalWeight = 0;
var totalWeightOther = 0;

var playerMaxWeight = 0;
var otherMaxWeight = 0;

var otherLabel = "";

var ClickedItemData = {};

var SelectedAttachment = null;
var AttachmentScreenActive = false;
var ControlPressed = false;
var disableRightMouse = false;
var selectedItem = null;

var IsDragging = false;

$(document).on("keydown", function() {
    if (event.repeat) {
        return;
    }
    switch (event.keyCode) {
        case 27: // ESC
            Inventory.Close();
            $('.health-system ').css('left', '-50%');
            $('.health-system').css('display', 'none');
            break;
        case 9: // TAB
            Inventory.Close();
            break;
        case 17: // TAB
            ControlPressed = true;
            break;
    }
});

$(document).on("dblclick", ".item-slot", function(e) {
    var ItemData = $(this).data("item");
    var ItemInventory = $(this).parent().attr("data-inventory");
    if (ItemData) {
        Inventory.Close();
        $.post(
            "https://qb-inventory/UseItem",
            JSON.stringify({
                inventory: ItemInventory,
                item: ItemData,
            })
        );
    }
});

$(document).on("keyup", function() {
    switch (event.keyCode) {
        case 17: // TAB
            ControlPressed = false;
            break;
    }
});

$(document).on("mouseenter", ".item-slot", function (e) {
    e.preventDefault();
    if($("#qbcore-inventory").css("display") == "block"){
        if ($(this).data("item") != null) {
            if ($('.item-shit').css('display') == 'none') {
                $(".ply-iteminfo-container").css('display', 'block');
                FormatItemInfo($(this).data("item"));
            } else {
                $(".ply-iteminfo-container").css('display', 'none');
                $('.item-shit').css('display', 'none');
                $('.item-split').css('display', 'none');
                $('.item-info-description').css('display', 'block');

            }
            
        } else {
            if ($(this).data("item") != null && $('.item-shit').css('display') !== 'flex'){
                $(".ply-iteminfo-container").css('display', 'none');
                $('.item-shit').css('display', 'none');
                $('.item-split').css('display', 'none');
                $('.item-info-description').css('display', 'block');
            }
        }
    }
});

$(document).on("mouseleave", ".item-slot", function(e){
    e.preventDefault();
    if ($('.item-shit').css('display') == 'none') {
        $(".ply-iteminfo-container").fadeOut(0)
        $('.item-shit').css('display', 'none');
        $('.item-split').css('display', 'none');
        $('.item-info-description').css('display', 'block');
    }
});

$(document).on("mousedown", function (event) {
    switch (event.which) {
        case 1:
            if ($('.item-shit').css('display') !== 'none') {
                $(".ply-iteminfo-container").fadeOut(100);
                $('.item-shit').css('display', 'none');
                $('.item-split').css('display', 'none');
                $('.item-info-description').css('display', 'block');
            }
        break;
    }
});
$(document).on("mousedown", "#Use", function (event) {
    switch (event.which) {
        case 1:
            fromData = selected_item.data("item");
            fromInventory = selected_item.parent().attr("data-inventory");
            Inventory.Close();
            $.post(
                "https://qb-inventory/UseItem",
                JSON.stringify({
                    inventory: fromInventory,
                    item: fromData,
                })
            );
            $(".ply-iteminfo-container").fadeOut(100);
            $('.item-shit').css('display', 'none');
            $('.item-split').css('display', 'none');
            $('.item-info-description').css('display', 'block');
        break
    }
});
$(document).on("mousedown", "#Give", function (event) {
    switch (event.which) {
        case 1:
            fromData = selected_item.data("item");
            fromInventory = selected_item.parent().attr("data-inventory");
            Inventory.Close();
            amount = $("#item-amount").val() || fromData.amount
            $.post(
                "https://qb-inventory/GiveItem",
                JSON.stringify({
                    inventory: fromInventory,
                    item: fromData,
                    amount: parseInt(amount),
                })
            );
            $(".ply-iteminfo-container").fadeOut(100);
            $('.item-shit').css('display', 'none');
            $('.item-split').css('display', 'none');
            $('.item-info-description').css('display', 'none');
        break
    }
});
$(document).on("mousedown", "#Drop", function (event) {
    switch (event.which) {
        case 1:
            fromData = selected_item.data("item");
            fromInventory = selected_item.parent().attr("data-inventory");
            amount = $("#item-amount").val() || fromData.amount
            Inventory.Close();
            $.post(
                "https://qb-inventory/DropItem",
                JSON.stringify({
                    inventory: fromInventory,
                    item: fromData,
                    amount: parseInt(amount),
                })
            );

            $(".ply-iteminfo-container").fadeOut(100);
            $('.item-shit').css('display', 'none');
            $('.item-split').css('display', 'none');
            $('.item-info-description').css('display', 'block');
        break
    }
});
$(document).on("mousedown", "#Throw", function (event) {
    switch (event.which) {
        case 1:
            fromData = selected_item.data("item");
            fromInventory = selected_item.parent().attr("data-inventory");
            amount = $("#item-amount").val() || fromData.amount
          if (fromData.amount<amount){
            amount=fromData.amount;
          }
            Inventory.Close();
            $.post(
                "https://qb-inventory/ThrowItem",
                JSON.stringify({
                    inventory: fromInventory,
                    item: fromData,
                    amount: parseInt(amount),
                })
            );

            $(".ply-iteminfo-container").fadeOut(100);
            $('.item-shit').css('display', 'none');
            $('.item-split').css('display', 'none');
            $('.item-info-description').css('display', 'block');
        break
    }
});
$(document).on("mousedown", "#Clip", function (event) {
    switch (event.which) {
        case 1:
            fromData = selected_item.data("item");
            fromInventory = selected_item.parent().attr("data-inventory");
            amount = $("#item-amount").val() || fromData.amount
            Inventory.Close();
            $.post(
                "https://qb-inventory/RemoveClip",
                JSON.stringify({
                    inventory: fromInventory,
                    item: fromData
                })
            );

            $(".ply-iteminfo-container").fadeOut(100);
            $('.item-shit').css('display', 'none');
            $('.item-split').css('display', 'none');
            $('.item-info-description').css('display', 'block');
        break
    }
});

// Player Item Info & Inventory Options Merged
var contextMenuSelectedItem = null;
var ItemInventory = null;
$('#item-split').click(function() {
    var currentValue = $('#item-amount').val();
    var newValue = Math.floor(currentValue / 2);
    $.post("https://qb-inventory/PlayDropSound", JSON.stringify({}));
    $('#item-amount').val(newValue);
    $('#item-amount-text').val(newValue);
});

// Autostack Quickmove
function GetFirstFreeSlot($toInv, $fromSlot) {
    var retval = null;
    $.each($toInv.find(".item-slot"), function(i, slot) {
        if ($(slot).data("item") === undefined) {
            if (retval === null) {
                retval = i + 1;
            }
        }
    });
    return retval;
}

function CanQuickMove() {
    var otherinventory = otherLabel.toLowerCase();
    var retval = true;
    // if (otherinventory == "grond") {
    //     retval = false
    // } else if (otherinventory.split("-")[0] == "dropped") {
    //     retval = false;
    // }
    if (otherinventory.split("-")[0] == "player") {
        retval = false;
    }
    return retval;
}

$(document).on("click", ".item-slot", function(e) {
    e.preventDefault();
    var ItemData = $(this).data("item");

    if (ItemData !== null && ItemData !== undefined) {
        if (ItemData.name !== undefined) {
            if (ItemData.name.split("_")[0] == "weapon") {
                if (!$("#weapon-attachments").length) {
                    // if (ItemData.info.attachments !== null && ItemData.info.attachments !== undefined && ItemData.info.attachments.length > 0) {
                    $(".inv-options-list").append(
                        // '<div class="inv-option-item" id="weapon-attachments"><p><i style="margin-top: 1rem" class="fas fa-gun"></i></p></div>'
                    );
                    $("#weapon-attachments").hide().fadeIn(250);
                    ClickedItemData = ItemData;
                    // }
                } else if (ClickedItemData == ItemData) {
                    $("#weapon-attachments").fadeOut(250, function() {
                        $("#weapon-attachments").remove();
                    });
                    ClickedItemData = {};
                } else {
                    ClickedItemData = ItemData;
                }
            } else {
                ClickedItemData = {};
                if ($("#weapon-attachments").length) {
                    $("#weapon-attachments").fadeOut(250, function() {
                        $("#weapon-attachments").remove();
                    });
                }
            }
        } else {
            ClickedItemData = {};
            if ($("#weapon-attachments").length) {
                $("#weapon-attachments").fadeOut(250, function() {
                    $("#weapon-attachments").remove();
                });
            }
        }
    } else {
        ClickedItemData = {};
        if ($("#weapon-attachments").length) {
            $("#weapon-attachments").fadeOut(250, function() {
                $("#weapon-attachments").remove();
            });
        }
    }
});

$(document).on("click", "#inv-close", function(e) {
    e.preventDefault();
    Inventory.Close();
});

$(document).on("click", ".weapon-attachments-back", function(e) {
    e.preventDefault();
    $("#qbcore-inventory").css({ display: "block" });
    $("#qbcore-inventory").animate({
            left: 0 + "vw",
        },
        200
    );
    $(".weapon-attachments-container").animate({
            left: -100 + "vw",
        },
        200,
        function() {
            $(".weapon-attachments-container").css({ display: "none" });
        }
    );
    AttachmentScreenActive = false;
});

// function changeInventoryColor(color) {
//     $( ".player-inventory-bg" ).css( "background-color", color);
//     $( ".other-inventory-bg" ).css( "background-color", color);
//     $( ".inv-options" ).css( "background-color", color);
//     localStorage.setItem('qb-inventory-color', color);
// }

// const savedColor = localStorage.getItem('qb-inventory-color');

// if (savedColor) {
//     changeInventoryColor(savedColor)
// }

// $('#favcolor').change(function(){
//     let color = $(this).val();
//     let hexOpacity = "CC";
//     let finalColor = color+hexOpacity;
//     changeInventoryColor(finalColor);
// });

function FormatAttachmentInfo(data) {
    $.post(
        "https://qb-inventory/GetWeaponData",
        JSON.stringify({
            weapon: data.name,
            ItemData: ClickedItemData,
        }),
        function(data) {
            var AmmoLabel = "9mm";
            var Durability = 100;
            if (data.WeaponData.ammotype == "AMMO_RIFLE") {
                AmmoLabel = "7.62";
            } else if (data.WeaponData.ammotype == "AMMO_SHOTGUN") {
                AmmoLabel = "12 Gauge";
            }
            if (ClickedItemData.info.quality !== undefined) {
                Durability = ClickedItemData.info.quality;
            }

            $(".weapon-attachments-container-title").html(
                data.WeaponData.label + " | " + AmmoLabel
            );
            $(".weapon-attachments-container-description").html(
                data.WeaponData.description
            );
            $(".weapon-attachments-container-details").html(
                '<span style="font-weight: bold; letter-spacing: .1vh;">Serial</span><br> ' +
                ClickedItemData.info.serie +
                '<br><br><span style="font-weight: bold; letter-spacing: .1vh;">Durability - ' +
                Durability.toFixed() +
                '% </span> <div class="weapon-attachments-container-detail-durability"><div class="weapon-attachments-container-detail-durability-total"></div></div>'
            );
            $(".weapon-attachments-container-detail-durability-total").css({
                width: Durability + "%",
            });
            $(".weapon-attachments-container-image").attr(
                "src",
                "./images/" + data.WeaponData.name + ".png"
            );
            $(".weapon-attachments").html("");

            if (data.AttachmentData !== null && data.AttachmentData !== undefined) {
                if (data.AttachmentData.length > 0) {
                    $(".weapon-attachments-title").html(
                        '<span style="font-weight: bold; letter-spacing: .1vh;">Attachments</span>'
                    );
                    $.each(data.AttachmentData, function(i, attachment) {
                        var WeaponType = data.WeaponData.ammotype
                            .split("_")[1]
                            .toLowerCase();
                        $(".weapon-attachments").append(
                            '<div class="weapon-attachment" id="weapon-attachment-' +
                            i +
                            '"> <div class="weapon-attachment-label"><p>' +
                            attachment.label +
                            '</p></div> <div class="weapon-attachment-img"><img src="./images/' +
                            attachment.image + '"></div> </div>'
                        );
                        attachment.id = i;
                        $("#weapon-attachment-" + i).data("AttachmentData", attachment);
                    });
                } else {
                    $(".weapon-attachments-title").html(
                        '<span style="font-weight: bold; letter-spacing: .1vh;">This gun doesn\'t contain attachments</span>'
                    );
                }
            } else {
                $(".weapon-attachments-title").html(
                    '<span style="font-weight: bold; letter-spacing: .1vh;">This gun doesn\'t contain attachments</span>'
                );
            }

            handleAttachmentDrag();
        }
    );
}

var AttachmentDraggingData = {};

function handleAttachmentDrag() {
    $(".weapon-attachment").draggable({
        helper: "clone",
        appendTo: "body",
        scroll: true,
        revertDuration: 0,
        revert: "invalid",
        start: function(event, ui) {
            var ItemData = $(this).data("AttachmentData");
            $(this).addClass("weapon-dragging-class");
            AttachmentDraggingData = ItemData;
        },
        stop: function() {
            $(this).removeClass("weapon-dragging-class");
        },
    });
    $(".weapon-attachments-remove").droppable({
        accept: ".weapon-attachment",
        hoverClass: "weapon-attachments-remove-hover",
        drop: function(event, ui) {
            $.post(
                "https://qb-inventory/RemoveAttachment",
                JSON.stringify({
                    AttachmentData: AttachmentDraggingData,
                    WeaponData: ClickedItemData,
                }),
                function(data) {
                    if (data.Attachments !== null && data.Attachments !== undefined) {
                        if (data.Attachments.length > 0) {
                            $("#weapon-attachment-" + AttachmentDraggingData.id).fadeOut(
                                150,
                                function() {
                                    $("#weapon-attachment-" + AttachmentDraggingData.id).remove();
                                    AttachmentDraggingData = null;
                                }
                            );
                        } else {
                            $("#weapon-attachment-" + AttachmentDraggingData.id).fadeOut(
                                150,
                                function() {
                                    $("#weapon-attachment-" + AttachmentDraggingData.id).remove();
                                    AttachmentDraggingData = null;
                                    $(".weapon-attachments").html("");
                                }
                            );
                            $(".weapon-attachments-title").html(
                                '<span style="font-weight: bold; letter-spacing: .1vh;">This gun doesn\'t contain attachments</span>'
                            );
                        }
                    } else {
                        $("#weapon-attachment-" + AttachmentDraggingData.id).fadeOut(
                            150,
                            function() {
                                $("#weapon-attachment-" + AttachmentDraggingData.id).remove();
                                AttachmentDraggingData = null;
                                $(".weapon-attachments").html("");
                            }
                        );
                        $(".weapon-attachments-title").html(
                            '<span style="font-weight: bold; letter-spacing: .1vh;">This gun doesn\'t contain attachments</span>'
                        );
                    }
                }
            );
        },
    });
}

$(document).on("click", "#weapon-attachments", function(e) {
    e.preventDefault();
    if (!Inventory.IsWeaponBlocked(ClickedItemData.name)) {
        $(".weapon-attachments-container").css({ display: "block" });
        $("#qbcore-inventory").animate({
                left: 100 + "vw",
            },
            200,
            function() {
                $("#qbcore-inventory").css({ display: "none" });
            }
        );
        $(".weapon-attachments-container").animate({
                left: 0 + "vw",
            },
            200
        );
        AttachmentScreenActive = true;
        FormatAttachmentInfo(ClickedItemData);
    } else {
        $.post(
            "https://qb-inventory/Notify",
            JSON.stringify({
                message: "Attachments are unavailable for this gun.",
                type: "error",
            })
        );
    }
});

function getGender(info) {
    return info.gender === 1 ? "Woman" : "Man";
}

function setItemInfo(title, description) {
    $(".item-info-title").html(`<p>${title}</p>`);
    $(".item-info-description").html(description);
}

function generateDescription(itemData) {
    if (itemData.type === "weapon") {
        let ammo = 'No Clip';
        if (itemData.info.clip || itemData.info.ammo > 0) {
            ammo = itemData.info.ammo
        }
        return `<p><strong>Serie: </strong><span>${itemData.info.serie}</span></p>
            <p><strong>Ammunition: </strong><span>${ammo}</span></p>`;
    }

    // if (itemData.name == "phone" && itemData.info.lbPhoneNumber) {
    //     return `<p><strong>Phone Number: </strong><span>${itemData.info.lbFormattedNumber ?? itemData.info.lbPhoneNumber}</span></p>`;
    // }

    switch (itemData.name) {
        case "fishinglure":
    return `<p><strong>Uses: </strong><span>${itemData.info.uses}</span></p>`;
case "fishinglure2":
    return `<p><strong>Uses: </strong><span>${itemData.info.uses}</span></p>`;

    case "zatburger":
        return `<p>with: ${itemData.info.emojis}</p>`; 
    case "zatsprunk":
        return `<p>with: ${itemData.info.emojis}</p>`;     
    case "zatecola":
        return `<p>with: ${itemData.info.emojis}</p>`;  
    case "zatecolalight":
        return `<p>with: ${itemData.info.emojis}</p>`;  
    case "zatorangotang":
        return `<p>with: ${itemData.info.emojis}</p>`;  
    case "zatfries":
        return `<p>with: ${itemData.info.emojis}</p>`;
    case "zatweedbranch":
        return `<p><strong>Genetics: </strong><span>${itemData.info.genetics}</span></p>
                <p><strong>Purity: </strong><span>${itemData.info.purity}</span></p>
                <p><strong>Dry: </strong><span>${itemData.info.drylevel}</span></p>`;
    case "zatpackedweed":
        return `<p><strong>Purity: </strong><span>${itemData.info.purity}</span></p>`;
    case "zatjoint":
        return `<p><strong>Purity: </strong><span>${itemData.info.purity}</span></p>`;
    
        case "zatgpu":
            return `<p>Type: ${itemData.info.type}</p>
            <p>Performance:${itemData.info.performance}%</p>
            <p>Freq:${itemData.info.hz}Ghz</p>`;  
        case "zatcpu":
            return `<p>Type: ${itemData.info.type}</p>
            <p>Performance:${itemData.info.performance}%</p>`;  
        case "zatmb":
            return `<p>Type: ${itemData.info.type}</p>
            <p>Performance:${itemData.info.performance}%</p>`;  
        case "zatps":
            return `<p>Type: ${itemData.info.type}</p>
              <p>Performance:${itemData.info.performance}%</p>`;  
        case "id_card":
            return `<p><strong>CSN: </strong><span>${itemData.info.citizenid}</span></p>
              <p><strong>First Name: </strong><span>${itemData.info.firstname}</span></p>
              <p><strong>Last Name: </strong><span>${itemData.info.lastname}</span></p>
              <p><strong>Birth Date: </strong><span>${itemData.info.birthdate}</span></p>
              <p><strong>Gender: </strong><span>${getGender(itemData.info)}</span></p>
              <p><strong>Nationality: </strong><span>${itemData.info.nationality}</span></p>`;
        case "jerrycan":
            return `<p><strong>A Jerry Can, designed to hold fuel! </strong><span>${itemData.info.gasamount} Liters Inside.</span></p>`
        case "wateringcan":
            return `<p><strong>A Watering Can, designed to hold Water ! </strong><span>${itemData.info.durability} Liters Inside.</span></p>`
        case "harness":
                 if (itemData.name == "mechboard") {
                $(".item-info-title").html("<p>" + itemData.label + "</p>");
                $(".item-info-description").html(
                    "<p>" + itemData.info.vehplate + "</p>" +
                    "<p>" + itemData.info.veh + "</p>"
                )
                }
       case "fishinglure":
                $(".item-info-title").html("<p>" + itemData.label + "</p>");
                $(".item-info-description").html(
                    "<p><strong>Uses: </strong><span>" +
                    itemData.info.uses +
                    "</span></p><p style=\"font-size:11px\"><b>Weight: </b>" + itemData.weight + " | <b>Amount: </b> " + itemData.amount + " | <b>Quality: </b> " + "<a style=\"font-size:11px;color:green\">" + Math.floor(itemData.info.quality) + "</a>"
                );
       case  "fishinglure2" :
                $(".item-info-title").html("<p>" + itemData.label + "</p>");
                $(".item-info-description").html(
                    "<p><strong>Uses: </strong><span>" +
                    itemData.info.uses +
                    "</span></p><p style=\"font-size:11px\"><b>Weight: </b>" + itemData.weight + " | <b>Amount: </b> " + itemData.amount + " | <b>Quality: </b> " + "<a style=\"font-size:11px;color:green\">" + Math.floor(itemData.info.quality) + "</a>"
                );


        case "filled_evidence_bag":
            if (itemData.info.type == "casing") {
                return `<p><strong>Evidence material: </strong><span>${itemData.info.label}</span></p>
                <p><strong>Type number: </strong><span>${itemData.info.ammotype}</span></p>
                <p><strong>Caliber: </strong><span>${itemData.info.ammolabel}</span></p>
                <p><strong>Name: </strong><span>${itemData.info.serie}</span></p>
                <p><strong>Crime scene: </strong><span>${itemData.info.street}</span></p><br /><p>${itemData.description}</p>`;
            } else if (itemData.info.type == "blood") {
                return `<p><strong>Evidence material: </strong><span>${itemData.info.label}</span></p>
                <p><strong>Blood type: </strong><span>${itemData.info.bloodtype}</span></p>
                <p><strong>DNA Code: </strong><span>${itemData.info.dnalabel}</span></p>
                <p><strong>Crime scene: </strong><span>${itemData.info.street}</span></p><br /><p>${itemData.description}</p>`;
            }
            else if (itemData.info.type == "fingerprint") {
                return `<p><strong>Evidence material: </strong><span>${itemData.info.label}</span></p>
                <p><strong>Fingerprint: </strong><span>${itemData.info.fingerprint}</span></p>
                <p><strong>Crime Scene: </strong><span>${itemData.info.street}</span></p><br /><p>${itemData.description}</p>`;
            }    
             else if (itemData.info.type == "dna") {
                return `<p><strong>Evidence material: </strong><span>${itemData.info.label}</span></p>
                <p><strong>DNA Code: </strong><span>${itemData.info.dnalabel}</span></p><br/><p><strong>Name: </strong><span>${itemData.info.dnaname}</span></p><br/><p>${itemData.description}</p>`;
            }
        case "summonablepet":
            return `<p>${itemData.info.Name}</p>`;
        case "diving_gear":
            return `<p>Tank: ${itemData.info.oxygen} O2</p>`;
        case "pistol_clip":
            return `<p>Ammo: ${itemData.info.ammo}</p>`;
        case "rifle_clip":
            return `<p>Ammo: ${itemData.info.ammo}</p>`;
        case "smg_clip":
            return `<p>Ammo: ${itemData.info.ammo}</p>`;
        case "blueprint":
            return `<p>Type: ${itemData.info.type}</p>`;
        case "pdradio":
            return `<p>Serie: ${itemData.info.serie}</p>`;
        default:
            return itemData.description;
    }
}

function FormatItemInfo(itemData, mouse) {
    if (itemData && itemData.info !== "") {
        const description = generateDescription(itemData);
        $('.item-uselessinfo-weight').html(`<i class="fa-solid fa-weight-hanging"></i> ${((itemData.weight * itemData.amount / 1000)).toFixed(2)}KG`)
        $('.item-uselessinfo-decay').html(`<i class="fa-solid fa-bolt"></i> ${(Math.floor(itemData.info?.quality || 100))}%`)
        setItemInfo(itemData.label, description, mouse);
    } else {
        setItemInfo(itemData.label, itemData.description || "", mouse);
    }
}

$(document).on("mousedown", ".item-slot", function (event) {
    switch (event.which) {
        case 1:
            fromInventory = $(this).parent();
            if ($(fromInventory).attr("data-inventory") == "player") {
                if ($('.item-shit').css('display') == 'none') {
                    if (ThrowAllow[$(this).data("item").name]!= undefined){
                        $('#Throw').css('display', 'flex');
                    }else{
                        $('#Throw').css('display', 'none');
                    }
                    if ($(this).data("item").name.split("_")[0] == "weapon" || clips[$(this).data("item").name]!= undefined){
                        $('#Clip').css('display', 'flex');
                    }else{
                        $('#Clip').css('display', 'none');
                    }

                    $('.item-shit').css('display', 'flex');
                    $('.item-info-description').css('display', 'block');
                    $('.item-split').css('display', 'none');
                    selected_item = $(this)
                    selected_item_data = $(this).data("item")
                    
                    topy = event.clientY
                    lefty = event.clientX
                } else {
                    $('.item-shit').css('display', 'none');
                    $('.item-split').css('display', 'none');
                    $('.item-info-description').css('display', 'block');
                    if ($(this).data('item') != undefined) {
                        FormatItemInfo($(this).data("item"));
                    }
                }
            }
        break 
        case 3:
            if (event.shiftKey) {
                fromSlot = $(this).attr("data-slot");
                fromInventory = $(this).parent();
                if ($(fromInventory).attr("data-inventory") == "player") {
                    toInventory = $(".other-inventory");
                } else {
                    toInventory = $(".player-inventory");
                }
                toSlot = GetFirstFreeSlot(toInventory, $(this));
                if ($(this).data("item") === undefined) {
                    return;
                }
                toAmount = $("#item-amount").val() || $(this).data("item").amount;
                
                if (CanQuickMove()) {
                    if (toSlot === null) {
                        InventoryError(fromInventory, fromSlot);
                        return;
                    }
                    if (fromSlot == toSlot && fromInventory == toInventory) {
                        return;
                    }
                    if (toAmount >= 0) {
                        if (updateweights(fromSlot, toSlot, fromInventory, toInventory, toAmount)) {
                            swap(fromSlot, toSlot, fromInventory, toInventory, toAmount);
                        }
                    }
                } else {
                    InventoryError(fromInventory, fromSlot);
                }
                break;
            } else {
                if ($('.item-shit').css('display') == 'none') {
                    if (ThrowAllow[$(this).data("item").name]!= undefined){
                        $('#Throw').css('display', 'flex');
                    }else{
                        $('#Throw').css('display', 'none');
                       
                    }

                    if ($(this).data("item").name.split("_")[0] == "weapon" || clips[$(this).data("item").name]!= undefined){
                        $('#Clip').css('display', 'flex');
                    }else{
                        $('#Clip').css('display', 'none');
                    }
                    $('.item-shit').css('display', 'flex');
                    $('.item-info-description').css('display', 'block');
                    selected_item = $(this)
                    selected_item_data = $(this).data("item")
                } else {
                    $('.item-shit').css('display', 'none');
                    $('.item-info-description').css('display', 'block');
                    if ($(this).data('item') != undefined) {
                        FormatItemInfo($(this).data("item"));
                    }
                }
            }
        }
    }
);

let lefty = 0
let topy = 0
$('body').mousemove(function (event) { 
    if ($('.item-shit').css('display') !== 'none') {return}
    topy = event.clientY
    lefty = event.clientX
    var howloooong = $('.ply-iteminfo-container').width();
    var howtaaaall = $('.ply-iteminfo-container').height()/2 > 70 ? $('.ply-iteminfo-container').height()/2 - 100 : $('.ply-iteminfo-container').height()/2 
    if (event.clientX < 1560) {
        datway = false
        $('.ply-iteminfo-container').css('left', (event.clientX+26)+'px').css('top', (event.clientY-howtaaaall)+'px')
    } else if (event.clientX >= 1560) {
        datway = true
        var howloooong = $('.ply-iteminfo-container').width();
        $('.ply-iteminfo-container').css('left', (event.clientX-howloooong-26)+'px').css('top', (event.clientY-howtaaaall)+'px')
    }
});

function handleDragDrop() {
    $(".item-drag").draggable({
        helper: "clone",
        appendTo: "body",
        scroll: true,
        revertDuration: 0,
        revert: "invalid",
        cancel: ".item-nodrag",
        start: function(event, ui) {
            IsDragging = true;
            // $(this).css("background", "rgba(20,20,20,1.0)");
            $(this).find("img").css("filter", "brightness(50%)");

            $(".ply-iteminfo-container").fadeOut(100);
            $('.item-shit').css('display', 'none');
            $('.item-info-description').css('display', 'block');

            //  $(".item-slot").css("border", "1px solid rgba(255, 255, 255, 0.1)");

            var itemData = $(this).data("item");
            var dragAmount = $("#item-amount").val();
            if (!itemData.useable) {
                // $("#item-use").css("background", "rgba(35,35,35, 0.5");
            }

            if (dragAmount == 0) {
                if (itemData.price != null) {
                    $(this).find(".item-slot-amount p").html("0");
                    $(".ui-draggable-dragging")
                        .find(".item-slot-amount p")
                        .html(" " + itemData.amount + " £" + itemData.price);
                    $(".ui-draggable-dragging").find(".item-slot-key").remove();
                    if ($(this).parent().attr("data-inventory") == "hotbar") {
                        // $(".ui-draggable-dragging").find(".item-slot-key").remove();
                    }
                } else {
                    $(this).find(".item-slot-amount p").html("0");
                    $(".ui-draggable-dragging")
                        .find(".item-slot-amount p")
                        .html(
                            itemData.amount +
                            " " +
                            
                            " "
                        );
                    $(".ui-draggable-dragging").find(".item-slot-key").remove();
                    if ($(this).parent().attr("data-inventory") == "hotbar") {
                        // $(".ui-draggable-dragging").find(".item-slot-key").remove();
                    }
                }
            } else if (dragAmount > itemData.amount) {
                if (itemData.price != null) {
                    $(this)
                        .find(".item-slot-amount p")
                        .html(" " + itemData.amount + " £" + itemData.price);
                    if ($(this).parent().attr("data-inventory") == "hotbar") {
                        // $(".ui-draggable-dragging").find(".item-slot-key").remove();
                    }
                } else {
                    $(this)
                        .find(".item-slot-amount p")
                        .html(
                            itemData.amount +
                            " " +
                            
                            " "
                        );
                    if ($(this).parent().attr("data-inventory") == "hotbar") {
                        // $(".ui-draggable-dragging").find(".item-slot-key").remove();
                    }
                }
                InventoryError($(this).parent(), $(this).attr("data-slot"));
            } else if (dragAmount > 0) {
                if (itemData.price != null) {
                    $(this)
                        .find(".item-slot-amount p")
                        .html(" " + itemData.amount + " £" + itemData.price);
                    $(".ui-draggable-dragging")
                        .find(".item-slot-amount p")
                        .html(" " + itemData.amount + " £" + itemData.price);
                    $(".ui-draggable-dragging").find(".item-slot-key").remove();
                    if ($(this).parent().attr("data-inventory") == "hotbar") {
                        // $(".ui-draggable-dragging").find(".item-slot-key").remove();
                    }
                } else {
                    $(this)
                        .find(".item-slot-amount p")
                        .html(
                            itemData.amount -
                            dragAmount +
                            " " +
                            (
                                (itemData.weight * (itemData.amount - dragAmount)) /
                                1000
                            ).toFixed(1) +
                            " "
                        );
                    $(".ui-draggable-dragging")
                        .find(".item-slot-amount p")
                        .html(
                            dragAmount +
                            " " +
                            
                            " "
                        );
                    $(".ui-draggable-dragging").find(".item-slot-key").remove();
                    if ($(this).parent().attr("data-inventory") == "hotbar") {
                        // $(".ui-draggable-dragging").find(".item-slot-key").remove();
                    }
                }
            } else {
                if ($(this).parent().attr("data-inventory") == "hotbar") {
                    // $(".ui-draggable-dragging").find(".item-slot-key").remove();
                }
                $(".ui-draggable-dragging").find(".item-slot-key").remove();
                $(this)
                    .find(".item-slot-amount p")
                    .html(
                        itemData.amount +
                        " " +
                        
                        " "
                    );
                InventoryError($(this).parent(), $(this).attr("data-slot"));
            }
        },
        stop: function() {
            setTimeout(function() {
                IsDragging = false;
            }, 300);
            $(this).css("background", "rgba(23, 27, 43, 0.5)");
            $(this).find("img").css("filter", "brightness(100%)");
            // $("#item-use").css("background", "rgba(" + InventoryOption + ", 0.3)");
        },
    });

    $(".item-slot").droppable({
        hoverClass: "item-slot-hoverClass",
        drop: function(event, ui) {
            setTimeout(function() {
                IsDragging = false;
            }, 300);
            fromSlot = ui.draggable.attr("data-slot");
            fromInventory = ui.draggable.parent();
            toSlot = $(this).attr("data-slot");
            toInventory = $(this).parent();
            toAmount = $("#item-amount").val();

            var toDataUnique = toInventory.find("[data-slot=" + toSlot + "]").data("item");
            var fromDataUnique = fromInventory.find("[data-slot=" + fromSlot + "]").data("item");

            if (fromSlot == toSlot && fromInventory == toInventory) {
                return;
            }
            if (toAmount >= 0) {
                if (!toDataUnique) {
                if (
                    updateweights(fromSlot, toSlot, fromInventory, toInventory, toAmount)
                ) {
                    swap(fromSlot, toSlot, fromInventory, toInventory, toAmount);
                }
                } else {
                    if (fromDataUnique.unique == toDataUnique.unique) {
                        if (!toDataUnique.combinable) {
                            if (
                                updateweights(fromSlot, toSlot, fromInventory, toInventory, toAmount)
                            ) {
                                swap(fromSlot, toSlot, fromInventory, toInventory, toAmount);
                            }
                        } else {
                            swap(fromSlot, toSlot, fromInventory, toInventory, toAmount);
                        }
                    } else {
                        if (
                            updateweights(fromSlot, toSlot, fromInventory, toInventory, toAmount)
                        ) {
                            swap(fromSlot, toSlot, fromInventory, toInventory, toAmount);
                        }
                    }
                }
            }
        },
    });

    $("#item-use").droppable({
        hoverClass: "button-hover",
        drop: function(event, ui) {
            setTimeout(function() {
                IsDragging = false;
            }, 300);
            fromData = ui.draggable.data("item");
            fromInventory = ui.draggable.parent().attr("data-inventory");
            if (fromData.useable) {
                if (fromData.shouldClose) {
                    Inventory.Close();
                }
                $.post(
                    "https://qb-inventory/UseItem",
                    JSON.stringify({
                        inventory: fromInventory,
                        item: fromData,
                    })
                );
            }
        },
    });

    $("#item-drop").droppable({
        hoverClass: "item-slot-hoverClass",
        drop: function(event, ui) {
            setTimeout(function() {
                IsDragging = false;
            }, 300);
            fromData = ui.draggable.data("item");
            fromInventory = ui.draggable.parent().attr("data-inventory");
            amount = $("#item-amount").val();
            if (amount == 0) {
                amount = fromData.amount;
            }
            $(this).css("background", "rgba(23, 27, 43, 0.7");
            $.post(
                "https://qb-inventory/DropItem",
                JSON.stringify({
                    inventory: fromInventory,
                    item: fromData,
                    amount: parseInt(amount),
                })
            );
        },
    });
}

function updateweights($fromSlot, $toSlot, $fromInv, $toInv, $toAmount) {
    var otherinventory = otherLabel.toLowerCase();
    if (otherinventory.split("-")[0] == "dropped") {
        toData = $toInv.find("[data-slot=" + $toSlot + "]").data("item");
        if (toData !== null && toData !== undefined) {
            InventoryError($fromInv, $fromSlot);
            return false;
        }
    }
    if (
        ($fromInv.attr("data-inventory") == "hotbar" &&
            $toInv.attr("data-inventory") == "player") ||
        ($fromInv.attr("data-inventory") == "player" &&
            $toInv.attr("data-inventory") == "hotbar") ||
        ($fromInv.attr("data-inventory") == "player" &&
            $toInv.attr("data-inventory") == "player") ||
        ($fromInv.attr("data-inventory") == "hotbar" &&
            $toInv.attr("data-inventory") == "hotbar")
    ) {
        return true;
    }
    if (
        ($fromInv.attr("data-inventory").split("-")[0] == "itemshop" &&
            $toInv.attr("data-inventory").split("-")[0] == "itemshop") ||
        ($fromInv.attr("data-inventory") == "crafting" &&
            $toInv.attr("data-inventory") == "crafting")
    ) {
        itemData = $fromInv.find("[data-slot=" + $fromSlot + "]").data("item");
        if ($fromInv.attr("data-inventory").split("-")[0] == "itemshop") {
            $fromInv
                .find("[data-slot=" + $fromSlot + "]")
                .html(
                    '<div class="item-slot-img"><img src="' +
                    itemData.image +
                    '" alt="' +
                    itemData.name +
                    '" /></div><div class="item-slot-amount"><p>' +
                    itemData.amount +
                    '</div><div class="item-slot-name1"><p>' +
                    " £" +
                    itemData.price +
                    '</p></div><div class="item-slot-label"><p>' +
                    itemData.label +
                    "</p></div>"
                );
        } else {
            $fromInv
                .find("[data-slot=" + $fromSlot + "]")
                .html(
                    '<div class="item-slot-img"><img src="' +
                    itemData.image +
                    '" alt="' +
                    itemData.name +
                    '" /></div><div class="item-slot-amount"><p>' +
                    itemData.amount +
                    '</div><div class="item-slot-name1"><p>' +
                    " " +
                    ((itemData.weight * itemData.amount) / 1000).toFixed(1) +
                    '</p></div><div class="item-slot-label"><p>' +
                    itemData.label +
                    "</p></div>"
                );
        }

        InventoryError($fromInv, $fromSlot);
        return false;
    }

    if (
        $toAmount == 0 &&
        ($fromInv.attr("data-inventory").split("-")[0] == "itemshop" ||
            $fromInv.attr("data-inventory") == "crafting")
    ) {
        itemData = $fromInv.find("[data-slot=" + $fromSlot + "]").data("item");
        if ($fromInv.attr("data-inventory").split("-")[0] == "itemshop") {
            $fromInv
                .find("[data-slot=" + $fromSlot + "]")
                .html(
                    '<div class="item-slot-img"><img src="' +
                    itemData.image +
                    '" alt="' +
                    itemData.name +
                    '" /></div><div class="item-slot-amount"><p>' +
                    itemData.amount +
                    '</div><div class="item-slot-name1"><p>' +
                    " £" +
                    itemData.price +
                    '</p></div><div class="item-slot-label"><p>' +
                    itemData.label +
                    "</p></div>"
                );
        } else {
            $fromInv
                .find("[data-slot=" + $fromSlot + "]")
                .html(
                    '<div class="item-slot-img"><img src="' +
                    itemData.image +
                    '" alt="' +
                    itemData.name +
                    '" /></div><div class="item-slot-amount"><p>' +
                    itemData.amount +
                    '</div><div class="item-slot-name1"><p>' +
                    " " +
                    ((itemData.weight * itemData.amount) / 1000).toFixed(1) +
                    '</p></div><div class="item-slot-label"><p>' +
                    itemData.label +
                    "</p></div>"
                );
        }

        InventoryError($fromInv, $fromSlot);
        return false;
    }

    if (
        $toInv.attr("data-inventory").split("-")[0] == "itemshop" ||
        $toInv.attr("data-inventory") == "crafting"
    ) {
        itemData = $toInv.find("[data-slot=" + $toSlot + "]").data("item");
        if ($toInv.attr("data-inventory").split("-")[0] == "itemshop") {
            $toInv
                .find("[data-slot=" + $toSlot + "]")
                .html(
                    '<div class="item-slot-img"><img src="' +
                    itemData.image +
                    '" alt="' +
                    itemData.name +
                    '" /></div><div class="item-slot-amount"><p>' +
                    itemData.amount +
                    '</div><div class="item-slot-name1"><p>' +
                    " £" +
                    itemData.price +
                    '</p></div><div class="item-slot-label"><p>' +
                    itemData.label +
                    "</p></div>"
                );
        } else {
            $toInv
                .find("[data-slot=" + $toSlot + "]")
                .html(
                    '<div class="item-slot-img"><img src="' +
                    itemData.image +
                    '" alt="' +
                    itemData.name +
                    '" /></div><div class="item-slot-amount"><p>' +
                    itemData.amount +
                    '</div><div class="item-slot-name1"><p>' +
                    " " +
                    ((itemData.weight * itemData.amount) / 1000).toFixed(1) +
                    '</p></div><div class="item-slot-label"><p>' +
                    itemData.label +
                    "</p></div>"
                );
        }

        InventoryError($fromInv, $fromSlot);
        return false;
    }

    if ($fromInv.attr("data-inventory") != $toInv.attr("data-inventory")) {
        fromData = $fromInv.find("[data-slot=" + $fromSlot + "]").data("item");
        toData = $toInv.find("[data-slot=" + $toSlot + "]").data("item");
        if ($toAmount == 0) {
            $toAmount = fromData.amount;
        }
        if (toData == null || fromData.name == toData.name) {
            if (
                $fromInv.attr("data-inventory") == "player" ||
                $fromInv.attr("data-inventory") == "hotbar"
            ) {
                totalWeight = totalWeight - fromData.weight * $toAmount;
                totalWeightOther = totalWeightOther + fromData.weight * $toAmount;
            } else {
                totalWeight = totalWeight + fromData.weight * $toAmount;
                totalWeightOther = totalWeightOther - fromData.weight * $toAmount;
            }
        } else {
            if (
                $fromInv.attr("data-inventory") == "player" ||
                $fromInv.attr("data-inventory") == "hotbar"
            ) {
                totalWeight = totalWeight - fromData.weight * $toAmount;
                totalWeight = totalWeight + toData.weight * toData.amount;

                totalWeightOther = totalWeightOther + fromData.weight * $toAmount;
                totalWeightOther = totalWeightOther - toData.weight * toData.amount;
            } else {
                totalWeight = totalWeight + fromData.weight * $toAmount;
                totalWeight = totalWeight - toData.weight * toData.amount;

                totalWeightOther = totalWeightOther - fromData.weight * $toAmount;
                totalWeightOther = totalWeightOther + toData.weight * toData.amount;
            }
        }
    }

    if (
        totalWeight > playerMaxWeight ||
        (totalWeightOther > otherMaxWeight &&
            $fromInv.attr("data-inventory").split("-")[0] != "itemshop" &&
            $fromInv.attr("data-inventory") != "crafting")
    ) {
        InventoryError($fromInv, $fromSlot);
        return false;
    }

    var per =(totalWeight/1000)/(playerMaxWeight/100000)
    $(".pro").css("width",per+"%")
    $("#player-inv-weight").html(
        // '<i class="fas fa-dumbbell"></i> ' +
        (parseInt(totalWeight) / 1000).toFixed(2) +
        "/" +
        (playerMaxWeight / 1000).toFixed(2)
    );
    if (
        $fromInv.attr("data-inventory").split("-")[0] != "itemshop" &&
        $toInv.attr("data-inventory").split("-")[0] != "itemshop" &&
        $fromInv.attr("data-inventory") != "crafting" &&
        $toInv.attr("data-inventory") != "crafting"
    ) {
        $("#other-inv-label").html(otherLabel);
        $("#other-inv-weight").html(
            // '<i class="fas fa-dumbbell"></i> ' +
            (parseInt(totalWeightOther) / 1000).toFixed(2) +
            "/" +
            (otherMaxWeight / 1000).toFixed(2)
        );
        var per1 =(totalWeightOther/1000)/(otherMaxWeight/100000)
        $(".pro1").css("width",per1+"%");
    }

    return true;
}

function swap($fromSlot, $toSlot, $fromInv, $toInv, $toAmount) {
    fromData = $fromInv.find("[data-slot=" + $fromSlot + "]").data("item");
    toData = $toInv.find("[data-slot=" + $toSlot + "]").data("item");
    var otherinventory = otherLabel.toLowerCase();

    if (otherinventory.split("-")[0] == "dropped") {
        if (toData !== null && toData !== undefined) {
            InventoryError($fromInv, $fromSlot);
            return;
        }
    }

    if (fromData !== undefined && fromData.amount >= $toAmount) {
        if (fromData.unique && $toAmount > 1) {
            InventoryError($fromInv, $fromSlot);
            return;
        }

        if (
            ($fromInv.attr("data-inventory") == "player" ||
                $fromInv.attr("data-inventory") == "hotbar") &&
            $toInv.attr("data-inventory").split("-")[0] == "itemshop" &&
            $toInv.attr("data-inventory") == "crafting"
        ) {
            InventoryError($fromInv, $fromSlot);
            return;
        }

        if (
            $toAmount == 0 &&
            $fromInv.attr("data-inventory").split("-")[0] == "itemshop" &&
            $fromInv.attr("data-inventory") == "crafting"
        ) {
            InventoryError($fromInv, $fromSlot);
            return;
        } else if ($toAmount == 0) {
            $toAmount = fromData.amount;
        }
        if (
            (toData != undefined || toData != null) &&
            toData.name == fromData.name &&
            !fromData.unique
        ) {
            var newData = [];
            newData.name = toData.name;
            newData.label = toData.label;
            newData.amount = parseInt($toAmount) + parseInt(toData.amount);
            newData.type = toData.type;
            newData.description = toData.description;
            newData.image = toData.image;
            newData.weight = toData.weight;
            newData.info = toData.info;
            newData.useable = toData.useable;
            newData.unique = toData.unique;
            newData.slot = parseInt($toSlot);

            if (newData.name == fromData.name) {
                if (newData.info.quality !== fromData.info.quality  ) {
                    InventoryError($fromInv, $fromSlot);
                    $.post(
                        "https://qb-inventory/Notify",
                        JSON.stringify({
                            message: "You can not stack items which are not the same quality.",
                            type: "error",
                        })
                    );
                    return;

                }
            }

            if (fromData.amount == $toAmount) {
                $toInv.find("[data-slot=" + $toSlot + "]").data("item", newData);

                $toInv.find("[data-slot=" + $toSlot + "]").addClass("item-drag");
                $toInv.find("[data-slot=" + $toSlot + "]").removeClass("item-nodrag");

                var ItemLabel =
                    '<div class="item-slot-label"><p>' + newData.label + "</p></div>";
                // if (newData.name.split("_")[0] == "weapon") {
                //     if (!Inventory.IsWeaponBlocked(newData.name)) {
                        ItemLabel =
                            '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                            newData.label +
                            "</p></div>";
                    // }
                // }

                if ($toSlot < 6 && $toInv.attr("data-inventory") == "player") {
                    $toInv
                        .find("[data-slot=" + $toSlot + "]")
                        .html(
                            '<div class="item-slot-key"><p>' +
                            $toSlot +
                            '</p></div><div class="item-slot-img"><img src="' +
                            newData.image +
                            '" alt="' +
                            newData.name +
                            '" /></div><div class="item-slot-amount"><p>' +
                            newData.amount +
                            '</div><div class="item-slot-name"><p>' +
                            " " +
                            ((newData.weight * newData.amount) / 1000).toFixed(1) +
                            "</p></div>" +
                            ItemLabel
                        );
                } else {
                    $toInv
                        .find("[data-slot=" + $toSlot + "]")
                        .html(
                            '<div class="item-slot-img"><img src="' +
                            newData.image +
                            '" alt="' +
                            newData.name +
                            '" /></div><div class="item-slot-amount"><p>' +
                            newData.amount +
                            '</div><div class="item-slot-name"><p>' +
                            " " +
                            ((newData.weight * newData.amount) / 1000).toFixed(1) +
                            "</p></div>" +
                            ItemLabel
                        );
                }

                // if (newData.name.split("_")[0] == "weapon") {
                    // if (!Inventory.IsWeaponBlocked(newData.name)) {
                        if (newData.info.quality == undefined) {
                            newData.info.quality = 100.0;
                        }
                        var QualityColor = "rgb(15, 255, 213)";
                        if (newData.info.quality < 25) {
                            QualityColor = "rgb(192, 57, 43)";
                        } else if (newData.info.quality > 25 && newData.info.quality < 50) {
                            QualityColor = "rgb(230, 126, 34)";
                        } else if (newData.info.quality >= 50) {
                            QualityColor = "rgb(15, 255, 213)";
                        }
                        if (newData.info.quality !== undefined) {
                            qualityLabel = newData.info.quality.toFixed();
                        } else {
                            qualityLabel = newData.info.quality;
                        }
                        if (newData.info.quality == 0) {
                            qualityLabel = "BROKEN";
                        }
                        $toInv
                            .find("[data-slot=" + $toSlot + "]")
                            .find(".item-slot-quality-bar")
                            .css({
                                width: qualityLabel + "%",
                                "background-color": QualityColor,
                            })
                            .find("p")
                            .html(qualityLabel);
                    // }
                // }

                $fromInv.find("[data-slot=" + $fromSlot + "]").removeClass("item-drag");
                $fromInv.find("[data-slot=" + $fromSlot + "]").addClass("item-nodrag");

                $fromInv.find("[data-slot=" + $fromSlot + "]").removeData("item");
                $fromInv
                    .find("[data-slot=" + $fromSlot + "]")
                    .html(
                        '<div class="item-slot-img"></div><div class="item-slot-label"><p>&nbsp;</p></div>'
                    );
            } else if (fromData.amount > $toAmount) {
                var newDataFrom = [];
                newDataFrom.name = fromData.name;
                newDataFrom.label = fromData.label;
                newDataFrom.amount = parseInt(fromData.amount - $toAmount);
                newDataFrom.type = fromData.type;
                newDataFrom.description = fromData.description;
                newDataFrom.image = fromData.image;
                newDataFrom.weight = fromData.weight;
                newDataFrom.price = fromData.price;
                newDataFrom.info = fromData.info;
                newDataFrom.useable = fromData.useable;
                newDataFrom.unique = fromData.unique;
                newDataFrom.slot = parseInt($fromSlot);

                $toInv.find("[data-slot=" + $toSlot + "]").data("item", newData);

                $toInv.find("[data-slot=" + $toSlot + "]").addClass("item-drag");
                $toInv.find("[data-slot=" + $toSlot + "]").removeClass("item-nodrag");

                var ItemLabel =
                    '<div class="item-slot-label"><p>' + newData.label + "</p></div>";
                // if (newData.name.split("_")[0] == "weapon") {
                    // if (!Inventory.IsWeaponBlocked(newData.name)) {
                        ItemLabel =
                            '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                            newData.label +
                            "</p></div>";
                    // }
                // }

                if ($toSlot < 6 && $toInv.attr("data-inventory") == "player") {
                    $toInv
                        .find("[data-slot=" + $toSlot + "]")
                        .html(
                            '<div class="item-slot-key"><p>' +
                            $toSlot +
                            '</p></div><div class="item-slot-img"><img src="' +
                            newData.image +
                            '" alt="' +
                            newData.name +
                            '" /></div><div class="item-slot-amount"><p>' +
                            newData.amount +
                            '</div><div class="item-slot-name"><p>' +
                            " " +
                            ((newData.weight * newData.amount) / 1000).toFixed(1) +
                            "</p></div>" +
                            ItemLabel
                        );
                } else {
                    $toInv
                        .find("[data-slot=" + $toSlot + "]")
                        .html(
                            '<div class="item-slot-img"><img src="' +
                            newData.image +
                            '" alt="' +
                            newData.name +
                            '" /></div><div class="item-slot-amount"><p>' +
                            newData.amount +
                            '</div><div class="item-slot-name"><p>' +
                            " " +
                            ((newData.weight * newData.amount) / 1000).toFixed(1) +
                            "</p></div>" +
                            ItemLabel
                        );
                }

                // if (newData.name.split("_")[0] == "weapon") {
                    // if (!Inventory.IsWeaponBlocked(newData.name)) {
                        if (newData.info.quality == undefined) {
                            newData.info.quality = 100.0;
                        }
                        var QualityColor = "rgb(15, 255, 213)";
                        if (newData.info.quality < 25) {
                            QualityColor = "rgb(192, 57, 43)";
                        } else if (newData.info.quality > 25 && newData.info.quality < 50) {
                            QualityColor = "rgb(230, 126, 34)";
                        } else if (newData.info.quality >= 50) {
                            QualityColor = "rgb(15, 255, 213)";
                        }
                        if (newData.info.quality !== undefined) {
                            qualityLabel = newData.info.quality.toFixed();
                        } else {
                            qualityLabel = newData.info.quality;
                        }
                        if (newData.info.quality == 0) {
                            qualityLabel = "BROKEN";
                        }
                        $toInv
                            .find("[data-slot=" + $toSlot + "]")
                            .find(".item-slot-quality-bar")
                            .css({
                                width: qualityLabel + "%",
                                "background-color": QualityColor,
                            })
                            .find("p")
                            .html(qualityLabel);
                    // }
                // }

                // From Data zooi
                $fromInv
                    .find("[data-slot=" + $fromSlot + "]")
                    .data("item", newDataFrom);

                $fromInv.find("[data-slot=" + $fromSlot + "]").addClass("item-drag");
                $fromInv
                    .find("[data-slot=" + $fromSlot + "]")
                    .removeClass("item-nodrag");

                if ($fromInv.attr("data-inventory").split("-")[0] == "itemshop") {
                    $fromInv
                        .find("[data-slot=" + $fromSlot + "]")
                        .html(
                            '<div class="item-slot-img"><img src="' +
                            newDataFrom.image +
                            '" alt="' +
                            newDataFrom.name +
                            '" /></div><div class="item-slot-amount"><p>' +
                            newDataFrom.amount +
                            '</div><div class="item-slot-name1"><p>' +
                            " £" +
                            newDataFrom.price +
                            '</p></div><div class="item-slot-label"><p>' +
                            newDataFrom.label +
                            "</p></div>"
                        );
                } else {
                    var ItemLabel =
                        '<div class="item-slot-label"><p>' +
                        newDataFrom.label +
                        "</p></div>";
                    // if (newDataFrom.name.split("_")[0] == "weapon") {
                        // if (!Inventory.IsWeaponBlocked(newDataFrom.name)) {
                            ItemLabel =
                                '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                                newDataFrom.label +
                                "</p></div>";
                        // }
                    // }

                    if ($fromSlot < 6 && $fromInv.attr("data-inventory") == "player") {
                        $fromInv
                            .find("[data-slot=" + $fromSlot + "]")
                            .html(
                                '<div class="item-slot-key"><p>' +
                                $fromSlot +
                                '</p></div><div class="item-slot-img"><img src="' +
                                newDataFrom.image +
                                '" alt="' +
                                newDataFrom.name +
                                '" /></div><div class="item-slot-amount"><p>' +
                                newDataFrom.amount +
                                '</div><div class="item-slot-name"><p>' +
                                " " +
                                ((newDataFrom.weight * newDataFrom.amount) / 1000).toFixed(
                                    1
                                ) +
                                "</p></div>" +
                                ItemLabel
                            );
                    } else {
                        $fromInv
                            .find("[data-slot=" + $fromSlot + "]")
                            .html(
                                '<div class="item-slot-img"><img src="' +
                                newDataFrom.image +
                                '" alt="' +
                                newDataFrom.name +
                                '" /></div><div class="item-slot-amount"><p>' +
                                newDataFrom.amount +
                                '</div><div class="item-slot-name"><p>' +
                                " " +
                                ((newDataFrom.weight * newDataFrom.amount) / 1000).toFixed(
                                    1
                                ) +
                                "</p></div>" +
                                ItemLabel
                            );
                    }

                    // if (newDataFrom.name.split("_")[0] == "weapon") {
                        // if (!Inventory.IsWeaponBlocked(newDataFrom.name)) {
                            if (newDataFrom.info.quality == undefined) {
                                newDataFrom.info.quality = 100.0;
                            }
                            var QualityColor = "rgb(15, 255, 213)";
                            if (newDataFrom.info.quality < 25) {
                                QualityColor = "rgb(192, 57, 43)";
                            } else if (
                                newDataFrom.info.quality > 25 &&
                                newDataFrom.info.quality < 50
                            ) {
                                QualityColor = "rgb(230, 126, 34)";
                            } else if (newDataFrom.info.quality >= 50) {
                                QualityColor = "rgb(15, 255, 213)";
                            }
                            if (newDataFrom.info.quality !== undefined) {
                                qualityLabel = newDataFrom.info.quality.toFixed();
                            } else {
                                qualityLabel = newDataFrom.info.quality;
                            }
                            if (newDataFrom.info.quality == 0) {
                                qualityLabel = "BROKEN";
                            }
                            $fromInv
                                .find("[data-slot=" + $fromSlot + "]")
                                .find(".item-slot-quality-bar")
                                .css({
                                    width: qualityLabel + "%",
                                    "background-color": QualityColor,
                                })
                                .find("p")
                                .html(qualityLabel);
                        // }
                    // }
                        }
                    }
            $.post("https://qb-inventory/PlayDropSound", JSON.stringify({}));
            $.post(
                "https://qb-inventory/SetInventoryData",
                JSON.stringify({
                    fromInventory: $fromInv.attr("data-inventory"),
                    toInventory: $toInv.attr("data-inventory"),
                    fromSlot: $fromSlot,
                    toSlot: $toSlot,
                    fromAmount: $toAmount,
                })
            );
        } else {
            if (fromData.amount == $toAmount) {
                if (
                    toData != undefined &&
                    toData.combinable != null &&
                    isItemAllowed(fromData.name, toData.combinable)
                ) {
                    Inventory.Close();
                    if ($fromInv.attr("data-inventory") == 'player' && $toInv.attr("data-inventory") == 'player') {
                        $.post(
                            "https://qb-inventory/CombineItem",
                            JSON.stringify({
                                az: fromData,
                                be: toData
                            })
                        );
                    }
                    return;
                }
                if (toData && toData.unique){
                    InventoryError($fromInv, $fromSlot);
                    return;
                }

                fromData.slot = parseInt($toSlot);

                $toInv.find("[data-slot=" + $toSlot + "]").data("item", fromData);

                $toInv.find("[data-slot=" + $toSlot + "]").addClass("item-drag");
                $toInv.find("[data-slot=" + $toSlot + "]").removeClass("item-nodrag");

                var ItemLabel =
                    '<div class="item-slot-label"><p>' + fromData.label + "</p></div>";
                // if (fromData.name.split("_")[0] == "weapon") {
                    // if (!Inventory.IsWeaponBlocked(fromData.name)) {
                        ItemLabel =
                            '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                            fromData.label +
                            "</p></div>";
                    // }
                // }

                if ($toSlot < 6 && $toInv.attr("data-inventory") == "player") {
                    $toInv
                        .find("[data-slot=" + $toSlot + "]")
                        .html(
                            '<div class="item-slot-key"><p>' +
                            $toSlot +
                            '</p></div><div class="item-slot-img"><img src="' +
                            fromData.image +
                            '" alt="' +
                            fromData.name +
                            '" /></div><div class="item-slot-amount"><p>' +
                            fromData.amount +
                            '</div><div class="item-slot-name"><p>' +
                            " " +
                            ((fromData.weight * fromData.amount) / 1000).toFixed(1) +
                            "</p></div>" +
                            ItemLabel
                        );
                } else {
                    $toInv
                        .find("[data-slot=" + $toSlot + "]")
                        .html(
                            '<div class="item-slot-img"><img src="' +
                            fromData.image +
                            '" alt="' +
                            fromData.name +
                            '" /></div><div class="item-slot-amount"><p>' +
                            fromData.amount +
                            '</div><div class="item-slot-name"><p>' +
                            " " +
                            ((fromData.weight * fromData.amount) / 1000).toFixed(1) +
                            "</p></div>" +
                            ItemLabel
                        );
                }

                // if (fromData.name.split("_")[0] == "weapon") {
                    // if (!Inventory.IsWeaponBlocked(fromData.name)) {
                        if (fromData.info.quality == undefined) {
                            fromData.info.quality = 100.0;
                        }
                        var QualityColor = "rgb(15, 255, 213)";
                        if (fromData.info.quality < 25) {
                            QualityColor = "rgb(192, 57, 43)";
                        } else if (
                            fromData.info.quality > 25 &&
                            fromData.info.quality < 50
                        ) {
                            QualityColor = "rgb(230, 126, 34)";
                        } else if (fromData.info.quality >= 50) {
                            QualityColor = "rgb(15, 255, 213)";
                        }
                        if (fromData.info.quality !== undefined) {
                            qualityLabel = fromData.info.quality.toFixed();
                        } else {
                            qualityLabel = fromData.info.quality;
                        }
                        if (fromData.info.quality == 0) {
                            qualityLabel = "BROKEN";
                        }
                        $toInv
                            .find("[data-slot=" + $toSlot + "]")
                            .find(".item-slot-quality-bar")
                            .css({
                                width: qualityLabel + "%",
                                "background-color": QualityColor,
                            })
                            .find("p")
                            .html(qualityLabel);
                    // }
                // }

                if (toData != undefined) {
                    toData.slot = parseInt($fromSlot);

                    $fromInv.find("[data-slot=" + $fromSlot + "]").addClass("item-drag");
                    $fromInv
                        .find("[data-slot=" + $fromSlot + "]")
                        .removeClass("item-nodrag");

                    $fromInv.find("[data-slot=" + $fromSlot + "]").data("item", toData);

                    var ItemLabel =
                        '<div class="item-slot-label"><p>' + toData.label + "</p></div>";
                    // if (toData.name.split("_")[0] == "weapon") {
                        // if (!Inventory.IsWeaponBlocked(toData.name)) {
                            ItemLabel =
                                '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                                toData.label +
                                "</p></div>";
                        // }
                    // }

                    if ($fromSlot < 6 && $fromInv.attr("data-inventory") == "player") {
                        $fromInv
                            .find("[data-slot=" + $fromSlot + "]")
                            .html(
                                '<div class="item-slot-key"><p>' +
                                $fromSlot +
                                '</p></div><div class="item-slot-img"><img src="' +
                                toData.image +
                                '" alt="' +
                                toData.name +
                                '" /></div><div class="item-slot-amount"><p>' +
                                toData.amount +
                                '</div><div class="item-slot-name"><p>' +
                                " " +
                                ((toData.weight * toData.amount) / 1000).toFixed(1) +
                                "</p></div>" +
                                ItemLabel
                            );
                    } else {
                        $fromInv
                            .find("[data-slot=" + $fromSlot + "]")
                            .html(
                                '<div class="item-slot-img"><img src="' +
                                toData.image +
                                '" alt="' +
                                toData.name +
                                '" /></div><div class="item-slot-amount"><p>' +
                                toData.amount +
                                '</div><div class="item-slot-name"><p>' +
                                " " +
                                ((toData.weight * toData.amount) / 1000).toFixed(1) +
                                "</p></div>" +
                                ItemLabel
                            );
                    }

                    // if (toData.name.split("_")[0] == "weapon") {
                        // if (!Inventory.IsWeaponBlocked(toData.name)) {
                            if (toData.info.quality == undefined) {
                                toData.info.quality = 100.0;
                            }
                            var QualityColor = "rgb(15, 255, 213)";
                            if (toData.info.quality < 25) {
                                QualityColor = "rgb(192, 57, 43)";
                            } else if (toData.info.quality > 25 && toData.info.quality < 50) {
                                QualityColor = "rgb(230, 126, 34)";
                            } else if (toData.info.quality >= 50) {
                                QualityColor = "rgb(15, 255, 213)";
                            }
                            if (toData.info.quality !== undefined) {
                                qualityLabel = toData.info.quality.toFixed();
                            } else {
                                qualityLabel = toData.info.quality;
                            }
                            if (toData.info.quality == 0) {
                                qualityLabel = "BROKEN";
                            }
                            $fromInv
                                .find("[data-slot=" + $fromSlot + "]")
                                .find(".item-slot-quality-bar")
                                .css({
                                    width: qualityLabel + "%",
                                    "background-color": QualityColor,
                                })
                                .find("p")
                                .html(qualityLabel);
                        // }
                    // }

                    $.post(
                        "https://qb-inventory/SetInventoryData",
                        JSON.stringify({
                            fromInventory: $fromInv.attr("data-inventory"),
                            toInventory: $toInv.attr("data-inventory"),
                            fromSlot: $fromSlot,
                            toSlot: $toSlot,
                            fromAmount: $toAmount,
                            toAmount: toData.amount,
                        })
                    );
                } else {
                    $fromInv
                        .find("[data-slot=" + $fromSlot + "]")
                        .removeClass("item-drag");
                    $fromInv
                        .find("[data-slot=" + $fromSlot + "]")
                        .addClass("item-nodrag");

                    $fromInv.find("[data-slot=" + $fromSlot + "]").removeData("item");

                    if ($fromSlot < 6 && $fromInv.attr("data-inventory") == "player") {
                        $fromInv
                            .find("[data-slot=" + $fromSlot + "]")
                            .html(
                                '<div class="item-slot-key"><p>' +
                                $fromSlot +
                                '</p></div><div class="item-slot-img"></div><div class="item-slot-label"><p>&nbsp;</p></div>'
                            );
                    } else {
                        $fromInv
                            .find("[data-slot=" + $fromSlot + "]")
                            .html(
                                '<div class="item-slot-img"></div><div class="item-slot-label"><p>&nbsp;</p></div>'
                            );
                    }

                    $.post(
                        "https://qb-inventory/SetInventoryData",
                        JSON.stringify({
                            fromInventory: $fromInv.attr("data-inventory"),
                            toInventory: $toInv.attr("data-inventory"),
                            fromSlot: $fromSlot,
                            toSlot: $toSlot,
                            fromAmount: $toAmount,
                        })
                    );
                }
                $.post("https://qb-inventory/PlayDropSound", JSON.stringify({}));
            } else if (
                fromData.amount > $toAmount &&
                (toData == undefined || toData == null)
            ) {
                var newDataTo = [];
                newDataTo.name = fromData.name;
                newDataTo.label = fromData.label;
                newDataTo.amount = parseInt($toAmount);
                newDataTo.type = fromData.type;
                newDataTo.description = fromData.description;
                newDataTo.image = fromData.image;
                newDataTo.weight = fromData.weight;
                newDataTo.info = fromData.info;
                newDataTo.useable = fromData.useable;
                newDataTo.unique = fromData.unique;
                newDataTo.slot = parseInt($toSlot);

                $toInv.find("[data-slot=" + $toSlot + "]").data("item", newDataTo);

                $toInv.find("[data-slot=" + $toSlot + "]").addClass("item-drag");
                $toInv.find("[data-slot=" + $toSlot + "]").removeClass("item-nodrag");

                var ItemLabel =
                    '<div class="item-slot-label"><p>' + newDataTo.label + "</p></div>";
                // if (newDataTo.name.split("_")[0] == "weapon") {
                    // if (!Inventory.IsWeaponBlocked(newDataTo.name)) {
                        ItemLabel =
                            '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                            newDataTo.label +
                            "</p></div>";
                    // }
                // }

                if ($toSlot < 6 && $toInv.attr("data-inventory") == "player") {
                    $toInv
                        .find("[data-slot=" + $toSlot + "]")
                        .html(
                            '<div class="item-slot-key"><p>' +
                            $toSlot +
                            '</p></div><div class="item-slot-img"><img src="' +
                            newDataTo.image +
                            '" alt="' +
                            newDataTo.name +
                            '" /></div><div class="item-slot-amount"><p>' +
                            newDataTo.amount +
                            '</div><div class="item-slot-name"><p>' +
                            " " +
                            ((newDataTo.weight * newDataTo.amount) / 1000).toFixed(1) +
                            "</p></div>" +
                            ItemLabel
                        );
                } else {
                    $toInv
                        .find("[data-slot=" + $toSlot + "]")
                        .html(
                            '<div class="item-slot-img"><img src="' +
                            newDataTo.image +
                            '" alt="' +
                            newDataTo.name +
                            '" /></div><div class="item-slot-amount"><p>' +
                            newDataTo.amount +
                            '</div><div class="item-slot-name"><p>' +
                            " " +
                            ((newDataTo.weight * newDataTo.amount) / 1000).toFixed(1) +
                            "</p></div>" +
                            ItemLabel
                        );
                }

                // if (newDataTo.name.split("_")[0] == "weapon") {
                    // if (!Inventory.IsWeaponBlocked(newDataTo.name)) {
                        if (newDataTo.info.quality == undefined) {
                            newDataTo.info.quality = 100.0;
                        }
                        var QualityColor = "rgb(15, 255, 213)";
                        if (newDataTo.info.quality < 25) {
                            QualityColor = "rgb(192, 57, 43)";
                        } else if (
                            newDataTo.info.quality > 25 &&
                            newDataTo.info.quality < 50
                        ) {
                            QualityColor = "rgb(230, 126, 34)";
                        } else if (newDataTo.info.quality >= 50) {
                            QualityColor = "rgb(15, 255, 213)";
                        }
                        if (newDataTo.info.quality !== undefined) {
                            qualityLabel = newDataTo.info.quality.toFixed();
                        } else {
                            qualityLabel = newDataTo.info.quality;
                        }
                        if (newDataTo.info.quality == 0) {
                            qualityLabel = "BROKEN";
                        }
                        $toInv
                            .find("[data-slot=" + $toSlot + "]")
                            .find(".item-slot-quality-bar")
                            .css({
                                width: qualityLabel + "%",
                                "background-color": QualityColor,
                            })
                            .find("p")
                            .html(qualityLabel);
                    // }
                // }

                var newDataFrom = [];
                newDataFrom.name = fromData.name;
                newDataFrom.label = fromData.label;
                newDataFrom.amount = parseInt(fromData.amount - $toAmount);
                newDataFrom.type = fromData.type;
                newDataFrom.description = fromData.description;
                newDataFrom.image = fromData.image;
                newDataFrom.weight = fromData.weight;
                newDataFrom.price = fromData.price;
                newDataFrom.info = fromData.info;
                newDataFrom.useable = fromData.useable;
                newDataFrom.unique = fromData.unique;
                newDataFrom.slot = parseInt($fromSlot);

                $fromInv
                    .find("[data-slot=" + $fromSlot + "]")
                    .data("item", newDataFrom);

                $fromInv.find("[data-slot=" + $fromSlot + "]").addClass("item-drag");
                $fromInv
                    .find("[data-slot=" + $fromSlot + "]")
                    .removeClass("item-nodrag");

                if ($fromInv.attr("data-inventory").split("-")[0] == "itemshop") {
                    $fromInv
                        .find("[data-slot=" + $fromSlot + "]")
                        .html(
                            '<div class="item-slot-img"><img src="' +
                            newDataFrom.image +
                            '" alt="' +
                            newDataFrom.name +
                            '" /></div><div class="item-slot-amount"><p>' +
                            newDataFrom.amount +
                            '</div><div class="item-slot-name1"><p>' +
                            " £" +
                            newDataFrom.price +
                            '</p></div><div class="item-slot-label"><p>' +
                            newDataFrom.label +
                            "</p></div>"
                        );
                } else {
                    var ItemLabel =
                        '<div class="item-slot-label"><p>' +
                        newDataFrom.label +
                        "</p></div>";
                    // if (newDataFrom.name.split("_")[0] == "weapon") {
                        // if (!Inventory.IsWeaponBlocked(newDataFrom.name)) {
                            ItemLabel =
                                '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                                newDataFrom.label +
                                "</p></div>";
                        // }
                    // }

                    if ($fromSlot < 6 && $fromInv.attr("data-inventory") == "player") {
                        $fromInv
                            .find("[data-slot=" + $fromSlot + "]")
                            .html(
                                '<div class="item-slot-key"><p>' +
                                $fromSlot +
                                '</p></div><div class="item-slot-img"><img src="' +
                                newDataFrom.image +
                                '" alt="' +
                                newDataFrom.name +
                                '" /></div><div class="item-slot-amount"><p>' +
                                newDataFrom.amount +
                                '</div><div class="item-slot-name"><p>' +
                                " " +
                                ((newDataFrom.weight * newDataFrom.amount) / 1000).toFixed(
                                    1
                                ) +
                                "</p></div>" +
                                ItemLabel
                            );
                    } else {
                        $fromInv
                            .find("[data-slot=" + $fromSlot + "]")
                            .html(
                                '<div class="item-slot-img"><img src="' +
                                newDataFrom.image +
                                '" alt="' +
                                newDataFrom.name +
                                '" /></div><div class="item-slot-amount"><p>' +
                                newDataFrom.amount +
                                '</div><div class="item-slot-name"><p>' +
                                " " +
                                ((newDataFrom.weight * newDataFrom.amount) / 1000).toFixed(
                                    1
                                ) +
                                "</p></div>" +
                                ItemLabel
                            );
                    }

                    // if (newDataFrom.name.split("_")[0] == "weapon") {
                        // if (!Inventory.IsWeaponBlocked(newDataFrom.name)) {
                            if (newDataFrom.info.quality == undefined) {
                                newDataFrom.info.quality = 100.0;
                            }
                            var QualityColor = "rgb(15, 255, 213)";
                            if (newDataFrom.info.quality < 25) {
                                QualityColor = "rgb(192, 57, 43)";
                            } else if (
                                newDataFrom.info.quality > 25 &&
                                newDataFrom.info.quality < 50
                            ) {
                                QualityColor = "rgb(230, 126, 34)";
                            } else if (newDataFrom.info.quality >= 50) {
                                QualityColor = "rgb(15, 255, 213)";
                            }
                            if (newDataFrom.info.quality !== undefined) {
                                qualityLabel = newDataFrom.info.quality.toFixed();
                            } else {
                                qualityLabel = newDataFrom.info.quality;
                            }
                            if (newDataFrom.info.quality == 0) {
                                qualityLabel = "BROKEN";
                            }
                            $fromInv
                                .find("[data-slot=" + $fromSlot + "]")
                                .find(".item-slot-quality-bar")
                                .css({
                                    width: qualityLabel + "%",
                                    "background-color": QualityColor,
                                })
                                .find("p")
                                .html(qualityLabel);
                        // }
                    // }
                        }
                $.post("https://qb-inventory/PlayDropSound", JSON.stringify({}));
                $.post(
                    "https://qb-inventory/SetInventoryData",
                    JSON.stringify({
                        fromInventory: $fromInv.attr("data-inventory"),
                        toInventory: $toInv.attr("data-inventory"),
                        fromSlot: $fromSlot,
                        toSlot: $toSlot,
                        fromAmount: $toAmount,
                    })
                );
            } else {
                InventoryError($fromInv, $fromSlot);
            }
        }
    } else {
        //InventoryError($fromInv, $fromSlot);
    }
    handleDragDrop();
}

function isItemAllowed(item, allowedItems) {
    var retval = false;
    $.each(allowedItems, function(index, i) {
        if (i == item) {
            retval = true;
        }
    });
    return retval;
}

function InventoryError($elinv, $elslot) {
    $elinv
        .find("[data-slot=" + $elslot + "]")
        .css("background", "rgba(156, 20, 20, 0.5)")
        .css("transition", "background 500ms");
    setTimeout(function() {
        $elinv
            .find("[data-slot=" + $elslot + "]")
            .css("background", "rgba(255, 255, 255, 0.3)");
    }, 500);
    $.post("https://qb-inventory/PlayDropFail", JSON.stringify({}));
}

var requiredItemOpen = false;

(() => {
    Inventory = {};

    Inventory.dropslots = 15;
    Inventory.droplabel = "Ground";
    Inventory.dropmaxweight = 100000;

    Inventory.IsWeaponBlocked = function(WeaponName) {
        var DurabilityBlockedWeapons = [
            "weapon_unarmed",
            "weapon_stickybomb",
        ];

        var retval = false;
        $.each(DurabilityBlockedWeapons, function(i, name) {
            if (name == WeaponName) {
                retval = true;
            }
        });
        return retval;
    };

    Inventory.QualityCheck = function(item, IsHotbar, IsOtherInventory) {
        // if (!Inventory.IsWeaponBlocked(item.name)) {
            // if (item.name.split("_")[0] == "weapon") {
                if (item.info.quality == undefined) {
                    item.info.quality = 100;
                }
                var QualityColor = "rgb(15, 255, 213)";
                if (item.info.quality < 25) {
                    QualityColor = "rgb(192, 57, 43)";
                } else if (item.info.quality > 25 && item.info.quality < 50) {
                    QualityColor = "rgb(230, 126, 34)";
                } else if (item.info.quality >= 50) {
                    QualityColor = "rgb(15, 255, 213)";
                }
                if (item.info.quality !== undefined) {
                    qualityLabel = item.info.quality.toFixed();
                } else {
                    qualityLabel = item.info.quality;
                }
                if (item.info.quality == 0) {
                    qualityLabel = "BROKEN";
                }
                if (!IsOtherInventory) {
                    if (!IsHotbar) {
                        $(".player-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .find(".item-slot-quality-bar")
                            .css({
                                width: qualityLabel + "%",
                                "background-color": QualityColor,
                            })
                            .find("p")
                            .html(qualityLabel);
                    } else {
                        $(".z-hotbar-inventory")
                            .find("[data-zhotbarslot=" + item.slot + "]")
                            .find(".item-slot-quality-bar")
                            .css({
                                width: qualityLabel + "%",
                                "background-color": QualityColor,
                            })
                            .find("p")
                            .html(qualityLabel);
                    }
                } else {
                    $(".other-inventory")
                        .find("[data-slot=" + item.slot + "]")
                        .find(".item-slot-quality-bar")
                        .css({
                            width: qualityLabel + "%",
                            "background-color": QualityColor,
                        })
                        .find("p")
                        .html(qualityLabel);
                }
            // }
        // }
    };

    Inventory.Open = function(data) {
        totalWeight = 0;
        totalWeightOther = 0;
        $('.health-system ').css('left', '-50%');
        $('.health-system').css('display', 'none');
        
        $('.inventory-search-input-box').val('');
        $(".player-inv-label").html('Player');
        $(".player-inventory").find(".item-slot").remove();
        $(".player-inventory-backpack").find(".item-slot").remove();
        $(".ply-hotbar-inventory").find(".item-slot").remove();
        $(".ply-iteminfo-container").css("display", "none");
        $('.item-shit').css('display', 'none');
        $('.item-info-description').css('display', 'block');

        $(".personal-vehicle-title").html('Personal Vehicle');
        $(".personal-vehicle").html('N/A');

        $(".player-id-title").html(data.pName);
        $(".player-id").html('Citizen ID: ' + data.pCID);

        $(".phone-number-title").html('Phone Number');
        $(".phone-number").html(data.pNumber);

        $(".apartment-id-apartment").html('N/A');
        if(data.apartment){
            $(".apartment-id-apartment").html(data.apartment);
        }
        ThrowAllow=data.ThrowAllow;
        clips=data.clips;

        // $(".citizen-id").html(data.pCID);
        
        // $(".head-damage").html('Head');
        $(".head .progress").css("width", data.pHeadDamage + "%");

        // $(".right-arm-damage").html('Right Arm');
        $(".right-arm .progress").css("width", data.pRArmDamage + "%");

        // $(".left-arm-damage").html('Left Arm');
        $(".left-arm .progress").css("width", data.pLArmDamage + "%");

        // $(".body-damage").html('Body');
        $(".body .progress").css("width", data.pBodyDamage + "%");

        // $(".right-leg-damage").html('Right Leg');
        $(".right-leg .progress").css("width", data.pRLegDamage + "%");

        // $(".left-leg-damage").html('Left Leg');
        $(".left-leg .progress").css("width", data.pLLegDamage + "%");

        
    
        if (requiredItemOpen) {
            $(".requiredItem-container").hide();
            requiredItemOpen = false;
        }
    
        $("#qbcore-inventory").fadeIn(300);
        if (data.other != null && data.other != "") {
            $(".other-inventory").attr("data-inventory", data.other.name);
        } else {
            $(".other-inventory").attr("data-inventory", 0);
        }
        
        var backpackSlots = $(".player-inventory-backpack");
        for (i = 1; i < 21; i++) {
            backpackSlots.append(
                '<div class="item-slot" data-slot="' +
                    i +
                    '"><div class="item-slot-img"></div><div class="item-slot-label"><p>&nbsp;</p></div></div>'
                );
            }
        $(".player-inventory").append(backpackSlots);

        if (data.slots > 20) {
            $(".backpack-remove-btn").css('display', 'inline')
            var remainingSlots = $(".player-inventory");
            for (i = 21; i < data.slots + 1; i++) {{
                    remainingSlots.append(
                        '<div class="item-slot" data-slot="' +
                        i +
                        '"><div class="item-slot-img"></div><div class="item-slot-label"><p>&nbsp;</p></div></div>'
                    );
                }
            }
            $(".player-inventory").append(remainingSlots);
        } else {
            $(".backpack-remove-btn").css('display', 'none')
        }
        
        if (data.other != null && data.other != "") {
            for (i = 1; i < data.other.slots + 1; i++) {
                $(".other-inventory").append(
                    '<div class="item-slot" data-slot="' +
                    i +
                    '"><div class="item-slot-img"></div><div class="item-slot-label"><p>&nbsp;</p></div></div>'
                );
            }
        } else {
            for (i = 1; i < Inventory.dropslots + 1; i++) {
                $(".other-inventory").append(
                    '<div class="item-slot" data-slot="' +
                    i +
                    '"><div class="item-slot-img"></div><div class="item-slot-label"><p>&nbsp;</p></div></div>'
                );
            }
            $(".other-inventory .item-slot").css({
                "background-color": "rgba(23, 27, 43, 0.5)",
            });
        }

        if (data.inventory !== null) {
            $.each(data.inventory, function(i, item) {
                if (item != null) {
                    totalWeight += item.weight * item.amount;
                    var ItemLabel =
                        '<div class="item-slot-label"><p>' + item.label + "</p></div>";
                    // if (item.name.split("_")[0] == "weapon") {
                        // if (!Inventory.IsWeaponBlocked(item.name)) {
                            ItemLabel =
                                '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                                item.label +
                                "</p></div>";
                        // }
                    // }
                    if (item.slot < 6) {
                        $(".player-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .addClass("item-drag");
                        $(".player-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .html(
                                '<div class="item-slot-key"><p>' +
                                item.slot +
                                '</p></div><div class="item-slot-img"><img src="' +
                                item.image +
                                '" alt="' +
                                item.name +
                                '" /></div><div class="item-slot-amount"><p>' +
                                item.amount +
                                '</div><div class="inv-item-slot-name"><p>' +
                                " " +
                                ((item.weight * item.amount) / 1000).toFixed(1) +
                                "</p></div>" +
                                ItemLabel
                            );
                        $(".player-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .data("item", item);
                    } else {
                        $(".player-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .addClass("item-drag");
                        $(".player-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .html(
                                '<div class="item-slot-img"><img src="' +
                                item.image +
                                '" alt="' +
                                item.name +
                                '" /></div><div class="item-slot-amount"><p>' +
                                item.amount +
                                '</div><div class="inv-item-slot-name"><p>' +
                                " " +
                                ((item.weight * item.amount) / 1000).toFixed(1) +
                                "</p></div>" +
                                ItemLabel
                            );
                        $(".player-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .data("item", item);
                    }
                    Inventory.QualityCheck(item, false, false);
                }
            });
        }

        if (
            data.other != null &&
            data.other != "" &&
            data.other.inventory != null
        ) {
            if (data.other.label == "Player") {
                $.each(data.other.inventory, function(i, item) {
                    if (item != null) {
                        var ItemLabel =
                            '<div class="item-slot-label"><p>' + 'Loading' + "</p></div>";
                        // if (item.name.split("_")[0] == "weapon") {
                            // if (!Inventory.IsWeaponBlocked(item.name)) {
                                ItemLabel =
                                    '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                                    'Loading' +
                                    "</p></div>";
                            // }
                        // }
                        $(".other-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .addClass("item-drag");
                            $(".other-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .html(
                                '<div class="item-slot-img"><img src="' +
                                'inventory_images/loading.gif' +
                                '" alt="' +
                                'loading' +
                                '" /></div><div class="item-slot-amount"><p>' +
                                0 +
                                '</div><div class="item-slot-name1"><p>' +
                                " " +
                                ((0) / 1000).toFixed(1) +
                                "</p></div>" +
                                ItemLabel
                            );
                        $(".other-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .data("item", 'hichi');
                    }
                });
                let delay = 750
                $.each(data.other.inventory, function(i, item) {
                    delay = delay + 750
                    setTimeout(function() {
                        if (item != null) {
                            totalWeightOther += item.weight * item.amount;
                            var ItemLabel =
                                '<div class="item-slot-label"><p>' + item.label + "</p></div>";
                            // if (item.name.split("_")[0] == "weapon") {
                                // if (!Inventory.IsWeaponBlocked(item.name)) {
                                    ItemLabel =
                                        '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                                        item.label +
                                        "</p></div>";
                                // }
                            // }
                            $(".other-inventory")
                                .find("[data-slot=" + item.slot + "]")
                                .addClass("item-drag");
                                $(".other-inventory")
                                .find("[data-slot=" + item.slot + "]")
                                .html(
                                    '<div class="item-slot-img"><img src="' +
                                    item.image +
                                    '" alt="' +
                                    item.name +
                                    '" /></div><div class="item-slot-amount"><p>' +
                                    item.amount +
                                    '</div><div class="item-slot-name1"><p>' +
                                    " " +
                                    ((item.weight * item.amount) / 1000).toFixed(1) +
                                    "</p></div>" +
                                    ItemLabel
                                );
                            $(".other-inventory")
                                .find("[data-slot=" + item.slot + "]")
                                .data("item", item);
                            Inventory.QualityCheck(item, false, true);
                        }
                    }, delay);
                });
            } else {
                $.each(data.other.inventory, function(i, item) {
                    if (item != null) {
                        totalWeightOther += item.weight * item.amount;
                        var ItemLabel =
                            '<div class="item-slot-label"><p>' + item.label + "</p></div>";
                        // if (item.name.split("_")[0] == "weapon") {
                            // if (!Inventory.IsWeaponBlocked(item.name)) {
                                ItemLabel =
                                    '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                                    item.label +
                                    "</p></div>";
                            // }
                        // }
                        $(".other-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .addClass("item-drag");
                        if (item.price != null) {
                            $(".item-slot-name > p").css("display", "block");
                            $(".other-inventory")
                                .find("[data-slot=" + item.slot + "]")
                                .html(
                                    '<div class="item-slot-img"><img src="' +
                                    item.image +
                                    '" alt="' +
                                    item.name +
                                    '" /></div><div class="item-slot-amount"><p>' +
                                    item.amount +
                                    '</div><div class="item-slot-name1"><p>' +
                                    " £" +
                                    item.price +
                                    "</p></div>" +
                                    ItemLabel
                                );
                        } else {
                            $(".other-inventory")
                                .find("[data-slot=" + item.slot + "]")
                                .html(
                                    '<div class="item-slot-img"><img src="' +
                                    item.image +
                                    '" alt="' +
                                    item.name +
                                    '" /></div><div class="item-slot-amount"><p>' +
                                    item.amount +
                                    '</div><div class="item-slot-name1"><p>' +
                                    " " +
                                    ((item.weight * item.amount) / 1000).toFixed(1) +
                                    "</p></div>" +
                                    ItemLabel
                                );
                        }
                        $(".other-inventory")
                            .find("[data-slot=" + item.slot + "]")
                            .data("item", item);
                        Inventory.QualityCheck(item, false, true);
                    }
                });
            }
        }

        var per =(totalWeight/1000)/(data.maxweight/100000)
        $(".pro").css("width",per+"%");
        $("#player-inv-weight").html(
            // '<i class="fas fa-dumbbell"></i> ' +
            (totalWeight / 1000).toFixed(2) +
            "/" +
            (data.maxweight / 1000).toFixed(2)
        );
        playerMaxWeight = data.maxweight;
        if (data.other != null) {
            var name = data.other.name.toString();
            if (
                name != null &&
                (name.split("-")[0] == "itemshop" || name == "crafting")
            ) {
                $("#other-inv-label").html(data.other.label);
            } else {
                $("#other-inv-label").html(data.other.label);
                $("#other-inv-weight").html(
                    // '<i class="fas fa-dumbbell"></i> ' +
                    (totalWeightOther / 1000).toFixed(2) +
                    "/" +
                    (data.other.maxweight / 1000).toFixed(2)
                );
            }
            otherMaxWeight = data.other.maxweight;
            otherLabel = data.other.label;
            var per1 =(totalWeightOther/1000)/(otherMaxWeight/100000)
            $(".pro1").css("width",per1+"%");
        } else {
            $("#other-inv-label").html(Inventory.droplabel);
            $("#other-inv-weight").html(
                // '<i class="fas fa-dumbbell"></i> ' +
                (totalWeightOther / 1000).toFixed(2) +
                "/" +
                (Inventory.dropmaxweight / 1000).toFixed(2)
            );
            otherMaxWeight = Inventory.dropmaxweight;
            otherLabel = Inventory.droplabel;
            var per1 =(totalWeightOther/1000)/(otherMaxWeight/100000)
            $(".pro1").css("width",per1+"%");
        }

        $.each(data.maxammo, function(index, ammotype) {
            $("#" + index + "_ammo")
                .find(".ammo-box-amount")
                .css({ height: "0%" });
        });

        if (data.Ammo !== null) {
            $.each(data.Ammo, function(i, amount) {
                var Handler = i.split("_");
                var Type = Handler[1].toLowerCase();
                if (amount > data.maxammo[Type]) {
                    amount = data.maxammo[Type];
                }
                var Percentage = (amount / data.maxammo[Type]) * 100;

                $("#" + Type + "_ammo")
                    .find(".ammo-box-amount")
                    .css({ height: Percentage + "%" });
                $("#" + Type + "_ammo")
                    .find("span")
                    .html(amount);
            });
        }

        handleDragDrop();
    };

    Inventory.Close = function() {
        // $(".item-slot").css("border", "1px solid rgba(255, 255, 255, 0.1)");
        $(".ply-hotbar-inventory").css("display", "block");
        // $(".ply-iteminfo-container").css("display", "none");
        $(".ply-iteminfo-container").css("display", "none");
        $('.item-shit').css('display', 'none');
        $('.item-info-description').css('display', 'block');
        $("#qbcore-inventory").fadeOut(300);
        $(".item-slot").remove();
        $.post("https://qb-inventory/CloseInventory", JSON.stringify({}));

        if (AttachmentScreenActive) {
            $("#qbcore-inventory").css({ left: "0vw" });
            $(".weapon-attachments-container").css({ left: "-100vw" });
            AttachmentScreenActive = false;
        }

        if (ClickedItemData !== null) {
            $("#weapon-attachments").fadeOut(250, function() {
                $("#weapon-attachments").remove();
                ClickedItemData = {};
            });
        }
    };

    Inventory.ToggleHotbar = function(data) {
        if (data.open) {
            $(".z-hotbar-inventory").html("");
            for (i = 1; i < 6; i++) {
                var elem =
                    '<div class="z-hotbar-item-slot" data-zhotbarslot="' +
                    i +
                    '"> <div class="z-hotbar-item-slot-key"><p>' +
                    i +
                    '</p></div><div class="z-hotbar-item-slot-img"></div><div class="z-hotbar-item-slot-label"><p>&nbsp;</p></div></div>';
                $(".z-hotbar-inventory").append(elem);
            }
            // var elem =
            //     '<div class="z-hotbar-item-slot" data-zhotbarslot="43"> <div class="z-hotbar-item-slot-key"><p>6 <i style="top: -62px; left: 58px;" class="fas fa-lock"></i></p></div><div class="z-hotbar-item-slot-img"></div><div class="z-hotbar-item-slot-label"><p>&nbsp;</p></div></div>';
            // $(".z-hotbar-inventory").append(elem);
            $.each(data.items, function(i, item) {
                if (item != null) {
                    var ItemLabel =
                        '<div class="item-slot-label"><p>' + item.label + "</p></div>";
                    // if (item.name.split("_")[0] == "weapon") {
                        // if (!Inventory.IsWeaponBlocked(item.name)) {
                            ItemLabel =
                                '<div class="item-slot-quality"><div class="item-slot-quality-bar"><p>100</p></div></div><div class="item-slot-label"><p>' +
                                item.label +
                                "</p></div>";
                        // }
                    // }
                    $(".z-hotbar-inventory")
                    .find("[data-zhotbarslot=" + item.slot + "]")
                    .html(
                        '<div class="z-hotbar-item-slot-key"><p>' +
                        item.slot +
                        '</p></div><div class="z-hotbar-item-slot-img"><img src="' +
                        item.image +
                        '" alt="' +
                        item.name +
                        '" /></div><div class="z-hotbar-item-slot-amount"><p>' +
                        item.amount +
                        '</div><div class="z-hotbar-item-slot-amount-name"><p>' +
                        " " +
                        ((item.weight * item.amount) / 1000).toFixed(1) +
                        "</p></div>" +
                        ItemLabel
                    );
                    Inventory.QualityCheck(item, true, false);
                }
            });
            $(".z-hotbar-inventory").fadeIn(150);
        } else {
            $(".z-hotbar-inventory").fadeOut(150, function() {
                $(".z-hotbar-inventory").html("");
            });
        }
    };

    Inventory.UseItem = function(data) {
        $(".itembox-container").hide();
        $(".itembox-container").fadeIn(250);
        $("#itembox-action").html("<p>Used</p>");
        $("#itembox-label").html("<p>" + data.item.label + "</p>");
        $("#itembox-image").html(
            '<div class="item-slot-img"><img src="' +
            data.item.image +
            '" alt="' +
            data.item.name +
            '" /></div>'
        );
        setTimeout(function() {
            $(".itembox-container").fadeOut(250);
        }, 2000);
    };

    var itemBoxtimer = null;
    var requiredTimeout = null;

    Inventory.itemBox = function(data) {
        if (itemBoxtimer !== null) {
            clearTimeout(itemBoxtimer);
        }
    
        var type = "Used " + "x" + data.itemAmount;
        if (data.type == "add") {
            type = "Received " + data.itemAmount;
        } else if (data.type == "remove") {
            type = "Removed " + data.itemAmount;
        }
    
        // Check if there's an existing item box
        var $existingItemBox = $(".itembox-container:not(.template)");
    
        if ($existingItemBox.length > 0) {
            // Update existing item box content
            $existingItemBox.find("#itembox-action p").text(type);
            $existingItemBox.find("#itembox-label p").text(data.item.label);
            $existingItemBox.find(".item-slot-img-itembox img").attr("src", "" + data.item.image).attr("alt", data.item.name);
        } else {
            // Create a new item box
            var $itembox = $(".itembox-container.template").clone();
            $itembox.removeClass("template");
            $itembox.html(
                '<div id="itembox-action"><p>' +
                type +
                '</p></div><div id="itembox-label"><p>' +
                data.item.label +
                '</p></div><div class="item-slot-img-itembox"><img src="' +
                data.item.image +
                '" alt="' +
                data.item.name +
                '" /></div>'
            );
            $(".itemboxes-container").prepend($itembox);
            $itembox.fadeIn(250);
        }
    
        // Show background
        $(".itemboxes-container-background").fadeIn(250);
    
        // Set timeout for removal
        setTimeout(function() {
            $(".itemboxes-container-background").fadeOut(300);
            $(".itembox-container:not(.template)").fadeOut(300, function() {
                $(this).remove();
            });
        }, 3000);
    }; 

    Inventory.RequiredItem = function(data) {
        if (requiredTimeout !== null) {
            clearTimeout(requiredTimeout);
        }
        if (data.toggle) {
            if (!requiredItemOpen) {
                $(".requiredItem-container").html("");
                $.each(data.items, function(index, item) {
                    var element =
                        '<div class="requiredItem-box"><div id="requiredItem-action">Required</div><div id="requiredItem-label"><p>' +
                        item.label +
                        '</p></div><div id="requiredItem-image"><div class="item-slot-img"><img src="' +
                        item.image +
                        '" alt="' +
                        item.name +
                        '" /></div></div></div>';
                    $(".requiredItem-container").hide();
                    $(".requiredItem-container").append(element);
                    $(".requiredItem-container").fadeIn(100);
                });
                requiredItemOpen = true;
            }
        } else {
            $(".requiredItem-container").fadeOut(100);
            requiredTimeout = setTimeout(function() {
                $(".requiredItem-container").html("");
                requiredItemOpen = false;
            }, 100);
        }
    };

    window.onload = function(e) {
        window.addEventListener("message", function(event) {
            switch (event.data.action) {
                case "open":
                    Inventory.Open(event.data);
                    break;
                case "close":
                    Inventory.Close();
                    break;
                case "itemBox":
                    Inventory.itemBox(event.data);
                    break;
                case "requiredItem":
                    Inventory.RequiredItem(event.data);
                    break;
                case "toggleHotbar":
                    Inventory.ToggleHotbar(event.data);
                    break;
                case "health":
                    $(".health-system , body").css("display", "block");
                    $('body').css('background-color','transparent')
                    $(".health-system").animate({
                        left: "0%"
                    }, 1000);

                     healthData = event.data.playerhealth;

                    var woundColors = {
                        Head: "rgba(255, 103, 103, {opacity})",
                        Chest: "rgba(255, 103, 103, {opacity})",
                        RArm: "rgba(255, 103, 103, {opacity})",
                        LArm: "rgba(255, 103, 103, {opacity})",
                        RKnee: "rgba(255, 103, 103, {opacity})",
                        LKnee: "rgba(255, 103, 103, {opacity})"
                    };
            
                    Object.keys(woundColors).forEach(function(area) {
                       var opacity = 100 - healthData[area];
                       if (opacity>60 ){
                        var color = woundColors[area].replace("{opacity}", 0.6);
                       }else{
                        var color = woundColors[area].replace("{opacity}", (opacity/100));
                       }
                    
                       $('.'+area).css("fill", color);
                       $('.bar-'+area).css("width", healthData[area] + "%" );
                        $('.health-'+area).html(healthData[area] + "%");
                    })

                    
                    // $('.two-circle .text').html(event.data.playerDamage['label']);
                    // $('.two-circle .number').html(event.data.playerDamage['count']);
            }
        });
    };
})();

// Item Search  //
$(".inventory-search-input-box").on("keyup", function() {
    var val = $(this).val().toLowerCase();

    $(".player-inventory .item-slot").each(function () {
        var html = $(this).find(".item-slot-label").html().toLowerCase();

        if (html.indexOf("&nbsp;") === -1) {
            if (html.indexOf(val) === -1) {
                $(this).css('opacity', '0.3');
            } else {
                $(this).css('opacity', '1');
            }
        }
    });
});

// remove backpack 
$(".backpack-remove-btn").on( "click", function() {
    $.post(
        "https://qb-inventory/RemoveBackPack",
        JSON.stringify({})
    );
});