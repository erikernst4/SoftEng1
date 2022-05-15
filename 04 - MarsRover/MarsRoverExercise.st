!classDefinition: #MarsRoverTest category: 'MarsRoverExercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 22:53:48'!
test01RoverStaysAtPositionWhenReceivesEmptyString

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #South.
	
	self assert: ((marsRover process: '') position) equals: 0@0. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 22:58:48'!
test02RoverDoesNotChangesItsHeadingWhenReceivesEmptyString

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #South.
	
	self assert: ((marsRover process: '') heading) equals: #South. ! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 01:36:24'!
test03RoverMovesOnePositionToTheSouthWhenReceivesForwardCommandAndIsHeadingToTheSouth

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 1@1 heading: #South.
	
	self assert: ((marsRover process: 'f') position) equals: 1@0! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:11:17'!
test04RoverMovesOnePositionToTheNorthWhenReceivesBackwardsCommandAndIsHeadingToTheSouth

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #South.
	
	self assert: ((marsRover process: 'b') position) equals: 0@1! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:30:00'!
test05RoverChangesItsHeadingToTheWestWhenReceivesRightRotationCommandAndIsHeadingToTheSouth

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #South.
	
	self assert: ((marsRover process: 'r') heading) equals: #West! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:30:26'!
test06RoverChangesItsHeadingToTheEastWhenReceivesLeftRotationCommandAndIsHeadingToTheSouth

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #South.
	
	self assert: ((marsRover process: 'l') heading) equals: #East! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:24:38'!
test07RoverMovesOnePositionToTheNorthWhenReceivesForwardCommandAndIsHeadingToTheNorth

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #North.
	
	self assert: ((marsRover process: 'f') position) equals: 0@1! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:27:59'!
test08RoverMovesOnePositionToTheSouthWhenReceivesBackwardsCommandAndIsHeadingToTheNorth

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #North.
	
	self assert: ((marsRover process: 'b') position) equals: 0@(-1)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:32:30'!
test09RoverChangesItsHeadingToTheEastWhenReceivesRightRotationCommandAndIsHeadingToTheNorth

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #North.
	
	self assert: ((marsRover process: 'r') heading) equals: #East! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:33:00'!
test10RoverChangesItsHeadingToTheWestWhenReceivesLeftRotationCommandAndIsHeadingToTheNorth

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #North.
	
	self assert: ((marsRover process: 'l') heading) equals: #West! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:39:12'!
test11RoverMovesOnePositionToTheEastWhenReceivesForwardCommandAndIsHeadingToTheEast

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #East.
	
	self assert: ((marsRover process: 'f') position) equals: 1@0! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:57:49'!
test12RoverMovesOnePositionToTheWestWhenReceivesBackwardsCommandAndIsHeadingToTheEast

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #East.
	
	self assert: ((marsRover process: 'b') position) equals: (-1)@0! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:41:13'!
test13RoverChangesItsHeadingToTheSouthWhenReceivesRightRotationCommandAndIsHeadingToTheEast

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #East.
	
	self assert: ((marsRover process: 'r') heading) equals: #South! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:44:23'!
test14RoverChangesItsHeadingToTheNorthWhenReceivesLeftRotationCommandAndIsHeadingToTheEast

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #East.
	
	self assert: ((marsRover process: 'l') heading) equals: #North! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:54:01'!
test15RoverMovesOnePositionToTheWestWhenReceivesForwardCommandAndIsHeadingToTheWest

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #West.
	
	self assert: ((marsRover process: 'f') position) equals: (-1)@0! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:56:15'!
test16RoverMovesOnePositionToTheEastWhenReceivesBackwardCommandAndIsHeadingToTheWest

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #West.
	
	self assert: ((marsRover process: 'b') position) equals: 1@0! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:58:40'!
test17RoverChangesItsHeadingToTheNorthWhenReceivesRightRotationCommandAndIsHeadingToTheWest

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #West.
	
	self assert: ((marsRover process: 'r') heading) equals: #North! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/14/2022 23:59:44'!
test18RoverChangesItsHeadingToTheSouthWhenReceivesLeftRotationCommandAndIsHeadingToTheWest

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #West.
	
	self assert: ((marsRover process: 'l') heading) equals: #South! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 01:25:42'!
