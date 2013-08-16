describe 'HeaderCtrl', () ->
  $httpBackend = null
  scope = null

  beforeEach angular.mock.module('crowdtro')
  beforeEach angular.mock.inject ($rootScope, $controller, _$httpBackend_) ->
    $httpBackend = _$httpBackend_ 
    $httpBackend
      .when('GET', '/me')
      .respond({
        id:         1
        first_name: 'Testy'
        last_name:  'McTesterson'
      })

    scope = $rootScope.$new()

    $controller('HeaderCtrl', { $scope: scope })

  it 'should fetch me', () ->
    $httpBackend.flush()
    expect(scope.me.first_name).toBe('Testy')

describe 'CrowdtroCtrl', () ->
  $httpBackend = null
  scope = null

  beforeEach angular.mock.module('crowdtro')
  beforeEach angular.mock.inject ($rootScope, $controller, _$httpBackend_) ->
    $httpBackend = _$httpBackend_ 
    $httpBackend
      .when('GET', '/concerns')
      .respond([{
        id:       1
        content:  'This is concerning'
        complete: false
        score:    1
      }, {
        id:       2
        content:  'This is also concerning'
        complete: false
        score:    0
      }, {
        id:       3
        content:  'This is the third concern'
        complete: false
        score:    10
      }, {
        id:       4
        content:  'This is a complete concern'
        complete: true
        score:    10
      }])

    scope = $rootScope.$new()

    $controller('CrowdtroCtrl', { $scope: scope })

  it "should set newConcern's content to empty string", () ->
    expect(scope.newConcern).toEqual({ content: '' })

  it "should query for all concerns", () ->
    $httpBackend.flush()
    expect(scope.concerns.length).toBe(4)

  describe "editConcern", () ->
    current = null
    beforeEach () ->
      concern = {
        id:       4
        content:  'This is a complete concern'
        complete: true
        score:    10
      }
      current = { editing: false }
      scope.editConcern(concern, current)

    it "sets cachedConcern to concern.content", () ->
      expect(scope.cachedConcern).toEqual('This is a complete concern')

    it "sets current.editing to true", () ->
      expect(current.editing).toBe(true)
