module.exports = function(config) {
  'use strict';

  config.set({
    basePath: './app/assets/javascripts',

    frameworks: ["mocha", "chai"],

    preprocessors: {
      '**/*.coffee': ['coffee'],
      '**/*.html': ['ng-html2js'],
    },

    ngHtml2JsPreprocessor: {
      // Use below line at the very top of your tests
      // beforeEach(module('external-templates'))
      moduleName: 'external-templates',
      stripPrefix: 'templates/',
    },

    files: [
      // bower
      '../bower_components/jquery/dist/jquery.js',
      '../bower_components/bootstrap/dist/js/bootstrap.js',
      '../bower_components/angular/angular.js',
      '../bower_components/angular-mocks/angular-mocks.js',
      // endbower
      //
      // src
      'src/**/*.js',
      'templates/**/*.html',
      // tests
      'test/**/*.js',
    ],

    browsers: [ "Chrome" ],
  });
};
