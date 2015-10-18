Validator.js
============

Installation
------------

Validate Fields
---------------
```javascript
<script src="https://cdn.omise.co/validator.js"></script>
<script>
  var validator = new OmiseValidator;
  
  validator.validates('field_id', 'rule_name');
  validator.attachForm('form_id');
</script>
```

Verbose method
---------------
```javascript
<script src="https://cdn.omise.co/validator.js"></script>
<script>
  var validator = new OmiseValidator;
  
  validator.validateCcName('field_id');
  validator.attachForm('form_id');
</script>
```

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
  'The value must not be an empty'

- `alphabetOnly`  
  'The value must be a alphabet character only'

- `digitOnly`  
  'The value must be a digit character only'


Advanced Integration
--------------------
The **Advanced Integration** is the another awesome way to integrate Omise's `validator.js` by pass a callback function through the validate function for take more control of an validate's output.  
#### Example
```javascript
<script src="https://cdn.omise.co/validator.js"></script>
<script>
  var validator = new OmiseValidator;
  
  validator.validates('my_creditcard_name_field', 'ccName', function(response, field){
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
  
  validator.validateCcName('my_creditcard_name_field', function(response, field){
    console.log(response);
    console.log(field);
  }); // <input id="my_creditcard_name_field">
  validator.attachForm('my_form'); // <form id="my_form">...</form>
</script>
```