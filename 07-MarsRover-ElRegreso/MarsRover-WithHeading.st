!classDefinition: #MarsRoverLoggerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:27:50'!
test01LoggerLogsNothingWhenRoverDoesNothing

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLoggerOfPositionAndHeading followChangesOn: marsRover.
	
	marsRover process: ''.
	
	self assert: logger readStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:28:05'!
test02LoggerLogsChangeInPositionWhenRoverMovesForward

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLoggerOfPosition followChangesOn: marsRover.
	
	marsRover process: 'f'.
	
	logStream := logger readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:28:16'!
test03LoggerLogsChangeInPositionWhenRoverMovesBackward

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLoggerOfPosition followChangesOn: marsRover.
	
	marsRover process: 'b'.
	
	logStream := logger readStream.
	self assert: '1@0' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:28:30'!
test04LoggerLogsMoreThanOneChangeInPosition

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLoggerOfPosition followChangesOn: marsRover.
	
	marsRover process: 'fb'.
	
	logStream := logger readStream.
	self assert: '2@1' equals: logStream nextLine.
	self assert: '1@1' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:28:47'!
test05LoggerLogsChangeInHeadingWhenRoverTurnsToItsRightAndWasHeadingNorth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLoggerOfHeading followChangesOn: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'East' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:28:58'!
test06LoggerLogsChangeInHeadingWhenRoverTurnsToItsRightAndWasHeadingEast

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLoggerOfHeading followChangesOn: marsRover.
	
	marsRover process: 'r'.
	
	logStream := logger readStream.
	self assert: 'South' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:22:12'!
test07LoggerLogsChangeInHeadingWhenRoverTurnsToItsRightAndWasHeadingSouth

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingSouth.
	logger := MarsRoverLoggerOfHeading followChangesOn: marsRover.
	
	marsRover process: 'rr'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: 'North' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:01:58'!
test08WindowDoesNothingWhenRoverDoesNothing

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverWindow followChangesOn: marsRover.
	
	marsRover process: ''.
	
	self assert: (logger position) equals: ''.
	
	self assert: (logger heading) equals: ''.! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:02:35'!
test09WindowUpdatePositionWhenRoverChangesItsPosition

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverWindow followChangesOn: marsRover.
	
	marsRover process: 'f'.
	
	self assert: '1@2' equals: (logger position).
	
	self assert: (logger heading) equals: ''.! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:04:07'!
test10WindowUpdatesHeadingWhenRoverChangesItsHeadingToEast

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverWindow followChangesOn: marsRover.
	
	marsRover process: 'r'.
	
	self assert: '' equals: (logger position).
	
	self assert: 'East' equals: (logger heading).! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:04:24'!
test11WindowUpdatesHeadingWhenRoverChangesItsHeadingToSouth

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverWindow followChangesOn: marsRover.
	
	marsRover process: 'rr'.
	
	self assert: '' equals: (logger position).
	
	self assert: 'South' equals: (logger heading).! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:04:41'!
test12WindowUpdatesHeadingWhenRoverChangesItsHeadingToWest

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverWindow followChangesOn: marsRover.
	
	marsRover process: 'rrr'.
	
	self assert: '' equals: (logger position).
	
	self assert: 'West' equals: (logger heading).! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:04:51'!
test13WindowUpdatesHeadingWhenRoverChangesItsHeadingToNorth

	| marsRover logger |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverWindow followChangesOn: marsRover.
	
	marsRover process: 'rrrr'.
	
	self assert: '' equals: (logger position).
	
	self assert: 'North' equals: (logger heading).! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 20:45:06'!
test14LoggerOnlyLogsHeadingChangesWhenRequired

	| marsRover loggerFollowingHeading logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingSouth.
	loggerFollowingHeading := MarsRoverLoggerOfHeading followChangesOn: marsRover.
	
	marsRover process: 'rf'.
	
	logStream := loggerFollowingHeading readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: logStream atEnd.
! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 20:50:13'!
test15LoggerOnlyLogsPositionChangesWhenRequired

	| marsRover loggerFollowingPosition logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingSouth.
	loggerFollowingPosition := MarsRoverLoggerOfPosition followChangesOn: marsRover.
	
	marsRover process: 'rrf'.
	
	logStream := loggerFollowingPosition readStream.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.! !

!MarsRoverLoggerTest methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:22:22'!
test16LoggerLogsPositionAndHeadingChangesWhenRequired

	| marsRover logger logStream |
	
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingSouth.
	logger := MarsRoverLoggerOfPositionAndHeading followChangesOn: marsRover.
	
	marsRover process: 'rrf'.
	
	logStream := logger readStream.
	self assert: 'West' equals: logStream nextLine.
	self assert: 'North' equals: logStream nextLine.
	self assert: '1@2' equals: logStream nextLine.
	self assert: logStream atEnd.
! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head logger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:10:49'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self ! !


