module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON 'package.json'
    
    watch:
      options:
        nospawn: true

      coffeelint:
        files: [
          'src/coffee/validator.coffee'
          'src/coffee/validationResponse.coffee'
          'src/coffee/validationRule.coffee'
          'src/coffee/validationMessage.coffee'
          'src/coffee/validation.coffee'
          'src/coffee/helper.coffee'
          'src/coffee/validations/*.coffee'
        ]
        tasks: ['coffeelint']

      coffee:
        files: [
          'src/coffee/validator.coffee'
          'src/coffee/validationResponse.coffee'
          'src/coffee/validationRule.coffee'
          'src/coffee/validationMessage.coffee'
          'src/coffee/validation.coffee'
          'src/coffee/helper.coffee'
          'src/coffee/validations/*.coffee'
        ]
        tasks: ['coffee', 'beep']
      
      scripts:
        files: ['lib/js/validator.js']
        tasks: ['uglify']

    coffeelint:
      app: [
        'src/coffee/validator.coffee'
        'src/coffee/validationResponse.coffee'
        'src/coffee/validationRule.coffee'
        'src/coffee/validationMessage.coffee'
        'src/coffee/validation.coffee'
        'src/coffee/helper.coffee'
        'src/coffee/validations/*.coffee'
      ]

    coffee:
      compile:
        files:
          'lib/js/validator.js': [
            'src/coffee/validator.coffee'
            'src/coffee/validationResponse.coffee'
            'src/coffee/validationRule.coffee'
            'src/coffee/validationMessage.coffee'
            'src/coffee/validation.coffee'
            'src/coffee/helper.coffee'
            'src/coffee/validations/*.coffee'
          ]

    uglify:
      my_target:
        files:
          'lib/js/validator.min.js': ['lib/js/validator.js']
  )

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-beep'

  grunt.registerTask 'default', ['coffeelint', 'coffee', 'uglify', 'beep']