test19RoverMovesTwoPositionForwardWhenReceivesTwoForwardsCommand

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #South.
	
	marsRover process: 'f'.
	marsRover process: 'f'.
	
	self assert: (marsRover position) equals: 0@(-2)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 01:25:24'!
test20RoverMovesTwoPositionBackwardsWhenReceivesTwoBackwardsCommand

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #South.
	
	marsRover process: 'b'.
	marsRover process: 'b'.
	
	self assert: (marsRover position) equals: 0@2! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 01:30:18'!
test21RoverMovesCorrectlyWhenReceivesAStringCommandWithLengthGreaterThanOne

	|marsRover|
	
	marsRover := MarsRover new initializeAt: 0@0 heading: #South.
	
	marsRover process: 'bb'.
	
	self assert: (marsRover position) equals: 0@2.! !


!classDefinition: #MarsRover category: 'MarsRoverExercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position headingState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRover methodsFor: 'initialization' stamp: 'LT 5/15/2022 01:37:07'!
initializeAt: aPosition heading: aCardinalPoint

	position := aPosition.
	headingState := (MarsRoverHeadingState subclasses detect: [:subclass | subclass canHandle: aCardinalPoint]) new.
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


!classDefinition: #MarsRoverHeadingState category: 'MarsRoverExercise'!
Object subclass: #MarsRoverHeadingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverHeadingState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:10:36'!
heading
	
	self subclassResponsibility ! !

!MarsRoverHeadingState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:10:00'!
moveBackwards
	
	self subclassResponsibility ! !

!MarsRoverHeadingState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:09:53'!
moveForward
	
	self subclassResponsibility ! !

!MarsRoverHeadingState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:09:37'!
rotateLeft
	
	self subclassResponsibility ! !

!MarsRoverHeadingState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 01:40:24'!
rotateRight
	
	self subclassResponsibility ! !


!classDefinition: #MarsRoverHeadingEastState category: 'MarsRoverExercise'!
MarsRoverHeadingState subclass: #MarsRoverHeadingEastState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRoverExercise'!

!MarsRoverHeadingEastState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:11:00'!
heading

	^ #East! !

!MarsRoverHeadingEastState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:12:20'!
moveBackwards
	
	^ (-1)@0! !

!MarsRoverHeadingEastState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:14:12'!
moveForward
	
	^ 1@0! !

!MarsRoverHeadingEastState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:18:46'!
rotateLeft
	
	^ MarsRoverHeadingNorthState new! !

!MarsRoverHeadingEastState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 01:40:24'!
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

!MarsRoverHeadingNorthState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:11:12'!
heading

	^ #North! !

!MarsRoverHeadingNorthState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:12:45'!
moveBackwards
	
	^ 0@(-1) ! !

!MarsRoverHeadingNorthState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:14:26'!
moveForward
	
	^0@1! !

!MarsRoverHeadingNorthState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:19:26'!
rotateLeft
	
	^ MarsRoverHeadingWestState new! !

!MarsRoverHeadingNorthState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 01:40:24'!
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

!MarsRoverHeadingSouthState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:11:24'!
heading

	^ #South! !

!MarsRoverHeadingSouthState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:13:08'!
moveBackwards
	
	^ 0@1! !

!MarsRoverHeadingSouthState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:14:50'!
moveForward
	
	^ 0@(-1)! !

!MarsRoverHeadingSouthState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:19:51'!
rotateLeft
	
	^ MarsRoverHeadingEastState new! !

!MarsRoverHeadingSouthState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 01:40:24'!
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

!MarsRoverHeadingWestState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:11:32'!
heading

	^ #West! !

!MarsRoverHeadingWestState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:13:32'!
moveBackwards
	
	^ 1@0! !

!MarsRoverHeadingWestState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:15:22'!
moveForward
	
	^ (-1)@0 ! !

!MarsRoverHeadingWestState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:20:15'!
rotateLeft
	
	^ MarsRoverHeadingSouthState new! !

!MarsRoverHeadingWestState methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 01:40:24'!
rotateRight

	^ MarsRoverHeadingNorthState new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWestState class' category: 'MarsRoverExercise'!
MarsRoverHeadingWestState class
	instanceVariableNames: ''!

!MarsRoverHeadingWestState class methodsFor: 'as yet unclassified' stamp: 'LT 5/15/2022 00:21:57'!
canHandle: aCardinalPoint

	^ (aCardinalPoint =#West)! !
