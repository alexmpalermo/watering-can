Dispenser.success = function(json){
  var dispenser = newDispenser(json);
  var dispenserLi = dispenser.renderLi()
  $('#'+newDispenser.id+'-name-container').append(dispenserLi)
}

Dispenser.error = function(response){
  console.log("There was an error", response)
}

Dispenser.formSubmit = function(e){
  e.preventDefault()
  var $form = $(this);
  var action = $form.attr("action");
  var params = $form.serialize();
  $.ajax({
    url: action,
    data: params,
    dataType: "json",
    method: ($('input[name='_method']').val() || $form.attr("method"))
  })
  .success(Dispenser.success)
  .error(Dispenser.error)
}

$(function(){
  $('form.edit_dispenser).on('submit', Dispenser.formSubmit)
})


$(function(){
  Dispenser.templateSource = $('#dispenser-template').html()
  Dispenser.template = Handlebars.compile(Dispenser.templateSource);
})

Dispenser.prototype.renderLi = function(){
  return Dispenser.template(this)
}
