(function() {
  var OmiseValidator;

  OmiseValidator = (function() {
    function OmiseValidator(params1) {
      this.params = params1 != null ? params1 : {};
      this.ccNameValidation = new window.OmiseValidation.ccname(this);
      this.ccNumberValidation = new window.OmiseValidation.ccnumber(this);
      this.ccExpiryValidation = new window.OmiseValidation.ccexpiry(this);
      this.ccSecureValidation = new window.OmiseValidation.ccsecure(this);
      delete window.OmiseValidation;
      this.selectors = {};
      this.input = {
        name: "",
        number: "",
        expiry: "",
        secure: ""
      };
      this._initFormSelectors();
      this._attachEvents();
    }


    /*
     * Initiate default style sheet
     */

    OmiseValidator.prototype._initCcStyle = (function() {
      var _elem, _lastElem;
      _elem = document.createElement('link');
      _elem.rel = 'stylesheet';
      _elem.href = '../../assets/styles/omise-validation.css';
      _lastElem = document.documentElement;
      while (_lastElem.childNodes.length && _lastElem.lastChild.nodeType === 1) {
        _lastElem = _lastElem.lastChild;
      }
      return _lastElem.parentNode.appendChild(_elem);
    })();


    /*
     * Initiate selectors
     */

    OmiseValidator.prototype._initFormSelectors = function(params) {
      if (params == null) {
        params = {};
      }
      return this.selectors = {
        elemName: document.getElementById('omise_card_name'),
        elemNumber: document.getElementById('omise_card_number'),
        elemExpiry: document.getElementById('omise_card_expiration'),
        elemSecure: document.getElementById('omise_card_security')
      };
    };


    /*
     * Attach envents to selectors
     */

    OmiseValidator.prototype._attachEvents = function() {
      if (this.selectors.elemName != null) {
        this.ccNameValidation.init(this.selectors.elemName);
      }
      if (this.selectors.elemNumber != null) {
        this.ccNumberValidation.init(this.selectors.elemNumber);
      }
      if (this.selectors.elemExpiry != null) {
        this.ccExpiryValidation.init(this.selectors.elemExpiry);
      }
      if (this.selectors.elemSecure != null) {
        return this.ccSecureValidation.init(this.selectors.elemSecure);
      }
    };

    return OmiseValidator;

  })();

  window.OmiseValidation = {};

  window.OmiseValidator = OmiseValidator;

}).call(this);

(function() {
  var OmiseCcExpiryValidation;

  OmiseCcExpiryValidation = (function() {
    function OmiseCcExpiryValidation() {
      this.charMax = 6;
      this.strPattern = [null, null, '#', '#', '#', null, null, null, null];
    }


    /*
     * Initiate card expiry field
     */

    OmiseCcExpiryValidation.prototype.init = function(elem) {
      return elem.onkeypress = (function(_this) {
        return function(e) {
          var inp, ref;
          e = e || window.event;
          inp = String.fromCharCode(e.which);
          if ((ref = e.which) === null || ref === 0 || ref === 9 || ref === 27) {
            return true;
          }
          if (e.which === 8) {

          } else {
            inp = String.fromCharCode(e.which);
            if (!/^\d+$/.test(inp)) {
              return false;
            }
            if ((e.target.value.replace(/\D/g, '')).length >= _this.charMax) {
              return false;
            }
            if (e.target.value.length === 0 && /^[2-9]+$/.test(inp)) {
              e.preventDefault();
              e.target.value = 0 + inp + " / ";
              _this.strPattern[0] = "0";
              _this.strPattern[1] = inp;
            } else if ((e.target.value.replace(/\D/g, '') + inp).length === 2) {
              e.preventDefault();
              e.target.value = e.target.value + inp + " / ";
            } else {
              _this.strPattern[e.target.selectionStart] = inp;
            }
          }
          return console.log(_this.strPattern);
        };
      })(this);
    };

    return OmiseCcExpiryValidation;

  })();

  window.OmiseValidation.ccexpiry = OmiseCcExpiryValidation;

}).call(this);

(function() {
  var OmiseCcNameValidation;

  OmiseCcNameValidation = (function() {
    function OmiseCcNameValidation() {}


    /*
     * Initiate card name field
     */

    OmiseCcNameValidation.prototype.init = function(elem) {
      return elem.onkeypress = (function(_this) {
        return function(e) {
          var inp, ref;
          e = e || window.event;
          if ((ref = e.which) === null || ref === 0 || ref === 8 || ref === 9 || ref === 27 || ref === 32) {
            return true;
          }
          inp = String.fromCharCode(e.which);
          if (!/^[a-z]+$/gi.test(inp)) {
            return false;
          }
        };
      })(this);
    };

    return OmiseCcNameValidation;

  })();

  window.OmiseValidation.ccname = OmiseCcNameValidation;

}).call(this);

