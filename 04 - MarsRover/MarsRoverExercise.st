!classDefinition: #MarsRoverTest category: 'MarsRoverExercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:48:00'!
test01RoverStaysAtPositionWhenReceivesEmptyString

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingSouth.
	
	self assert: ((marsRover process: '') position) equals: 0@0. ! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:48:00'!
test02RoverDoesNotChangesItsHeadingWhenReceivesEmptyString

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingSouth.
	
	self assert: ((marsRover process: '') heading) equals: #South. ! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 19:08:03'!
test03RoverMovesOnePositionToTheSouthWhenReceivesForwardCommandAndIsHeadingToTheSouth

	|marsRover|
	
	marsRover := MarsRover at: 1@1 heading: #South.
	
	self assert: ((marsRover process: 'f') position) equals: 1@0! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:48:00'!
test04RoverMovesOnePositionToTheNorthWhenReceivesBackwardsCommandAndIsHeadingToTheSouth

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingSouth.
	
	self assert: ((marsRover process: 'b') position) equals: 0@1! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:48:00'!
test05RoverChangesItsHeadingToTheWestWhenReceivesRightRotationCommandAndIsHeadingToTheSouth

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingSouth.
	
	self assert: ((marsRover process: 'r') heading) equals: #West! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:48:00'!
test06RoverChangesItsHeadingToTheEastWhenReceivesLeftRotationCommandAndIsHeadingToTheSouth

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingSouth.
	
	self assert: ((marsRover process: 'l') heading) equals: #East! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:48:56'!
test07RoverMovesOnePositionToTheNorthWhenReceivesForwardCommandAndIsHeadingToTheNorth

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingNorth.
	
	self assert: ((marsRover process: 'f') position) equals: 0@1! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:48:56'!
test08RoverMovesOnePositionToTheSouthWhenReceivesBackwardsCommandAndIsHeadingToTheNorth

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingNorth.
	
	self assert: ((marsRover process: 'b') position) equals: 0@(-1)! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:48:56'!
test09RoverChangesItsHeadingToTheEastWhenReceivesRightRotationCommandAndIsHeadingToTheNorth

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingNorth.
	
	self assert: ((marsRover process: 'r') heading) equals: #East! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:48:56'!
test10RoverChangesItsHeadingToTheWestWhenReceivesLeftRotationCommandAndIsHeadingToTheNorth

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingNorth.
	
	self assert: ((marsRover process: 'l') heading) equals: #West! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:49:21'!
test11RoverMovesOnePositionToTheEastWhenReceivesForwardCommandAndIsHeadingToTheEast

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingEast.
	
	self assert: ((marsRover process: 'f') position) equals: 1@0! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:49:21'!
test12RoverMovesOnePositionToTheWestWhenReceivesBackwardsCommandAndIsHeadingToTheEast

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingEast.
	
	self assert: ((marsRover process: 'b') position) equals: (-1)@0! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:49:21'!
test13RoverChangesItsHeadingToTheSouthWhenReceivesRightRotationCommandAndIsHeadingToTheEast

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingEast.
	
	self assert: ((marsRover process: 'r') heading) equals: #South! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:49:21'!
test14RoverChangesItsHeadingToTheNorthWhenReceivesLeftRotationCommandAndIsHeadingToTheEast

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingEast.
	
	self assert: ((marsRover process: 'l') heading) equals: #North! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:49:43'!
test15RoverMovesOnePositionToTheWestWhenReceivesForwardCommandAndIsHeadingToTheWest

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingWest.
	
	self assert: ((marsRover process: 'f') position) equals: (-1)@0! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:49:43'!
test16RoverMovesOnePositionToTheEastWhenReceivesBackwardCommandAndIsHeadingToTheWest

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingWest.
	
	self assert: ((marsRover process: 'b') position) equals: 1@0! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:49:43'!
test17RoverChangesItsHeadingToTheNorthWhenReceivesRightRotationCommandAndIsHeadingToTheWest

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingWest.
	
	self assert: ((marsRover process: 'r') heading) equals: #North! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:49:43'!
test18RoverChangesItsHeadingToTheSouthWhenReceivesLeftRotationCommandAndIsHeadingToTheWest

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingWest.
	
	self assert: ((marsRover process: 'l') heading) equals: #South! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:53:35'!
test19RoverMovesTwoPositionForwardWhenReceivesTwoForwardsCommand

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingSouth.
	
	marsRover process: 'f'; process: 'f'.
	
	self assert: (marsRover position) equals: 0@(-2)! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:53:47'!
