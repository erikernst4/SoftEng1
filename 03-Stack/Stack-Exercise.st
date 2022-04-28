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

!SentenceFinderByPrefixTest methodsFor: 'instance collection' stamp: 'EE 4/27/2022 19:54:25'!
collectionWithMultipleSentences

	| collection | 
	
	collection := OrderedCollection new.
	
	collection add: 'Borges, el otro, el mismo'.
	
	collection add: 'Borges:- Soy desagradablemente sentimental'.
	
	^collection! !

!SentenceFinderByPrefixTest methodsFor: 'instance collection' stamp: 'EE 4/27/2022 19:50:28'!
collectionWithOneSentence

	| collection | 
	
	collection := OrderedCollection new.
	
	collection add: 'Mirar el río hecho de tiempo y agua // y recordar que el tiempo es otro río'.
	
	^collection! !


!SentenceFinderByPrefixTest methodsFor: 'instance stack' stamp: 'EE 4/27/2022 19:40:59'!
stackWithMultipleSentences

	| stack |
	
	stack := OOStack new.
	
	stack push: 'Borges:- Soy desagradablemente sentimental'.
	
	stack push: 'Solo una cosa no hay // es el olvido'.
	
	stack push: 'Mirar el río hecho de tiempo y agua // y recordar que el tiempo es otro río'.
	
	stack push: 'Estar contigo o no estar contigo es la medida de mi tiempo.'.
	
	stack push: 'Yo marcho por más que gima // toda mi miseria humana'.
	
	stack push: 'Borges, el otro, el mismo'.
	
	^stack! !


!SentenceFinderByPrefixTest methodsFor: 'test in stacks' stamp: 'LT 4/28/2022 00:55:51'!
test01SearchInEmptyStackShouldReturnZeroValues

	| stack sentenceFinder|
	
	stack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: [sentenceFinder findSentencesInStack: stack withPrefix: 'Borges'] value size equals: 0.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test in stacks' stamp: 'LT 4/28/2022 00:55:57'!
test02SearchInNonEmptyStackWithNoMatchesShouldReturnZeroValues

	| stack sentenceFinder|
	
	stack := self stackWithMultipleSentences.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: [sentenceFinder findSentencesInStack: stack withPrefix: 'Paulo Coelho'] value size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'test in stacks' stamp: 'LT 4/28/2022 00:56:02'!
test03SearchInNonEmptyStackWithOneMatchShouldReturnOneValue

	| stack sentenceFinder|
	
	stack := self stackWithMultipleSentences.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: [sentenceFinder findSentencesInStack: stack withPrefix: 'Mirar el río'] value size equals: 1.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test in stacks' stamp: 'LT 4/28/2022 00:56:07'!
test04SearchInNonEmptyStackWithTwoMatchesShouldTwoValues

	| stack sentenceFinder|
	
	stack := self stackWithMultipleSentences.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: [sentenceFinder findSentencesInStack: stack withPrefix: 'Borges'] value size equals: 2.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test in stacks' stamp: 'LT 4/28/2022 00:56:12'!
test05SearchInNonEmptyStackWithMatchesDoesntModifyTheStack

	| stack controlStack sentenceFinder|
	
	stack := self stackWithMultipleSentences.
	controlStack := self stackWithMultipleSentences.
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder findSentencesInStack: stack withPrefix: 'Borges'.
	
	self assert: (stack size) equals: (controlStack size).
	
	[controlStack isEmpty] 
	whileFalse:[ self assert: stack pop equals: controlStack pop. ].! !

!SentenceFinderByPrefixTest methodsFor: 'test in stacks' stamp: 'LT 4/28/2022 00:56:19'!
test06SearchInNonEmptyStackWithoutMatchesDoesntModifyTheStack

	| stack controlStack sentenceFinder|
	
	stack := self stackWithMultipleSentences.
	controlStack := self stackWithMultipleSentences.
	sentenceFinder := SentenceFinderByPrefix new.
	
	sentenceFinder findSentencesInStack: stack withPrefix: 'Paulo Coelho'.
	
	self assert: (stack size) equals: (controlStack size).
	
	[controlStack isEmpty] 
	whileFalse:[ self assert: stack pop equals: controlStack pop. ].! !

!SentenceFinderByPrefixTest methodsFor: 'test in stacks' stamp: 'LT 4/28/2022 00:56:26'!
test07SearchInEmptyStackShouldReturnEmptyCollection

	| stack sentenceFinder|
	
	stack := OOStack new.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: [sentenceFinder findSentencesInStack: stack withPrefix: 'Mirar el río'] value
		equals: OrderedCollection new.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test in stacks' stamp: 'LT 4/28/2022 00:56:31'!
test08SearchInNonEmptyStackWithOneMatchShouldReturnACollectionWithOneSentence

	| stack sentenceFinder|
	
	stack := self stackWithMultipleSentences.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: [sentenceFinder findSentencesInStack: stack withPrefix: 'Mirar el río'] value
		equals: self collectionWithOneSentence.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test in stacks' stamp: 'LT 4/28/2022 00:56:39'!
