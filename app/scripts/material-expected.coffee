'use strict'

app = angular.module('TestApp', ['ngMaterial'])

app.controller 'Dashboard', ($mdSidenav) ->
  $scope.toggleSidenav = (menuId) ->
    $mdSidenav(menuId).toggle()

