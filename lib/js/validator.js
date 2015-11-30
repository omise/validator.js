(function() {
  var OmiseValidator;

  OmiseValidator = (function() {
    function OmiseValidator() {
      this.core = new window.OmiseValidation.validation;
      this.rules = {
        ccName: new window.OmiseValidation.ccname,
        ccNumber: new window.OmiseValidation.ccnumber,
        ccExpiry: new window.OmiseValidation.ccexpiry,
        ccExpiryMonth: new window.OmiseValidation.ccexpirymonth,
        ccExpiryYear: new window.OmiseValidation.ccexpiryyear,
        ccSecurityCode: new window.OmiseValidation.ccsecuritycode
      };
      this.form = {
        form: null,
        fields: []
      };
    }


    /*
     * Set a validation to an element
     * @callback failureCallback
     * @param {object} form - the form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @param {string} field - the name of an element that have to validate
     * @param {string} rule - the name of a validation
     * @param {failureCallback} [default=null] callback - the callback function
     * @return {void}
     */

    OmiseValidator.prototype.validates = function(field, rule, callback) {
      if (callback == null) {
        callback = null;
      }
      if (typeof field === "string" && typeof rule === "string") {
        return this.form.fields.push({
          target: field,
          validates: typeof rule === "string" ? [rule] : rule,
          selector: null,
          callback: callback
        });
      }
    };


    /*
     * Verbose way of the 'CcName' validation
     * @callback failureCallback
     * @param {object} form - the form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @param {string} field - the name of an element that have to validate
     * @param {failureCallback} [default=null] callback - the callback function
     * @return {void}
     */

    OmiseValidator.prototype.validateCcName = function(field, callback) {
      if (callback == null) {
        callback = null;
      }
      return this.validates(field, 'ccName', callback);
    };


    /*
     * Verbose way of the 'validateCcNumber' validation
     * @callback failureCallback
     * @param {object} form - the form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @param {string} field - the name of an element that have to validate
     * @param {failureCallback} [default=null] callback - the callback function
     * @return {void}
     */

    OmiseValidator.prototype.validateCcNumber = function(field, callback) {
      if (callback == null) {
        callback = null;
      }
      return this.validates(field, 'ccNumber', callback);
    };


    /*
     * Verbose way of the 'validateCcExpiry' validation
     * @callback failureCallback
     * @param {object} form - the form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @param {string} field - the name of an element that have to validate
     * @param {failureCallback} [default=null] callback - the callback function
     * @return {void}
     */

    OmiseValidator.prototype.validateCcExpiry = function(field, callback) {
      if (callback == null) {
        callback = null;
      }
      return this.validates(field, 'ccExpiry', callback);
    };


    /*
     * Verbose way of the 'validateCcExpiryMonth' validation
     * @callback failureCallback
     * @param {object} form - the form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @param {string} field - the name of an element that have to validate
     * @param {failureCallback} [default=null] callback - the callback function
     * @return {void}
     */

    OmiseValidator.prototype.validateCcExpiryMonth = function(field, callback) {
      if (callback == null) {
        callback = null;
      }
      return this.validates(field, 'ccExpiryMonth', callback);
    };


    /*
     * Verbose way of the 'validateCcExpiryYear' validation
     * @callback failureCallback
     * @param {object} form - the form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @param {string} field - the name of an element that have to validate
     * @param {failureCallback} [default=null] callback - the callback function
     * @return {void}
     */

    OmiseValidator.prototype.validateCcExpiryYear = function(field, callback) {
      if (callback == null) {
        callback = null;
      }
      return this.validates(field, 'ccExpiryYear', callback);
    };


    /*
     * Verbose way of the 'validateCcSecurityCode' validation
     * @callback failureCallback
     * @param {object} form - the form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @param {string} field - the name of an element that have to validate
     * @param {failureCallback} [default=null] callback - the callback function
     * @return {void}
     */

    OmiseValidator.prototype.validateCcSecurityCode = function(field, callback) {
      if (callback == null) {
        callback = null;
      }
      return this.validates(field, 'ccSecurityCode', callback);
    };


    /*
     * Validate fields in case you need to run the validate method
     * through your event listener
     * @return {boolean}
     */

    OmiseValidator.prototype.validate = function() {
      var field, j, len, ref, result, valid;
      valid = true;
      ref = this.form.fields;
      for (j = 0, len = ref.length; j < len; j++) {
        field = ref[j];
        field.selector.dataset.dirty = true;
        if ((result = field.validates.validate(field.selector.value)) !== true) {
          valid = false;
        }
        this.core.response.result(null, field, result);
      }
      return valid;
    };


    /*
     * Attach all of a validation to a selector
     * @callback failureCallback
     * @param {object} form - the form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @callback successCallback
     * @param {object} form - a form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @param {string} form - the name of a form element
     * @param {failureCallback} fc - will be executed when the form is invalid
     * @param {successCallback} sc - will be executed when the form is valid
     * @return {void}
     */

    OmiseValidator.prototype.attachForm = function(form, fc, sc) {
      var field, i, j, ref, result;
      if (form == null) {
        form = null;
      }
      if (fc == null) {
        fc = null;
      }
      if (sc == null) {
        sc = null;
      }
      if (form != null) {
        this.form.form = this._manipulateSelectors(form);
        if (this.form.form == null) {
          return false;
        }
        ref = this.form.fields.reverse();
        for (i = j = ref.length - 1; j >= 0; i = j += -1) {
          field = ref[i];
          if (field.selector != null) {
            continue;
          }
          result = (function(_this) {
            return function(field) {
              field.selector = _this._manipulateSelectors(field.target);
              if (field.selector == null) {
                return false;
              }
              field.validates = _this.rules[field.validates[0]] || false;
              if (field.validates === false) {
                return false;
              }
              _this._initValidateField(field.selector, field.target);
              return _this._observeField(field);
            };
          })(this)(field);
          if (result === false) {
            this.form.fields.splice(i, 1);
          } else {
            this.form.fields[i] = field;
          }
        }
        this._observeForm(this.form, fc, sc);
      }
    };


    /*
     * Manipulate a selector from element's id or class attribute
     * @param {string} target - the name of an element
     * @return {object} a HTML DOM object
     */

    OmiseValidator.prototype._manipulateSelectors = function(target) {
      switch (target[0]) {
        case "#":
          return document.getElementById(target.substring(1));
        case ".":
          return (document.getElementsByClassName(target.substring(1)))[0];
        default:
          return document.getElementById(target);
      }
    };


    /*
     * Transform a target field to be a validated field
     * @param {object} elem - an element that is a target
     * @param {string} prefix - The name that will be a prefix of an element's id
     * @return {void}
     */

    OmiseValidator.prototype._initValidateField = function(elem, prefix) {
      var cnt, message, wrapper;
      if (/^[.#]/.test(prefix)) {
        prefix = prefix.substring(1);
      }
      cnt = document.getElementsByClassName(prefix + "_wrapper");
      cnt = cnt.length > 0 ? cnt.length : "";
      wrapper = document.createElement('span');
      wrapper.id = "" + prefix + cnt + "_wrapper";
      wrapper.className = "omise_validation_wrapper";
      elem.parentNode.replaceChild(wrapper, elem);
      wrapper.appendChild(elem);
      message = document.createElement('span');
      message.id = "" + prefix + cnt + "_validation_msg";
      message.className = "omise_validation_msg";
      wrapper.appendChild(message);
      elem.dataset.dirty = false;
      elem.dataset.wrapper = wrapper.id;
      return elem.dataset.validationMsg = message.id;
    };


    /*
     * Listen to form event
     * @callback failureCallback
     * @param {object} form - the form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @callback successCallback
     * @param {object} form - a form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @param {object} form - the form that be retrieved from @form variable
     * @param {object} form.form - a selector of form target element
     * @param {object} form.fields - a field objects
     * @param {failureCallback} fc - will be executed when the form is invalid
     * @param {successCallback} sc - will be executed when the form is valid
     * @return {void}
     */

    OmiseValidator.prototype._observeForm = function(form, fc, sc) {
      if (fc == null) {
        fc = null;
      }
      if (sc == null) {
        sc = null;
      }
      return this.core.observeForm(form, fc, sc);
    };


    /*
     * Listen to field event
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {void}
     */

    OmiseValidator.prototype._observeField = function(field) {
      return this.core.observeField(field);
    };

    return OmiseValidator;

  })();

  window.OmiseValidation = {};

  window.OmiseValidator = OmiseValidator;

}).call(this);

(function() {
  var OmiseValidationResponse;

  OmiseValidationResponse = (function() {
    function OmiseValidationResponse() {}


    /*
     * Push a message to a field target
     * @param {object} elem - an target element
     * @param {string} msg - a message that want to publish
     * @return {void}
     */

    OmiseValidationResponse.prototype.pushMessage = function(elem, msg) {
      var _t;
      _t = elem.dataset.validationMsg;
      _t = document.getElementById(_t);
      return _t != null ? _t.innerHTML = msg : void 0;
    };


    /*
     * Take an action when field's validation is invalid
     * @param {object} elem - an element target
     * @param {string} msg - a message that want to publish
     * @return {void}
     */

    OmiseValidationResponse.prototype.invalid = function(elem, msg) {
      var _w;
      _w = document.getElementById(elem.dataset.wrapper);
      _w.className = _w.className.replace(/\ valid/, '');
      if (/ invalid/.test(_w.className) === false) {
        _w.className += " invalid";
      }
      return this.pushMessage(elem, msg);
    };


    /*
     * Take an action when field's validation is valid
     * @param {object} elem - an element target
     * @return {void}
     */

    OmiseValidationResponse.prototype.valid = function(elem) {
      var _w;
      _w = document.getElementById(elem.dataset.wrapper);
      _w.className = _w.className.replace(/\ invalid/, '');
      if (/ valid/.test(_w.className) === false) {
        _w.className += " valid";
      }
      return this.pushMessage(elem, '');
    };


    /*
     * Get a result and display it into a screen
     * @param {object} e - an key event object
     * @param {object} field - a field target
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @param {boolean|string} result - a result of a validate action
     * @return {void}
     */

    OmiseValidationResponse.prototype.result = function(e, field, result) {
      if (result !== true) {
        if (typeof field.callback === 'function') {
          return field.callback(e, field, result);
        } else if (result === false) {
          return false;
        } else {
          return this.invalid(field.selector, result);
        }
      } else {
        return this.valid(field.selector);
      }
    };

    return OmiseValidationResponse;

  })();

  window.OmiseValidation.response = OmiseValidationResponse;

}).call(this);

(function() {
  var OmiseValidationRule;

  OmiseValidationRule = (function() {
    function OmiseValidationRule() {}

    OmiseValidationRule.prototype.isEmpty = function(input) {
      return input.length <= 0;
    };

    OmiseValidationRule.prototype.isDigit = function(input) {
      return /^\d+$/.test(input);
    };

    OmiseValidationRule.prototype.isAlphabet = function(input) {
      return /^[a-z\.]+$/gi.test(input);
    };

    OmiseValidationRule.prototype.isExpiry = function(input) {
      return /^(0[1-9]|1[0-2]) \/ ([0-9]{2}|[0-9]{4})$/.test(input);
    };

    OmiseValidationRule.prototype.isExpiryYear = function(input) {
      return /^([0-9]{2}|[0-9]{4})$/.test(input);
    };

    OmiseValidationRule.prototype.isExpiryMonth = function(input) {
      return /^(0[1-9]|1[0-2])$/.test(input);
    };

    OmiseValidationRule.prototype.isCard = function(cardType, input) {
      var mastercard, visa;
      visa = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
      mastercard = /^(?:5[1-5][0-9]{14})$/;
      switch (cardType) {
        case 'visa':
          return visa.test(input);
        case 'mastercard':
          return mastercard.test(input);
        default:
          return false;
      }
    };

    return OmiseValidationRule;

  })();

  window.OmiseValidation.rules = OmiseValidationRule;

}).call(this);

(function() {
  var OmiseValidationMessage;

  OmiseValidationMessage = (function() {
    function OmiseValidationMessage() {
      this.messages = {
        emptyString: 'The value must not be an empty',
        alphabetOnly: 'The value must be a alphabet character only',
        digitOnly: 'The value must be a digit character only',
        nameEmpty: 'Name on card cannot be empty',
        nameAlphabet: 'Name on card must only contains letters',
        cardEmpty: 'Card number cannot be empty',
        cardFormat: 'Card number is invalid',
        cardNotMatch: 'Card number is invalid',
        expiryEmpty: 'Expiration cannot be empty',
        expiryFormat: 'Expiration is invalid',
        securitycodeMin: 'Code must be greater or equal to 3 characters',
        securitycodeMax: 'Code must be less or equal to 4 characters'
      };
    }


    /*
     * Get a response message
     * @param {string} code - a response message code
     * @return {string} a response message
     */

    OmiseValidationMessage.prototype.get = function(code) {
      return this.messages[code] || 'invalid';
    };

    return OmiseValidationMessage;

  })();

  window.OmiseValidation.messages = OmiseValidationMessage;

}).call(this);

(function() {
  var Validation;

  Validation = (function() {
    function Validation() {
      this.rule = new window.OmiseValidation.rules;
      this.helper = new window.OmiseValidation.helper;
      this.message = new window.OmiseValidation.messages;
      this.response = new window.OmiseValidation.response;
    }


    /*
     * Listen to form event
     * @callback failureCallback
     * @param {object} form - the form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @callback successCallback
     * @param {object} form - a form object
     * @param {object} form.form - a selector of the form target element
     * @param {object} form.fields - a field objects
     * @see more the property list of form.fields in '@validates' method
     *
     * @param {object} form - the form that be retrieved from @form variable
     * @param {object} form.form - a selector of form target element
     * @param {object} form.fields - a field objects
     * @param {failureCallback} fc - will be executed when the form is invalid
     * @param {successCallback} sc - will be executed when the form is valid
     * @return {void}
     */

    Validation.prototype.observeForm = function(form, fc, sc) {
      if (fc == null) {
        fc = null;
      }
      if (sc == null) {
        sc = null;
      }
      return form.form.addEventListener('submit', (function(_this) {
        return function(e) {
          var field, i, invalid, len, ref, result;
          e.preventDefault();
          invalid = false;
          ref = form.fields;
          for (i = 0, len = ref.length; i < len; i++) {
            field = ref[i];
            field.selector.dataset.dirty = true;
            if ((result = field.validates.validate(field.selector.value)) !== true) {
              invalid = true;
            }
            _this.response.result(e, field, result);
          }
          if (invalid === false) {
            if (typeof sc === 'function') {
              return sc(form);
            } else {
              return form.form.submit();
            }
          } else if (typeof fc === 'function') {
            return fc(form);
          }
        };
      })(this), false);
    };


    /*
     * Listen to field event
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {void}
     */

    Validation.prototype.observeField = function(field) {
      var base;
      if (typeof (base = field.validates).init === "function") {
        base.init(field, {
          '_validates': this.rule,
          '_helper': this.helper,
          '_message': this.message,
          '_response': this.response
        });
      }
      field.selector.onkeydown = (function(_this) {
        return function(e) {
          return _this._onkeydownEvent(e, field);
        };
      })(this);
      field.selector.onkeypress = (function(_this) {
        return function(e) {
          return _this._onkeypressEvent(e, field);
        };
      })(this);
      field.selector.onkeyup = (function(_this) {
        return function(e) {
          return _this._onkeyupEvent(e, field);
        };
      })(this);
      field.selector.onpaste = (function(_this) {
        return function(e) {
          return _this._onpasteEvent(e, field);
        };
      })(this);
      return field.selector.onblur = (function(_this) {
        return function(e) {
          return _this._onblurEvent(e, field);
        };
      })(this);
    };


    /*
     * Capture and handle on-key-down event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    Validation.prototype._onkeydownEvent = function(e, field) {
      var base;
      e = e || window.event;
      e.which = e.which || e.keyCode || 0;
      return typeof (base = field.validates).onkeydownEvent === "function" ? base.onkeydownEvent(e, field) : void 0;
    };


    /*
     * Capture and handle on-key-press event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    Validation.prototype._onkeypressEvent = function(e, field) {
      var base;
      e = e || window.event;
      e.which = e.which || e.keyCode || 0;
      return typeof (base = field.validates).onkeypressEvent === "function" ? base.onkeypressEvent(e, field) : void 0;
    };


    /*
     * Capture and handle on-key-up event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    Validation.prototype._onkeyupEvent = function(e, field) {
      var base;
      e = e || window.event;
      e.which = e.which || e.keyCode || 0;
      return typeof (base = field.validates).onkeyupEvent === "function" ? base.onkeyupEvent(e, field) : void 0;
    };


    /*
     * Capture and handle on-paste event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    Validation.prototype._onpasteEvent = function(e, field) {
      var base;
      e = e || window.event;
      e.which = e.which || e.keyCode || 0;
      return typeof (base = field.validates).onpasteEvent === "function" ? base.onpasteEvent(e, field) : void 0;
    };


    /*
     * Capture and handle on-blur event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    Validation.prototype._onblurEvent = function(e, field) {
      var base;
      e = e || window.event;
      e.which = e.which || e.keyCode || 0;
      return typeof (base = field.validates).onblurEvent === "function" ? base.onblurEvent(e, field) : void 0;
    };

    return Validation;

  })();

  window.OmiseValidation.validation = Validation;

}).call(this);

(function() {
  var Helper;

  Helper = (function() {
    function Helper() {}


    /*
     * Slice field's value starting from caret position
     * @param {object} elem - a selector object of an element
     * @param {int} length - number of string's length that need to slice
     * @return {void}
     */

    Helper.prototype.delValFromCaretPosition = function(elem, length) {
      var pos;
      if (length == null) {
        length = 1;
      }
      if ((pos = elem.selectionStart - length) >= 0) {
        elem.value = elem.value.slice(0, pos) + elem.value.slice(pos + length);
      } else {
        elem.value = "";
      }
      elem.focus();
      elem.setSelectionRange(pos, pos);
      return pos;
    };

    Helper.prototype.insertValAfterCaretPos = function(value, input, caret) {
      var _value;
      if (caret !== value.length) {
        _value = value.split('');
        _value.splice(caret, 0, input);
        _value = _value.join('');
        _value = _value.match(/\d/g);
        _value = _value.join('');
      } else {
        _value = "" + value + input;
      }
      return _value;
    };


    /*
     * Get caret position
     * @param {object} elem - a selector object of an element
     * @return {void}
     */

    Helper.prototype.getCaretPosition = function(elem) {
      return elem.selectionStart;
    };

    Helper.prototype.setCaretPosition = function(elem, pos) {
      elem.focus();
      return elem.setSelectionRange(pos, pos);
    };

    Helper.prototype.beDirty = function(elem) {
      return elem.dataset.dirty = true;
    };

    Helper.prototype.dirty = function(elem) {
      if (elem.dataset.dirty === "true") {
        return true;
      } else {
        return false;
      }
    };

    Helper.prototype.isMetaKey = function(e) {
      if (e.metaKey === false && e.ctrlKey === false && e.altKey === false && e.code !== "ShiftLeft" && e.code !== "ShiftRight" && e.keyIdentifier !== "Shift") {
        return false;
      }
      return true;
    };

    Helper.prototype.inputChar = function(e) {
      var char;
      if (e.keyIdentifier != null) {
        char = parseInt(e.keyIdentifier.substr(2), 16);
        char = String.fromCharCode(char);
      } else {
        char = e.key;
      }
      return char;
    };

    Helper.prototype.caretRange = function(elem) {
      var end, range, start;
      range = this.getCaretRange(elem);
      start = range.start;
      end = range.end;
      return elem.value.substring(start, end);
    };

    Helper.prototype.getCaretRange = function(elem) {
      var end, range, start;
      if (elem.createTextRange != null) {
        range = document.selection.createRange().duplicate();
        range.moveEnd('character', elem.value.length);
        if (range.text === '') {
          start = elem.value.length;
        } else {
          start = elem.value.lastIndexOf(start.text);
        }
        range.moveStart('character', -elem.value.length);
        end = range.text.length;
      } else {
        start = elem.selectionStart;
        end = elem.selectionEnd;
      }
      return {
        start: start,
        end: end
      };
    };

    return Helper;

  })();

  window.OmiseValidation.helper = Helper;

}).call(this);

(function() {
  var OmiseCcExpiryValidation,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  OmiseCcExpiryValidation = (function() {
    function OmiseCcExpiryValidation() {
      this.onblurEvent = bind(this.onblurEvent, this);
      this.onpasteEvent = bind(this.onpasteEvent, this);
      this.onkeyupEvent = bind(this.onkeyupEvent, this);
      this.onkeydownEvent = bind(this.onkeydownEvent, this);
      this.strLimit = 6;
      this.pattern = '## / ####';
      this.format = /^(0[1-9]|1[0-2]) \/ ([0-9]{2}|[0-9]{4})$/;
    }

    OmiseCcExpiryValidation.prototype.init = function(field, dep) {
      this.validates = dep._validates;
      this.helper = dep._helper;
      this.message = dep._message;
      return this.response = dep._response;
    };

    OmiseCcExpiryValidation.prototype._format = function(value, input, caret) {
      var _value;
      if (value == null) {
        value = "";
      }
      if (input == null) {
        input = "";
      }
      if (caret == null) {
        caret = null;
      }
      if (value.length === 0 && /^[2-9]+$/.test(input)) {
        _value = "0" + input;
      } else if (caret !== value.length) {
        _value = value.split('');
        _value.splice(caret, 0, input);
        _value = _value.join('');
        _value = _value.match(/\d/g);
        _value = _value.join('');
      } else {
        _value = "" + value + input;
      }
      return this._reFormat(_value);
    };

    OmiseCcExpiryValidation.prototype._reFormat = function(value) {
      var _pos, _value, char, i, j, len, ref;
      if (value == null) {
        value = "";
      }
      if (value.length === 0) {
        return value;
      }
      value = value.match(/\d/g);
      value = value != null ? value.join("" || "") : void 0;
      _value = "";
      _pos = 0;
      ref = this.pattern;
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        char = ref[i];
        if (char === "#") {
          if (_pos < value.length) {
            _value += value[_pos];
            _pos += 1;
          } else {
            break;
          }
        } else {
          _value += char;
        }
      }
      return _value;
    };

    OmiseCcExpiryValidation.prototype._reFormatExpiryPattern = function(value, e) {
      var _c, _pos, _value, caret, char, i, j, len, ref;
      if (value == null) {
        value = "";
      }
      if (value.length === 0) {
        return value;
      }
      value = value.match(/\d/g);
      value = value != null ? value.join("" || "") : void 0;
      _value = "";
      _pos = 0;
      _c = 0;
      ref = this.pattern;
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        char = ref[i];
        _c += 1;
        if (char === "#") {
          if (_pos < value.length) {
            _value += value[_pos];
            _pos += 1;
          } else {
            break;
          }
        } else {
          _value += char;
        }
      }
      caret = e.target.selectionStart;
      e.target.value = _value;
      this.helper.setCaretPosition(e.target, caret + (_value.length - caret));
      return _value;
    };


    /*
     * Validate an input
     * @param {string} value - a value that retrieve from typing
     * @param {string} [fieldValue=null] - a current field's value
     * @return {string|boolean}
     */

    OmiseCcExpiryValidation.prototype.validate = function(value, fieldValue) {
      if (fieldValue == null) {
        fieldValue = null;
      }
      if (this.validates.isEmpty(value)) {
        return this.message.get('expiryEmpty');
      }
      if (!this.validates.isExpiry(value)) {
        return this.message.get('expiryFormat');
      }
      return true;
    };


    /*
     * Prevent the field from a word that will be invalid
     * @param {string} input - a value that retrieve from typing
     * @param {string} value - a current field's value
     * @return {boolean}
     */

    OmiseCcExpiryValidation.prototype._preventCharacter = function(input, value) {
      input = input.replace(/\ \/\ /g, '');
      if (!this.validates.isDigit(input)) {
        return false;
      }
      if (input.length > this.strLimit) {
        return false;
      }
      return true;
    };


    /*
     * Prevent the field from a word that will be invalid
     * @param {string} input - a value that retrieve from typing
     * @param {string} value - a current field's value
     * @param {object} e - an key event object
     * @return {boolean}
     */

    OmiseCcExpiryValidation.prototype._preventInput = function(input, value, e) {
      var caret, p1, p2, range;
      if (!this.validates.isDigit(input)) {
        return false;
      }
      caret = e.target.selectionStart;
      if ((range = this.helper.caretRange(e.target)) !== "") {
        p1 = value.slice(0, caret);
        p2 = value.slice(caret + range.length);
        value = p1 + input + p2;
      } else {
        value = this.helper.insertValAfterCaretPos(value, input, caret);
      }
      value = value.match(/\d/g);
      value = value != null ? value.join("" || "") : void 0;
      if (value.length > this.strLimit) {
        return false;
      }
      return value;
    };


    /*
     * Capture and handle on-key-down event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryValidation.prototype.onkeydownEvent = function(e, field) {
      var beDeleted, caret, input, pos, ref, value;
      if ((this.helper.isMetaKey(e)) === false) {
        if ((ref = e.which) === null || ref === 0 || ref === 9 || ref === 13 || ref === 20 || ref === 27 || ref === 37 || ref === 38 || ref === 39 || ref === 40) {
          return true;
        }
        if (e.which === 8) {
          e.preventDefault();
          if ((pos = this.helper.getCaretPosition(e.target)) !== 0) {
            beDeleted = e.target.value[pos - 1];
            switch (pos - 1) {
              case 4:
              case 3:
              case 2:
                pos = this.helper.delValFromCaretPosition(e.target, pos - 1);
                break;
              default:
                pos = this.helper.delValFromCaretPosition(e.target);
            }
            e.target.value = this._reFormat(e.target.value);
            this.helper.setCaretPosition(e.target, pos);
          }
          if (this.helper.dirty(e.target) === "true") {
            return this.response.result(e, field, this.validate(e.target.value));
          }
        } else {
          input = this.helper.inputChar(e);
          value = e.target.value;
          caret = e.target.selectionStart;
          if (value.length === 0 && /^[2-9]+$/.test(input)) {
            input = "0" + input;
            caret += 2;
          } else if (caret === 1) {
            caret += 1;
          }
          if (!(value = this._preventInput(input, value, e))) {
            return false;
          }
          e.preventDefault();
          this._reFormatExpiryPattern(value, e);
          if (this.helper.dirty(e.target)) {
            return this.response.result(e, field, this.validate(e.target.value));
          }
        }
      }
    };


    /*
     * Capture and handle on-key-up event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryValidation.prototype.onkeyupEvent = function(e, field) {
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };


    /*
     * Capture and handle on-paste event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryValidation.prototype.onpasteEvent = function(e, field) {
      var input, value;
      input = e.clipboardData.getData('text/plain');
      value = e.target.value;
      if (!(value = this._preventInput(input, value, e))) {
        return false;
      }
      e.preventDefault();
      this._reFormatExpiryPattern(value, e);
      return this.helper.beDirty(e.target);
    };


    /*
     * Capture and handle on-blur event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryValidation.prototype.onblurEvent = function(e, field) {
      if (e.target.value.length > 0) {
        this.helper.beDirty(e.target);
      }
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };

    return OmiseCcExpiryValidation;

  })();

  window.OmiseValidation.ccexpiry = OmiseCcExpiryValidation;

}).call(this);

(function() {
  var OmiseCcExpiryMonthValidation,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  OmiseCcExpiryMonthValidation = (function() {
    function OmiseCcExpiryMonthValidation() {
      this.onblurEvent = bind(this.onblurEvent, this);
      this.onpasteEvent = bind(this.onpasteEvent, this);
      this.onkeyupEvent = bind(this.onkeyupEvent, this);
      this.onkeydownEvent = bind(this.onkeydownEvent, this);
      this.strLimit = 2;
    }

    OmiseCcExpiryMonthValidation.prototype.init = function(field, dep) {
      this.validates = dep._validates;
      this.helper = dep._helper;
      this.message = dep._message;
      return this.response = dep._response;
    };


    /*
     * Validate an input
     * @param {string} value - a value that retrieve from typing
     * @param {string} [fieldValue=null] - a current field's value
     * @return {string|boolean}
     */

    OmiseCcExpiryMonthValidation.prototype.validate = function(value, fieldValue) {
      if (fieldValue == null) {
        fieldValue = null;
      }
      if (this.validates.isEmpty(value)) {
        return this.message.get('expiryEmpty');
      }
      if (!this.validates.isDigit(value)) {
        return this.message.get('digitOnly');
      }
      if (!this.validates.isExpiryMonth(value)) {
        return this.message.get('expiryFormat');
      }
      return true;
    };


    /*
     * Prevent the field from a word that will be invalid
     * @param {string} input - a value that retrieve from typing
     * @param {string} value - a current field's value
     * @param {object} e - an key event object
     * @return {boolean}
     */

    OmiseCcExpiryMonthValidation.prototype._preventInput = function(input, value, e) {
      var caret, p1, p2, range;
      if (!this.validates.isDigit(input)) {
        return false;
      }
      caret = e.target.selectionStart;
      if ((range = this.helper.caretRange(e.target)) !== "") {
        p1 = value.slice(0, caret);
        p2 = value.slice(caret + range.length);
        value = p1 + input + p2;
      } else {
        value = this.helper.insertValAfterCaretPos(value, input, caret);
      }
      if (value.length > this.strLimit) {
        return false;
      }
      return value;
    };


    /*
     * Capture and handle on-key-down event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryMonthValidation.prototype.onkeydownEvent = function(e, field) {
      var input, ref, value;
      if ((this.helper.isMetaKey(e)) === false) {
        if ((ref = e.which) === null || ref === 0 || ref === 9 || ref === 13 || ref === 20 || ref === 27 || ref === 37 || ref === 38 || ref === 39 || ref === 40) {
          return true;
        }
        if (e.which !== 8) {
          input = this.helper.inputChar(e);
          value = e.target.value;
          if (!this._preventInput(input, value, e)) {
            return false;
          }
          if (value.length === 0 && /^[2-9]+$/.test(input)) {
            e.preventDefault();
            value = "0" + input;
            return e.target.value = value;
          }
        }
      }
    };


    /*
     * Capture and handle on-key-up event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryMonthValidation.prototype.onkeyupEvent = function(e, field) {
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };


    /*
     * Capture and handle on-paste event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryMonthValidation.prototype.onpasteEvent = function(e, field) {
      var input, value;
      input = e.clipboardData.getData('text/plain');
      value = e.target.value;
      if (!(value = this._preventInput(input, value, e))) {
        return false;
      }
      this.helper.beDirty(e.target);
      return this.response.result(e, field, this.validate(value));
    };


    /*
     * Capture and handle on-blur event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryMonthValidation.prototype.onblurEvent = function(e, field) {
      if (e.target.value.length > 0) {
        this.helper.beDirty(e.target);
      }
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };

    return OmiseCcExpiryMonthValidation;

  })();

  window.OmiseValidation.ccexpirymonth = OmiseCcExpiryMonthValidation;

}).call(this);

(function() {
  var OmiseCcExpiryYearValidation,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  OmiseCcExpiryYearValidation = (function() {
    function OmiseCcExpiryYearValidation() {
      this.onblurEvent = bind(this.onblurEvent, this);
      this.onpasteEvent = bind(this.onpasteEvent, this);
      this.onkeyupEvent = bind(this.onkeyupEvent, this);
      this.onkeydownEvent = bind(this.onkeydownEvent, this);
      this.strLimit = 4;
    }

    OmiseCcExpiryYearValidation.prototype.init = function(field, dep) {
      this.validates = dep._validates;
      this.helper = dep._helper;
      this.message = dep._message;
      return this.response = dep._response;
    };


    /*
     * Validate an input
     * @param {string} value - a value that retrieve from typing
     * @param {string} [fieldValue=null] - a current field's value
     * @return {string|boolean}
     */

    OmiseCcExpiryYearValidation.prototype.validate = function(value, fieldValue) {
      if (fieldValue == null) {
        fieldValue = null;
      }
      if (this.validates.isEmpty(value)) {
        return this.message.get('expiryEmpty');
      }
      if (!this.validates.isDigit(value)) {
        return this.message.get('digitOnly');
      }
      if (!this.validates.isExpiryYear(value)) {
        return this.message.get('expiryFormat');
      }
      return true;
    };


    /*
     * Prevent the field from a word that will be invalid
     * @param {string} input - a value that retrieve from typing
     * @param {string} value - a current field's value
     * @param {object} e - an key event object
     * @return {boolean}
     */

    OmiseCcExpiryYearValidation.prototype._preventInput = function(input, value, e) {
      var caret, p1, p2, range;
      if (!this.validates.isDigit(input)) {
        return false;
      }
      caret = e.target.selectionStart;
      if ((range = this.helper.caretRange(e.target)) !== "") {
        p1 = value.slice(0, caret);
        p2 = value.slice(caret + range.length);
        value = p1 + input + p2;
      } else {
        value = this.helper.insertValAfterCaretPos(value, input, caret);
      }
      if (value.length > this.strLimit) {
        return false;
      }
      return value;
    };


    /*
     * Capture and handle on-key-down event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryYearValidation.prototype.onkeydownEvent = function(e, field) {
      var input, ref, value;
      if ((this.helper.isMetaKey(e)) === false) {
        if ((ref = e.which) === null || ref === 0 || ref === 9 || ref === 13 || ref === 20 || ref === 27 || ref === 37 || ref === 38 || ref === 39 || ref === 40) {
          return true;
        }
        if (e.which !== 8) {
          input = this.helper.inputChar(e);
          value = e.target.value;
          if (!this._preventInput(input, value, e)) {
            return false;
          }
        }
      }
    };


    /*
     * Capture and handle on-key-up event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryYearValidation.prototype.onkeyupEvent = function(e, field) {
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };


    /*
     * Capture and handle on-paste event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryYearValidation.prototype.onpasteEvent = function(e, field) {
      var input, value;
      input = e.clipboardData.getData('text/plain');
      value = e.target.value;
      if (!(value = this._preventInput(input, value, e))) {
        return false;
      }
      this.helper.beDirty(e.target);
      return this.response.result(e, field, this.validate(value));
    };


    /*
     * Capture and handle on-blur event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcExpiryYearValidation.prototype.onblurEvent = function(e, field) {
      if (e.target.value.length > 0) {
        this.helper.beDirty(e.target);
      }
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };

    return OmiseCcExpiryYearValidation;

  })();

  window.OmiseValidation.ccexpiryyear = OmiseCcExpiryYearValidation;

}).call(this);

(function() {
  var OmiseCcNameValidation,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  OmiseCcNameValidation = (function() {
    function OmiseCcNameValidation() {
      this.onblurEvent = bind(this.onblurEvent, this);
      this.onpasteEvent = bind(this.onpasteEvent, this);
      this.onkeyupEvent = bind(this.onkeyupEvent, this);
      this.onkeydownEvent = bind(this.onkeydownEvent, this);
    }

    OmiseCcNameValidation.prototype.init = function(field, dep) {
      this.validates = dep._validates;
      this.helper = dep._helper;
      this.message = dep._message;
      return this.response = dep._response;
    };


    /*
     * Validate an input
     * @param {string} value - a value that retrieve from typing
     * @param {string} [fieldValue=null] - a current field's value
     * @return {string|boolean}
     */

    OmiseCcNameValidation.prototype.validate = function(value, fieldValue) {
      if (fieldValue == null) {
        fieldValue = null;
      }
      value = value.replace(/\s/g, '');
      if (this.validates.isEmpty(value)) {
        return this.message.get('nameEmpty');
      }
      if (!this.validates.isAlphabet(value)) {
        return this.message.get('nameAlphabet');
      }
      return true;
    };


    /*
     * Capture and handle on-key-down event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcNameValidation.prototype.onkeydownEvent = function(e, field) {
      var ref;
      if ((this.helper.isMetaKey(e)) === false) {
        if ((ref = e.which) === null || ref === 0 || ref === 9 || ref === 20 || ref === 27 || ref === 37 || ref === 38 || ref === 39 || ref === 40) {
          return true;
        }
        if (e.which !== 8) {
          return this.helper.beDirty(e.target);
        }
      }
    };


    /*
     * Capture and handle on-key-up event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcNameValidation.prototype.onkeyupEvent = function(e, field) {
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };


    /*
     * Capture and handle on-paste event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcNameValidation.prototype.onpasteEvent = function(e, field) {
      var input, value;
      input = e.clipboardData.getData('text/plain');
      value = e.target.value;
      this.helper.beDirty(e.target);
      return this.response.result(e, field, this.validate(value + input));
    };


    /*
     * Capture and handle on-blur event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcNameValidation.prototype.onblurEvent = function(e, field) {
      if (e.target.value.length > 0) {
        this.helper.beDirty(e.target);
      }
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };

    return OmiseCcNameValidation;

  })();

  window.OmiseValidation.ccname = OmiseCcNameValidation;

}).call(this);

(function() {
  var OmiseCcNumberValidation,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  OmiseCcNumberValidation = (function() {
    function OmiseCcNumberValidation() {
      this.onblurEvent = bind(this.onblurEvent, this);
      this.onpasteEvent = bind(this.onpasteEvent, this);
      this.onkeyupEvent = bind(this.onkeyupEvent, this);
      this.onkeydownEvent = bind(this.onkeydownEvent, this);
      this.init = bind(this.init, this);
      this.cards = [
        {
          type: 'mastercard',
          pattern: /^5[1-5]/,
          format: '#### #### #### ####',
          length: [16],
          icon: 'http://cdn.omise.co/validator/images/icon-mastercard.png',
          validate: /(?:^|\s)(\d{4})$/
        }, {
          type: 'visa',
          pattern: /^4/,
          format: '#### #### #### ####',
          length: [13, 16],
          icon: 'http://cdn.omise.co/validator/images/icon-visa.png',
          validate: /(?:^|\s)(\d{4})$/
        }
      ];
      this.cardUnknow = {
        type: 'unknow',
        format: '#### #### #### ####',
        length: [16]
      };
    }


    /*
     * Initiate the validation event
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {void}
     */

    OmiseCcNumberValidation.prototype.init = function(field, dep) {
      this.validates = dep._validates;
      this.helper = dep._helper;
      this.message = dep._message;
      this.response = dep._response;
      return this._appendCcIcon(field.selector);
    };


    /*
     * Create a credit card icon's element
     * @param {object} elem - a selector object of an element
     * @return {void}
     */

    OmiseCcNumberValidation.prototype._appendCcIcon = function(elem) {
      var card, e, i, j, len, parent, ref, results, wrapper;
      parent = elem.parentNode;
      wrapper = document.createElement('span');
      wrapper.id = "omise_card_brand_supported";
      parent.appendChild(wrapper);
      ref = this.cards;
      results = [];
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        card = ref[i];
        e = document.createElement('img');
        e.src = card.icon;
        e.className = "omise_ccnumber_card omise_ccnumber_" + card.type;
        results.push(wrapper.appendChild(e));
      }
      return results;
    };


    /*
     * Show a valid credit card logo
     * @param {object} elem - an target element
     * @param {object} cardTarget - one of cardAcceptance object
     * @return {void}
     */

    OmiseCcNumberValidation.prototype._show = function(elem, cardTarget) {
      var className, target;
      this._hide(elem);
      className = "omise_ccnumber_" + cardTarget.type;
      target = elem.parentNode.getElementsByClassName(className);
      if (target.length !== 0) {
        target = target[0];
        return target.className = target.className + " match";
      }
    };


    /*
     * Hide all of credit card icons
     * @param {object} elem - an target element
     * @return {void}
     */

    OmiseCcNumberValidation.prototype._hide = function(elem) {
      var card, cards, j, len, results;
      cards = elem.parentNode.getElementsByClassName("omise_ccnumber_card");
      results = [];
      for (j = 0, len = cards.length; j < len; j++) {
        card = cards[j];
        results.push(card.className = card.className.replace(/\ match/gi, ""));
      }
      return results;
    };


    /*
     * Validate input card pattern
     * @param {string} num   - An input card number
     * @return {array}
     */

    OmiseCcNumberValidation.prototype._validateCardPattern = function(num) {
      var _card, j, len, ref;
      num = (num + '').replace(/\D/g, '');
      ref = this.cards;
      for (j = 0, len = ref.length; j < len; j++) {
        _card = ref[j];
        if (_card.pattern.test(num) === true) {
          return _card;
        }
      }
    };


    /*
     * Validate input card pattern
     * @param {string} num   - An input card number
     * @return {string} formatted value
     */

    OmiseCcNumberValidation.prototype._reFormatCardPattern = function(value, card) {
      var char, i, j, len, p, ref, v;
      if (value == null) {
        value = "";
      }
      if (value.length === 0) {
        return value;
      }
      value = value.match(/\d/g);
      value = value != null ? value.join("" || "") : void 0;
      v = "";
      p = 0;
      ref = card.format;
      for (i = j = 0, len = ref.length; j < len; i = ++j) {
        char = ref[i];
        if (char === "#") {
          if (p < value.length) {
            v += value[p];
            p += 1;
          } else {
            break;
          }
        } else {
          v += char;
        }
      }
      return v;
    };


    /*
     * Validate an input
     * @param {string} value - a value that coming from typing
     * @param {string} fieldValue - a current field's value
     * @return {string|boolean}
     */

    OmiseCcNumberValidation.prototype.validate = function(value, fieldValue) {
      var c;
      if (fieldValue == null) {
        fieldValue = "";
      }
      value = (value + '').replace(/\D/g, '');
      if (this.validates.isEmpty(value)) {
        return this.message.get('cardEmpty');
      }
      c = this._validateCardPattern(value);
      if (c == null) {
        return this.message.get('cardNotMatch');
      }
      if (!this.validates.isCard(c.type, value)) {
        return this.message.get('cardFormat');
      }
      return true;
    };


    /*
     * Prevent the field from a word that will be invalid
     * @param {string} input - a value that retrieve from typing
     * @param {string} value - a current field's value
     * @param {object} e - an key event object
     * @return {boolean}
     */

    OmiseCcNumberValidation.prototype._preventInput = function(input, value, e) {
      input = (input + '').replace(/\s/g, '');
      if (!this.validates.isDigit(input)) {
        return false;
      }
      return true;
    };


    /*
     * Capture and handle on-key-down event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcNumberValidation.prototype.onkeydownEvent = function(e, field) {
      var _value, c, card, input, p1, p2, pos, range, ref, v, value;
      if ((this.helper.isMetaKey(e)) === false) {
        if ((ref = e.which) === null || ref === 0 || ref === 9 || ref === 13 || ref === 20 || ref === 27 || ref === 37 || ref === 38 || ref === 39 || ref === 40) {
          return true;
        }
        if (e.which === 8) {
          if ((range = this.helper.caretRange(e.target)) !== "") {
            pos = e.target.selectionStart;
            p1 = e.target.value.slice(0, pos);
            p2 = e.target.value.slice(pos + range.length);
            _value = p1 + p2;
            e.target.value = _value;
          } else if ((pos = this.helper.getCaretPosition(e.target)) !== 0) {
            if (/\s/.test(e.target.value[pos - 1])) {
              pos = this.helper.delValFromCaretPosition(e.target, 2);
            } else {
              pos = this.helper.delValFromCaretPosition(e.target);
            }
          }
          card = this._validateCardPattern(e.target.value) || this.cardUnknow;
          if (card.type === 'unknow') {
            this._hide(e.target);
          } else {
            this._show(e.target, card);
          }
          e.preventDefault();
          e.target.value = this._reFormatCardPattern(e.target.value, card);
          this.helper.setCaretPosition(e.target, pos);
        } else {
          input = this.helper.inputChar(e);
          value = e.target.value;
          if (!this._preventInput(input, value, e)) {
            return false;
          }
          if ((range = this.helper.caretRange(e.target)) !== "") {
            if (range.length === value.length) {
              return true;
            }
          }
          c = e.target.selectionStart;
          v = this.helper.insertValAfterCaretPos(value, input, c);
          v = (v + '').replace(/\D/g, '');
          card = this._validateCardPattern(v) || this.cardUnknow;
          if (card.type === 'unknow') {
            this._hide(e.target);
          } else {
            this._show(e.target, card);
          }
          if (v.length > card.length[card.length.length - 1]) {
            return false;
          }
          v = this._reFormatCardPattern(v, card);
          e.preventDefault();
          e.target.value = v;
          c += 1;
          if ((v.charAt(c)) === ' ') {
            c += 1;
          } else if ((v.charAt(c - 1)) === ' ') {
            c += 1;
          }
          this.helper.setCaretPosition(e.target, c);
        }
        if (this.helper.dirty(e.target)) {
          return this.response.result(e, field, this.validate(e.target.value));
        }
      }
    };


    /*
     * Capture and handle on-key-up event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcNumberValidation.prototype.onkeyupEvent = function(e, field) {
      var card, v;
      v = (e.target.value + '').replace(/\D/g, '');
      card = this._validateCardPattern(v) || this.cardUnknow;
      if (card.type === 'unknow') {
        this._hide(e.target);
      } else {
        this._show(e.target, card);
      }
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };


    /*
     * Capture and handle on-paste event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcNumberValidation.prototype.onpasteEvent = function(e, field) {
      var c, card, input, p1, p2, range, v, value;
      input = e.clipboardData.getData('text/plain');
      value = e.target.value;
      if (!this._preventInput(input, value, e)) {
        return false;
      }
      range = this.helper.getCaretRange(e.target);
      if (range.start === range.end) {
        c = e.target.selectionStart;
        v = this.helper.insertValAfterCaretPos(value, input, c);
        v = (v + '').replace(/\D/g, '');
      } else {
        c = e.target.selectionStart;
        if (range.start === 0 && range.end === value.length) {
          c = range.start;
          v = input;
          value = '';
        } else {
          p1 = e.target.value.slice(0, range.start);
          p2 = e.target.value.slice(range.end);
          v = p1 + input + p2;
          value = p1 + p2;
        }
      }
      v = (v + '').replace(/\D/g, '');
      card = this._validateCardPattern(v) || this.cardUnknow;
      if (card.type === 'unknow') {
        this._hide(e.target);
      } else {
        this._show(e.target, card);
      }
      if (v.length > card.length[card.length.length - 1]) {
        return false;
      }
      v = this._reFormatCardPattern(v, card);
      c = c + (Math.abs(v.length - value.length));
      if (/ $/.test(value)) {
        c += 1;
      }
      e.preventDefault();
      e.target.value = v;
      this.helper.setCaretPosition(e.target, c);
      this.helper.beDirty(e.target);
      return this.response.result(e, field, this.validate(value + input));
    };


    /*
     * Capture and handle on-blur event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @return {boolean}
     */

    OmiseCcNumberValidation.prototype.onblurEvent = function(e, field) {
      if (e.target.value.length > 0) {
        this.helper.beDirty(e.target);
      }
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };

    return OmiseCcNumberValidation;

  })();

  window.OmiseValidation.ccnumber = OmiseCcNumberValidation;

}).call(this);

