module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-bower-task');

  grunt.initConfig({
    bower: {
      install: {
        options: {
          targetDir: "public",
          verbose: true,
          cleanBowerDir: true
        }
      }
    }
  });

  grunt.registerTask('default', 'A default task', function () {
    grunt.log.writeln('Running empty task by default...done');
  });

  grunt.registerTask('heroku', 'should run on heroku', function () {
    grunt.task.run('bower:install');
  });
};
