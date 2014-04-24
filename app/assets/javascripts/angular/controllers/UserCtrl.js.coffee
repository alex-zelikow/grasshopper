Grasshopper.controller "UserCtrl", (['$scope', '$location', 'Restangular', 'targetUser', ($scope, $location, Restangular, targetUser) ->
  $scope.targetUser = targetUser

  targetUser.loadCurrentUser()

  $scope.updateProfile = () ->
    targetUser.data.route = 'users'
    targetUser.data.put().then ( ->
      $location.path('/')
    )

  $scope.removeSkill = (proficiencyId) ->
    Restangular.one('proficiencies', proficiencyId).get().then( (proficiency) ->
      proficiency.route = 'proficiencies/' + proficiencyId
      proficiency.remove()
      proficiencies = $scope.targetUser.data.links.proficiencies
      console.log "selected proficiency index", idx = _.findIndex(proficiencies, (proficiency) ->
        proficiency.id == proficiencyId
      )
      proficiencies.splice(idx, 1)
    )
])