module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON 'package.json'
    
    coffee:
      compile:
        files:
          'lib/js/validator.js': [
          	'src/coffee/*.coffee'
          	'src/coffee/validations/*.coffee'
          ]
  )

  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', ['coffee']

