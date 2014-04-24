
Grasshopper.controller "SearchCtrl", ['$scope', '$location', 'Restangular', 'targetUser', ($scope, $location, Restangular, targetUser) ->

  initialize = () ->
    baseUsers = Restangular.all('users')
    baseUsers.getList().then (users) ->
      $scope.users = users

  $scope.targetUser = targetUser

  targetUser.loadCurrentUser()

  initialize()

  $scope.search = () ->
    $location.url '/search'

  $scope.viewProfile = (userId) ->
    # $location.url '/view-profile'
    # test targetUser functionality
    targetUser.loadUser(userId)
    console.log targetUser.data

  $scope.searchText = ''

  $scope.filterByNameOrSkill = (users,searchText) ->
    filteredUsers = []
    searchTextRegExp = RegExp(searchText, 'i')

    angular.forEach users, (user) ->
      if user.first_name.match(searchTextRegExp) or user.last_name.match(searchTextRegExp)
        isMatch = true
      else angular.forEach user.links.proficiencies, (proficiency) ->
        if proficiency.skill.match(searchTextRegExp)
          isMatch = true
      filteredUsers.push user if isMatch == true
    console.log searchText
    filteredUsers

  $scope.checkForExistingConversation = (currentUser, selectedUser) ->
    Restangular.one('conversations').getList().then (conversations) ->
      existingConversation = conversation for conversation in conversations when \
        conversation.links.created_by.id == selectedUser.id or \
        conversation.links.created_for.id == selectedUser.id
        $scope.conversation = existingConversation
        $scope.messages = existingConversation.links.messages

  # $scope.submitMessage = (messageText) ->
  #   thisConversation = $scope.conversation
  #   console.log("PATCH REQUEST")
  #   $scope.messageText = ''
  #   # Restangular.patch(object, [queryParams, headers])
  #   debugger

  $("ul.nav.nav-pills.nav-justified li a").click () ->
    $(this).parent().addClass("active").siblings().removeClass "active"
    return

]

