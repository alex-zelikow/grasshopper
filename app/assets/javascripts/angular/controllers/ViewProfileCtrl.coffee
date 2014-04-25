Grasshopper.controller "ViewProfileCtrl", (['$scope', '$location', '$http', 'User', '$routeParams', ($scope, $location, $http, User, $routeParams) ->

  userId = $routeParams.userId

  User.loadOne(userId).then (result) ->
    $scope.user = result.users[0]
])
