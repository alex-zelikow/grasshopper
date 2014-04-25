Grasshopper.controller "IndexCtrl", ['$scope', '$location', '$http', 'User', ($scope, $location, $http, User) ->

  User.loadCurrentUser().then (result) ->
    $scope.currentUser = result.users[0]

  $scope.editProfile = () ->
    $location.url '/edit-profile'
]