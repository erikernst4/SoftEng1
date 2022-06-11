!classDefinition: #CreditCardTest category: 'TusLibrosExercise'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 00:03:21'!
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


!classDefinition: #InterfaceTest category: 'TusLibrosExercise'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 20:58:52'!
test01InterfaceCreateCartWithValidAuthenticationCreatesAnEmptyCart

	| authenticator cartId interface |
	authenticator := AuthenticatorSimulator new.
	
	interface := Interface with: authenticator for: OrderedCollection new.
	cartId := interface createCartFor: 'Username' withPassword: '123' .
	
	self assert: (interface listCart: cartId) isEmpty.! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 20:58:52'!
test02InterfaceCreateCartWithInvalidAuthenticationDoesNotCreateACart

	| authenticator interface |
	authenticator := AuthenticatorSimulator new.
	authenticator invalidAuthentication.
	
	interface := Interface with: authenticator for: OrderedCollection new.
	
	self 
		should: [interface createCartFor: 'Username' withPassword: '123']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface invalidAuthenticationErrorMessage.
		]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 21:12:32'!
test03XXXX

	| authenticator interface cartId expectedContent |
	authenticator := AuthenticatorSimulator new.
	
	interface := Interface with: authenticator for: (PublisherTest new catalogueWithOneBook).
	cartId := interface createCartFor: 'Username' withPassword: '123'.
	
	interface addToCart: cartId aBook: 12 quantity: 1.
	expectedContent := Bag new.
	expectedContent add: 12 withOccurrences: 1.
	
	self assert: expectedContent equals: (interface listCart: cartId).
		! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 21:16:19'!
test04InterfaceCannotAddWithInvalidCartId

	| authenticator interface cartId |
	
	authenticator := AuthenticatorSimulator new.
	
	interface := Interface with: authenticator for: (PublisherTest new catalogueWithOneBook).
	cartId := interface createCartFor: 'Username' withPassword: '123'.
	
	self 
		should: [interface addToCart: (cartId + 1) aBook: 12 quantity: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface invalidCartIdErrorMessage.
		]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 21:20:49'!
test05InterfaceCannotListACartWithInvalidCartId

	| authenticator interface |
	
	authenticator := AuthenticatorSimulator new.
	
	interface := Interface with: authenticator for: (PublisherTest new catalogueWithOneBook).
	
	self 
		should: [interface listCart: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface invalidCartIdErrorMessage.
		]! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibrosExercise'!
TestCase subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'simulatedAction amountOfMoneyDebited creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'LT 6/9/2022 00:51:54'!
debit: anAmountOfMoney from: aCreditCard
	
	^simulatedAction value: anAmountOfMoney value: aCreditCard.! !


!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'LT 6/9/2022 00:51:13'!
initialize

	simulatedAction := [ :anAmountOfMoney :aCreditCard | 
		amountOfMoneyDebited := anAmountOfMoney.
		creditCard := aCreditCard.]! !


!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 01:06:44'!
denyCardWithNoFunds

	simulatedAction := [ :anAmount :aCreditCard | self error: PublisherCashier canNotMakeACheckoutWithCardWithNoFundsErrorMessages ]! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 01:00:47'!
denyStolenCard

	simulatedAction := [ :anAmount :aCreditCard | self error: PublisherCashier canNotMakeACheckoutWithStolenCardErrorMessages ]! !


!classDefinition: #PublisherTest category: 'TusLibrosExercise'!
TestCase subclass: #PublisherTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherTest methodsFor: 'instance creation' stamp: 'LT 6/9/2022 01:16:33'!
cartWithOneBook

	| cartWithOneBook catalogue |
	
	catalogue := self catalogueWithOneBook.

	cartWithOneBook := PublisherCart for: catalogue.
	cartWithOneBook addBookWithISBN: 12 quantity: 2.
	
	^ cartWithOneBook.! !

!PublisherTest methodsFor: 'instance creation' stamp: 'LT 6/9/2022 01:25:37'!
cartWithTwoBooks

	| cartWithTwoBooks catalogue |
	
	catalogue := self catalogueWithTwoBooks.
	
	cartWithTwoBooks := PublisherCart for: catalogue.
	cartWithTwoBooks addBookWithISBN: 12 quantity: 1; addBookWithISBN: 13 quantity: 1.
	
	^ cartWithTwoBooks.! !

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

