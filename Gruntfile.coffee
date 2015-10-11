module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON 'package.json'
    
    watch:
      coffeelint:
        files: [
            'src/coffee/validator.coffee'
            'src/coffee/rules.coffee'
            'src/coffee/validations/*.coffee'
          ]
        tasks: ['coffeelint']

      coffee:
        files: [
            'src/coffee/validator.coffee'
            'src/coffee/rules.coffee'
            'src/coffee/validations/*.coffee'
          ]
        tasks: ['coffee']


    coffeelint:
      app: [
        'src/coffee/validator.coffee'
        'src/coffee/rules.coffee'
        'src/coffee/validations/*.coffee'
      ]


    coffee:
      compile:
        files:
          'lib/js/validator.js': [
            'src/coffee/validator.coffee'
            'src/coffee/rules.coffee'
            'src/coffee/validations/*.coffee'
          ]
  )

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'default', ['coffeelint', 'coffee']

