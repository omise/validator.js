class Helper
  ###
  # Slice field's value starting from caret position
  # @param {object} elem - a selector object of an element
  # @param {int} length - number of string's length that need to slice
  # @return {void}
  ###
  delValFromCaretPosition: (elem, length = 1) ->
    if ((pos = elem.selectionStart - length) >= 0)
      # Set a new value into element
      elem.value = elem.value.slice(0, pos) + elem.value.slice(pos + length)
    else
      elem.value = ""
    
    # Set a new position of caret
    elem.focus()
    elem.setSelectionRange pos, pos

    return pos

  insertValAfterCaretPos: (value, input, caret) ->
    if caret != value.length
      _value = value.split ''
      _value.splice caret, 0, input
      _value = _value.join ''

      _value = _value.match /\d/g
      _value = _value.join ''

    else
      _value = "#{value}#{input}"

    return _value

  ###
  # Get caret position
  # @param {object} elem - a selector object of an element
  # @return {void}
  ###
  getCaretPosition: (elem) ->
    return elem.selectionStart

  setCaretPosition: (elem, pos) ->
    elem.focus()
    elem.setSelectionRange pos, pos

  beDirty: (elem) ->
    elem.dataset.dirty = true

  dirty: (elem) ->
    return if elem.dataset.dirty is "true" then true else false

  isMetaKey: (e) ->
    if e.metaKey is false and
      e.ctrlKey is false and
      e.altKey is false and
      e.code isnt "ShiftLeft" and
      e.code isnt "ShiftRight" and
      e.keyIdentifier isnt "Shift"
        return false

    return true

  inputChar: (e) ->
    # Safari, Chrome onKeyDown behaviour
    if e.keyIdentifier?
      char = parseInt e.keyIdentifier.substr(2), 16
      char = String.fromCharCode char

    # Firefox onKeyDown behaviour
    else
      char = e.key

    return char

  caretRange: (elem) ->
    range = @getCaretRange elem
    start = range.start
    end   = range.end

    return elem.value.substring start, end

  getCaretRange: (elem) ->
    if elem.createTextRange?
      # Get range start
      range = document.selection.createRange().duplicate()
      range.moveEnd('character', elem.value.length)
      
      if (range.text == '')
        start = elem.value.length
      else
        start = elem.value.lastIndexOf start.text

      # Get range end
      range.moveStart('character', -elem.value.length)
      end = range.text.length

    else
      start = elem.selectionStart
      end   = elem.selectionEnd

    return {start: start, end: end}

window.OmiseValidation.helper = Helper