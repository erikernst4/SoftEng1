!classDefinition: #CartTest category: 'TusLibrosExercise'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!CartTest methodsFor: 'tests' stamp: 'EE 6/4/2022 16:48:57'!
test01CartIsEmptyWhenCreated

	| cart catalogue |
	
	catalogue := EditorialCatalogue with: OrderedCollection new.
	cart := EditorialCart for: catalogue.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'EE 6/4/2022 16:48:57'!
test02CartIsNotEmptyWhenAddedABook

	| cart books catalogue |
	
	books := OrderedCollection new.
	books add: 12.
	
	catalogue := EditorialCatalogue with: books.
	cart := EditorialCart for: catalogue.
	
	cart addBookWithISBN: 12 quantity: 1.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'EE 6/4/2022 16:48:57'!
test03CartHasOnlyTheBookAdded

	| cart expectedBooks books catalogue |
	
	books := OrderedCollection new.
	books add: 12.
	
	catalogue := EditorialCatalogue with: books.
	cart := EditorialCart for: catalogue.
	
	cart addBookWithISBN: 12 quantity: 1.
	
	expectedBooks := #(12).
	
	self assert: (expectedBooks) equals: (cart books).! !

!CartTest methodsFor: 'tests' stamp: 'EE 6/4/2022 16:48:57'!
test04CartHasOnlyTheBooksAdded

	| cart expectedBooks books catalogue |
	
	books := OrderedCollection new.
	books add: 12; add: 13.
	
	catalogue := EditorialCatalogue with: books.
	cart := EditorialCart for: catalogue.
	
	cart addBookWithISBN: 12 quantity: 1; addBookWithISBN: 13 quantity: 1.
	
	expectedBooks := #(12 13).
	
	self assert: expectedBooks equals: (cart books).! !

!CartTest methodsFor: 'tests' stamp: 'EE 6/4/2022 16:48:57'!
test05CanNotAddABookThatIsNotInTheCatalogue

	| cart catalogue books |
	
	books := OrderedCollection new.
	books add: 12.
	
	catalogue := EditorialCatalogue with: books.
	cart := EditorialCart for: catalogue.
	
	self 
		should: [ cart addBookWithISBN: 13 quantity: 1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: EditorialCart canNotAddABookOutsideOfTheCatalogueErrorMessage equals: anError messageText.
			self assert: cart isEmpty.
			]! !

!CartTest methodsFor: 'tests' stamp: 'EE 6/4/2022 16:48:57'!
test06ABookAddedMoreThanOnceQuantityInACartIsTheSumOfTheAddedAmount

	| cart catalogue books |
	
	books := OrderedCollection new.
	books add: 12.
	
	catalogue := EditorialCatalogue with: books.
	cart := EditorialCart for: catalogue.
	
	cart addBookWithISBN: 12 quantity: 1.
	cart addBookWithISBN: 12 quantity: 4.
	
	self assert: 5 equals: (cart quantityOf: 12).
	! !

!CartTest methodsFor: 'tests' stamp: 'EE 6/4/2022 16:48:57'!
test07ABookAddedOnceQuantityInACartIsTheAddedAmount

	| cart catalogue books |
	
	books := OrderedCollection new.
	books add: 12.
	
	catalogue := EditorialCatalogue with: books.
	cart := EditorialCart for: catalogue.
	
	cart addBookWithISBN: 12 quantity: 1.
	
	self assert: 1 equals: (cart quantityOf: 12).
	! !

!CartTest methodsFor: 'tests' stamp: 'EE 6/4/2022 16:48:57'!
test08ACartCanNotAddNonPositiveQuantityOfABook

	| cart catalogue books |
	
	books := OrderedCollection new.
	books add: 12.
	
	catalogue := EditorialCatalogue with: books.
	cart := EditorialCart for: catalogue.
	
	self 
		should: [ cart addBookWithISBN: 12 quantity: -1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: EditorialCart canNotAddNonPositiveQuantityOfABookErrorMessage equals: anError messageText.
			self assert: cart isEmpty.
			]! !


