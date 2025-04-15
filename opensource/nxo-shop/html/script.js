cartArr = []
count = 1
control = false
totalCartPrice = 0;
itemList = []
marketType = ""
itemlicenses=[]
itemhuntinglicenses=[]
hasweaponlicense=false
hashuntinglicense=false
buytext=""
window.addEventListener("message", function (e) {
  e = e.data
  switch (e.action) {
    case "OPEN":
      return openMenu(e.data)
    case "CLOSE":
      return closeNUI()
      case "UPDATE":
        return update(e.data)
        case "payresult":
          payresult(e.data)
    default:
      return;
  }
});

$(document).on('click', '.fa-shopping-cart', function (e) {
  var type = $(this).data("type");
  var price = $(this).data("price");
  var image = $(this).data("image");
  var id = $(this).data("id");
  var itemname = $(this).data("itemname");
  var iname = $(this).data("iname");
  if (itemlicenses[itemname] && !hasweaponlicense){
    $.post("http://nxo-shop/notify", JSON.stringify({
      message: "No have a Licenses",
    }));
      $(".job-cart-error").show()
      $(".job-cart-error").text("No have a Licenses")
    return;
  }
  if (itemhuntinglicenses[itemname] && !hashuntinglicense){
    $.post("http://nxo-shop/notify", JSON.stringify({
      message: "No have a Licenses",
    }));
      $(".job-cart-error").show()
      $(".job-cart-error").text("No have a Licenses")
    return;
  }
  var existingCartItem = cartArr.find(item => item.id === id);

  if (existingCartItem) {
    existingCartItem.count++;
  } else {
    cartArr.push({
      type: type,
      price: price,
      image: image,
      iname:iname,
      id: id,
      itemname: itemname,
      count: 1
    });
    if (marketType == "market") {
      
      $(".cart-box").append(`
      <div class="cart-item item-${id}">
          <div class="cart-img">
          <img src="nui://qb-inventory/html/images/${image}" alt="">
          </div>
          <div class="cart-name">${iname}</div>
          <div class="cart-price">$${price}</div>
          <div class="cart-count">x1</div>  
          <div data-id=${id} class="eksi-box">
          <div class="ex">-</div>
          </div>
          <div data-id=${id} class="arti-box">
          <div class="arti">+</div>
          </div>
          <div data-id=${id} class="delete-box">
          <div class="delete">
          <i class="fas fa-trash-alt"></i>
          </div>
          </div>
      </div>
      `);
    }else{
      $(".job-cart-box").append(`
      <div class="job-cart-item item-${id}">
      <div class="cart-img">
        <img src="nui://qb-inventory/html/images/${image}" alt="">
      </div>
      <div class="cart-name">${iname}</div>
      <div class="cart-price">$${price}</div>
        <div class="cart-count">x3</div>  
      <div data-id=${id} class="eksi-box">
          <div class="ex">-</div>
        </div>
        <div data-id=${id} class="arti-box">
          <div class="arti">+</div>
        </div>
        <div data-id=${id} class="delete-box">
          <div class="delete">
            <i class="fas fa-trash-alt"></i>
          </div>
        </div>
    </div>
      `);
    }

    $.post("http://nxo-shop/setCart", JSON.stringify({
      type: type,
      price: price,
      image: image,
      id: id,
      count: 1
    }));
  }

  updateCartView();

})





$(document).on('click', '.eksi-box', function (e) {
  var id = $(this).data("id");
  var existingCartItem = cartArr.find(item => item.id === id);
  if (existingCartItem.count === 1) {
    cartArr = cartArr.filter(item => item.id !== id);
    $(`.item-${id}`).remove();
  } else {
    existingCartItem.count--;
  }

  updateCartView();
});

$(document).on('click', '.arti-box', function (e) {
  var id = $(this).data("id");
  var existingCartItem = cartArr.find(item => item.id === id);
  existingCartItem.count++;

  updateCartView();
});

$(document).on('click', '.delete-box', function (e) {
  var id = $(this).data("id");
  cartArr = cartArr.filter(item => item.id !== id);
  $(`.item-${id}`).remove();

  updateCartView();
});

$(document).on('click', '.MDMDLeftSide', function (e) {
  var category = $(this).data("category");
  $(".item-box").empty()
  appendItem(itemList[category])
})

$(document).on('click', '.job-category-item', function (e) {
  var category = $(this).data("category");
  $(".job-item-box").empty()
  appendJobItem(itemList[category])
})

$(document).on('click', '.pay', function (e) {
  payType = $(this).data("type"); 
  $('.bank-text').hide()
  $('.cash-text').hide()

  $.post("http://nxo-shop/pay", JSON.stringify({price:totalCartPrice,payType: payType, cartArr: cartArr}));
})



document.getElementById('scrollBox').addEventListener('wheel', function (e) {
  if (e.deltaY < 0) {
    this.scrollLeft += 50;
  } else {
    this.scrollLeft -= 50;
  }
  e.preventDefault();
});

document.getElementById('jobscroll').addEventListener('wheel', function (e) {
  if (e.deltaY < 0) {
    this.scrollLeft += 30;
  } else {
    this.scrollLeft -= 30;
  }
  e.preventDefault();
});


function updateCartView() {
  totalCartPrice = cartArr.reduce((total, item) => total + item.price * item.count, 0);

  $(".total-price,.job-cart-price").html(`$${totalCartPrice}`);
  cartArr.forEach(item => {
    $(`.item-${item.id}`).find(".cart-count").html(`x${item.count}`);
    $(`.item-${item.id}`).find(".cart-price").html(`$${item.price * item.count}`);
  });
}

