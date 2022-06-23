!classDefinition: #CreditCardTest category: 'TusLibrosExercise'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 15:46:55'!
test01ACreditCardExpirationDateIsTheDateGivenInTheCreation

	| card |
	
	card := InstanceCreator new validCard.
	
	self assert: (GregorianMonthOfYear current next) equals: card expirationDate! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 14:47:16'!
test02CanNotCreateACreditCardWithoutAnOwnerName

	self should: [
			CreditCard 
				for: '' 
				validUntil: (GregorianMonthOfYear current) 
				numbered: 4444444444444444.
		] raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: CreditCard canNotCreateACardWithAnEmptyNameErrorMessage 
			equals: anError messageText.
		].! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 14:47:30'!
test03CanNotCreateACreditCardWithAnInvalidNumber

	self should: [
			CreditCard 
				for: 'Felipe Pettinato' 
				validUntil: (GregorianMonthOfYear current) 
				numbered: 911.
		] raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: CreditCard canNotCreateACreditCardWithAnInvalidNumberErrorMessage 
			equals: anError messageText.
		].! !


!classDefinition: #InterfaceTest category: 'TusLibrosExercise'!
TestCase subclass: #InterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 21:09:58'!
test01InterfaceCreateCartWithValidAuthenticationCreatesAnEmptyCart

	| authenticator cartId interface |
	
	authenticator := AuthenticatorSimulator new.
	interface := Interface 
		withAuthenticator: authenticator 
		withCatalogue: OrderedCollection new 
		withMerchantProcessor: (MerchantProcessorSimulator new).
		
	cartId := interface createCartFor: 'Username' withPassword: '123' .
	
	self assert: (interface listCart: cartId) isEmpty.! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 21:10:09'!
test02InterfaceCreateCartWithInvalidAuthenticationDoesNotCreateACart

	| authenticator interface |
	
	authenticator := AuthenticatorSimulator new.
	authenticator invalidAuthentication.
	interface := Interface 
		withAuthenticator: authenticator 
		withCatalogue: OrderedCollection new 
		withMerchantProcessor: (MerchantProcessorSimulator new).
	
	self  should: [interface createCartFor: 'Username' withPassword: '123']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface invalidAuthenticationErrorMessage.
		]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 21:10:20'!
test03InterfaceCanAddBooksWithValidIdCart

	| authenticator interface cartId expectedContent |
	
	authenticator := AuthenticatorSimulator new.
	interface := Interface 
		withAuthenticator: authenticator 
		withCatalogue: InstanceCreator new catalogueWithOneBook 
		withMerchantProcessor: MerchantProcessorSimulator new.
	
	cartId := interface createCartFor: 'Username' withPassword: '123'.
	interface addToCart: cartId aBook: 12 quantity: 1.
	
	expectedContent := Bag new.
	expectedContent add: 12 withOccurrences: 1.
	
	self assert: expectedContent equals: (interface listCart: cartId).
		! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 21:10:30'!
test04InterfaceCannotAddWithInvalidCartId

	| authenticator interface |
	
	authenticator := AuthenticatorSimulator new.
	interface := Interface 
		withAuthenticator: authenticator 
		withCatalogue: InstanceCreator new catalogueWithOneBook
		withMerchantProcessor: MerchantProcessorSimulator new.
	
	self  should: [interface addToCart: 1 aBook: 12 quantity: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface invalidCartIdErrorMessage.
		]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 21:10:37'!
test05InterfaceCannotListACartWithInvalidCartId

	| authenticator interface |
	
	authenticator := AuthenticatorSimulator new.
	interface := Interface 
		withAuthenticator: authenticator 
		withCatalogue: InstanceCreator new catalogueWithOneBook 
		withMerchantProcessor: MerchantProcessorSimulator new.
	
	self  should: [interface listCart: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface invalidCartIdErrorMessage.
		]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 21:10:44'!
test06InterfaceMakeCheckOutNonEmptyCartWithValidCartIdAndValidCreditCardRegistersAllTheBooksPurchased

	| authenticator cartId interface expectedContent card catalogue |
		
	authenticator := AuthenticatorSimulator new.		
	catalogue := InstanceCreator new catalogueWithOneBook.	
	interface := Interface 
		withAuthenticator: authenticator 
		withCatalogue: catalogue 
		withMerchantProcessor: MerchantProcessorSimulator new.
	
	cartId := interface createCartFor: 'Username' withPassword: '123' .
	
	interface addToCart: cartId aBook: 12 quantity: 1.
	card := InstanceCreator new validCard.
	interface checkoutCart: cartId withCreditCard: card.
	
	expectedContent := Bag new.
	expectedContent add: 12 withOccurrences: 1.
		
	self assert: expectedContent equals: (interface listPurchasesOf: 'Username' withPassword: '123').! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 21:10:49'!
