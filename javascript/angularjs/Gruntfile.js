module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    sass: {
      options: {
        style: 'expanded',
        bundleExec: true,
      },
      dist: {
        files: {
          // for simplicity's sake
          'main.css': 'main.scss'
        }
      }
    },
    watch: {
      options: {
        livereload: true
      },
      css: {
        files: ['main.scss'],
        tasks: ['sass']
      },
      // watch html files too, simple layout for now
      // expound later for sections of snippets
      html: {
        files: ['*.html'],
      },
    },
    connect: {
      server: {
        options: {
          port: 10000,
          hostname: '*',
        }
      }
    }
  });
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.registerTask('default', [
    'connect:server',
    'watch']
    )};