!PublisherTest methodsFor: 'instance creation' stamp: 'LT 6/9/2022 01:24:01'!
emptyCart

	| emptyCart catalogue |
	
	catalogue := self catalogueWithZeroBooks.
	emptyCart := PublisherCart for: catalogue.
		
	^ emptyCart.! !


!classDefinition: #PublisherCartTest category: 'TusLibrosExercise'!
PublisherTest subclass: #PublisherCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:24:22'!
test01CartIsEmptyWhenCreated

	| cart |
	
	cart := self emptyCart.
	
	self assert: cart isEmpty.! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:16:04'!
test02CartIsNotEmptyWhenAddedABook

	| cart |
	
	cart := self cartWithOneBook.
	
	self deny: cart isEmpty.! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:17:13'!
test03CartHasOnlyTheBookAdded

	| cart expectedBooks |
	
	cart := self cartWithOneBook.
	
	expectedBooks := Set with:12.
	
	self assert: (expectedBooks) equals: (cart books).! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:25:58'!
test04CartHasOnlyTheBooksAdded

	| cart expectedBooks |
	
	cart := self cartWithTwoBooks .
	
	expectedBooks := Set with:12 with:13.
	
	self assert: expectedBooks equals: (cart books).! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:26:34'!
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

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:28:53'!
test07ACartCanNotAddNonPositiveQuantityOfABook

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

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:29:41'!
test08CannotAskTheQuantityOfABookThatHasNotBeenAdd

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

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:31:18'!
test09CartListOfAnEmptyCartShouldReturnEmptyString

	| cart |
	
	cart := self emptyCart.
	
	self assert: '' equals: cart asStringList.
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:31:27'!
test10CartListOfACartWithOneBookShouldReturnTheBookISBNAndItsQuantity

	| cart |

	cart := self cartWithOneBook.
	
	self assert: '|12|2' equals: cart asStringList.
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:31:36'!
test11CartListOfACartWithMultipleBooksShouldReturnItsBooksISBNAndQuantity

	| cart |

	cart := self cartWithTwoBooks.
	
	self assert: '|12|1|13|1' equals: cart asStringList
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:32:40'!
test12ACartCanNotAddANonIntegerQuantity

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

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:33:37'!
test01ACashierCantMakeTheCheckoutOfAnEmptyCart

	| cashier cart card date salesBook merchantProcessor |
	
	salesBook  := OrderedCollection new.
	
	cart := self emptyCart.
	
	card := self validCard.
	
	date := GregorianMonthOfYear current.
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: (Dictionary new) 
		registerOn: salesBook 
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
	
	self 
		should: [cashier checkout]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: PublisherCashier canNotDoTheCheckoutToAnEmptyCartErrorMessage 
			equals: anError messageText.
			
			self deny: cashier cartHasBeenPaid.
			self assert: salesBook isEmpty.
		].! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:35:18'!
test02ACashierAmountPaidAfterCheckoutIsThePriceOfTheBookMultipliedForItsQuantity

	| cashier cart prices card date merchantProcessor |
	
	cart := self cartWithOneBook.
	
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	card := self validCard.
	
	date := GregorianMonthOfYear current.
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: prices 
		registerOn: OrderedCollection new
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
	
	cashier checkout.
	
	self assert: (4 * 2) equals: cashier amountPaid.! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:36:11'!
test03ACashierAmountPaidAfterCheckoutIsSumOfThePriceOfTheBookMultipliedForItsQuantity

	| cashier cart catalogue prices card date merchantProcessor |
	
	catalogue := Set with: 12 with: 13.
	
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 2; addBookWithISBN: 13 quantity: 1.
	
	prices := Dictionary new.
	prices at: 12 put: 4 ; at: 13 put: 44.
	
	card := self validCard.
	
	date := GregorianMonthOfYear current.
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: prices 
		registerOn: OrderedCollection new
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
	
	cashier checkout.
	
	self assert: (4 * 2 + (1 * 44)) equals: cashier amountPaid.! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:38:02'!