test07InterfaceCanNotListPurchasesOfAValidCartIdWithAnInvalidPassword

	| authenticator cartId interface catalogue |
		
	catalogue := InstanceCreator new catalogueWithOneBook.	
	authenticator := AuthenticatorSimulator new.
	interface := Interface 
		withAuthenticator: authenticator 
		withCatalogue: catalogue 
		withMerchantProcessor: MerchantProcessorSimulator new.
	
	cartId := interface createCartFor: 'Username' withPassword: '123' .
	authenticator invalidAuthentication.
		
	self  should: [interface listPurchasesOf: cartId withPassword: '000']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface invalidAuthenticationErrorMessage.
		]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 21:10:55'!
test08InterfaceCanNotUseACartIdAfterMakingCheckOut

	| authenticator cartId interface expectedContent card catalogue |
		
	catalogue := InstanceCreator new catalogueWithOneBook.	
	authenticator := AuthenticatorSimulator new.	
	interface := Interface 
		withAuthenticator: authenticator 
		withCatalogue: catalogue 
		withMerchantProcessor: MerchantProcessorSimulator new.
	
	cartId := interface createCartFor: 'Username' withPassword: '123' .
	interface addToCart: cartId aBook: 12 quantity: 1.		
	card := InstanceCreator new validCard.
	interface checkoutCart: cartId withCreditCard: card.
	
	expectedContent := Bag new.
	expectedContent add: 12 withOccurrences: 1.

		
	self  should: [interface addToCart: cartId aBook: 12 quantity: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface invalidCartIdErrorMessage.
		]! !

!InterfaceTest methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 21:33:16'!
test09InterfaceCanNotAddItemToExpiredCart

	| authenticator cartId interface catalogue |
			
	catalogue := InstanceCreator new catalogueWithOneBook.	
	authenticator := AuthenticatorSimulator new.	
	interface := Interface 
		withAuthenticator: authenticator 
		withCatalogue: catalogue 
		withMerchantProcessor: MerchantProcessorSimulator new.
	
	cartId := interface createCartFor: 'Username' withPassword: '123' .
	
	((interface getCart: cartId) getClock) advanceTimeBy: 30.
		
	self  should: [interface addToCart: cartId aBook: 12 quantity: 1.	]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Interface cartExpiredErrorMessage.
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


!MerchantProcessorSimulator methodsFor: 'deny' stamp: 'LT 6/12/2022 14:50:14'!
denyCardWithNoFunds

	simulatedAction := [ :anAmountOfMoney :aCreditCard | 
		self error: PublisherCashier canNotMakeACheckoutWithCardWithNoFundsErrorMessages ]! !

!MerchantProcessorSimulator methodsFor: 'deny' stamp: 'LT 6/12/2022 14:50:08'!
denyStolenCard

	simulatedAction := [ :anAmountOfMoney :aCreditCard | 
		self error: PublisherCashier canNotMakeACheckoutWithStolenCardErrorMessages ]! !


!classDefinition: #PublisherCartTest category: 'TusLibrosExercise'!
TestCase subclass: #PublisherCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/12/2022 15:43:07'!
test01CartIsEmptyWhenCreated

	| cart |
	
	cart := InstanceCreator new emptyCart.
	
	self assert: cart isEmpty.! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/12/2022 15:43:12'!
test02CartIsNotEmptyWhenAddedABook

	| cart |
	
	cart := InstanceCreator new cartWithOneBook.
	
	self deny: cart isEmpty.! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/12/2022 15:43:16'!
test03CartHasOnlyTheBookAdded

	| cart expectedBooks |
	
	cart := InstanceCreator new cartWithOneBook.
	
	expectedBooks := Set with:12.
	
	self assert: (expectedBooks) equals: (cart books).! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/12/2022 15:43:21'!
test04CartHasOnlyTheBooksAdded

	| cart expectedBooks |
	
	cart := InstanceCreator new cartWithTwoBooks .
	
	expectedBooks := Set with:12 with:13.
	
	self assert: expectedBooks equals: (cart books).! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:10:24'!
