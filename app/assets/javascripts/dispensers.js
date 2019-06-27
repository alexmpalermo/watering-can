

/////
$(() => {
  editDispHandlers()
})

const editDispHandlers = () => {
  $(document).on('click', '.disp-name-edit', function(e) {
    e.preventDefault()
    let disp_id = $(this).attr('data_id')
    fetch(`/dispensers/${disp_id}/edit.json`)
    .then(res => res.json())
    .then(dispenser => {
      let newDisp = new Disp(dispenser)
      $('#'+newDisp.id+'-name-container').html('')
      let dispenserHtml = newDisp.formatDispenserNameField()
      $('#'+newDisp.id+'-name-container').append(dispenserHtml)
    })
  })
  $(document).on('submit', 'form.edit_dispenser', Disp.formSubmit)
}

Disp.formSubmit = function(e){
  e.preventDefault()
  let id = $(this).attr('data_id')
  let $form = $(this);
  $.ajax({
    url: $form.attr("action"),
    data: $form.serialize(),
    dataType: "json",
    method: ($("input[name='_method']").val() || $form.attr("method"))
  })
  .success(Disp.success)
  .error(Disp.error)
}

function Disp(dispenser) {
  this.id = dispenser.id
  this.name = dispenser.name
  this.product_number = dispenser.product_number
  this.capacity = dispenser.capacity
  this.user = dispenser.user
  this.plants = dispenser.plants
  this.containers = dispenser.containers
}

Disp.success = function(json){
  let newDisp = new Disp(json);
  $('#'+newDisp.id+'-name-container').html('')
  let dispenserH2 = newDisp.renderH2()
  $('#'+newDisp.id+'-name-container').append(dispenserH2)
}

Disp.error = function(response){
  console.log("There was an error", response)
}

Disp.prototype.renderH2 = function(){
  let dispenserHtml = `
  <h2><a class="disp-font disp-name-edit" data_id="${this.id}" href="/dispensers/${this.id}/edit">${this.name}</a></h2>
  `
  return dispenserHtml
}

Disp.prototype.formatDispenserNameField = function(){
  let authToken = $('meta[name=csrf-token]').attr('content')
  let dispenserHtml = `
  <form class="edit_dispenser" id="edit_dispenser_${this.id}" action="/dispensers/${this.id}" accept-charset="UTF-8" method="post">
    <input name="utf8" type="hidden" value="✓">
    <input type="hidden" name="_method" value="patch">
    <input type="hidden" name="authenticity_token" value=${authToken}>
    <input placeholder="${this.name}" type="text" value="${this.name}" name="dispenser[name]" id="dispenser_name">
    <input type="submit" name="commit" value="Rename Can" data-disable-with="Rename Can">
  </form>
  `
  return dispenserHtml
}