test04ACashierMustKnowThePriceForEveryCartBook

	| cart prices card date merchantProcessor |
	
	cart := self cartWithOneBook.
	
	prices := Dictionary new. 
	prices at: 13 put: 4.
	
	card := self validCard.
	
	date := GregorianMonthOfYear current.
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	self 
		should: [ PublisherCashier 
			for: cart 
			withPrices: prices 
			registerOn: (OrderedCollection new) 
			withCard: card 
			on: date 
			withMerchantProcessor: 	merchantProcessor.
		] raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self 
			assert: PublisherCashier canNotCreateACashierThatDoesntHaveAllThePricesForACartErrorMessage 
			equals: anError messageText.
		].! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:38:12'!
test05ACashierCanNotDoACheckoutMoreThanOnce

	| cart prices cashier card date merchantProcessor |
	
	cart := self cartWithOneBook.
	
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	card := self validCard.
	
	date := GregorianMonthOfYear current.
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: prices 
		registerOn: OrderedCollection new
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
	
	cashier checkout.
	
	self 
		should: [cashier checkout.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: PublisherCashier canNotMakeACheckoutMoreThanOnceErrorMessage equals: anError messageText.
			self assert: (4 * 2) equals: cashier amountPaid.
		].! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:38:33'!
test06ACashierCanNotDoTheCheckoutWithAnExpiredCard

	| cashier cart prices card date merchantProcessor |
	
	cart := self cartWithOneBook.
	
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	card := self invalidCard.
	
	date := GregorianMonthOfYear current.
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: prices 
		registerOn: OrderedCollection new
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
	
	self 
		should: [cashier checkout.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self 
			assert: PublisherCashier canNotMakeACheckoutWithAnExpiredCreditCardErrorMessages 
			equals: anError messageText.
			self deny: cashier cartHasBeenPaid.
		].! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:38:42'!
test07WhenACashierDoesACheckoutItSaveTheSaleInSalesBook

	| cashier cart prices card date salesBook merchantProcessor |
	
	salesBook := OrderedCollection new.
	
	cart := self cartWithOneBook.
	
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	card := self validCard.
	date := GregorianMonthOfYear current.
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: prices
		registerOn: salesBook 
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
		
	cashier checkout.
	
	self assert: salesBook includes: cashier amountPaid.! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/9/2022 00:41:27'!
test08ACashierCollaboratesWithMerchantProcessorAndItAllowsTheCheckout

	| cashier cart prices card date salesBook merchantProcessor |
	
	salesBook := OrderedCollection new.
	
	cart := self cartWithOneBook.
	
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	card := self validCard.
	date := GregorianMonthOfYear current.
	
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: prices
		registerOn: salesBook 
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
		
	cashier checkout.
	
	self assert: salesBook includes: cashier amountPaid.
			! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:38:54'!
test09ACashierCollaboratesWithMerchantProcessorAndItDoesntAllowsTransactionOnStolenCard

	| cashier cart prices card date salesBook merchantProcessor |
	
	salesBook := OrderedCollection new.
	
	cart := self cartWithOneBook.
	
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	card := self validCard.
	date := GregorianMonthOfYear current.
	
	merchantProcessor := MerchantProcessorSimulator new.
	merchantProcessor denyStolenCard.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: prices
		registerOn: salesBook 
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
		
	self 
		should: [cashier checkout.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self 
			assert: PublisherCashier canNotMakeACheckoutWithStolenCardErrorMessages 
			equals: anError messageText.
			self deny: cashier cartHasBeenPaid.
		].
			! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/9/2022 01:39:00'!
test10ACashierCollaboratesWithMerchantProcessorAndItDoesntAllowsTransactionOnCardWithNoFunds

	| cashier cart prices card date salesBook merchantProcessor |
	
	salesBook := OrderedCollection new.
	
	cart := self cartWithOneBook.
	
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	card := self validCard.
	date := GregorianMonthOfYear current.
	
	merchantProcessor := MerchantProcessorSimulator new.
	merchantProcessor denyCardWithNoFunds.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: prices
		registerOn: salesBook 
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
		
	self 
		should: [cashier checkout.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self 
			assert: PublisherCashier canNotMakeACheckoutWithCardWithNoFundsErrorMessages 
			equals: anError messageText.
			self deny: cashier cartHasBeenPaid.
		].
			! !