test05CanNotAddABookThatIsNotInTheCatalogue

	| cart catalogue |
	
	catalogue := InstanceCreator new catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	
	self 
		should: [ cart addBookWithISBN: 13 quantity: 1 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: PublisherCart canNotAddABookOutsideOfTheCatalogueErrorMessage 
			equals: anError messageText.
			self assert: cart isEmpty.
		]! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/12/2022 15:43:30'!
test06ABookAddedMoreThanOnceQuantityInACartIsTheSumOfTheAddedAmount

	| cart catalogue |
	
	catalogue := InstanceCreator new catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	cart addBookWithISBN: 12 quantity: 1.
	cart addBookWithISBN: 12 quantity: 4.
	
	self assert: 5 equals: (cart quantityOf: 12).
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:10:47'!
test07ACartCanNotAddNonPositiveQuantityOfABook

	| cart catalogue |
	
	catalogue := InstanceCreator new catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	
	self 
		should: [ cart addBookWithISBN: 12 quantity: -1. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PublisherCart canNotAddNonPositiveQuantityOfABookErrorMessage 
			equals: anError messageText.
			self assert: cart isEmpty.
		]! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:11:24'!
test08CannotAskTheQuantityOfABookThatHasNotBeenAdd

	| cart catalogue |

	catalogue := InstanceCreator new catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	
	self 
		should: [ cart quantityOf: 12 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: PublisherCart bookHasNotBeenAddToTheCartMessage 
			equals: anError messageText.
			self assert: cart isEmpty.
		].
	! !

!PublisherCartTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:11:46'!
test09ACartCanNotAddANonIntegerQuantity

	| cart catalogue |
	
	catalogue := InstanceCreator new catalogueWithOneBook.
	
	cart := PublisherCart for: catalogue.
	
	self 
		should: [ cart addBookWithISBN: 12 quantity: 1.5. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: PublisherCart canNotAddANonIntegerQuantityOfABookErrorMessage 
			equals: anError messageText.
			self assert: cart isEmpty.
		]! !


!classDefinition: #PublisherCashierTest category: 'TusLibrosExercise'!
TestCase subclass: #PublisherCashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:17:45'!
test01ACashierCantMakeTheCheckoutOfAnEmptyCart

	| salesBook cart card date merchantProcessor cashier |
	
	salesBook  := OrderedCollection new.
	cart := InstanceCreator new emptyCart.
	card := InstanceCreator new validCard.
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

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:18:54'!
test02ACashierAmountPaidAfterCheckoutIsThePriceOfTheBookMultipliedForItsQuantity

	| cart catalogue card date merchantProcessor cashier |
	
	cart := InstanceCreator new cartWithOneBook.
	catalogue := InstanceCreator new catalogueWithOneBook.
	card := InstanceCreator new validCard.
	date := GregorianMonthOfYear current.
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: catalogue 
		registerOn: OrderedCollection new
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
	
	cashier checkout.
	
	self assert: (4 * 2) equals: cashier amountPaid.! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:23:09'!
test03ACashierAmountPaidAfterCheckoutIsSumOfThePriceOfTheBookMultipliedForItsQuantity

	| cart catalogue card date merchantProcessor cashier |
	
	cart := InstanceCreator new emptyCartWithCatalogueOfTwoBooks.
	cart addBookWithISBN: 12 quantity: 2; addBookWithISBN: 13 quantity: 1.
	catalogue := InstanceCreator new catalogueWithTwoBooks.
	card := InstanceCreator new validCard.
	date := GregorianMonthOfYear current.
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: catalogue 
		registerOn: OrderedCollection new
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
	
	cashier checkout.
	
	self assert: (4 * 2 + (1 * 44)) equals: cashier amountPaid.! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:24:48'!
test04ACashierMustKnowThePriceForEveryCartBook

	| cart catalogue card date merchantProcessor |
	
	cart := InstanceCreator new cartWithOneBook.
	catalogue := Dictionary new. 
	catalogue at: 13 put: 4.
	card := InstanceCreator new validCard.
	date := GregorianMonthOfYear current.
	merchantProcessor := MerchantProcessorSimulator new.
	
	self 
		should: [ PublisherCashier 
			for: cart 
			withPrices: catalogue 
			registerOn: (OrderedCollection new) 
			withCard: card 
			on: date 
			withMerchantProcessor: 	merchantProcessor.
		] raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: PublisherCashier canNotCreateACashierThatDoesntHaveAllThePricesForACartErrorMessage 
			equals: anError messageText.
		].! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:26:08'!
