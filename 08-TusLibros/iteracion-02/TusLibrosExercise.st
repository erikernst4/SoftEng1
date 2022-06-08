!classDefinition: #CreditCardTest category: 'TusLibrosExercise'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'EE 6/8/2022 17:36:43'!
test01ACreditCardExpirationDateIsTheDateGivenInTheCreation

	| card |
	card := CreditCard for: 'Hernán Wilkinson' validUntil: (GregorianMonthOfYear current) numbered: 4444444444444444.
	
	self assert: (GregorianMonthOfYear current) equals: card expirationDate! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'EE 6/8/2022 17:41:44'!
test02CanNotCreateACreditCardWithoutAnOwnerName

	self 
		should: [CreditCard for: '' validUntil: (GregorianMonthOfYear current) numbered: 4444444444444444.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: CreditCard canNotCreateACardWithAnEmptyNameErrorMessage equals: anError messageText.
			].! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'EE 6/8/2022 18:05:14'!
test03CanNotCreateACreditCardWithAnInvalidNumber

	self 
		should: [CreditCard for: 'Felipe Pettinato' validUntil: (GregorianMonthOfYear current) numbered: 911.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: CreditCard canNotCreateACreditCardWithAnInvalidNumberErrorMessage equals: anError messageText.
			].! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibrosExercise'!
TestCase subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'EE 6/8/2022 18:37:00'!
test01MerchantProcessorDebitReturnsSuccessWhenDebitingWithValidCard

	| merchantProcessor returnMessage |
	
	merchantProcessor  := MerchantProcessorSimulator new.
	
	returnMessage := merchantProcessor debit: 44.44 from: 4444444444444444 withExpirationDate: (GregorianMonthOfYear current next) ownedBy: 'El Diego'.
	
	self assert: 'Success' equals: returnMessage.! !


!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'EE 6/8/2022 18:36:54'!
debit: anAmountOfMoney from: aCreditCardNumber withExpirationDate: aGregorianMonthOfYear ownedBy: aName 
	
	^'Success'! !


!classDefinition: #PublisherTest category: 'TusLibrosExercise'!
TestCase subclass: #PublisherTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherTest methodsFor: 'instance creation' stamp: 'EE 6/8/2022 17:20:06'!
catalogueWithOneBook

	| books |
	
	books := OrderedCollection new.
	books add: 12.
	
	^ books.
	! !

!PublisherTest methodsFor: 'instance creation' stamp: 'EE 6/8/2022 17:20:15'!
catalogueWithTwoBooks

	| books |
	
	books := OrderedCollection new.
	books add: 12; add: 13.
	
	^ books.
	! !

!PublisherTest methodsFor: 'instance creation' stamp: 'EE 6/8/2022 17:20:19'!
catalogueWithZeroBooks

	| books |
	
	books := OrderedCollection new.
	
	^ books.
	! !


