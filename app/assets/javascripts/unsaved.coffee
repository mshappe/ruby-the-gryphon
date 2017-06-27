# Coffeescript

change = ->
  $("form input, form textarea").change( ->
    $('a').click( ->
      confirm('Unsaved changes on the page. Are you sure?')
    )
  )

$(document).ready(change)

# the page has been parsed and changed to the new version and on DOMContentLoaded
$(document).on('page:change', change)
