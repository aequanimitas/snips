module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    clientPath: 'client',
    sass: {
      options: {
        style: 'expanded',
        bundleExec: true,
      },
      dist: {
        files: {
          // for simplicity's sake
          'client/app/app.css': 'client/app/app.scss'
        }
      }
    },
    watch: {
      options: {
        livereload: 55967
      },
      css: {
        files: ['client/app/app.scss', 'client/app/sidebar.scss'],
        tasks: ['sass']
      },
      // watch html files too, simple layout for now
      // expound later for sections of snippets
      html: {
        files: ['*.html', 'client/*.html', 'partials/*/**.html'],
      },
      js: {
        files: ['*.js'],
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
  grunt.loadNpmTasks('grunt-karma');
  grunt.registerTask('default', [
    'connect:server',
    'watch'
  ])};
