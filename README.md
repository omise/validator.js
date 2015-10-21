Validator.js
============
The **validator.js** was made to use for validate a credit card form.

Installation
------------
Include the validator.js from Omise CDN to your checkout form as below.
```html
<html>
<header>
  <script src="https://cdn.omise.co/validator.js"></script>
</header>
...
</html>
```

Getting started
---------------
In order to attach the validation ability to your credit card checkout form, we provided the `OmiseValidator` class to help you easily integrate the validation abilities to your form.  

```javascript
<script src="https://cdn.omise.co/validator.js"></script>
<script>
  var validator = new OmiseValidator;
  
  validator.validates('field_id', 'rule_name');
  validator.attachForm('form_id');
</script>
```

From the example code above, we initiate the `OmiseValidator` into a variable named `validator`. Then, call the `validator.validates` method to let the validator know what field you want to add the validation ability and what the ability that you want to validate the field.  
Next, we call the `validator.attachForm` method to attach all of rules that we already set into a form target.  

For the example:
```html
<html>
...
<body>
  <form id="checkout-form" action="checkout-page.html">
    <input id="cc-name">
    <input id="cc-cardnumber">
    <input class="cc-expiry">
  </form>

  <script src="https://cdn.omise.co/validator.js"></script>
  <script>
    var validator = new OmiseValidator;
  
    validator.validates('cc_name', 'ccName'); // referred to [id="..."]
    validator.validates('#cc-cardnumber', 'ccNumber'); // referred to [id="..."]
    validator.validates('.cc-expiry', 'ccExpiry'); // referred to [class="..."]

    validator.attachForm('checkout-form');
  </script>
</body>
</html>
```

Verbose methods
---------------
We also provided the verbose method.  
The list below is all methods that be accepted.

#### Available methods
- `validateCcName()`
- `validateCcNumber()`
- `validateCcExpiry()`
- `validateCcExpiryMonth()`
- `validateCcExpiryYear()`
- `validateCcSecurityCode()`

Available Validation Rules
--------------------------
The list below is all available validation rules that be accepted.

- `ccName`  
  Allowed only alphabet (A-Za-z) and spacebar characters.
  
- `ccNumber`  
  Allowed only digit (0-9) characters.

- `ccExpiry`  
  Allowed only digit (0-9) characters. (6 character limit)

- `ccExpiryMonth`  
  Allowed only digit (0-9) characters. (2 character limit)

- `ccExpiryYear`  
  Allowed only digit (0-9) characters. (4 character limit)

- `ccSecurityCode`  
  Allowed only digit (0-9) characters. (4 character limit)

Available Response Messages
---------------------------
The list below is all available validation's response message that be returned.

- `emptyString`  
  The value must not be an empty

- `alphabetOnly`  
  The value must be a alphabet character only

- `digitOnly`  
  The value must be a digit character only

- `expiryFormat`  
  The value's format is wrong

- `cardFormat`  
  The value's format of card is wrong

- `cardNotMatch`  
  The card is not support

Advanced Integration
--------------------
The **Advanced Integration** is the another awesome way to integrate Omise's `validator.js` by pass a callback function through the validate function for take more control of an validate's output.  

`validator.validates(field, failureCallback(e, field, result))`

`validator.attachForm(field, failureCallback(e, field, result), successCallback(e, field, result))`

#### Example
```javascript
<script src="https://cdn.omise.co/validator.js"></script>
<script>
  var validator = new OmiseValidator;
  
  validator.validates('my_creditcard_name_field', 'ccName', function(e, response, field){
    console.log(e);
    console.log(response);
    console.log(field);
  }); // <input id="my_creditcard_name_field">
  validator.attachForm('my_form'); // <form id="my_form">...</form>
</script>
```

#### Example with verbose method
```javascript
<script src="https://cdn.omise.co/validator.js"></script>
<script>
  var validator = new OmiseValidator;
  
  validator.validateCcName('my_creditcard_name_field', function(e, response, field){
    console.log(e);
    console.log(response);
    console.log(field);
  }); // <input id="my_creditcard_name_field">
  validator.attachForm('my_form'); // <form id="my_form">...</form>
</script>
```