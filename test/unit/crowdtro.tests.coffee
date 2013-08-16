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
        content:  'This is an incomplete concern'
        complete: false
        score:    10
      }
      current = { editing: false }
      scope.editConcern(concern, current)

    it "sets cachedConcern to concern.content", () ->
      expect(scope.cachedConcern).toEqual('This is an incomplete concern')

    it "sets current.editing to true", () ->
      expect(current.editing).toBe(true)

  describe "editingBlurred", () ->
    current = null
    beforeEach () ->
      concern = {
        id:       4
        content:  'This is an incomplete concern'
        complete: false
        score:    10
      }
      current = { editing: false }
      scope.editingBlurred(concern, current)
      scope.cachedConcern = 'This was the concern before editing!'

    it "sets cachedConcern to concern.content", () ->
      expect(scope.cachedConcern).toEqual('This was the concern before editing!')

    it "sets current.editing to true", () ->
      expect(current.editing).toBe(false)

  describe "addConcern", () ->
    concern = null
    event = null

    beforeEach () ->
      concern =
        id:       4
        content:  'This is an incomplete concern'
        complete: false
        score:    10
      event =
        keyCode: 13
        preventDefault: jasmine.createSpy()

    it "prevents default if enter is pressed", () ->
      scope.addConcern(event, concern)
      expect(event.preventDefault).toHaveBeenCalled()

    it "does not add concern if content is blank", () ->
      numConcerns = scope.concerns.length
      concern.content = ''
      scope.addConcern(event, concern)
      expect(scope.concerns.length).toEqual(numConcerns)

    it "adds a concern if content is not blank", () ->
      scope.addConcern(event, concern)
      numConcerns = scope.concerns.length
      expect(scope.concerns[numConcerns-1].content).toEqual('This is an incomplete concern')
      expect(scope.concerns.length).toEqual(numConcerns)

  describe "toggleConcern", () ->
    concern = null

    beforeEach () ->
      concern =
        id:       4
        content:  'This is an incomplete concern'
        complete: false
        score:    10
        $update:  jasmine.createSpy()

    it "prevents default and sets editing to false", () ->
      scope.toggleConcern(concern)
      expect(concern.complete).toBe(true)
      expect(concern.$update).toHaveBeenCalled()

  describe "trashConcern", () ->
    concern = null

    beforeEach () ->
      concern =
        id:       4
        content:  'This is an incomplete concern'
        complete: false
        score:    10
        $remove:  jasmine.createSpy()
      scope.concerns[0] = concern

    it "removes the concern", () ->
      scope.trashConcern(0)
      expect(scope.concerns.length).toBe(0)
      expect(concern.$remove).toHaveBeenCalled()

  describe "upVote", () ->
    concern = null

    beforeEach () ->
      concern =
        id:       4
        content:  'This is an incomplete concern'
        complete: false
        score:    10
        $update:  jasmine.createSpy()

    it "prevents default and sets editing to false", () ->
      scope.upVote(concern)
      expect(concern.score).toBe(11)
      expect(concern.$update).toHaveBeenCalled()

  describe "downVote", () ->
    concern = null

    beforeEach () ->
      concern =
        id:       4
        content:  'This is an incomplete concern'
        complete: false
        score:    10
        $update:  jasmine.createSpy()

    it "prevents default and sets editing to false", () ->
      scope.downVote(concern)
      expect(concern.score).toBe(9)
      expect(concern.$update).toHaveBeenCalled()

  describe "updateConcern", () ->
    concern = null
    event = null
    current = null

    beforeEach () ->
      concern =
        id:       4
        content:  'This is an incomplete concern'
        complete: false
        score:    10
        $update:  jasmine.createSpy()
      event =
        keyCode: 13
        preventDefault: jasmine.createSpy()
      current =
        editing: true
      scope.concerns[0] = concern
      scope.cachedConcern = 'This was the concern before editing!'

    describe "enter pressed", () ->
      it "prevents default and sets editing to false", () ->
        scope.updateConcern(event, 0, concern, current)
        expect(event.preventDefault).toHaveBeenCalled()
        expect(current.editing).toBe(false)

      it "updates the concern", () ->
        scope.updateConcern(event, 0, concern, current)
        expect(concern.$update).toHaveBeenCalled()

    describe "escape pressed", () ->
      beforeEach () ->
        event.keyCode = 27
      it "prevents default and sets editing to false if escape is pressed", () ->
        scope.updateConcern(event, 0, concern, current)
        expect(event.preventDefault).toHaveBeenCalled()
        expect(current.editing).toBe(false)

      it "resets the content of the concern back to the cached content", () ->
        scope.updateConcern(event, 0, concern, current)
        expect(concern.content).toEqual('This was the concern before editing!')
