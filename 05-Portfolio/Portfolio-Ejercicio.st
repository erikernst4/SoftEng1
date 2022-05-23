!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/16/2022 20:43:51'!
test01PortfolioHasZeroAsBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/16/2022 20:43:45'!
test02PortfolioHasNoTransactionsWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: OrderedCollection new equals: portfolio transactions.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/16/2022 20:43:38'!
test03PortfolioHasNotRegisteredTransactionsWhenCreated 

	| portfolio deposit withdraw |
	
	portfolio := Portfolio new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (portfolio hasRegistered: deposit).
	self deny: (portfolio hasRegistered:withdraw).

! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/19/2022 20:46:37'!
test04PortfolioBalanceIsEqualToReceptiveAccountWhenIsTheOnlyAccountAdded

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: account.
	
	Deposit register: 100 on: account.
	
	self assert: account balance equals: portfolio balance.	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/19/2022 20:47:01'!
test05PortfolioBalanceIsEqualToTheSumOfItsAccountsBalances

	| portfolio account account2 |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: account.
	
	Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount new.
	portfolio add: account2.
	Deposit register: 100 on: account2.
	Withdraw register: 50 on: account2.
	
	self assert: (account balance + account2 balance) equals: portfolio balance.	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/19/2022 20:49:47'!
test06PortfolioBalanceIsZeroWhenCreatedAndAddedEmptyPortfolio

	| portfolio portfolio2 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio add: portfolio2.
		
	self assert: portfolio2 balance equals: portfolio balance.	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/19/2022 20:47:53'!
test07PortfolioBalanceWhenCreatedAndAddedNonEmptyPortfolioIsThisLastPortfolioBalance

	| portfolio portfolio2 account |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio2 add: account.
	Deposit register: 100 on: account.
	
	portfolio add: portfolio2.
		
	self assert: portfolio2 balance equals: portfolio balance.	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/19/2022 20:48:11'!
test08PortfolioBalanceIsTheSumOfPortfoliosBalanceWhenAddedMultiplePortfoliosAndNotAnyAccount

	| portfolio portfolio2 account account2 portfolio3 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio2 add: account.
	Deposit register: 100 on: account.
	
	portfolio add: portfolio2.
	
	portfolio3 := Portfolio new.
	portfolio add: portfolio3.
	account2 := ReceptiveAccount new.
	portfolio3 add: account2.
	Deposit register: 100 on: account2.
	Withdraw register: 50 on: account2.
		
	self assert: (portfolio2 balance + portfolio3 balance) equals: portfolio balance.	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/19/2022 20:48:22'!
test09PortfolioWithMultipleAccountsAndNonePortfoliosHasRegisteredTheAccountsTransactions

	| portfolio account deposit account2 withdraw |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: account.
	deposit := Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount  new.
	portfolio add: account2.
	withdraw := Withdraw for: 100.
	
	self assert: (portfolio hasRegistered: deposit).
	self deny: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/19/2022 20:48:32'!