test20RoverMovesTwoPositionBackwardsWhenReceivesTwoBackwardsCommand

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingSouth.
	
	marsRover process: 'b'; process: 'b'.
	
	self assert: (marsRover position) equals: 0@2! !

!MarsRoverTest methodsFor: 'test suite' stamp: 'EE 5/15/2022 18:48:00'!
test21RoverMovesCorrectlyWhenReceivesAStringCommandWithLengthGreaterThanOne

	|marsRover|
	
	marsRover := self marsRoverAtOriginHeadingSouth.
	
	marsRover process: 'bb'.
	
	self assert: (marsRover position) equals: 0@2.! !


!MarsRoverTest methodsFor: 'Mars Rover creations' stamp: 'EE 5/15/2022 19:06:04'!
marsRoverAtOriginHeadingEast

	^ MarsRover at: 0@0 heading: #East! !

!MarsRoverTest methodsFor: 'Mars Rover creations' stamp: 'EE 5/15/2022 19:07:23'!
marsRoverAtOriginHeadingNorth

	^ MarsRover at: 0@0 heading: #North! !

!MarsRoverTest methodsFor: 'Mars Rover creations' stamp: 'EE 5/15/2022 19:07:40'!
marsRoverAtOriginHeadingSouth

	^ MarsRover at: 0@0 heading: #South! !

!MarsRoverTest methodsFor: 'Mars Rover creations' stamp: 'EE 5/15/2022 19:07:50'!
marsRoverAtOriginHeadingWest

	^ MarsRover at: 0@0 heading: #West! !


!classDefinition: #MarsRover category: 'MarsRoverExercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position headingState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRover methodsFor: 'initialization' stamp: 'EE 5/15/2022 18:39:43'!
initializeAt: aPosition heading: aCardinalPoint

	position := aPosition.
	headingState := MarsRoverHeadingState with: aCardinalPoint.
	! !


!MarsRover methodsFor: 'procesing' stamp: 'LT 5/15/2022 01:40:52'!
process: aString 

	aString do:[ :aCommand|
		
		(aCommand = $f) ifTrue: [
			position := position + headingState moveForward
		].
		(aCommand = $b) ifTrue: [
			position := position + headingState moveBackwards
		].
		(aCommand = $r) ifTrue: [
			headingState := headingState rotateRight
		].
		(aCommand = $l) ifTrue: [
			headingState := headingState rotateLeft
		].
	
	]! !


!MarsRover methodsFor: 'testing' stamp: 'LT 5/15/2022 01:38:51'!
heading

	^ headingState heading! !

!MarsRover methodsFor: 'testing' stamp: 'LT 5/15/2022 01:39:00'!
position

	^ position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRoverExercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'EE 5/15/2022 19:07:01'!
at: aPosition heading: aCardinalPoint

	^self new initializeAt: aPosition heading: aCardinalPoint! !


!classDefinition: #MarsRoverHeadingState category: 'MarsRoverExercise'!
Object subclass: #MarsRoverHeadingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverHeadingState methodsFor: 'rotations' stamp: 'LT 5/15/2022 00:09:37'!
rotateLeft
	
	self subclassResponsibility ! !

!MarsRoverHeadingState methodsFor: 'rotations' stamp: 'LT 5/15/2022 01:40:24'!
rotateRight
	
	self subclassResponsibility ! !


!MarsRoverHeadingState methodsFor: 'movement' stamp: 'LT 5/15/2022 00:10:00'!
moveBackwards
	
	self subclassResponsibility ! !

!MarsRoverHeadingState methodsFor: 'movement' stamp: 'LT 5/15/2022 00:09:53'!
moveForward
	
	self subclassResponsibility ! !


!MarsRoverHeadingState methodsFor: 'accessing' stamp: 'LT 5/15/2022 00:10:36'!
heading
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingState class' category: 'MarsRoverExercise'!
MarsRoverHeadingState class
	instanceVariableNames: ''!

!MarsRoverHeadingState class methodsFor: 'instance creation' stamp: 'EE 5/15/2022 18:43:44'!
with: aCardinalPoint

	^ (self subclasses detect: [:subclass | subclass canHandle: aCardinalPoint]) new! !


!classDefinition: #MarsRoverHeadingEastState category: 'MarsRoverExercise'!
MarsRoverHeadingState subclass: #MarsRoverHeadingEastState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverHeadingEastState methodsFor: 'accessing' stamp: 'LT 5/15/2022 00:11:00'!
heading

	^ #East! !


!MarsRoverHeadingEastState methodsFor: 'movement' stamp: 'LT 5/15/2022 00:12:20'!
moveBackwards
	
	^ (-1)@0! !

!MarsRoverHeadingEastState methodsFor: 'movement' stamp: 'LT 5/15/2022 00:14:12'!
moveForward
	
	^ 1@0! !