!classDefinition: #PublisherCartTest category: 'TusLibrosExercise'!
PublisherTest subclass: #PublisherCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test01CartIsEmptyWhenCreated

	| cart catalogue |
	
	catalogue := self catalogueWithZeroBooks.
	cart := PublisherCart for: catalogue.
	
	self assert: cart isEmpty.! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test02CartIsNotEmptyWhenAddedABook

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1.
	
	self deny: cart isEmpty.! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test03CartHasOnlyTheBookAdded

	| cart expectedBooks catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1.
	
	expectedBooks := Set with:12.
	
	self assert: (expectedBooks) equals: (cart books).! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test04CartHasOnlyTheBooksAdded

	| cart expectedBooks catalogue |
	
	catalogue := self catalogueWithTwoBooks.
	
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1; addBookWithISBN: 13 quantity: 1.
	
	expectedBooks := Set with:12 with:13.
	
	self assert: expectedBooks equals: (cart books).! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test05CanNotAddABookThatIsNotInTheCatalogue

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	
	self 
		should: [ cart addBookWithISBN: 13 quantity: 1 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: PublisherCart canNotAddABookOutsideOfTheCatalogueErrorMessage equals: anError messageText.
			self assert: cart isEmpty.
			]! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test06ABookAddedMoreThanOnceQuantityInACartIsTheSumOfTheAddedAmount

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1.
	cart addBookWithISBN: 12 quantity: 4.
	
	self assert: 5 equals: (cart quantityOf: 12).
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test07ABookAddedOnceQuantityInACartIsTheAddedAmount

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1.
	
	self assert: 1 equals: (cart quantityOf: 12).
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test08ACartCanNotAddNonPositiveQuantityOfABook

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	
	self 
		should: [ cart addBookWithISBN: 12 quantity: -1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PublisherCart canNotAddNonPositiveQuantityOfABookErrorMessage equals: anError messageText.
			self assert: cart isEmpty.
			]! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test09CannotAskTheQuantityOfABookThatHasNotBeenAdd

	| cart catalogue |

	catalogue := self catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	
	self 
		should: [ cart quantityOf: 12 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: PublisherCart bookHasNotBeenAddToTheCartMessage equals: anError messageText.
			self assert: cart isEmpty.
			].
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test10CartListOfAnEmptyCartShouldReturnEmptyString

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	
	self assert: '' equals: cart asStringList.
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test11CartListOfACartWithOneBookShouldReturnTheBookISBNAndItsQuantity

	| cart catalogue |

	catalogue := self catalogueWithTwoBooks.
	
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1. 
	
	self assert: '|12|1' equals: cart asStringList.
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test12CartListOfACartWithMultipleBooksShouldReturnItsBooksISBNAndQuantity

	| cart catalogue |

	catalogue := self catalogueWithTwoBooks.
	
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1. 
	cart addBookWithISBN: 13 quantity: 2. 
	
	self assert: '|12|1|13|2' equals: cart asStringList
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'EE 6/6/2022 18:05:49'!
test13ACartCanNotAddANonIntegerQuantity

	| cart catalogue |
	
	catalogue := self catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	
	self 
		should: [ cart addBookWithISBN: 12 quantity: 1.5. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PublisherCart canNotAddANonIntegerQuantityOfABookErrorMessage equals: anError messageText.
			self assert: cart isEmpty.
			]! !



!classDefinition: #PublisherCashierTest category: 'TusLibrosExercise'!
PublisherTest subclass: #PublisherCashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherCashierTest methodsFor: 'tests' stamp: 'EE 6/8/2022 17:36:43'!
test01ACashierCantMakeTheCheckoutOfAnEmptyCart

	| cashier cart card date |
	
	cart := PublisherCart for: (OrderedCollection new).
	
	card := CreditCard for: 'Hernán Wilkinson' validUntil: (GregorianMonthOfYear current next) numbered: 4444444444444444.
	
	date := GregorianMonthOfYear current.
	
	cashier := PublisherCashier for: cart withPrices: (Dictionary new) withCard: card on: date.
	
	self 
		should: [cashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: PublisherCashier canNotDoTheCheckoutToAnEmptyCartErrorMessage equals: anError messageText.
			self assert: 0 equals: cashier amountPaid.
			].! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'EE 6/8/2022 17:36:43'!
test02ACashierAmountPaidAfterCheckoutIsThePriceOfTheBookMultipliedForItsQuantity

	| cashier cart catalogue prices card date |
	
	catalogue := Set with: 12.
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 2.
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	card := CreditCard for: 'Hernán Wilkinson' validUntil: (GregorianMonthOfYear current next) numbered: 4444444444444444.
	
	date := GregorianMonthOfYear current.
	
	cashier := PublisherCashier for: cart withPrices: prices withCard: card on: date.
	
	cashier checkout.
	self assert: (4 * 2) equals: cashier amountPaid.! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'EE 6/8/2022 17:36:43'!
