Grasshopper.controller "UserCtrl", (['$scope', '$location', 'Restangular', 'getCurrentUser', ($scope, $location, Restangular, getCurrentUser) ->
  $scope.currentUser = getCurrentUser.currentUser

  getCurrentUser.loadData()

])