Grasshopper.controller "ViewProfileCtrl", (['$scope', '$location', 'Restangular', 'targetUser', '$routeParams', ($scope, $location, Restangular, targetUser, $routeParams) ->
  userId = parseInt $routeParams.userID, 10
  Restangular.all('users').getList().then( (users) ->
    $scope.targetUser = _.find(users, (user) ->
        user.id == userId
    )
  )
])