!MarsRover methodsFor: 'heading' stamp: 'EE 5/30/2022 21:07:53'!
headEast
	
	self heading: MarsRoverHeadingEast! !

!MarsRover methodsFor: 'heading' stamp: 'EE 5/30/2022 21:08:20'!
headNorth
	
	self heading: MarsRoverHeadingNorth ! !

!MarsRover methodsFor: 'heading' stamp: 'EE 5/30/2022 21:09:00'!
headSouth
	
	self heading: MarsRoverHeadingSouth! !

!MarsRover methodsFor: 'heading' stamp: 'EE 5/30/2022 21:09:13'!
headWest
	
	self heading: MarsRoverHeadingWest! !

!MarsRover methodsFor: 'heading' stamp: 'EE 5/30/2022 21:49:08'!
heading: aMarsRoverHeadingClass

	head := aMarsRoverHeadingClass for: self.
	logger ifNotNil: [logger headingChangedTo: head]
	! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'EE 5/30/2022 21:48:46'!
addToPositionAndLogNewPosition: newPosition

	position := position + newPosition.
	logger ifNotNil: [ logger positionChangedTo: position ].! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveEast
	
	self addToPositionAndLogNewPosition: 1@0.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveNorth
	
	self addToPositionAndLogNewPosition: 0@1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveSouth
	
	self addToPositionAndLogNewPosition: 0@-1.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 5/30/2022 20:38:44'!
moveWest
	
	self addToPositionAndLogNewPosition: -1@0! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'EE 5/30/2022 21:45:05'!
followChangesWith: aMarsRoverWindow 

	logger := aMarsRoverWindow.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MarsRoverHeading methodsFor: 'logger' stamp: 'LT 5/31/2022 20:17:26'!
accept: aMarsRoverLogger

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:46:21'!
accept: aVisitor

	^aVisitor visitMarsRoverHeadingEast: self! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'visiting' stamp: 'EE 5/30/2022 21:04:59'!
accept: aMarsRoverLogger 
	
	aMarsRoverLogger visitMarsRoverHeadingNorth: self.! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'visiting' stamp: 'EE 5/30/2022 21:01:23'!
accept: aMarsRoverLogger 
	
	aMarsRoverLogger visitMarsRoverHeadingSouth: self.! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'visiting' stamp: 'EE 5/30/2022 21:03:48'!
accept: aMarsRoverLogger 
	
	aMarsRoverLogger visitAMarsRoverHeadingWest: self.! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'EE 5/30/2022 21:44:17'!
followChangesOn: aMarsRover 
	
	aMarsRover followChangesWith: self! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:19:14'!
headingChangedTo: aMarsRoverHeading
	
	self subclassResponsibility.! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:25:00'!
initialize

	log  := WriteStream on: ''! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:22:16'!
positionChangedTo: aPosition

	log print: aPosition; newLine! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'HAW 5/30/2022 20:23:26'!
readStream
	
	^ReadStream on: log contents ! !


!MarsRoverLogger methodsFor: 'visiting' stamp: 'EE 5/30/2022 21:04:13'!
visitAMarsRoverHeadingWest: aMarsRoverHeadingWest 
	
	log nextPutAll: 'West'; newLine! !

!MarsRoverLogger methodsFor: 'visiting' stamp: 'HAW 5/30/2022 20:46:36'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast 
	
	log nextPutAll: 'East'; newLine! !

!MarsRoverLogger methodsFor: 'visiting' stamp: 'EE 5/30/2022 21:05:16'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth 
	
	log nextPutAll: 'North'; newLine! !

!MarsRoverLogger methodsFor: 'visiting' stamp: 'EE 5/30/2022 21:01:11'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth 
	
	log nextPutAll: 'South'; newLine
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'EE 5/30/2022 21:43:35'!
followChangesOn: aMarsRover 
	
	^self new followChangesOn: aMarsRover ! !


!classDefinition: #MarsRoverLoggerOfHeading category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverLoggerOfHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerOfHeading methodsFor: 'visiting' stamp: 'LT 5/31/2022 20:38:30'!
visitAMarsRoverHeadingWest: aMarsRoverHeadingWest 
	
	log nextPutAll: 'West'; newLine! !

!MarsRoverLoggerOfHeading methodsFor: 'visiting' stamp: 'LT 5/31/2022 20:38:59'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast 
	
	log nextPutAll: 'East'; newLine! !

!MarsRoverLoggerOfHeading methodsFor: 'visiting' stamp: 'LT 5/31/2022 20:39:09'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth 
	
	log nextPutAll: 'North'; newLine! !

!MarsRoverLoggerOfHeading methodsFor: 'visiting' stamp: 'LT 5/31/2022 20:39:24'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth 
	
	log nextPutAll: 'South'; newLine! !


!MarsRoverLoggerOfHeading methodsFor: 'changing' stamp: 'LT 5/31/2022 21:19:22'!
headingChangedTo: aMarsRoverHeading
	
	aMarsRoverHeading accept: self.! !