!MarsRoverHeadingEastState methodsFor: 'rotations' stamp: 'LT 5/15/2022 00:18:46'!
rotateLeft
	
	^ MarsRoverHeadingNorthState new! !

!MarsRoverHeadingEastState methodsFor: 'rotations' stamp: 'LT 5/15/2022 01:40:24'!
rotateRight

	^ MarsRoverHeadingSouthState new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEastState class' category: 'MarsRoverExercise'!
MarsRoverHeadingEastState class
	instanceVariableNames: ''!

!MarsRoverHeadingEastState class methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:21:20'!
canHandle: aCardinalPoint

	^ (aCardinalPoint =#East)! !


!classDefinition: #MarsRoverHeadingNorthState category: 'MarsRoverExercise'!
MarsRoverHeadingState subclass: #MarsRoverHeadingNorthState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverHeadingNorthState methodsFor: 'accessing' stamp: 'LT 5/15/2022 00:11:12'!
heading

	^ #North! !


!MarsRoverHeadingNorthState methodsFor: 'movement' stamp: 'LT 5/15/2022 00:12:45'!
moveBackwards
	
	^ 0@(-1) ! !

!MarsRoverHeadingNorthState methodsFor: 'movement' stamp: 'LT 5/15/2022 00:14:26'!
moveForward
	
	^0@1! !


!MarsRoverHeadingNorthState methodsFor: 'rotations' stamp: 'LT 5/15/2022 00:19:26'!
rotateLeft
	
	^ MarsRoverHeadingWestState new! !

!MarsRoverHeadingNorthState methodsFor: 'rotations' stamp: 'LT 5/15/2022 01:40:24'!
rotateRight

	^ MarsRoverHeadingEastState new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorthState class' category: 'MarsRoverExercise'!
MarsRoverHeadingNorthState class
	instanceVariableNames: ''!

!MarsRoverHeadingNorthState class methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:21:30'!
canHandle: aCardinalPoint

	^ (aCardinalPoint =#North)! !


!classDefinition: #MarsRoverHeadingSouthState category: 'MarsRoverExercise'!
MarsRoverHeadingState subclass: #MarsRoverHeadingSouthState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverHeadingSouthState methodsFor: 'accessing' stamp: 'LT 5/15/2022 00:11:24'!
heading

	^ #South! !


!MarsRoverHeadingSouthState methodsFor: 'movement' stamp: 'LT 5/15/2022 00:13:08'!
moveBackwards
	
	^ 0@1! !

!MarsRoverHeadingSouthState methodsFor: 'movement' stamp: 'LT 5/15/2022 00:14:50'!
moveForward
	
	^ 0@(-1)! !


!MarsRoverHeadingSouthState methodsFor: 'rotations' stamp: 'LT 5/15/2022 00:19:51'!
rotateLeft
	
	^ MarsRoverHeadingEastState new! !

!MarsRoverHeadingSouthState methodsFor: 'rotations' stamp: 'LT 5/15/2022 01:40:24'!
rotateRight

	^ MarsRoverHeadingWestState new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouthState class' category: 'MarsRoverExercise'!
MarsRoverHeadingSouthState class
	instanceVariableNames: ''!

!MarsRoverHeadingSouthState class methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:21:38'!
canHandle: aCardinalPoint

	^ (aCardinalPoint =#South)! !


!classDefinition: #MarsRoverHeadingWestState category: 'MarsRoverExercise'!
MarsRoverHeadingState subclass: #MarsRoverHeadingWestState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverHeadingWestState methodsFor: 'accessing' stamp: 'LT 5/15/2022 00:11:32'!
heading

	^ #West! !


!MarsRoverHeadingWestState methodsFor: 'movement' stamp: 'LT 5/15/2022 00:13:32'!
moveBackwards
	
	^ 1@0! !

!MarsRoverHeadingWestState methodsFor: 'movement' stamp: 'LT 5/15/2022 00:15:22'!
moveForward
	
	^ (-1)@0 ! !


!MarsRoverHeadingWestState methodsFor: 'rotations' stamp: 'LT 5/15/2022 00:20:15'!
rotateLeft
	
	^ MarsRoverHeadingSouthState new! !

!MarsRoverHeadingWestState methodsFor: 'rotations' stamp: 'LT 5/15/2022 01:40:24'!
rotateRight

	^ MarsRoverHeadingNorthState new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWestState class' category: 'MarsRoverExercise'!
MarsRoverHeadingWestState class
	instanceVariableNames: ''!

!MarsRoverHeadingWestState class methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:21:57'!
canHandle: aCardinalPoint

	^ (aCardinalPoint =#West)! !