function appendItem(data) { 
    $.each(data, function (i, v) {
      if (v){
        $(".item-box").append(`
          <div class="item">
            <div class="moneybox"><i class="fa-solid fa-dollar-sign dollaricon"></i>
             ${v.price}
             </div>
            <img class="img" src="nui://qb-inventory/html/images/${v.image}" alt="">
            <div class="itemalt">
              <div class="item-name">${v.name}</div>
              <div class="item-altcategory">${v.type}</div>
              <div class="cartbox">
                <i data-iname="${v.name}" data-itemname="${v.itemname}" data-id="${v.itemname}" data-image="${v.image}" data-type="${v.type}" data-price="${v.price}" class="fas fa-shopping-cart"></i>
              </div>
            </div>
            <div class="itemalthr"</div>
          </div>`)
      }
     
    })
}

function appendJobItem(data) { 
  $(".job-item-box").empty();
  $.each(data, function (i, v) {
    $(".job-item-box").append(`
    <div class="job-item">
      <img class="job-icon" src="../images/miniicon.png" alt="">
      <div class="job-dollarbox">
      </div>
      <i class="fa-solid fa-dollar-sign job-dollaricon"></i>
      <div class="job-itemoney">${v.price}</div>
      <div class="job-moneybox"></div>
      <img class="job-img" src="nui://qb-inventory/html/images/${v.image}" alt="">
      <div class="job-itemaltt">
        <div class="job-item-name">${v.name}</div>
        <div class="job-item-altcategory">${v.type}</div>
        <div class="job-cartbox">
          <i data-iname="${v.name}" data-itemname="${v.itemname}" data-id="${v.itemname}" data-image="${v.image}" data-type="${v.type}" data-price="${v.price}" class="fas fa-shopping-cart"></i>
        </div>
      </div>
      <div class="job-itemalthr"</div>
    </div>`)
  })
}

function openMenu(data){
  buytext=data.buytext
  // if (data.buytext=="free"){
  //   $(".cash-text").hide() 
  //   $(".total-text").hide() 
  //   $(".payment-text").hide() 
  //   $(".total-price").hide()
  //   $(".bank-text").html("Give Item")
  // }
 
  hasweaponlicense=data.licences;
  hashuntinglicense=data.huntlisc;
  itemlicenses=data.itemlicenses;
  itemhuntinglicenses=data.itemhuntinglicenses;
  var firstData = data.marketItemList[data.marketCategoryList[0].name];
  itemList = data.marketItemList;
  if (data.marketJob != "") {
    marketType = "job"
    $(".box,.bg").hide()
    $(".job-market,body").show()
    $(".job-box,.job-cart-circle").animate({
      top: "0px"
    }, 500)

    var str = data.marketName;
    var words = str.split(' ');

    if (words.length >= 2) {
        $(".job-header").html(`${words[0]} <span style="font-family: AkrobatExtraLight;">${words[1]}</span>`)
    } else {
        $(".job-header").html(`${words[0]}`)
    }

    $(".job-text-box").html("News")

    $(".job-category").empty()

    // if (data.marketCategoryList.length>1){
      $.each(data.marketCategoryList, function (i, v) {
      if (i){
        $(".job-category").append(`
          <div data-category="${i.name}" class="job-category-item">
          <div class="job-category-name">${i.name}</div>
          <div class="job-itemalt"></div>
        </div>
          `)
      }
       
      })
  
    // }
   
    appendJobItem(firstData)
    
  }else{
    marketType = "market"
    $("body,.box,.bg").show()
    $(".job-market").hide()
    $(".category,.item-box").empty()
    $(".header").html(data.marketName)
    $(".alt").html(data.marketCategory)
    
    
    appendItem(firstData)
    
    // if (data.marketCategoryList.length>1){
    $.each(data.marketCategoryList, function (i, v) {
     
      $(".category").append(`
      <div id="MDMarkerDiv">
      <div data-category="${v.name}" class="MDMDLeftSide">
      <div class="MDMDLDDiv1"></div>
      <div class="MDMDLDDiv2">
      <i style="transform: rotate(-135deg); font-size: 10px;" class="fad fa-building"></i>
      </div>
        <div class="categoryname">${v.name}</div>
        <div class="categorydesc">${v.disc}</div>
        <div class="MDMDLDDiv3">
        </div>
        </div>
        </div> 
        
        `)
      })
    // }
    }
}

function capitalizeFirstLetter(word) {
  return word.charAt(0).toUpperCase() + word.slice(1);
}

function clearlist(){
  $('.cart-box').empty()
  cartArr=[]
  updateCartView();
}
function closeNUI() {
  $("body").hide()
  $(".job-cart-error").hide()
  $('.bank-text').show()
  $('.cash-text').show()
  $.post("http://nxo-shop/close", JSON.stringify({}));
  $(".job-box,.job-cart-circle").animate({
    top: "15rem"
  }, 500)

  clearlist()

}
function payresult(data){
  $('.bank-text').show()
  $('.cash-text').show()
  if (data.res){
    closeNUI()
  }else{
    $(".job-cart-error").show()
    $(".job-cart-error").text(data.message)
  }

}
document.addEventListener('keydown', function(event) {

  if (event.key === 'Escape') {
      closeNUI();
  }
});
