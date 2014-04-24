Grasshopper.controller "UserCtrl", (['$scope', '$location', 'Restangular', 'targetUser', '$routeParams', ($scope, $location, Restangular, targetUser, $routeParams) ->
  $scope.currentUser = targetUser.loadCurrentUser()
  userId = parseInt $routeParams.userID, 10
  $scope.targetUser = targetUser.loadUser(userId)

  $scope.updateProfile = () ->
    $scope.currentUser.route = 'users'
    $scope.currentUser.put().then ( ->
      $location.path('/')
    )

  $scope.removeSkill = (proficiencyId) ->
    Restangular.one('proficiencies', proficiencyId).get().then( (proficiency) ->
      proficiency.route = 'proficiencies/' + proficiencyId
      proficiency.remove()
      proficiencies = $scope.targetUser.data.links.proficiencies
      idx = _.findIndex(proficiencies, (proficiency) ->
        proficiency.id == proficiencyId
      )
      proficiencies.splice(idx, 1)
    )
])