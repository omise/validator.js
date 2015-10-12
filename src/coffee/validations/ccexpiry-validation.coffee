class OmiseCcExpiryValidation
  constructor: ->
    @charMax    = 6
    @strPattern = [null, null, '#', '#', '#', null, null, null, null]

  ###
  # Initiate validation rule
  ###
  init: (elem) ->
    elem.onkeypress = (e) =>
      e = e || window.event
      @validate e

  ###
  #
  ###
  validate: (e) =>
    inp = String.fromCharCode e.which

    # Allow: delete, tab, escape, home, end and left-right arrow
    return true if e.which in [null, 0, 9, 27]

    # Detect 'backspace' key
    if e.which is 8

    else
      inp = String.fromCharCode e.which

      # Allow: only digit character [0 - 9]
      return false if !/^\d+$/.test inp

      return false if (e.target.value.replace(/\D/g, '')).length >= @charMax


      if e.target.value.length is 0 and /^[2-9]+$/.test inp
        e.preventDefault()
        e.target.value = 0 + inp + " / "
        @strPattern[0] = "0"
        @strPattern[1] = inp
      else if (e.target.value.replace(/\D/g, '') + inp).length is 2
        e.preventDefault()
        e.target.value = e.target.value + inp + " / "
      else
        @strPattern[e.target.selectionStart] = inp

# Export class
window.OmiseValidation.ccexpiry = OmiseCcExpiryValidation
