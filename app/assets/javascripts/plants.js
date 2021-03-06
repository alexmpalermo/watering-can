$(() => {
  bindClickHandlers()
})

const bindClickHandlers = () => {
  $(document).on('click', '.all_plants', function(e) {
    e.preventDefault()
    let disp_id = $(this).attr('data_id')
    fetch(`/dispensers/${disp_id}/plants.json`)
    .then(res => res.json())
    .then(plants =>
      {
      $('#'+disp_id).html('')
      plants.sort((a, b) => a.name.localeCompare(b.name))
      plants.forEach((plant) => {
        let newPlant = new Plant(plant)
        let plantHtml = newPlant.formatPlantIndex()
        $('#'+newPlant.dispenser_id).append(plantHtml)
      })
    })
  })
  $(document).on('click', ".show-link", function(e) {
    e.preventDefault()
    let id = $(this).attr('data_id')
    let d_id = $(this).attr('disp-id')
    fetch(`/dispensers/${d_id}/plants/${id}.json`)
    .then(res => res.json())
    .then(plant => {
      let newPlant = new Plant(plant)
      $('#'+newPlant.dispenser_id+newPlant.id).html('')
      let plantHtml = newPlant.formatPlantShow()
      $('#'+newPlant.dispenser_id+newPlant.id).append(plantHtml)
    })
  })
}

function Plant(plant) {
  this.id = plant.id
  this.name = plant.name
  this.location = plant.location
  this.water_quantity = plant.water_quantity
  this.water_frequency = plant.water_frequency
  this.last_day_watered = plant.last_day_watered
  this.next_water_day = plant.next_water_day
  this.dispenser_id = plant.dispenser_id
}

Plant.prototype.formatPlantIndex = function(){
  let plantHtml = `
  <a href="/dispensers/${this.dispenser_id}/plants" class="plantlink show-link" data_id=${this.id} disp-id=${this.dispenser_id}><li>${this.name} - ${this.location}</li></a>
  <div id=${this.dispenser_id}${this.id}></div>
  `
  return plantHtml
}

function parseDate(x) {
  let date = x
  let arr = date.split("-");
  arr.push(arr.shift());
  date = arr.join("/");
  return date
}

Plant.prototype.formatPlantShow = function(){
  let plantHtml = `
  <ul id="plain-text">
    <li>Water ${this.water_quantity}oz, every ${this.water_frequency} day(s)</li>
    <li>Last day watered: ${parseDate(this.last_day_watered)}, Next water day: ${parseDate(this.next_water_day)}</li>
    <a href="/dispensers/${this.dispenser_id}/plants/${this.id}/edit" id="plant-edit"><li>Edit this plant</li></a>
  </ul>
  `
  return plantHtml
}