!classDefinition: #EditorialCart category: 'TusLibrosExercise'!
Object subclass: #EditorialCart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!EditorialCart methodsFor: 'testing' stamp: 'EE 6/4/2022 15:50:11'!
isEmpty

	^ books isEmpty.! !


!EditorialCart methodsFor: 'assertions' stamp: 'EE 6/4/2022 16:45:11'!
assertCanAddBook: anISBN quantity: aQuantity 

	(catalogue has: anISBN) ifFalse: [ self class canNotAddABookOutsideOfTheCatalogue].
	
	(aQuantity > 0) ifFalse: [ self class canNotAddNonPositiveQuantityOfABook ].
	
! !


!EditorialCart methodsFor: 'adding' stamp: 'EE 6/4/2022 16:44:04'!
addBookWithISBN: anISBN quantity: aQuantity

	| previousQuantityOfTheBook |
	
	self assertCanAddBook: anISBN quantity: aQuantity.

	previousQuantityOfTheBook := books at: anISBN ifAbsent:[0].
	
	books at: anISBN put: (previousQuantityOfTheBook + aQuantity).! !


!EditorialCart methodsFor: 'initialization' stamp: 'EE 6/4/2022 16:26:02'!
initializeFor: aCatalogue

	books := Dictionary new.
	catalogue := aCatalogue.! !


!EditorialCart methodsFor: 'accessing' stamp: 'EE 6/4/2022 16:27:12'!
books
	
	^ books keys.! !

!EditorialCart methodsFor: 'accessing' stamp: 'EE 6/4/2022 16:34:56'!
quantityOf: anISBN
	
	^books at: anISBN.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EditorialCart class' category: 'TusLibrosExercise'!
EditorialCart class
	instanceVariableNames: ''!

!EditorialCart class methodsFor: 'instance creation' stamp: 'EE 6/4/2022 16:00:03'!
for: aCatalogue

	^ self new initializeFor: aCatalogue ! !


!EditorialCart class methodsFor: 'error' stamp: 'EE 6/4/2022 16:12:15'!
canNotAddABookOutsideOfTheCatalogue

	self error: self canNotAddABookOutsideOfTheCatalogueErrorMessage.! !

!EditorialCart class methodsFor: 'error' stamp: 'EE 6/4/2022 16:38:48'!
canNotAddNonPositiveQuantityOfABook

	self error: self canNotAddNonPositiveQuantityOfABookErrorMessage.! !


!EditorialCart class methodsFor: 'error messages' stamp: 'EE 6/4/2022 16:01:26'!
canNotAddABookOutsideOfTheCatalogueErrorMessage

	^ 'Can not add a book that is not on the catalogue'! !

!EditorialCart class methodsFor: 'error messages' stamp: 'EE 6/4/2022 16:38:30'!
canNotAddNonPositiveQuantityOfABookErrorMessage
	
	^ 'Can not add a non positive quantity of a book'! !


!classDefinition: #EditorialCatalogue category: 'TusLibrosExercise'!
Object subclass: #EditorialCatalogue
	instanceVariableNames: 'orderedCollection books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!EditorialCatalogue methodsFor: 'initialization' stamp: 'EE 6/4/2022 16:07:16'!
initializeWith: anOrderedCollection 
	
	books := anOrderedCollection.! !


!EditorialCatalogue methodsFor: 'testing' stamp: 'EE 6/4/2022 16:16:49'!
has: anISBN
	
	^ books includes: anISBN.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EditorialCatalogue class' category: 'TusLibrosExercise'!
EditorialCatalogue class
	instanceVariableNames: ''!

!EditorialCatalogue class methodsFor: 'instance creation' stamp: 'EE 6/4/2022 16:06:53'!
with: anOrderedCollection 

	^self new initializeWith: anOrderedCollection ! !
