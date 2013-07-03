# fadeout flash messages

$ ->
  $(".alert").delay(500).fadeIn "normal", ->
    $(this).delay(2500).fadeOut()

