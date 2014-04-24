Grasshopper.factory('targetUser', ['Restangular', (Restangular) ->

  targetUser =
    data:
      role: ""
      username: ""
      first_name: ""
      last_name: ""
      is_active: ""
      about_me: ""
      activeorinactive: ""

  checkActive = () ->
    if targetUser.data.is_active
      targetUser.data.activeorinactive = "Active"
      targetUser.data.activeLabel = "label-success"
    else
      targetUser.data.activeorinactive = "Inactive"
      targetUser.data.activeLabel = "label-danger"

  targetUser.loadCurrentUser = () ->
    Restangular.all('user').getList().then (user) ->
      targetUser.data = user[0]
      checkActive()


  targetUser.loadUser = (userId) ->
    Restangular.all('users').getList().then (users) ->
      targetUser.data = _.find(users, (user) ->
        user.id == userId
      )
      checkActive()

  return targetUser

])