test05ACashierCanNotDoACheckoutMoreThanOnce

	| cart catalogue card date merchantProcessor cashier |
	
	cart := InstanceCreator new cartWithOneBook.
	catalogue := InstanceCreator new catalogueWithOneBook.
	card := InstanceCreator new validCard.
	date := GregorianMonthOfYear current.
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: catalogue 
		registerOn: OrderedCollection new
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
	
	cashier checkout.
	
	self 
		should: [cashier checkout.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: PublisherCashier canNotMakeACheckoutMoreThanOnceErrorMessage 
			equals: anError messageText.
			self assert: (4 * 2) equals: cashier amountPaid.
		].! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:27:06'!
test06ACashierCanNotDoTheCheckoutWithAnExpiredCard

	| cart catalogue card date merchantProcessor cashier |
	
	cart := InstanceCreator new cartWithOneBook.
	catalogue := InstanceCreator new catalogueWithOneBook.
	card := InstanceCreator new expiredCard.
	date := GregorianMonthOfYear current.
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: catalogue 
		registerOn: OrderedCollection new
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
	
	self 
		should: [cashier checkout.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: PublisherCashier canNotMakeACheckoutWithAnExpiredCreditCardErrorMessages 
			equals: anError messageText.
			self deny: cashier cartHasBeenPaid.
		].! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:28:13'!
test07WhenACashierDoesACheckoutItSaveTheSaleInSalesBook

	| salesBook cart catalogue card date merchantProcessor cashier |
	
	salesBook := OrderedCollection new.
	cart := InstanceCreator new cartWithOneBook.
	catalogue := InstanceCreator new catalogueWithOneBook. 
	card := InstanceCreator new validCard.
	date := GregorianMonthOfYear current.
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: catalogue
		registerOn: salesBook 
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
		
	cashier checkout.
		
	self assert: salesBook size = 1.
	self assert: (cashier amountPaid) equals: (salesBook first total). ! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:29:15'!
test08ACashierCollaboratesWithMerchantProcessorAndItAllowsTheCheckout

	| salesBook cart catalogue card date merchantProcessor cashier |
	
	salesBook := OrderedCollection new.
	cart := InstanceCreator new cartWithOneBook.
	catalogue := InstanceCreator new catalogueWithOneBook.
	card := InstanceCreator new validCard.
	date := GregorianMonthOfYear current.
	merchantProcessor := MerchantProcessorSimulator new.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: catalogue
		registerOn: salesBook 
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
		
	cashier checkout.
	
	self assert: salesBook size = 1.
	self assert: (cashier amountPaid) equals: (salesBook first total). 
			! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:30:22'!
test09ACashierCollaboratesWithMerchantProcessorAndItDoesntAllowsTransactionOnStolenCard

	| salesBook cart catalogue card date merchantProcessor cashier |
	
	salesBook := OrderedCollection new.
	cart := InstanceCreator new cartWithOneBook.
	catalogue := InstanceCreator new catalogueWithOneBook . 
	card := InstanceCreator new validCard.
	date := GregorianMonthOfYear current.
	merchantProcessor := MerchantProcessorSimulator new.
	merchantProcessor denyStolenCard.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: catalogue 
		registerOn: salesBook 
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
		
	self  should: [cashier checkout.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self 
			assert: PublisherCashier canNotMakeACheckoutWithStolenCardErrorMessages 
			equals: anError messageText.
			self deny: cashier cartHasBeenPaid.
		].
			! !

!PublisherCashierTest methodsFor: 'tests' stamp: 'LT 6/12/2022 16:31:21'!
test10ACashierCollaboratesWithMerchantProcessorAndItDoesntAllowsTransactionOnCardWithNoFunds

	| salesBook cart catalogue card date merchantProcessor cashier |
	
	salesBook := OrderedCollection new.
	cart := InstanceCreator new cartWithOneBook.
	catalogue := InstanceCreator new catalogueWithOneBook . 
	card := InstanceCreator new validCard.
	date := GregorianMonthOfYear current.
	merchantProcessor := MerchantProcessorSimulator new.
	merchantProcessor denyCardWithNoFunds.
	
	cashier := PublisherCashier 
		for: cart 
		withPrices: catalogue
		registerOn: salesBook 
		withCard: card 
		on: date
		withMerchantProcessor: 	merchantProcessor.
		
	self  should: [cashier checkout.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self 
			assert: PublisherCashier canNotMakeACheckoutWithCardWithNoFundsErrorMessages 
			equals: anError messageText.
			self deny: cashier cartHasBeenPaid.
		].
			! !


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


