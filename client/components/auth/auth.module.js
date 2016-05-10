'use strict';

angular.module('nodejsGettingStartedApp.auth', [
  'nodejsGettingStartedApp.constants',
  'nodejsGettingStartedApp.util',
  'ngCookies',
  'ui.router'
])
  .config(function($httpProvider) {
    $httpProvider.interceptors.push('authInterceptor');
  });