!PublisherCashierTest methodsFor: 'instance creation' stamp: 'LT 6/9/2022 00:09:40'!
invalidCard

	^ CreditCard for: 'Hernán Wilkinson' validUntil: (GregorianMonthOfYear current previous) numbered: 4444444444444444! !

!PublisherCashierTest methodsFor: 'instance creation' stamp: 'LT 6/9/2022 00:08:52'!
validCard

	^ CreditCard for: 'Hernán Wilkinson' validUntil: (GregorianMonthOfYear current next) numbered: 4444444444444444! !


!classDefinition: #AuthenticatorSimulator category: 'TusLibrosExercise'!
Object subclass: #AuthenticatorSimulator
	instanceVariableNames: 'simulatedAction userId password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!AuthenticatorSimulator methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 20:18:10'!
initialize

	simulatedAction := [ :aUserId :aPassword | 
		userId := aUserId.
		password := aPassword.]! !

!AuthenticatorSimulator methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 20:23:06'!
invalidAuthentication

	simulatedAction := [ :aUserId :aPassword | self error: Interface invalidAuthenticationErrorMessage ]! !

!AuthenticatorSimulator methodsFor: 'as yet unclassified' stamp: 'LT 6/9/2022 20:24:26'!
login: aUserId with: aPassword

	simulatedAction value: aUserId value: aPassword.! !


!classDefinition: #CreditCard category: 'TusLibrosExercise'!
Object subclass: #CreditCard
	instanceVariableNames: 'ownerName expirationDate number'
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


!classDefinition: #Interface category: 'TusLibrosExercise'!
Object subclass: #Interface
	instanceVariableNames: 'authenticatorSimulator authenticator carts catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!Interface methodsFor: 'initialization' stamp: 'LT 6/9/2022 21:12:15'!
initializeWith: anAuthenticator for: aCatalogue 
	
	authenticator := anAuthenticator.
	carts := Dictionary new.
	catalogue := aCatalogue.! !


!Interface methodsFor: 'cart creation' stamp: 'LT 6/9/2022 20:57:22'!
createCartFor: aUserId withPassword: aPassword 

	| cart cartId |
	authenticator login: aUserId with: aPassword.
	
	cartId := ((ParkMiller88Random next) * 1000000) asInteger.
	
	cart := PublisherCart for: catalogue.
	
	carts at: cartId put: cart.
	
	^ cartId.
	
	! !


!Interface methodsFor: 'listing cart' stamp: 'LT 6/9/2022 21:21:13'!
listCart: aCartId

	| cart |
	
	cart := carts at: aCartId ifAbsent: [ self error: self class invalidCartIdErrorMessage].
	
	^ cart bagOfBooks.! !


!Interface methodsFor: 'adding to cart' stamp: 'LT 6/9/2022 21:17:57'!
addToCart: aCartId aBook: anISBN quantity: aQuantity

	| cart |
	
	cart := carts at: aCartId ifAbsent: [ self error: self class invalidCartIdErrorMessage].
	cart addBookWithISBN: anISBN quantity: aQuantity.

	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: 'TusLibrosExercise'!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'instance creation' stamp: 'LT 6/9/2022 20:25:19'!
invalidAuthenticationErrorMessage

	^ 'Error de autenticación'! !

!Interface class methodsFor: 'instance creation' stamp: 'LT 6/9/2022 21:18:38'!
invalidCartIdErrorMessage

	^ 'El CartId ingresado no está registrado'! !

!Interface class methodsFor: 'instance creation' stamp: 'LT 6/9/2022 21:00:10'!
with: anAuthenticatorSimulator for: aCatalogue  
	
	^self new initializeWith: anAuthenticatorSimulator for: aCatalogue ! !


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


!PublisherCart methodsFor: 'adding' stamp: 'LT 6/9/2022 01:09:11'!
addBookWithISBN: anISBN quantity: aQuantity
	
	self assertCanAddBook: anISBN quantity: aQuantity.
	
	books add: anISBN withOccurrences: aQuantity.! !