!classDefinition: #Clock category: 'TusLibrosExercise'!
Object subclass: #Clock
	instanceVariableNames: 'addedTime creationTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!Clock methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 20:47:14'!
advanceTimeBy: aNumberOfMinutes

	addedTime := (0 - aNumberOfMinutes) * minute.! !

!Clock methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 20:41:13'!
creationTime

	^ creationTime next: addedTime.! !

!Clock methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 20:40:05'!
initialize

	addedTime := (0 * minute).
	creationTime := GregorianDateTime now.! !


!classDefinition: #CreditCard category: 'TusLibrosExercise'!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!CreditCard methodsFor: 'initialization' stamp: 'LT 6/12/2022 14:43:22'!
validUntil: aGregorianMonthOfYear 
	
	expirationDate := aGregorianMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'EE 6/8/2022 17:10:22'!
hasExpiredOn: aDate

	^ aDate > expirationDate
! !


!CreditCard methodsFor: 'accessing' stamp: 'EE 6/8/2022 17:33:33'!
expirationDate

	^ expirationDate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibrosExercise'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LT 6/12/2022 14:43:22'!
for: aName validUntil: aGregorianMonthOfYear numbered: aSixteenDigitNumber

	self assertNameNotEmpty: aName.
	
	self assertNumberIsValid: aSixteenDigitNumber.
	
	^self new validUntil: aGregorianMonthOfYear ! !


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

!CreditCard class methodsFor: 'assertions' stamp: 'LT 6/12/2022 14:42:12'!
assertNumberIsValid: aSixteenDigitNumber

	((aSixteenDigitNumber isInteger) 
	and: [aSixteenDigitNumber > 0] 
	and: [aSixteenDigitNumber decimalDigitLength = 16])
	ifFalse: [self canNotCreateACreditCardWithAnInvalidNumber].
	
	! !


!classDefinition: #InstanceCreator category: 'TusLibrosExercise'!
Object subclass: #InstanceCreator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!InstanceCreator methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 15:37:32'!
cartWithOneBook

	| cartWithOneBook catalogue |
	
	catalogue := self catalogueWithOneBook.

	cartWithOneBook := PublisherCart for: catalogue.
	cartWithOneBook addBookWithISBN: 12 quantity: 2.
	
	^ cartWithOneBook.! !

!InstanceCreator methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 15:37:56'!
cartWithTwoBooks

	| cartWithTwoBooks catalogue |
	
	catalogue := self catalogueWithTwoBooks.
	
	cartWithTwoBooks := PublisherCart for: catalogue.
	cartWithTwoBooks addBookWithISBN: 12 quantity: 1; addBookWithISBN: 13 quantity: 1.
	
	^ cartWithTwoBooks.! !

!InstanceCreator methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 15:38:13'!
catalogueWithOneBook

	| prices |
	
	prices := Dictionary new. 
	prices at: 12 put: 4.
	
	^ prices.! !

!InstanceCreator methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 15:38:33'!
catalogueWithTwoBooks

	| prices |
	
	prices := Dictionary new.
	prices at: 12 put: 4 ; at: 13 put: 44.
	
	^ prices.! !

!InstanceCreator methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 15:38:55'!
catalogueWithZeroBooks

	| books |
	
	books := Dictionary new.
	
	^ books.! !

!InstanceCreator methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 15:39:12'!
emptyCart

	| emptyCart catalogue |
	
	catalogue := self catalogueWithZeroBooks.
	emptyCart := PublisherCart for: catalogue.
		
	^ emptyCart.! !

!InstanceCreator methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 16:22:01'!
emptyCartWithCatalogueOfTwoBooks

	| emptyCart catalogue |
	
	catalogue := InstanceCreator new catalogueWithTwoBooks.
	emptyCart := PublisherCart for: catalogue.
		
	^ emptyCart.! !

!InstanceCreator methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 15:41:02'!
expiredCard

	^ CreditCard 
		for: 'Hernán Wilkinson' 
		validUntil: (GregorianMonthOfYear current previous) 
		numbered: 4444444444444444! !

