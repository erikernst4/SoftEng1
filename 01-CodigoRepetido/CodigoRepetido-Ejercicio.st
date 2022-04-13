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

!CustomerBookTest methodsFor: 'testing' stamp: 'LT 4/11/2022 21:52:18'!
evaluating: aClosure shouldNotTakeMoreThan: anAmountOfMilliseconds

	|millisecondsBeforeRunning millisecondsAfterRunning|

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (anAmountOfMilliseconds * millisecond)! !


!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'LT 4/11/2022 21:52:23'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self evaluating: [customerBook addCustomerNamed: 'John Lennon'.] shouldNotTakeMoreThan: 50.! !

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'EE 4/13/2022 12:25:54'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := self newCustomerBookWithCustomer: 'Paul McCartney'.
	
	self evaluating: [customerBook removeCustomerNamed: 'Paul McCartney'.] shouldNotTakeMoreThan: 100.
	
! !

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'EE 4/12/2022 17:38:24'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertBlock: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
		whenCanNotEvaluate: [customerBook addCustomerNamed: '']
		whichRaises: Error ! !

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

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'EE 4/13/2022 12:32:16'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook|
	
	customerBook := self newCustomerBookWithCustomer: 'Paul McCartney'.
	
	customerBook suspendCustomerNamed: 'Paul McCartney'.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	

	
! !

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'EE 4/13/2022 12:29:39'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self newCustomerBookWithCustomer: 'Paul McCartney'.
	
	customerBook suspendCustomerNamed: 'Paul McCartney'.
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
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

!CustomerBookTest methodsFor: 'suiteDeLaCatedra' stamp: 'EE 4/13/2022 12:32:58'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
			
	customerBook := self newCustomerBookWithCustomer: 'John Lennon'.

	customerBook suspendCustomerNamed: 'John Lennon'.
	
	self assertBlock: [ :anError | 
				self assert: customerBook numberOfCustomers = 1.
				self assert: (customerBook includesCustomerNamed: 'John Lennon') ]
		whenCanNotEvaluate: [ customerBook suspendCustomerNamed: 'John Lennon'.]
		whichRaises: CantSuspend 
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


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
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
	].
	
	^ NotFound signal.
! !

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