test03ACashierAmountPaidAfterCheckoutIsSumOfThePriceOfTheBookMultipliedForItsQuantity

	| cashier cart catalogue prices card date |
	
	catalogue := Set with: 12 with: 13.
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 2; addBookWithISBN: 13 quantity: 1.
	
	prices := Dictionary new.
	prices at: 12 put: 4 ; at: 13 put: 44.
	
	card := CreditCard for: 'Hernán Wilkinson' validUntil: (GregorianMonthOfYear current next) numbered: 4444444444444444.
	
	date := GregorianMonthOfYear current.
	
	cashier := PublisherCashier for: cart withPrices: prices withCard: card on: date.
	
	cashier checkout.
	self assert: (4 * 2 + (1 * 44)) equals: cashier amountPaid.! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'EE 6/8/2022 17:36:43'!
test04ACashierMustKnowThePriceForEveryCartBook

	| cart catalogue prices card date |
	
	catalogue := Set with: 12.
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 2.
	prices := Dictionary new. 
	prices at: 13 put: 4.
	
	card := CreditCard for: 'Hernán Wilkinson' validUntil: (GregorianMonthOfYear current next) numbered: 4444444444444444.
	date := GregorianMonthOfYear current.
	
	self 
		should: [PublisherCashier for: cart withPrices: prices withCard: card on: date.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: PublisherCashier canNotCreateACashierThatDoesntHaveAllThePricesForACartErrorMessage equals: anError messageText.
			].! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'EE 6/8/2022 17:36:43'!
test05ACashierCanNotDoACheckoutMoreThanOnce

	| cart catalogue prices cashier card date |
	
	catalogue := Set with: 12.
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 2.
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	card := CreditCard for: 'Hernán Wilkinson' validUntil: (GregorianMonthOfYear current next) numbered: 4444444444444444.
	date := GregorianMonthOfYear current.
	cashier := PublisherCashier for: cart withPrices: prices withCard: card on: date.
	
	cashier checkout.
	
	self 
		should: [cashier checkout.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: PublisherCashier canNotMakeACheckoutMoreThanOnceErrorMessage equals: anError messageText.
			self assert: (4 * 2) equals: cashier amountPaid.
			].! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'EE 6/8/2022 17:36:43'!
test06ACashierCanNotDoTheCheckoutWithAnExpiredCard

	| cashier cart catalogue prices card date |
	
	catalogue := Set with: 12.
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 2.
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	card := CreditCard for: 'Hernán Wilkinson' validUntil: (GregorianMonthOfYear current previous) numbered: 4444444444444444.
	date := GregorianMonthOfYear current.
	
	cashier := PublisherCashier for: cart withPrices: prices withCard: card on: date.
	
	self 
		should: [cashier checkout.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: PublisherCashier canNotMakeACheckoutWithAnExpiredCreditCardErrorMessages equals: anError messageText.
			self assert: 0 equals: cashier amountPaid.
			].! !


!classDefinition: #CreditCard category: 'TusLibrosExercise'!
Object subclass: #CreditCard
	instanceVariableNames: 'ownerName expirationDate gregorianMonthOfYear number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!CreditCard methodsFor: 'initialization' stamp: 'EE 6/8/2022 17:33:12'!
initializeFor: aName validUntil: aGregorianMonthOfYear 
	
	ownerName := aName.
	expirationDate := aGregorianMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'EE 6/8/2022 17:10:22'!
hasExpiredOn: aDate

	^ aDate > expirationDate
! !


!CreditCard methodsFor: 'accessing' stamp: 'EE 6/8/2022 17:33:33'!
expirationDate

	^ expirationDate ! !

!CreditCard methodsFor: 'accessing' stamp: 'EE 6/8/2022 17:33:57'!
number

	^ number ! !

!CreditCard methodsFor: 'accessing' stamp: 'EE 6/8/2022 17:33:45'!
ownerName

	^ ownerName ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibrosExercise'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'EE 6/8/2022 17:45:44'!
for: aName validUntil: aGregorianMonthOfYear numbered: aSixteenDigitNumber

	self assertNameNotEmpty: aName.
	
	self assertNumberIsValid: aSixteenDigitNumber.
	
	^self new initializeFor: aName validUntil: aGregorianMonthOfYear ! !