(function() {
  var OmiseCcSecurityCodeValidation,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  OmiseCcSecurityCodeValidation = (function() {
    function OmiseCcSecurityCodeValidation() {
      this.onblurEvent = bind(this.onblurEvent, this);
      this.onpasteEvent = bind(this.onpasteEvent, this);
      this.onkeyupEvent = bind(this.onkeyupEvent, this);
      this.onkeydownEvent = bind(this.onkeydownEvent, this);
      this.strMin = 3;
      this.strLimit = 4;
    }

    OmiseCcSecurityCodeValidation.prototype.init = function(field, dep) {
      this.validates = dep._validates;
      this.helper = dep._helper;
      this.message = dep._message;
      return this.response = dep._response;
    };


    /*
     * Validate an input
     * @param {string} value - a value that retrieve from typing
     * @param {string} [fieldValue=null] - a current field's value
     * @return {string|boolean}
     */

    OmiseCcSecurityCodeValidation.prototype.validate = function(value, fieldValue) {
      if (fieldValue == null) {
        fieldValue = null;
      }
      if (this.validates.isEmpty(value)) {
        return this.message.get('emptyString');
      }
      if (!this.validates.isDigit(value)) {
        return this.message.get('digitOnly');
      }
      if (value.length < this.strMin) {
        return this.message.get('securitycodeMin');
      }
      if (value.length > this.strLimit) {
        return this.message.get('securitycodeMax');
      }
      return true;
    };


    /*
     * Prevent the field from a word that will be invalid
     * @param {string} input - a value that retrieve from typing
     * @param {string} value - a current field's value
     * @param {object} e - an key event object
     * @return {boolean}
     */

    OmiseCcSecurityCodeValidation.prototype._preventInput = function(input, value, e) {
      var caret, p1, p2, range;
      if (!this.validates.isDigit(input)) {
        return false;
      }
      caret = e.target.selectionStart;
      if ((range = this.helper.caretRange(e.target)) !== "") {
        p1 = value.slice(0, caret);
        p2 = value.slice(caret + range.length);
        value = p1 + input + p2;
      } else {
        value = this.helper.insertValAfterCaretPos(value, input, caret);
      }
      if (value.length > this.strLimit) {
        return false;
      }
      return value;
    };


    /*
     * Capture and handle on-key-down event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @param {object} response - the response handler class
     * @return {boolean}
     */

    OmiseCcSecurityCodeValidation.prototype.onkeydownEvent = function(e, field) {
      var input, ref, value;
      if ((this.helper.isMetaKey(e)) === false) {
        if ((ref = e.which) === null || ref === 0 || ref === 9 || ref === 13 || ref === 20 || ref === 27 || ref === 37 || ref === 38 || ref === 39 || ref === 40) {
          return true;
        }
        if (e.which !== 8) {
          input = this.helper.inputChar(e);
          value = e.target.value;
          if (!this._preventInput(input, value, e)) {
            return false;
          }
        }
      }
    };


    /*
     * Capture and handle on-key-up event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @param {object} response - the response handler class
     * @return {boolean}
     */

    OmiseCcSecurityCodeValidation.prototype.onkeyupEvent = function(e, field) {
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };


    /*
     * Capture and handle on-paste event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @param {object} response - the response handler class
     * @return {boolean}
     */

    OmiseCcSecurityCodeValidation.prototype.onpasteEvent = function(e, field) {
      var input, value;
      input = e.clipboardData.getData('text/plain');
      value = e.target.value;
      if (!(value = this._preventInput(input, value, e))) {
        return false;
      }
      return this.helper.beDirty(e.target);
    };


    /*
     * Capture and handle on-blur event
     * @param {object} e - an key event object
     * @param {object} field - the field that be retrieved from @form variable
     * @param {string} field.target - a field name (might be a id or class name)
     * @param {object} field.validates - a validation class
     * @param {object} field.selector - a selector of a target field
     * @param {object} field.callback - a callback function
     * @param {object} response - the response handler class
     * @return {boolean}
     */

    OmiseCcSecurityCodeValidation.prototype.onblurEvent = function(e, field) {
      if (e.target.value.length > 0) {
        this.helper.beDirty(e.target);
      }
      if (this.helper.dirty(e.target)) {
        return this.response.result(e, field, this.validate(e.target.value));
      }
    };

    return OmiseCcSecurityCodeValidation;

  })();

  window.OmiseValidation.ccsecuritycode = OmiseCcSecurityCodeValidation;

}).call(this);
