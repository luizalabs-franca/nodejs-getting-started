'use strict';

angular.module('nodejsGettingStartedApp', [
  'nodejsGettingStartedApp.auth',
  'nodejsGettingStartedApp.admin',
  'nodejsGettingStartedApp.constants',
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'btford.socket-io',
  'ui.router',
  'ui.bootstrap',
  'validation.match'
])
  .config(function($urlRouterProvider, $locationProvider) {
    $urlRouterProvider
      .otherwise('/');

    $locationProvider.html5Mode(true);
  });
