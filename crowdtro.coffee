app = angular.module('crowdtro', ['ngResource'])

app.controller 'HeaderCtrl', ($scope, Me) ->
  $scope.me = Me.get()

app.directive 'focusMe', ($timeout) ->
  #scope: true
  link: (scope, element, attrs) ->
    scope.$watch attrs.focusMe, () ->
      $timeout ->
        element[0].focus()
        temp = element[0].value
        element[0].value = ''
        element[0].value = temp 

app.directive 'ngBlur', ->
  (scope, elem, attrs) ->
    elem.bind 'blur', ->
      scope.$apply attrs.ngBlur

app.controller 'CrowdtroCtrl', ($scope, Concern) ->
  $scope.newConcern = { content: '' }

  $scope.concerns = Concern.query()

  $scope.editConcern = (concern, current) ->
    $scope.cachedConcern = concern.content
    current.editing = true

  $scope.addConcern = ($event, concern) ->
    if $event.keyCode == 13
      $event.preventDefault()
      if concern.content != ''
        newConcern = new Concern(concern)
        newConcern.$save()
        $scope.concerns.push newConcern
        concern.content = ''

  $scope.updateConcern = ($event, index, concern, current)->
    if $event.keyCode in [13, 27]
      $event.preventDefault()
      current.editing = false

      if $event.keyCode == 13
        $scope.concerns[index].$update()

      if $event.keyCode == 27
        concern.content = $scope.cachedConcern

  $scope.editingBlurred = (concern, current) ->
    concern.content = $scope.cachedConcern
    current.editing = false

  $scope.toggleConcern = (concern) ->
    concern.complete = !concern.complete
    concern.$update()

  $scope.trashConcern = (index) ->
    concern = $scope.concerns.splice(index, 1)
    concern[0].$remove()

  $scope.upVote = (concern) ->
    concern.score++
    concern.$update()

  $scope.downVote = (concern) ->
    if concern.score > 0
      concern.score--
      concern.$update()

app.factory 'Concern', ( $resource ) ->
  $resource '/concerns/:id', { id: '@id' }, update: { method: 'PUT' }

app.factory 'Me', ( $resource ) ->
  $resource '/me'