test09SearchInNonEmptyStackWithNoMatchesShouldReturnEmptyCollection

	| stack sentenceFinder|
	
	stack := self stackWithMultipleSentences.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: [sentenceFinder findSentencesInStack: stack withPrefix: 'Paulo Coelho'] value
		equals: OrderedCollection new.! !

!SentenceFinderByPrefixTest methodsFor: 'test in stacks' stamp: 'LT 4/28/2022 00:56:44'!
test10SearchInNonEmptyStackWithMultipleMatchesShouldReturnACollectionWithMultipleSentences

	| stack sentenceFinder|
	
	stack := self stackWithMultipleSentences.
	sentenceFinder := SentenceFinderByPrefix new.
	
	self assert: [sentenceFinder findSentencesInStack: stack withPrefix: 'Borges'] value
		equals: self collectionWithMultipleSentences.
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'modifying' stamp: 'LT 4/28/2022 00:53:44'!
pop

	|popedElement|
	
	popedElement := topElement value.
	topElement := topElement unstack.

	^popedElement! !

!OOStack methodsFor: 'modifying' stamp: 'LT 4/28/2022 00:53:53'!
push: anElement

	topElement := topElement stack: anElement! !


!OOStack methodsFor: 'testing' stamp: 'EE 4/27/2022 18:22:43'!
isEmpty

	^topElement isBase! !


!OOStack methodsFor: 'accessing' stamp: 'LT 4/27/2022 02:33:52'!
size

	^ topElement height.
! !

!OOStack methodsFor: 'accessing' stamp: 'LT 4/27/2022 02:34:13'!
top

	^ topElement value
! !


!OOStack methodsFor: 'initialization' stamp: 'LT 4/27/2022 02:08:23'!
initialize

	topElement := BaseElement new
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
	instanceVariableNames: 'sentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'searching in stacks' stamp: 'LT 4/28/2022 00:55:22'!
findSentencesInStack: aStack withPrefix: aPrefix

	| stackForRestoring |
	
	stackForRestoring := OOStack new.
	
	[aStack isEmpty] 
		whileFalse: [(aStack top beginsWith: aPrefix)
								ifTrue: [sentences add: aStack top].
								stackForRestoring push: aStack pop].
							
	self restoreStack: aStack toBeforeSearchWith: stackForRestoring.
	
	^sentences 

	! !

!SentenceFinderByPrefix methodsFor: 'searching in stacks' stamp: 'EE 4/27/2022 21:20:41'!
restoreStack: aStack toBeforeSearchWith: stackForRestoring

	[stackForRestoring isEmpty] 
		whileFalse: [aStack push: stackForRestoring pop].


	! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'EE 4/27/2022 18:45:07'!
initialize

	sentences := OrderedCollection new.! !


!classDefinition: #StackElements category: 'Stack-Exercise'!
Object subclass: #StackElements
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElements methodsFor: 'testing' stamp: 'LT 4/27/2022 23:21:53'!
height

	self subclassResponsibility! !

!StackElements methodsFor: 'testing' stamp: 'EE 4/27/2022 18:22:16'!
isBase

	self subclassResponsibility! !


!StackElements methodsFor: 'stacking' stamp: 'LT 4/28/2022 00:51:40'!
stack: anElement

	^ StackedElement new initializeWith: anElement overElement: self! !

!StackElements methodsFor: 'stacking' stamp: 'LT 4/28/2022 00:51:29'!
unstack

	self subclassResponsibility! !


!StackElements methodsFor: 'accessing' stamp: 'EE 4/27/2022 19:15:03'!
value

	self subclassResponsibility! !


!classDefinition: #BaseElement category: 'Stack-Exercise'!
StackElements subclass: #BaseElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseElement methodsFor: 'stacking' stamp: 'LT 4/28/2022 00:53:06'!
unstack

	^ self error: OOStack stackEmptyErrorDescription ! !


!BaseElement methodsFor: 'accessing' stamp: 'LT 4/27/2022 02:28:16'!
value

	^ self error: OOStack stackEmptyErrorDescription ! !


!BaseElement methodsFor: 'testing' stamp: 'LT 4/27/2022 02:12:56'!
height

	^ 0! !

!BaseElement methodsFor: 'testing' stamp: 'EE 4/27/2022 18:22:24'!
isBase

	^ true! !


!classDefinition: #StackedElement category: 'Stack-Exercise'!
StackElements subclass: #StackedElement
	instanceVariableNames: 'elementBelow height myValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackedElement methodsFor: 'initialization' stamp: 'EE 4/27/2022 18:29:23'!
initializeWith: aValue overElement: aStackElementBelow 

	myValue := aValue.
	elementBelow := aStackElementBelow.
	height := (aStackElementBelow height) + 1.! !


!StackedElement methodsFor: 'testing' stamp: 'LT 4/27/2022 02:11:55'!
height

	^ height! !

!StackedElement methodsFor: 'testing' stamp: 'EE 4/27/2022 18:22:31'!
isBase

	^ false! !


!StackedElement methodsFor: 'stacking' stamp: 'LT 4/28/2022 00:53:24'!
unstack

	^ elementBelow! !


!StackedElement methodsFor: 'accessing' stamp: 'EE 4/27/2022 18:27:44'!
value

	^ myValue! !
