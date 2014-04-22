Grasshopper.controller "IndexCtrl", ['$scope', '$location', 'Restangular', 'getCurrentUser', ($scope, $location, Restangular, getCurrentUser) ->

  initialize = () ->
    baseUsers = Restangular.all('users')
    baseUsers.getList().then (users) ->
      $scope.users = users

  $scope.currentUser = getCurrentUser.currentUser

  getCurrentUser.loadData()

  initialize()

  $scope.editProfile = () ->
    $location.url '/edit-profile'


]