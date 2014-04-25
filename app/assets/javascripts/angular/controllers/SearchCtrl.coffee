Grasshopper.controller "SearchCtrl", ['$scope', '$location', 'User', '$http', ($scope, $location, User, $http) ->

  User.loadAll().then (result) ->
    $scope.users = result.users

  User.loadCurrentUser().then (data) ->
    $scope.currentUser = data.users[0]

  $scope.search = () ->
    $location.url '/search'

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
    $http.get('./api/conversations').then (conversations) ->
      if existingConversation = conversation for conversation in conversations.data.conversations when \
        (conversation.links.created_by.id == selectedUser.id and \
        conversation.links.created_for.id == currentUser.id) or \
        (conversation.links.created_for.id == selectedUser.id and \
        conversation.links.created_by.id == currentUser.id)

        $scope.conversation = existingConversation
        $scope.messages = existingConversation.links.messages
      debugger

  $scope.submitMessage = (user, messageText) ->
    unless $scope.conversation
      conversations = Restangular.all('conversations')
      newConversation = {created_by: $scope.currentUser.id, created_for: user.id}
      console.log conversations.post(newConversation)
      binding.pry

    # var baseAccounts = Restangular.all('accounts');
    # var newAccount = {name: "Gonto's account"};
    # baseAccounts.post(newAccount);

  $("ul.nav.nav-pills.nav-justified li a").click () ->
    $(this).parent().addClass("active").siblings().removeClass "active"
    return

]

