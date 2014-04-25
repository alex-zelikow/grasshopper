Grasshopper.factory('User', ['$http', ($http) ->

  User =
    checkActive: (result) ->
      if result.data.users[0].is_active
        result.data.users[0].activeorinactive = "Active"
        result.data.users[0].activeLabel = "label-success"
      else
        result.data.users[0].activeorinactive = "Inactive"
        result.data.users[0].activeLabel = "label-danger"

    loadOne: (userId) ->
      $http.get('./api/users/'+userId).then (result) ->
        User.checkActive(result)
        result.data

    loadAll: () ->
      $http.get('./api/users').then (result) ->
        result.data

    loadCurrentUser: () ->
      $http.get('./api/user').then (result) ->
        User.checkActive(result)
        result.data

    update: (userId, data) ->
      $http({
        method: "PUT"
        url: "./api/users/"+userId
        data: data
      })

    removeProficiency: (proficiencyUrl) ->
      $http.delete(proficiencyUrl)

  User

])