!PublisherCart methodsFor: 'initialization' stamp: 'EE 6/6/2022 17:45:33'!
initializeFor: aCatalogue

	books := Bag new.
	catalogue := aCatalogue.! !


!PublisherCart methodsFor: 'accessing' stamp: 'LT 6/9/2022 21:05:43'!
bagOfBooks
	
	^ books.! !

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
	instanceVariableNames: 'publisherCart amountPaid alreadyPaid pricesCatalogue card date salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherCashier methodsFor: 'initialization' stamp: 'LT 6/9/2022 00:34:26'!
initializeFor: aPublisherCart withPrices: aCataloguePrices registerOn: aSalesBook withCard: aCard on: aDate withMerchantProcessor: aMerchantProcessor
	
	publisherCart := aPublisherCart.
	pricesCatalogue := aCataloguePrices.
	salesBook := aSalesBook.
	card := aCard.
	date := aDate.
	merchantProcessor := aMerchantProcessor.
	
	alreadyPaid := false.
	amountPaid := 0.! !


!PublisherCashier methodsFor: 'assertions' stamp: 'EE 6/6/2022 21:16:27'!
assertAlreadyPaid

	(alreadyPaid) ifTrue: [self class canNotMakeACheckoutMoreThanOnce]! !

!PublisherCashier methodsFor: 'assertions' stamp: 'LT 6/9/2022 00:06:00'!
assertCanMakeTheCheckout

	self assertCartIsNotEmpty.
	
	self assertAlreadyPaid.
	
	self assertCardIsValid.! !

!PublisherCashier methodsFor: 'assertions' stamp: 'EE 6/6/2022 21:43:43'!
assertCardIsValid
	
	(card hasExpiredOn: date ) ifTrue: [self class canNotMakeACheckoutWithAnExpiredCreditCard ]! !

!PublisherCashier methodsFor: 'assertions' stamp: 'EE 6/6/2022 21:07:13'!
assertCartIsNotEmpty

	(publisherCart isEmpty) ifTrue: [self class canNotDoTheCheckoutToAnEmptyCart]! !


!PublisherCashier methodsFor: 'checkout' stamp: 'LT 6/9/2022 00:57:06'!
checkout	

	self assertCanMakeTheCheckout.
	
	amountPaid := publisherCart sum: [ :book | (self priceOfBook: book) * (publisherCart quantityOf: book) ].
	
	merchantProcessor debit: amountPaid from: card.
	
	salesBook add: amountPaid.
	
	alreadyPaid := true.! !

!PublisherCashier methodsFor: 'checkout' stamp: 'EE 6/8/2022 17:16:09'!
priceOfBook: aBook 
	
	^ pricesCatalogue at: aBook! !


!PublisherCashier methodsFor: 'accessing' stamp: 'EE 6/6/2022 19:22:12'!
amountPaid
	
	^ amountPaid! !

!PublisherCashier methodsFor: 'accessing' stamp: 'LT 6/9/2022 01:03:55'!
cartHasBeenPaid
	
	^ alreadyPaid! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PublisherCashier class' category: 'TusLibrosExercise'!
PublisherCashier class
	instanceVariableNames: ''!

!PublisherCashier class methodsFor: 'instance creation' stamp: 'LT 6/9/2022 00:35:14'!
for: aPublisherCart withPrices: aCataloguePrices registerOn: aSalesBook withCard: aCard on: aDate withMerchantProcessor: aMerchantProcessor
	
	self assertThereIsAPriceIn: aCataloguePrices forAllCartBooks: (aPublisherCart books). 
	
	^self new initializeFor: aPublisherCart withPrices: aCataloguePrices registerOn: aSalesBook withCard: aCard on: aDate withMerchantProcessor: aMerchantProcessor! !


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

!PublisherCashier class methodsFor: 'errors' stamp: 'LT 6/9/2022 01:07:42'!
canNotMakeACheckoutWithCardWithNoFundsErrorMessages

	^ 'No se puede debitar una tarjeta sin fondos'.! !

!PublisherCashier class methodsFor: 'errors' stamp: 'LT 6/9/2022 01:07:48'!
canNotMakeACheckoutWithStolenCardErrorMessages

	^ 'No se puede debitar una tarjeta robada'.! !


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
