!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'instanceCustomerBook' stamp: 'EE 4/13/2022 12:20:40'!
newCustomerBookWithCustomer: aName

	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aName.
	
	^customerBook! !


!CustomerBookTest methodsFor: 'testing' stamp: 'EE 4/12/2022 17:36:24'!
assertBlock: anAssertionBlock whenCanNotEvaluate: aClosure whichRaises: aFailureSignal

	[aClosure value.  
	self fail]
		on: aFailureSignal
		do: anAssertionBlock! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LT 4/13/2022 14:58:41'!
checkingIn: aCustomerBook ifTheNumberOfActiveCustomersIs: aNumberOfActiveCostumers ifTheNumberOfSuspendedCustomersIs: aNumberOfSuspendedCustomers ifTheNumberOfCustomersIs: aNumberOfCostumers
	
	self assert: aNumberOfActiveCostumers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfCostumers equals: aCustomerBook numberOfCustomers.
	"self deny: (customerBook includesCustomerNamed: paulMcCartney)."! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LT 4/13/2022 14:42:21'!
evaluating: aClosure shouldNotTakeMoreThan: anAmountOfMilliseconds

	|millisecondsBeforeRunning millisecondsAfterRunning|

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (anAmountOfMilliseconds)! !


!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'LT 4/13/2022 14:42:35'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self evaluating: [customerBook addCustomerNamed: 'John Lennon'.] shouldNotTakeMoreThan: (50 * millisecond).! !

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'LT 4/13/2022 14:42:42'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := self newCustomerBookWithCustomer: 'Paul McCartney'.
	
	self evaluating: [customerBook removeCustomerNamed: 'Paul McCartney'.] shouldNotTakeMoreThan: (100 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'LT 4/13/2022 15:55:56'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertBlock: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
		whenCanNotEvaluate: [customerBook addCustomerNamed: '']
		whichRaises: Error 
		! !

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'EE 4/13/2022 12:27:25'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook |
			
	customerBook := self newCustomerBookWithCustomer: 'John Lennon'.
		
	self assertBlock: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]	 
		whenCanNotEvaluate: [customerBook removeCustomerNamed: 'Paul McCartney'.]
		whichRaises: NotFound 
		! !

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'LT 4/13/2022 15:40:43'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook|
	
	customerBook := self newCustomerBookWithCustomer: 'Paul McCartney'.
	
	customerBook suspendCustomerNamed: 'Paul McCartney'.
	
	self checkingIn: customerBook 
	ifTheNumberOfActiveCustomersIs: 0
	ifTheNumberOfSuspendedCustomersIs: 1
	ifTheNumberOfCustomersIs: 1.
	
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	

	
! !

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'LT 4/13/2022 15:31:26'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self newCustomerBookWithCustomer: 'Paul McCartney'.
	
	customerBook suspendCustomerNamed: 'Paul McCartney'.
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self checkingIn: customerBook 
	ifTheNumberOfActiveCustomersIs: 0
	ifTheNumberOfSuspendedCustomersIs: 0 
	ifTheNumberOfCustomersIs: 0.
	
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').
	
	


	
! !

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'EE 4/13/2022 12:31:53'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
			
	customerBook := self newCustomerBookWithCustomer: 'John Lennon'.	
	
	self assertBlock: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ] 
		whenCanNotEvaluate: [ customerBook suspendCustomerNamed: 'George Harrison'.]
		whichRaises: CantSuspend 
	! !

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'LT 4/13/2022 16:01:13'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
			
	customerBook := self newCustomerBookWithCustomer: 'John Lennon'.

	customerBook suspendCustomerNamed: 'John Lennon'.
	
	self assertBlock: [ :anError | 
				self assert: customerBook numberOfCustomers = 1.
				self assert: (customerBook includesCustomerNamed: 'John Lennon') ]
		whenCanNotEvaluate: [ customerBook suspendCustomerNamed: 'John Lennon'.]
		whichRaises: CantSuspend 
		
	"evaluating:
	shouldCauseAnExceptionOfType:
	BecauseTheCustomerBookLooksLike:"
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'Banana' stamp: 'LT 4/13/2022 17:28:05'!
removeFrom: aCustomerBookCategory theCustomer: aCustomerName

	1 to: aCustomerBookCategory size do: 
	[ :index |
		aCustomerName = (aCustomerBookCategory at: index)
			ifTrue: [
				aCustomerBookCategory removeAt: index.
				^ aCustomerName 
			] 
	].! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LT 4/13/2022 16:05:20'!
numberOfCustomers
	
	^active size + suspended size
	"^(self numberOfActiveCustomers) + (self numberOfSuspendedCustomers)"! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'LT 4/13/2022 17:23:33'!
removeCustomerNamed: aName 
 
	"1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	]."

	((self removeFrom: active theCustomer: aName) = aName) ifTrue: [ ^aName ].
	
	((self removeFrom: suspended theCustomer: aName) = aName) ifTrue: [ ^aName ].
	
	^ NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
