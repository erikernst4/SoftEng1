!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:08:23'!
initialize

	topElement := BaseElement new
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:18:09'!
isEmpty

	^topElement isEmpty! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:38:38'!
pop

	|popedElement|
	
	popedElement := topElement value.
	topElement := topElement pop.

	^popedElement! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:43:04'!
push: anElement

	topElement := topElement push: anElement! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:33:52'!
size

	^ topElement height.
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:34:13'!
top

	^ topElement value
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #StackElements category: 'Stack-Exercise'!
Object subclass: #StackElements
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #BaseElement category: 'Stack-Exercise'!
StackElements subclass: #BaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:12:56'!
height

	^ 0! !

!BaseElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:18:24'!
isEmpty

	^ true! !

!BaseElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:33:09'!
push: anElement

	^ StackedElement new initializeWith: anElement lowerElement: self! !

!BaseElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:28:16'!
value

	^ self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #StackedElement category: 'Stack-Exercise'!
StackElements subclass: #StackedElement
	instanceVariableNames: 'lowerLevelElement height selfValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackedElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:11:55'!
height

	^ height! !

!StackedElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:37:33'!
initializeWith: aValue lowerElement: aLowerLevelElement 

	selfValue := aValue.
	lowerLevelElement := aLowerLevelElement.
	height := (aLowerLevelElement height) + 1.! !

!StackedElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:18:35'!
isEmpty

	^ false! !

!StackedElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:11:41'!
lowerLevelElement

	^ lowerLevelElement! !

!StackedElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:25:46'!
pop

	^ lowerLevelElement! !

!StackedElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:48:23'!
push: anElement

	^ StackedElement new initializeWith: anElement lowerElement: self! !

!StackedElement methodsFor: 'as yet unclassified' stamp: 'LT 4/27/2022 02:43:42'!
value

	^ selfValue! !
