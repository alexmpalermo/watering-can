$(() => {
  bindClickHandlers()
})

const bindClickHandlers = () => {
  $('.all_plants').on('click', e => {
    e.preventDefault()
    history.pushState(null, null, "plants")
    let disp_id = $(this).attr('data_id')
    fetch(`/dispenser/${disp_id}/plants.json`)

  })
}
