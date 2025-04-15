
cars = []
carPrice = 0
carName = ""
let newPrice = 0
let limitday=0;
window.addEventListener("message", function (e) {
  e = e.data
  switch (e.action) {
    case "OPEN":
      return  openMenu(e)
    case "CLOSE":
      return closeNUI()
    default:
      return;
  }
});

// esc close

document.onkeyup = function (data) {
  if (data.which == 27) {
    closeNUI();
  }
}

openMenu = (data) => {
  cars = data.data["Cars"]
  limitday=data.limitday
  setCategory(data.data["Category"])
  setCar(data.data["Category"][0].name)

  $('body').css('display', 'block')
}

setCategory = (data) => {
  $('.category-box').empty()
  data.forEach(element => {
    $('.category-box').append(`
    <div class="item" data-name="${element.name}">
      <i class="fa fa-map-marker-alt"></i>
      <div class="name">${element.name}</div>
    </div>
    `)
  });
}

setCar = (data) => {
  $('.car-box').empty()
  cars[data].forEach(element => {
    $('.car-box').append(`
    <div data-name="${element.model}"  data-price="${element.price}" class="car-item">
        <div class="car-name">${element.name}</div>
        <div class="car-day">1 day</div>
        <div class="car-price">$${element.price}</div>
        <div class="car-line"></div>
        <div class="car-img">
          <img src="${element.img}" alt="">
        </div>
      </div>
    `)
  });
}

closeNUI = () => {
  $.post(`https://qb-rental/close`, JSON.stringify({}));
  $('body').css('display', 'none')
}


$(".search-input input").on("input", function () {
  let value = $(this).val().toLowerCase()
  $('.car-item').filter(function () {
    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
  })
})


$(document).on('click', '.pay-button', function (e) {
  payType = $(this).data('type')
  $.post(`https://qb-rental/rent`, JSON.stringify({
    carName: carName,
    carPrice: newPrice,
    carDay: $('.day-text').text().split(" ")[0],
    payType: payType
  }));
  closeNUI()
})

$(document).on('click', '.counter', function (e) {
  if (carPrice == 0) {
    return
  }
  e.preventDefault()
  let counter = $(".day-text")
  let count = $(counter).text().split(" ")[0]

  let rotation = $(this).data('rotation')
  if (rotation == "left") {
    count++
    if (limitday>0 && count>limitday){
      count=limitday
    }
    newPrice = count * carPrice; // Adjust the price calculation using the initial car price
  } else {
    if (count > 1) {
      count--
      if (limitday>0 && count>limitday){
        count=limitday
      }
      newPrice = count * carPrice; // Adjust the price calculation using the initial car price
    }
  }
  if (count < 1) {
    return
  }
  $('.total-price').text("$" + Number(newPrice))
  counter.text(count + " Day")
})



$(document).on('click', '.category-box .item', function (e) {
  categoryName = $(this).data('name')
  setCar(categoryName)

  $('.category-box .item').css('background-color','rgba(64, 66, 68, 0.3')
  $('.category-box .item').css('border','none')
  $('.category-box .item').children('i').css('color','#545f5d')
  $('.category-box .item').children('.name').css('color','#88888e')

  $(this).css('background-color','rgba(66, 9, 9, 0.5)')
  $(this).css('border','1px solid #dc143c')
  $(this).children('i').css('color','#f1f1f1')
  $(this).children('.name').css('color','#f1f1f1')

})

$(document).on('click', '.car-box .car-item', function (e) {
  carPrice = $(this).data('price')
  carName = $(this).data('name')
  $('.car-box .car-item').css('background-color','rgba(64, 66, 68, 0.3')
  $('.car-box .car-item').css('border','none')
  $('.car-box .car-item').children('i').css('color','#545f5d')
  $('.car-box .car-item').children('.name').css('color','#88888e')

  $(this).css('background-color','rgba(66, 9, 9, 0.5)')
  $(this).css('border','1px solid #dc143c')
  $(this).children('i').css('color','#f1f1f1')
  $(this).children('.name').css('color','#f1f1f1')
  newPrice = 1 * carPrice;
  $('.total-price').text("$" + carPrice)
  $(".day-text").text(1 + " Day")
})