!InstanceCreator methodsFor: 'as yet unclassified' stamp: 'LT 6/12/2022 15:40:26'!
validCard

	^ CreditCard 
		for: 'Hernán Wilkinson' 
		validUntil: (GregorianMonthOfYear current next) 
		numbered: 4444444444444444! !


!classDefinition: #Interface category: 'TusLibrosExercise'!
Object subclass: #Interface
	instanceVariableNames: 'authenticatorSimulator authenticator carts catalogue salesBook merchantProcessor cartUsers clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!Interface methodsFor: 'initialization' stamp: 'LT 6/12/2022 21:09:40'!
initializeWithAuthenticator: anAuthenticator withCatalogue: aCatalogue withMerchantProcessor: aMerchantProcessor
	
	authenticator := anAuthenticator.
	carts := Dictionary new.
	catalogue := aCatalogue.
	merchantProcessor := aMerchantProcessor.
	salesBook := Dictionary new.
	cartUsers := Dictionary new.! !


!Interface methodsFor: 'cart creation' stamp: 'EE 6/13/2022 15:31:07'!
createCartFor: aUsername withPassword: aPassword

	| cart cartId |
	
	self login: aUsername withPassword: aPassword.
	
	cartId := self createCartId.
	cart := PublisherCart for: catalogue withClock: (Clock new).
	
	carts at: cartId put: cart.
	cartUsers at: cartId put: aUsername.
	
	^ cartId.
	
	! !

!Interface methodsFor: 'cart creation' stamp: 'EE 6/13/2022 15:28:46'!
createCartId

	^ ((ParkMiller88Random next) * 1000000) asInteger! !


!Interface methodsFor: 'listing cart' stamp: 'LT 6/12/2022 17:10:01'!
listCart: aCartId

	| cart |
	
	cart := self getCart: aCartId.
	^ cart bagOfBooks.! !


!Interface methodsFor: 'adding to cart' stamp: 'LT 6/12/2022 21:39:13'!
addToCart: aCartId aBook: anISBN quantity: aQuantity

	| cart |
	
	cart := self getCart: aCartId.
	
	self assertCartHasExpired: cart.
	
	cart addBookWithISBN: anISBN quantity: aQuantity.

	
	
	! !


!Interface methodsFor: 'accessing - private' stamp: 'EE 6/11/2022 12:33:41'!
getCart: aCartId

	^ carts at: aCartId ifAbsent: [ self error: self class invalidCartIdErrorMessage]! !


!Interface methodsFor: 'cart checkout - private' stamp: 'EE 6/11/2022 18:04:56'!
createEntryInSalesBookFor: aClientId

	salesBook at: aClientId put: (OrderedCollection new).
	^ salesBook at: aClientId! !

!Interface methodsFor: 'cart checkout - private' stamp: 'EE 6/11/2022 18:06:17'!
getClientWithCart: aCartId 
	
	^ cartUsers at: aCartId
	! !

!Interface methodsFor: 'cart checkout - private' stamp: 'LT 6/12/2022 17:16:23'!
getPurchasesOfClient: aUsername

	^ salesBook at: aUsername ifAbsent: [self createEntryInSalesBookFor: aUsername]! !

!Interface methodsFor: 'cart checkout - private' stamp: 'LT 6/12/2022 17:16:02'!
getPurchasesOfClientWithCart: aCartId

	| username |
	username := self getClientWithCart: aCartId.
	^ self getPurchasesOfClient: username! !

!Interface methodsFor: 'cart checkout - private' stamp: 'EE 6/11/2022 23:43:57'!
removeCart: aCartId

	carts removeKey: aCartId.
	
	cartUsers removeKey: aCartId.
! !


!Interface methodsFor: 'cart checkout' stamp: 'EE 6/11/2022 23:41:52'!
checkoutCart: aCartId withCreditCard: aCreditCard

	| cashier |
	cashier := PublisherCashier 
		for: (self getCart: aCartId)
		withPrices: catalogue
		registerOn: (self getPurchasesOfClientWithCart: aCartId)
		withCard: aCreditCard 
		on: (GregorianMonthOfYear current)
		withMerchantProcessor: 	merchantProcessor.
		
	cashier checkout.
	
	self removeCart: aCartId.! !


!Interface methodsFor: 'assertions' stamp: 'LT 6/12/2022 21:38:54'!
assertCartHasExpired: aCart

	| cartClock |
	
	cartClock := aCart getClock.
	
	( ((cartClock creationTime ) distanceTo: GregorianDateTime now) > (29*minute) ) ifTrue: [
		self error: self class cartExpiredErrorMessage.
	].

	
	
	! !


