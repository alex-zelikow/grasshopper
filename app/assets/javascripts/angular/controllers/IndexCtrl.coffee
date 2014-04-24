Grasshopper.controller "IndexCtrl", ['$scope', '$location', 'Restangular', 'targetUser', ($scope, $location, Restangular, targetUser) ->

  initialize = () ->
    baseUsers = Restangular.all('users')
    baseUsers.getList().then (users) ->
      $scope.users = users
    $scope.targetUser = targetUser
    targetUser.loadCurrentUser()

  initialize()

  $scope.editProfile = () ->
    $location.url '/edit-profile'
]