!CreditCard class methodsFor: 'errors' stamp: 'EE 6/8/2022 17:41:31'!
canNotCreateACardWithAnEmptyName
	
	self error: self canNotCreateACardWithAnEmptyNameErrorMessage! !

!CreditCard class methodsFor: 'errors' stamp: 'EE 6/8/2022 17:58:59'!
canNotCreateACreditCardWithAnInvalidNumber
	
	self error: self canNotCreateACreditCardWithAnInvalidNumberErrorMessage! !


!CreditCard class methodsFor: 'error messages' stamp: 'EE 6/8/2022 17:41:44'!
canNotCreateACardWithAnEmptyNameErrorMessage

	^'Can not create a credit card with an empty name'! !

!CreditCard class methodsFor: 'error messages' stamp: 'EE 6/8/2022 17:59:37'!
canNotCreateACreditCardWithAnInvalidNumberErrorMessage
	
	^'Invalid number: creation of credit card failed'! !


!CreditCard class methodsFor: 'assertions' stamp: 'EE 6/8/2022 17:43:22'!
assertNameNotEmpty: aString 
	
	(aString isEmpty) ifTrue: [self canNotCreateACardWithAnEmptyName ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'EE 6/8/2022 18:02:46'!
assertNumberIsValid: anObject

	(((anObject isInteger not) or: [(anObject isInteger) and: [anObject < 0]]) or: [((anObject isInteger) and: [anObject > 0]) and: [(anObject decimalDigitLength = 16) not]])
		ifTrue: [self canNotCreateACreditCardWithAnInvalidNumber].
	
	! !


!classDefinition: #PublisherCart category: 'TusLibrosExercise'!
Object subclass: #PublisherCart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherCart methodsFor: 'testing' stamp: 'EE 6/4/2022 15:50:11'!
isEmpty

	^ books isEmpty.! !


!PublisherCart methodsFor: 'assertions' stamp: 'EE 6/6/2022 17:49:33'!
assertBookIsIncludedInCart: anISBN

	((books asSet) includes: anISBN) ifFalse: [
		self class error: ( self class bookHasNotBeenAddToTheCart).
	].! !

!PublisherCart methodsFor: 'assertions' stamp: 'EE 6/6/2022 17:20:46'!
assertCanAddBook: anISBN quantity: aQuantity 

	self assertIsValidBook: anISBN.
	
	self assertIsValidQuantity: aQuantity.
	
! !

!PublisherCart methodsFor: 'assertions' stamp: 'EE 6/6/2022 17:22:53'!
assertIsValidBook: anISBN

	^ (catalogue includes: anISBN) ifFalse: [ 
		self class canNotAddABookOutsideOfTheCatalogue
	]! !

!PublisherCart methodsFor: 'assertions' stamp: 'EE 6/6/2022 17:42:33'!
assertIsValidQuantity: aQuantity

	(aQuantity > 0) ifFalse: [ 
		self class canNotAddNonPositiveQuantityOfABook 
	].

	(aQuantity isInteger) ifFalse: [ self class canNotAddANonIntegerQuantityOfABook].! !


!PublisherCart methodsFor: 'adding' stamp: 'EE 6/6/2022 17:46:03'!
addBookWithISBN: anISBN quantity: aQuantity

	
	
	self assertCanAddBook: anISBN quantity: aQuantity.
	
	books add: anISBN withOccurrences: aQuantity.! !


!PublisherCart methodsFor: 'initialization' stamp: 'EE 6/6/2022 17:45:33'!
initializeFor: aCatalogue

	books := Bag new.
	catalogue := aCatalogue.! !


!PublisherCart methodsFor: 'accessing' stamp: 'EE 6/6/2022 17:48:26'!
books
	
	^ books asSet.! !

!PublisherCart methodsFor: 'accessing' stamp: 'EE 6/6/2022 17:50:24'!
quantityOf: anISBN

	self assertBookIsIncludedInCart: anISBN.
	
	^books occurrencesOf: anISBN.! !


!PublisherCart methodsFor: 'converting' stamp: 'EE 6/6/2022 17:50:59'!
asStringList

	| list |

	list := ''.
	
	(books asSet) do: [ :key |
		
		list := list, '|'	, key asString.
		list := list, '|', ((books occurrencesOf: key) asString).
		
	].

	^ list.! !


!PublisherCart methodsFor: 'enumerating' stamp: 'EE 6/6/2022 20:42:28'!
sum: aClosure

	^ books asSet sum: aClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PublisherCart class' category: 'TusLibrosExercise'!
PublisherCart class
	instanceVariableNames: ''!

!PublisherCart class methodsFor: 'instance creation' stamp: 'EE 6/4/2022 16:00:03'!
for: aCatalogue

	^ self new initializeFor: aCatalogue ! !


!PublisherCart class methodsFor: 'error' stamp: 'LT 6/5/2022 15:02:02'!
bookHasNotBeenAddToTheCart

	self error: self bookHasNotBeenAddToTheCartMessage.! !

!PublisherCart class methodsFor: 'error' stamp: 'EE 6/4/2022 16:12:15'!
canNotAddABookOutsideOfTheCatalogue

	self error: self canNotAddABookOutsideOfTheCatalogueErrorMessage.! !

!PublisherCart class methodsFor: 'error' stamp: 'EE 6/6/2022 17:40:00'!
canNotAddANonIntegerQuantityOfABook

	self error: self canNotAddANonIntegerQuantityOfABookErrorMessage.! !

!PublisherCart class methodsFor: 'error' stamp: 'EE 6/4/2022 16:38:48'!
canNotAddNonPositiveQuantityOfABook

	self error: self canNotAddNonPositiveQuantityOfABookErrorMessage.! !


!PublisherCart class methodsFor: 'error messages' stamp: 'LT 6/5/2022 15:01:36'!
bookHasNotBeenAddToTheCartMessage
	
	^ 'The book has not been add to the cart'! !

!PublisherCart class methodsFor: 'error messages' stamp: 'EE 6/4/2022 16:01:26'!
canNotAddABookOutsideOfTheCatalogueErrorMessage

	^ 'Can not add a book that is not on the catalogue'! !

!PublisherCart class methodsFor: 'error messages' stamp: 'EE 6/6/2022 17:39:41'!
canNotAddANonIntegerQuantityOfABookErrorMessage

	^'Quantity must be integer'! !

!PublisherCart class methodsFor: 'error messages' stamp: 'EE 6/4/2022 16:38:30'!
canNotAddNonPositiveQuantityOfABookErrorMessage
	
	^ 'Can not add a non positive quantity of a book'! !


!classDefinition: #PublisherCashier category: 'TusLibrosExercise'!
Object subclass: #PublisherCashier
	instanceVariableNames: 'publisherCart amountPaid alreadyPaid pricesCatalogue card date'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherCashier methodsFor: 'initialization' stamp: 'EE 6/8/2022 17:15:57'!
initializeFor: aPublisherCart withPrices: aCataloguePrices withCard: aCard on: aDate 
	
	publisherCart := aPublisherCart.
	pricesCatalogue := aCataloguePrices.
	card := aCard.
	alreadyPaid := false.
	amountPaid := 0.
	date := aDate.! !


!PublisherCashier methodsFor: 'assertions' stamp: 'EE 6/6/2022 21:16:27'!
assertAlreadyPaid

	(alreadyPaid) ifTrue: [self class canNotMakeACheckoutMoreThanOnce]! !

!PublisherCashier methodsFor: 'assertions' stamp: 'EE 6/6/2022 20:22:01'!
assertCanMakeTheCheckout

	self assertCartIsNotEmpty.
	
	self assertAlreadyPaid! !

!PublisherCashier methodsFor: 'assertions' stamp: 'EE 6/6/2022 21:43:43'!
assertCardIsValid
	
	(card hasExpiredOn: date ) ifTrue: [self class canNotMakeACheckoutWithAnExpiredCreditCard ]! !

!PublisherCashier methodsFor: 'assertions' stamp: 'EE 6/6/2022 21:07:13'!
assertCartIsNotEmpty

	(publisherCart isEmpty) ifTrue: [self class canNotDoTheCheckoutToAnEmptyCart]! !


!PublisherCashier methodsFor: 'checkout' stamp: 'EE 6/8/2022 17:13:45'!
checkout	

	self assertCanMakeTheCheckout.
	
	self assertCardIsValid.
	
	amountPaid := publisherCart sum: [ :book | (self priceOfBook: book) * (publisherCart quantityOf: book) ].
	
	alreadyPaid := true.! !

!PublisherCashier methodsFor: 'checkout' stamp: 'EE 6/8/2022 17:16:09'!
priceOfBook: aBook 
	
	^ pricesCatalogue at: aBook! !


!PublisherCashier methodsFor: 'accessing' stamp: 'EE 6/6/2022 19:22:12'!
amountPaid
	
	^ amountPaid! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PublisherCashier class' category: 'TusLibrosExercise'!
PublisherCashier class
	instanceVariableNames: ''!

!PublisherCashier class methodsFor: 'instance creation' stamp: 'EE 6/6/2022 21:43:59'!
for: aPublisherCart withPrices: aCataloguePrices withCard: aCard on: aDate
	
	self assertThereIsAPriceIn: aCataloguePrices forAllCartBooks: (aPublisherCart books). 
	
	^self new initializeFor: aPublisherCart withPrices: aCataloguePrices withCard: aCard on: aDate! !


!PublisherCashier class methodsFor: 'errors' stamp: 'EE 6/6/2022 19:41:42'!
canNotCreateACashierThatDoesntHaveAllThePricesForACart
	
	self error: self canNotCreateACashierThatDoesntHaveAllThePricesForACartErrorMessage! !

!PublisherCashier class methodsFor: 'errors' stamp: 'EE 6/6/2022 18:54:47'!
canNotDoTheCheckoutToAnEmptyCart
	
	self error: self canNotDoTheCheckoutToAnEmptyCartErrorMessage! !

!PublisherCashier class methodsFor: 'errors' stamp: 'EE 6/6/2022 20:15:33'!
canNotMakeACheckoutMoreThanOnce
	
	self error: self canNotMakeACheckoutMoreThanOnceErrorMessage! !

!PublisherCashier class methodsFor: 'errors' stamp: 'EE 6/6/2022 20:55:53'!
canNotMakeACheckoutWithAnExpiredCreditCard
	
	self error: self canNotMakeACheckoutWithAnExpiredCreditCardErrorMessages ! !


!PublisherCashier class methodsFor: 'assertions' stamp: 'EE 6/6/2022 19:50:39'!
assertThereIsAPriceIn: aCatalogPrices forAllCartBooks: aCartBooks

	| booksAreIncluded |
	
	booksAreIncluded := true.
	
	aCartBooks do: [:aBook | booksAreIncluded := booksAreIncluded and: [aCatalogPrices keys includes: aBook]].
	
	booksAreIncluded ifFalse: [self canNotCreateACashierThatDoesntHaveAllThePricesForACart ].! !


!PublisherCashier class methodsFor: 'error messages' stamp: 'EE 6/6/2022 19:42:18'!
canNotCreateACashierThatDoesntHaveAllThePricesForACartErrorMessage
	
	^' Can not create a cashier for a cart for which it doesnt have all the prices'! !

!PublisherCashier class methodsFor: 'error messages' stamp: 'EE 6/6/2022 18:55:21'!
canNotDoTheCheckoutToAnEmptyCartErrorMessage
	
	^' Can not do a checkout to an empty cart'! !

!PublisherCashier class methodsFor: 'error messages' stamp: 'EE 6/6/2022 20:15:18'!
canNotMakeACheckoutMoreThanOnceErrorMessage

	^'Can not make a checkout: already done'! !

!PublisherCashier class methodsFor: 'error messages' stamp: 'EE 6/6/2022 20:55:23'!
canNotMakeACheckoutWithAnExpiredCreditCardErrorMessages

	^ 'Can not make a checkout: credit card expired'
	
	! !