!Interface methodsFor: 'list purchases' stamp: 'EE 6/13/2022 15:30:50'!
listPurchasesOf: aUsername withPassword: aPassword 
	
	| purchasesList |
	
	self login: aUsername withPassword: aPassword.
	
	purchasesList := Bag new.
	(self getPurchasesOfClient: aUsername) do: [:aSale | purchasesList addAll: (aSale list)].
	
	^purchasesList
	! !


!Interface methodsFor: 'authentication' stamp: 'EE 6/13/2022 15:30:50'!
login: aUsername withPassword: aPassword

	^ authenticator login: aUsername with: aPassword! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interface class' category: 'TusLibrosExercise'!
Interface class
	instanceVariableNames: ''!

!Interface class methodsFor: 'instance creation' stamp: 'LT 6/12/2022 21:37:39'!
cartExpiredErrorMessage

	^ 'El carrito ha expirado'! !

!Interface class methodsFor: 'instance creation' stamp: 'LT 6/9/2022 20:25:19'!
invalidAuthenticationErrorMessage

	^ 'Error de autenticación'! !

!Interface class methodsFor: 'instance creation' stamp: 'LT 6/9/2022 21:18:38'!
invalidCartIdErrorMessage

	^ 'El CartId ingresado no está registrado'! !

!Interface class methodsFor: 'instance creation' stamp: 'LT 6/12/2022 21:09:18'!
withAuthenticator: anAuthenticatorSimulator withCatalogue: aCatalogue withMerchantProcessor: aMerchantProcessor
	
	^self new 
		initializeWithAuthenticator: anAuthenticatorSimulator 
		withCatalogue: aCatalogue 
		withMerchantProcessor: aMerchantProcessor.! !


!classDefinition: #PublisherCart category: 'TusLibrosExercise'!
Object subclass: #PublisherCart
	instanceVariableNames: 'books catalogue clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!PublisherCart methodsFor: 'testing' stamp: 'EE 6/4/2022 15:50:11'!
isEmpty

	^ books isEmpty.! !


!PublisherCart methodsFor: 'assertions' stamp: 'LT 6/12/2022 15:00:41'!
assertBookIsIncludedInCart: anISBN

	(books asSet includes: anISBN) ifFalse: [
		self class error: ( self class bookHasNotBeenAddToTheCart).
	].! !

!PublisherCart methodsFor: 'assertions' stamp: 'EE 6/6/2022 17:20:46'!
assertCanAddBook: anISBN quantity: aQuantity 

	self assertIsValidBook: anISBN.
	
	self assertIsValidQuantity: aQuantity.
	
! !

!PublisherCart methodsFor: 'assertions' stamp: 'EE 6/11/2022 13:42:21'!
assertIsValidBook: anISBN

	^ (catalogue keys includes: anISBN) ifFalse: [ 
		self class canNotAddABookOutsideOfTheCatalogue
	]! !

!PublisherCart methodsFor: 'assertions' stamp: 'EE 6/6/2022 17:42:33'!
assertIsValidQuantity: aQuantity

	(aQuantity > 0) ifFalse: [ 
		self class canNotAddNonPositiveQuantityOfABook 
	].

	(aQuantity isInteger) ifFalse: [ self class canNotAddANonIntegerQuantityOfABook].! !


!PublisherCart methodsFor: 'adding' stamp: 'LT 6/12/2022 21:41:30'!
addBookWithISBN: anISBN quantity: aQuantity
	
	self assertCanAddBook: anISBN quantity: aQuantity.
	
	books add: anISBN withOccurrences: aQuantity.
	
	clock := Clock new.! !


!PublisherCart methodsFor: 'initialization' stamp: 'EE 6/6/2022 17:45:33'!
initializeFor: aCatalogue

	books := Bag new.
	catalogue := aCatalogue.! !

!PublisherCart methodsFor: 'initialization' stamp: 'LT 6/12/2022 21:03:10'!
initializeFor: aCatalogue withClock: aClock

	books := Bag new.
	catalogue := aCatalogue.
	clock := aClock.! !


!PublisherCart methodsFor: 'accessing' stamp: 'LT 6/9/2022 21:05:43'!
bagOfBooks
	
	^ books.! !

!PublisherCart methodsFor: 'accessing' stamp: 'EE 6/6/2022 17:48:26'!
books
	
	^ books asSet.! !

