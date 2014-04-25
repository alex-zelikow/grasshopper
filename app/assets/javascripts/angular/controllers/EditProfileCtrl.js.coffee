Grasshopper.controller "EditProfileCtrl", (['$scope','$http', '$location', 'User', '$routeParams', ($scope, $http, $location, User, $routeParams) ->

  User.loadCurrentUser().then (data) ->
    $scope.currentUser = data

  $scope.updateProfile = () ->
    User.update($scope.currentUser.id, $scope.currentUser)
    $location.url('/')

  $scope.removeProficiency = (proficiencyUrl) ->
    User.removeProficiency(proficiencyUrl)
    idx = _.findIndex $scope.currentUser.links.proficiencies, (proficiency) ->
      proficiency.href == proficiencyUrl
    $scope.currentUser.links.proficiencies.splice idx, 1

])