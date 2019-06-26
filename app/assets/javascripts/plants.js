$(() => {
  bindClickHandlers()
})

const bindClickHandlers = () => {
  $(document).on('click', '.all_plants', function(e) {
    e.preventDefault()
    let disp_id = $(this).attr('data_id')
    fetch(`/dispensers/${disp_id}/plants.json`)
    .then(res => res.json())
    .then(dispenser => {
      let newDispenser = new Dispenser(dispenser)
      let plants = newDispenser.plants
      $('#'+newDispenser.id).html('')
      plants.forEach((plant) => {
        let newPlant = new Plant(plant, newDispenser)
        let plantHtml = newPlant.formatPlantIndex()
        $('#'+newPlant.dispenser_id).append(plantHtml)
        console.log(newPlant.dispenser_id)
      })
    })
  })
  $(document).on('click', ".show-link", function(e) {
    e.preventDefault()
    let id = $(this).attr('data_id')
    let d_id = $(this).attr('disp-id')
    fetch(`/dispensers/${d_id}/plants/${id}`)
    .then(res => res.json())
    .then(plant => {
      let newPlant = new Plant(plant)
      let plantHtml = newPlant.formatPlantShow()
      $('#'+newPlant.dispenser_id).append(plantHtml)
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

function Plant(plant, disp) {
  this.id = plant.id
  this.name = plant.name
  this.location = plant.location
  this.water_quantity = plant.water_quantity
  this.water_frequency = plant.water_frequency
  this.last_day_watered = plant.last_day_watered
  this.next_water_day = plant.next_water_day
  this.dispenser_id = disp.id

}

Plant.prototype.formatPlantIndex = function(){
  let plantHtml = `
  <a href="/dispensers/${this.dispenser_id}/plants" class="plantlink show-link" data_id=${this.id} disp-id=${this.dispenser_id}><li>${this.name} - ${this.location}</li></a>
  `
  return plantHtml
}

Plant.prototype.formatPlantShow = function(){
  let plantHtml = `
  <ul>
    <li>Water <%= ${this.water_quantity} %>oz, every <%= ${this.water_frequency} %> day(s)</li>
    <% unless ${this.next_water_day}.blank? && ${this.last_day_watered}.blank? %>
    <li>Last day watered: <%= ${this.last_day_watered}.to_date.strftime("%m/%d/%Y") %>, Next water day: <%= ${this.next_water_day}.to_date.strftime("%m/%d/%Y") %></li>
    <% end %>
    <a href="/dispensers/${this.dispenser_id}/plants/${this.id}"><li>Edit this plant</li></a>
  </ul>
  `
}