!MarsRoverLoggerOfHeading methodsFor: 'changing' stamp: 'LT 5/31/2022 20:37:33'!
positionChangedTo: aPosition
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLoggerOfHeading class' category: 'MarsRover-WithHeading'!
MarsRoverLoggerOfHeading class
	instanceVariableNames: ''!

!MarsRoverLoggerOfHeading class methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 20:36:03'!
followChangesOn: aMarsRover 
	
	^self new followChangesOn: aMarsRover ! !


!classDefinition: #MarsRoverLoggerOfPosition category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverLoggerOfPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerOfPosition methodsFor: 'changing' stamp: 'LT 5/31/2022 21:19:46'!
headingChangedTo: aMarsRoverHeading
! !

!MarsRoverLoggerOfPosition methodsFor: 'changing' stamp: 'LT 5/31/2022 20:49:04'!
positionChangedTo: aPosition

	log print: aPosition; newLine! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLoggerOfPosition class' category: 'MarsRover-WithHeading'!
MarsRoverLoggerOfPosition class
	instanceVariableNames: ''!

!MarsRoverLoggerOfPosition class methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 20:47:55'!
followChangesOn: aMarsRover 
	
	^self new followChangesOn: aMarsRover ! !


!classDefinition: #MarsRoverLoggerOfPositionAndHeading category: 'MarsRover-WithHeading'!
MarsRoverLogger subclass: #MarsRoverLoggerOfPositionAndHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLoggerOfPositionAndHeading methodsFor: 'visiting' stamp: 'LT 5/31/2022 21:15:12'!
visitAMarsRoverHeadingWest: aMarsRoverHeadingWest 
	
	log nextPutAll: 'West'; newLine! !

!MarsRoverLoggerOfPositionAndHeading methodsFor: 'visiting' stamp: 'LT 5/31/2022 21:15:24'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast 
	
	log nextPutAll: 'East'; newLine! !

!MarsRoverLoggerOfPositionAndHeading methodsFor: 'visiting' stamp: 'LT 5/31/2022 21:15:36'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth 
	
	log nextPutAll: 'North'; newLine! !

!MarsRoverLoggerOfPositionAndHeading methodsFor: 'visiting' stamp: 'LT 5/31/2022 21:16:01'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth 
	
	log nextPutAll: 'South'; newLine! !


!MarsRoverLoggerOfPositionAndHeading methodsFor: 'changing' stamp: 'LT 5/31/2022 21:14:25'!
headingChangedTo: aMarsRoverHeading
	
	aMarsRoverHeading accept: self! !

!MarsRoverLoggerOfPositionAndHeading methodsFor: 'changing' stamp: 'LT 5/31/2022 21:14:48'!
positionChangedTo: aPosition

	log print: aPosition; newLine! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLoggerOfPositionAndHeading class' category: 'MarsRover-WithHeading'!
MarsRoverLoggerOfPositionAndHeading class
	instanceVariableNames: ''!

!MarsRoverLoggerOfPositionAndHeading class methodsFor: 'as yet unclassified' stamp: 'LT 5/31/2022 21:14:03'!
followChangesOn: aMarsRover 
	
	^self new followChangesOn: aMarsRover! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'marsRoverHeading marsRoverPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'initialization' stamp: 'EE 5/30/2022 21:19:32'!
followChangesOn: aMarsRover 
	
	aMarsRover followChangesWith: self.! !

!MarsRoverWindow methodsFor: 'initialization' stamp: 'EE 5/30/2022 21:33:30'!
initialize

	marsRoverHeading := ''.
	marsRoverPosition := ''. ! !


!MarsRoverWindow methodsFor: 'accessing' stamp: 'EE 5/30/2022 21:33:41'!
heading
	
	^marsRoverHeading ! !

!MarsRoverWindow methodsFor: 'accessing' stamp: 'EE 5/30/2022 21:28:36'!
position
	
	^marsRoverPosition! !


!MarsRoverWindow methodsFor: 'updating' stamp: 'EE 5/30/2022 21:32:35'!
headingChangedTo: aMarsRoverHeading
	
	aMarsRoverHeading accept: self.! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'EE 5/30/2022 21:29:46'!
positionChangedTo: aPosition

	marsRoverPosition := aPosition asString.! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'EE 5/30/2022 21:36:10'!
visitAMarsRoverHeadingWest: aMarsRoverHeadingWest 
	
	marsRoverHeading := 'West'.! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'EE 5/30/2022 21:33:04'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast

	marsRoverHeading := 'East'.
	
	! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'EE 5/30/2022 21:36:54'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth 
	
	marsRoverHeading := 'North'.! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'EE 5/30/2022 21:35:27'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth 
	
	marsRoverHeading := 'South'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'instance creation' stamp: 'EE 5/30/2022 21:18:51'!
followChangesOn: aMarsRover 
	
	^self new followChangesOn: aMarsRover ! !