!PublisherCart methodsFor: 'accessing' stamp: 'LT 6/12/2022 21:33:16'!
getClock

	^ clock.! !

!PublisherCart methodsFor: 'accessing' stamp: 'EE 6/6/2022 17:50:24'!
quantityOf: anISBN

	self assertBookIsIncludedInCart: anISBN.
	
	^books occurrencesOf: anISBN.! !


!PublisherCart methodsFor: 'enumerating' stamp: 'LT 6/12/2022 15:11:14'!
sum

	^ books asSet sum: [ :book | (catalogue at: book) * (self quantityOf: book) ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PublisherCart class' category: 'TusLibrosExercise'!
PublisherCart class
	instanceVariableNames: ''!

!PublisherCart class methodsFor: 'instance creation' stamp: 'EE 6/4/2022 16:00:03'!
for: aCatalogue

	^ self new initializeFor: aCatalogue ! !

!PublisherCart class methodsFor: 'instance creation' stamp: 'LT 6/12/2022 21:02:17'!
for: aCatalogue withClock: aClock

	^ self new initializeFor: aCatalogue withClock: aClock.! !


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


!PublisherCashier methodsFor: 'checkout' stamp: 'LT 6/12/2022 15:11:14'!
calculateTotal

	^ publisherCart sum! !

!PublisherCashier methodsFor: 'checkout' stamp: 'EE 6/11/2022 13:13:16'!
checkout	

	self assertCanMakeTheCheckout.
	
	amountPaid := self calculateTotal.
	
	self debitTotal.
	
	self registerSale.
	
	alreadyPaid := true.
	! !

!PublisherCashier methodsFor: 'checkout' stamp: 'EE 6/11/2022 13:09:25'!
debitTotal

	^ merchantProcessor debit: amountPaid from: card! !

!PublisherCashier methodsFor: 'checkout' stamp: 'EE 6/8/2022 17:16:09'!
priceOfBook: aBook 
	
	^ pricesCatalogue at: aBook! !

!PublisherCashier methodsFor: 'checkout' stamp: 'EE 6/11/2022 17:38:27'!
registerSale
	
	| sale |
	sale := Sale of: (publisherCart bagOfBooks) withCatalogue: pricesCatalogue.
	salesBook add: sale.! !


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

!PublisherCashier class methodsFor: 'instance creation' stamp: 'LT 6/12/2022 15:34:18'!
for: aPublisherCart withPrices: aCataloguePrices registerOn: aSalesBook withCard: aCard on: aDate withMerchantProcessor: aMerchantProcessor
	
	self assertThereIsAPriceIn: aCataloguePrices forAllCartBooks: (aPublisherCart books). 
	
	^self new 
		initializeFor: aPublisherCart 
		withPrices: aCataloguePrices 
		registerOn: aSalesBook 
		withCard: aCard 
		on: aDate 
		withMerchantProcessor: aMerchantProcessor! !


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

!PublisherCashier class methodsFor: 'error messages' stamp: 'LT 6/9/2022 01:07:42'!
canNotMakeACheckoutWithCardWithNoFundsErrorMessages

	^ 'No se puede debitar una tarjeta sin fondos'.! !

!PublisherCashier class methodsFor: 'error messages' stamp: 'LT 6/9/2022 01:07:48'!
canNotMakeACheckoutWithStolenCardErrorMessages

	^ 'No se puede debitar una tarjeta robada'.! !


!classDefinition: #Sale category: 'TusLibrosExercise'!
Object subclass: #Sale
	instanceVariableNames: 'bagOfBooks catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosExercise'!

!Sale methodsFor: 'initialization' stamp: 'EE 6/11/2022 12:59:09'!
initializeOf: aBagOfBooks withCatalogue: aCatalogue 
	
	bagOfBooks := aBagOfBooks.
	catalogue := aCatalogue.! !


!Sale methodsFor: 'accessint' stamp: 'EE 6/11/2022 17:47:21'!
list
	^bagOfBooks! !

!Sale methodsFor: 'accessint' stamp: 'EE 6/11/2022 13:20:02'!
total
	
	^ bagOfBooks asSet sum: [ :book | (catalogue at: book) * (bagOfBooks occurrencesOf: book) ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibrosExercise'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'EE 6/11/2022 12:58:52'!
of: aBagOfBooks withCatalogue: aCatalogue 

	^self new initializeOf: aBagOfBooks withCatalogue: aCatalogue! !
