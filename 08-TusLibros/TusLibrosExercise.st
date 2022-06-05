!classDefinition: #CartTest category: 'TusLibrosExercise'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:32:33'!
catalogueWithOneBook

	| books |
	
	books := OrderedCollection new.
	books add: 12.
	
	^ EditorialCatalogue with: books.
	! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:34:57'!
catalogueWithTwoBooks

	| books |
	
	books := OrderedCollection new.
	books add: 12; add: 13.
	
	^ EditorialCatalogue with: books.
	! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:33:51'!
catalogueWithZeroBooks

	| books |
	
	books := OrderedCollection new.
	
	^ EditorialCatalogue with: books.
	! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:34:07'!
test01CartIsEmptyWhenCreated

	| cart catalogue |
	
	catalogue := self catalogueWithZeroBooks.
	cart := EditorialCart for: catalogue.
	
	self assert: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:39:45'!
test02CartIsNotEmptyWhenAddedABook

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := EditorialCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1.
	
	self deny: cart isEmpty.! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:39:53'!
test03CartHasOnlyTheBookAdded

	| cart expectedBooks catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := EditorialCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1.
	
	expectedBooks := #(12).
	
	self assert: (expectedBooks) equals: (cart books).! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:41:23'!
test04CartHasOnlyTheBooksAdded

	| cart expectedBooks catalogue |
	
	catalogue := self catalogueWithTwoBooks.
	
	cart := EditorialCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1; addBookWithISBN: 13 quantity: 1.
	
	expectedBooks := #(12 13).
	
	self assert: expectedBooks equals: (cart books).! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:41:30'!
test05CanNotAddABookThatIsNotInTheCatalogue

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := EditorialCart for: catalogue.
	
	self 
		should: [ cart addBookWithISBN: 13 quantity: 1 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: EditorialCart canNotAddABookOutsideOfTheCatalogueErrorMessage equals: anError messageText.
			self assert: cart isEmpty.
			]! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:41:38'!
test06ABookAddedMoreThanOnceQuantityInACartIsTheSumOfTheAddedAmount

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := EditorialCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1.
	cart addBookWithISBN: 12 quantity: 4.
	
	self assert: 5 equals: (cart quantityOf: 12).
	! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:41:45'!
test07ABookAddedOnceQuantityInACartIsTheAddedAmount

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := EditorialCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1.
	
	self assert: 1 equals: (cart quantityOf: 12).
	! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:41:55'!
test08ACartCanNotAddNonPositiveQuantityOfABook

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := EditorialCart for: catalogue.
	
	self 
		should: [ cart addBookWithISBN: 12 quantity: -1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: EditorialCart canNotAddNonPositiveQuantityOfABookErrorMessage equals: anError messageText.
			self assert: cart isEmpty.
			]! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:42:01'!
test09CannotAskTheQuantityOfABookThatHasNotBeenAdd

	| cart catalogue |

	catalogue := self catalogueWithOneBook.
	
	cart := EditorialCart for: catalogue.
	
	self 
		should: [ cart quantityOf: 12 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: EditorialCart bookHasNotBeenAddToTheCartMessage equals: anError messageText.
			self assert: cart isEmpty.
			].
	! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:42:07'!
test10CartListOfAnEmptyCartShouldReturnEmptyString

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := EditorialCart for: catalogue.
	
	self assert: '' equals: cart list.
	! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:42:14'!
test11CartListOfACartWithOneBookShouldReturnTheBookISBNAndItsQuantity

	| cart catalogue |

	catalogue := self catalogueWithTwoBooks.
	
	cart := EditorialCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1. 
	
	self assert: '|12|1' equals: cart list.
	! !

!CartTest methodsFor: 'tests' stamp: 'LT 6/5/2022 16:42:21'!
test12CartListOfACartWithMultipleBooksShouldReturnItsBooksISBNAndQuantity

	| cart catalogue |

	catalogue := self catalogueWithTwoBooks.
	
	cart := EditorialCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1. 
	cart addBookWithISBN: 13 quantity: 2. 
	
	self assert: '|12|1|13|2' equals: cart list
	! !


!classDefinition: #EditorialCart category: 'TusLibrosExercise'!
Object subclass: #EditorialCart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!EditorialCart methodsFor: 'testing' stamp: 'EE 6/4/2022 15:50:11'!
isEmpty

	^ books isEmpty.! !


!EditorialCart methodsFor: 'assertions' stamp: 'LT 6/5/2022 16:15:25'!
assertBookIsIncludedInCart: anISBN

	((books keys) includes: anISBN) ifFalse: [
		self class error: ( self class bookHasNotBeenAddToTheCart).
	].! !

!EditorialCart methodsFor: 'assertions' stamp: 'LT 6/5/2022 16:15:16'!
assertCanAddBook: anISBN quantity: aQuantity 

	(catalogue has: anISBN) ifFalse: [ 
		self class canNotAddABookOutsideOfTheCatalogue
	].
	
	(aQuantity > 0) ifFalse: [ 
		self class canNotAddNonPositiveQuantityOfABook 
	].
	
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

!EditorialCart methodsFor: 'accessing' stamp: 'LT 6/5/2022 16:14:44'!
quantityOf: anISBN

	self assertBookIsIncludedInCart: anISBN.
	
	^books at: anISBN.! !


!EditorialCart methodsFor: 'printing' stamp: 'LT 6/5/2022 15:58:32'!
list

	| list |

	list := ''.
	
	(books keys) do: [ :key |
		
		list := list, '|'	, key asString.
		list := list, '|', ((books at: key) asString).
		
	].

	^ list.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EditorialCart class' category: 'TusLibrosExercise'!
EditorialCart class
	instanceVariableNames: ''!

!EditorialCart class methodsFor: 'instance creation' stamp: 'EE 6/4/2022 16:00:03'!
for: aCatalogue

	^ self new initializeFor: aCatalogue ! !


!EditorialCart class methodsFor: 'error' stamp: 'LT 6/5/2022 15:02:02'!
bookHasNotBeenAddToTheCart

	self error: self bookHasNotBeenAddToTheCartMessage.! !

!EditorialCart class methodsFor: 'error' stamp: 'EE 6/4/2022 16:12:15'!
canNotAddABookOutsideOfTheCatalogue

	self error: self canNotAddABookOutsideOfTheCatalogueErrorMessage.! !

!EditorialCart class methodsFor: 'error' stamp: 'EE 6/4/2022 16:38:48'!
canNotAddNonPositiveQuantityOfABook

	self error: self canNotAddNonPositiveQuantityOfABookErrorMessage.! !


!EditorialCart class methodsFor: 'error messages' stamp: 'LT 6/5/2022 15:01:36'!
bookHasNotBeenAddToTheCartMessage
	
	^ 'The book has not been add to the cart'! !

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