test10PortfolioWithNoneAccountsAndOnePortfolioHasRegisteredThePortfolioRegisteredTransactions

	| portfolio account deposit portfolio2 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio add: portfolio2.
	account := ReceptiveAccount  new.
	
	portfolio2 add: account.
	deposit := Deposit register: 100 on: account.
	
	self assert: (portfolio hasRegistered: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/19/2022 20:48:44'!
test11PortfolioWithOneChildPortfolioWithMultipleAccountsHasRegisterTheChildPortfolioRegistrations

	| portfolio account deposit account2 withdraw portfolio2 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio add: portfolio2.
	account := ReceptiveAccount  new.
	
	portfolio2 add: account.
	deposit := Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount new.
	portfolio2 add: account2.
	withdraw := Withdraw for: 100.

	self assert: (portfolio hasRegistered: deposit).
	self deny: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/19/2022 20:49:13'!
test12PortfolioWithMultipleAccountsAndNonePortfoliosTransactionsAreTheAccountsTransactions

	| portfolio account account2 unionOfTransactions |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: account.
	Deposit register: 100 on: account.
	
	account2 := ReceptiveAccount  new.
	portfolio add: account2.
	Withdraw register: 100 on: account2.
	
	unionOfTransactions := account transactions.
	unionOfTransactions addAll: account2 transactions.
	
	self assert: (unionOfTransactions) equals: portfolio transactions
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/19/2022 20:49:27'!
test13PortfolioWithMultipleAccountsAndPortfolioWithAccountsTransactionsAreTheUnionOfAccountsAndPortfolioTransactions

	| portfolio account account2 unionOfTransactions portfolio2 |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: account.
	Deposit register: 100 on: account.
	
	portfolio2 := Portfolio new.
	portfolio add: portfolio2.
	account2 := ReceptiveAccount new.
	Withdraw register: 150 on: account2.
	portfolio2 add: account2.
	
	unionOfTransactions := account transactions.
	unionOfTransactions addAll: portfolio2 transactions.
	
	self assert: unionOfTransactions equals: portfolio transactions
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LT 5/22/2022 23:11:53'!
test14PortfolioCantAddAnAccountOrAPortfolioMoreThanOneTime

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: account.
	
	self should: [portfolio add: account.] 
			raise: Error
			withExceptionDo: [:anError | self assert: anError messageText equals: (Portfolio cantAddDuplicatesMessage).].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LT 5/22/2022 23:48:33'!
test15PortfolioCantAddAnAccountOrAPortfolioMoreThanOneTimeTwoOrMoreLevelsDown

	| portfolio account portfolioSon |
	
	portfolio := Portfolio new.
	portfolioSon := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: portfolioSon.
	portfolioSon add: account.
	
	self should: [portfolio add: account.] 
			raise: Error
			withExceptionDo: [:anError | self assert: anError messageText equals: (Portfolio cantAddDuplicatesMessage).].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LT 5/23/2022 00:12:20'!
test16PortfolioCantAddAPortfolioWithAnAccountOrPortfolioThatTheFirstPortfolioAlreadyHad

	| portfolio account portfolioSon |
	
	portfolio := Portfolio new.
	portfolioSon := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: account.
	portfolioSon add: account.
	
	self should: [portfolio add: portfolioSon.] 
			raise: Error
			withExceptionDo: [:anError | self assert: anError messageText equals: (Portfolio cantAddDuplicatesMessage).].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LT 5/23/2022 00:23:38'!
test17PortfolioCantAddAnAccountWhenAParentPortfolioAlreadyHadIt

	| portfolio portfolioSon account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	portfolio add: account.
	
	portfolioSon := Portfolio new.
	portfolio add: portfolioSon.
	
	self should: [portfolioSon add: account.] 
			raise: Error
			withExceptionDo: [:anError | self assert: anError messageText equals: (Portfolio cantAddDuplicatesMessage).].
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:18:39'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:19:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'adding' stamp: 'EE 5/16/2022 20:09:26'!
addTo: aBalanceValue 
	
	^aBalanceValue + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'adding' stamp: 'EE 5/16/2022 20:10:55'!
addTo: aBalanceValue
	
	^ aBalanceValue - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankAccount category: 'Portfolio-Ejercicio'!
Object subclass: #BankAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!BankAccount methodsFor: 'as yet unclassified' stamp: 'LT 5/23/2022 00:00:11'!
assertIfCantBeAdded: anAccountOrPortfolioToAdd

	self subclassResponsibility ! !

!BankAccount methodsFor: 'as yet unclassified' stamp: 'LT 5/22/2022 23:02:44'!
balance

	self subclassResponsibility ! !

!BankAccount methodsFor: 'as yet unclassified' stamp: 'LT 5/22/2022 23:02:59'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!BankAccount methodsFor: 'as yet unclassified' stamp: 'LT 5/22/2022 23:03:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAccount subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios parentsPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'EE 5/19/2022 20:47:10'!
balance
	
	^accountsAndPortfolios sum: [:anAccountOrPortfolio | anAccountOrPortfolio balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'transactions' stamp: 'EE 5/19/2022 20:53:36'!
transactions

	| unionOfTransactions |
	
	unionOfTransactions := OrderedCollection new.
	
	accountsAndPortfolios do: [:anAccountOrPortfolio | unionOfTransactions addAll: anAccountOrPortfolio transactions ].
	
	^unionOfTransactions! !


!Portfolio methodsFor: 'testing' stamp: 'LT 5/23/2022 01:08:15'!
assertCanAdd: anAccountOrPortfolioToAdd
	
	accountsAndPortfolios do: [ :anAccountOrPortfolio |
		
		anAccountOrPortfolio assertIfCantBeAdded: anAccountOrPortfolioToAdd.
		
	].

	(anAccountOrPortfolioToAdd isKindOf: Portfolio) ifTrue: [
		
		anAccountOrPortfolioToAdd assertChildsCanBeAddedToPortfolio: self.	
		
	].
	
	^true! !

!Portfolio methodsFor: 'testing' stamp: 'LT 5/23/2022 00:17:54'!
assertChildsCanBeAddedToPortfolio: aPortfolio

	accountsAndPortfolios do: [ : anAccountOrPortfolio |
		
		aPortfolio assertCanAdd: anAccountOrPortfolio.
		
		].! !

!Portfolio methodsFor: 'testing' stamp: 'LT 5/23/2022 01:09:20'!
assertFatherCantAdd: anAccountOrPortfolioToAdd

	parentsPortfolios ifEmpty: [
	
		^ ((self assertCanAdd: anAccountOrPortfolioToAdd) not).
		
	].
	
	^ parentsPortfolios anySatisfy: [ :aPortfolio |
		
		(aPortfolio assertFatherCantAdd: anAccountOrPortfolioToAdd).
		
	].	! !

!Portfolio methodsFor: 'testing' stamp: 'LT 5/23/2022 00:44:47'!
assertIfCantBeAdded: anAccountOrPortfolioToAdd

	((self = anAccountOrPortfolioToAdd) or: 
	[(self assertCanAdd: anAccountOrPortfolioToAdd) not]) ifTrue: [
			self class cantAddDuplicates.
	].! !

!Portfolio methodsFor: 'testing' stamp: 'EE 5/19/2022 20:52:49'!
hasRegistered: anAccountTransaction 
	
	| hasRegisterTransaction |

	hasRegisterTransaction := false.

	accountsAndPortfolios do: [:anAccountOrPortfolio | hasRegisterTransaction := hasRegisterTransaction or: [anAccountOrPortfolio hasRegistered: anAccountTransaction]].
	
	^ hasRegisterTransaction! !


!Portfolio methodsFor: 'initialization' stamp: 'LT 5/23/2022 00:31:05'!
initialize

	accountsAndPortfolios := OrderedCollection new.
	parentsPortfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'adding' stamp: 'LT 5/23/2022 01:08:40'!
add: anAccountOrPortfolio

	self assertCanAdd: anAccountOrPortfolio.
	
	(self assertFatherCantAdd: anAccountOrPortfolio) ifTrue: [
			self class cantAddDuplicates.			
			"CAMBIAR EL MENSAJE DE ERROR"	
			"Cant add: a father already had that bank account"
	].
	
	accountsAndPortfolios add: anAccountOrPortfolio.
	
	(anAccountOrPortfolio isKindOf: Portfolio) ifTrue: [
		anAccountOrPortfolio addFather: self.
		].! !

!Portfolio methodsFor: 'adding' stamp: 'LT 5/23/2022 00:32:03'!
addFather: aPortfolio

	parentsPortfolios add: aPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'LT 5/23/2022 00:09:26'!
cantAddDuplicates
	
	self error: (self cantAddDuplicatesMessage).! !

!Portfolio class methodsFor: 'error messages' stamp: 'LT 5/23/2022 00:09:12'!
cantAddDuplicatesMessage
	
	^ 'Cant add duplicates'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'EE 5/16/2022 20:19:07'!
balance

	| balance |
	
	balance := 0.
	
	transactions do: [ :aTransaction | balance := aTransaction addTo: balance ].
	
	^balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'LT 5/23/2022 00:09:54'!
assertIfCantBeAdded: anAccountOrPortfolioToAdd

	(self = anAccountOrPortfolioToAdd) ifTrue: [
			Portfolio cantAddDuplicates.
		].! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