(function() {
  var OmiseCcNumberValidation;

  OmiseCcNumberValidation = (function() {
    function OmiseCcNumberValidation() {
      this.cardAcceptance = [
        {
          type: 'mastercard',
          pattern: /^5[1-5]/,
          format: /(\d{14})/g,
          length: [16],
          cvcLength: [3],
          logo: null
        }, {
          type: 'visa',
          pattern: /^4/,
          format: /(\d{14})/g,
          length: [13, 14, 15, 16],
          cvcLength: [3],
          logo: null
        }
      ];
      this.cardIcons = {
        visa: null,
        mastercard: null
      };
    }


    /*
     * Initiate card number field
     */

    OmiseCcNumberValidation.prototype.init = function(elem) {
      this._appendCcIcon(elem);
      return elem.onkeypress = (function(_this) {
        return function(e) {
          var card, cardLength, inp, inputLength, inputPattern, pointer, ref;
          e = e || window.event;
          if ((ref = e.which) === null || ref === 0 || ref === 9 || ref === 27) {
            return true;
          }
          if (e.which === 8) {
            pointer = e.target.selectionStart - 1;
            if (pointer >= 0) {
              card = _this._validateCardPattern(e.target.value.slice(0, pointer) + e.target.value.slice(pointer + 1));
            } else {
              card = _this._validateCardPattern(e.target.value);
            }
          } else {
            inp = String.fromCharCode(e.which);
            if (!/^\d+$/.test(inp)) {
              return false;
            }
            card = _this._validateCardPattern(e.target.value + inp);
            cardLength = card ? card.length[card.length.length - 1] : 16;
            inputLength = (e.target.value.replace(/\D/g, '') + inp).length;
            if (inputLength > cardLength) {
              return false;
            }
            if ((e.target.selectionStart != null) && e.target.selectionStart !== e.target.value.length) {
              return false;
            }
            inputPattern = /(?:^|\s)(\d{4})$/;
            if (inputPattern.test(e.target.value)) {
              e.preventDefault();
              e.target.value = e.target.value + ' ' + inp;
            } else if (inputPattern.test(e.target.value + inp)) {
              e.preventDefault();
              e.target.value = e.target.value + inp + ' ';
            }
          }
          if (card) {
            return _this._show(card);
          } else {
            return _this._hide();
          }
        };
      })(this);
    };


    /*
     *
     */

    OmiseCcNumberValidation.prototype._appendCcIcon = function(elem) {
      var _ccMastercard, _ccVisa, _parent, _wrapper;
      _parent = elem.parentNode;
      _wrapper = document.createElement('span');
      _wrapper.id = "omise_card_number_wrapper";
      _wrapper.style.position = "relative";
      _ccVisa = document.createElement('img');
      _ccVisa.src = '../../assets/images/icon-visa.png';
      _ccVisa.className = 'omise_card_number_card omise_card_number_card_visa';
      _ccMastercard = document.createElement('img');
      _ccMastercard.src = '../../assets/images/icon-mastercard.png';
      _ccMastercard.className = 'omise_card_number_card omise_card_number_card_mastercard';
      _parent.replaceChild(_wrapper, elem);
      _wrapper.appendChild(elem);
      _wrapper.appendChild(_ccVisa);
      _wrapper.appendChild(_ccMastercard);
      this.cardIcons.visa = _ccVisa;
      return this.cardIcons.mastercard = _ccMastercard;
    };


    /*
     * Show a valid credit card logo
     */

    OmiseCcNumberValidation.prototype._show = function(card) {
      var className;
      this._hide();
      className = this.cardIcons[card.type].className;
      if (className.search('valid') < 0) {
        return this.cardIcons[card.type].className = className + " valid";
      }
    };


    /*
     * Hide all of credit card logos
     */

    OmiseCcNumberValidation.prototype._hide = function() {
      var card, key, ref, results;
      ref = this.cardIcons;
      results = [];
      for (key in ref) {
        card = ref[key];
        results.push(this.cardIcons[key].className = this.cardIcons[key].className.replace(/valid/gi, ""));
      }
      return results;
    };


    /*
     * Validate input card pattern
     * @param {string} num   - An input card number
     * @return {array}
     */

    OmiseCcNumberValidation.prototype._validateCardPattern = function(num) {
      var _card, i, len, ref;
      num = (num + '').replace(/\D/g, '');
      ref = this.cardAcceptance;
      for (i = 0, len = ref.length; i < len; i++) {
        _card = ref[i];
        if (_card.pattern.test(num) === true) {
          return _card;
        }
      }
    };

    return OmiseCcNumberValidation;

  })();

  window.OmiseValidation.ccnumber = OmiseCcNumberValidation;

}).call(this);

(function() {
  var OmiseCcSecureValidation;

  OmiseCcSecureValidation = (function() {
    function OmiseCcSecureValidation() {
      this.charMax = 4;
    }


    /*
     * Initiate card secure field
     */

    OmiseCcSecureValidation.prototype.init = function(elem) {
      return elem.onkeypress = (function(_this) {
        return function(e) {
          var inp, ref;
          e = e || window.event;
          if ((ref = e.which) === null || ref === 0 || ref === 8 || ref === 9 || ref === 27) {
            return true;
          }
          inp = String.fromCharCode(e.which);
          if (!/^\d+$/.test(inp)) {
            return false;
          }
          if (e.target.value.length >= _this.charMax) {
            return false;
          }
        };
      })(this);
    };

    return OmiseCcSecureValidation;

  })();

  window.OmiseValidation.ccsecure = OmiseCcSecureValidation;

}).call(this);
