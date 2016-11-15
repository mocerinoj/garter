$(document).on 'ready turbolinks:load', () ->
  $("#domains_table").DataTable({
    'framework': 'bootstrap4'
  })
