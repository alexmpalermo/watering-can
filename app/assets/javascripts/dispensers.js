$(() => {
  dispBindClickHandlers()
})

const dispBindClickHandlers = () => {
  $('.all_dispensers').on('click', e => {
    e.preventDefault()
    history.pushState(null, null, "dispensers")
    fetch(`/dispensers.json`)
      .then(res => res.json())
      .then(dispensers => {
        $('#dispenser-name-container').html('')
        dispensers.forEach((dispenser) => {
          let newDispenser = new Dispenser(dispenser)
          let dispenserHtml = newDispenser.formatIndex()
          $('#dispenser-name-container').append(dispenserHtml)
        })
      })
  })
}

function Dispenser(dispenser) {
  this.id = dispenser.id
  this.name = dispenser.name
  this.product_number = dispenser.product_number
  this.capacity = dispenser.capacity
  this.user = dispenser.user
  this.plants = dispenser.plants
  this.containers = dispenser.containers
}

Dispenser.prototype.formatIndex = function(){
  let dispenserHtml = `
  <h2><%= link_to ${this.name}, dispenser_plants_path(${this}), :class => "disp-font show-link" :data_id => ${this.id} %></h2>
  `
  return dispenserHtml
}
