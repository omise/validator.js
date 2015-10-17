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
  
  validator.validateCcName('field_id', 'rule_name');
  validator.attachForm('form_id');
</script>
```

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
