!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'instance creations' stamp: 'EE 5/23/2022 15:17:36'!
portfolioWithAccountWithDepositRegistered: anAccount 

	| portfolio |
	
	portfolio := Portfolio new.
	
	portfolio add: anAccount.
	
	Deposit register: 100 on: anAccount.
	
	^portfolio! !


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

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:19:31'!
test04PortfolioBalanceIsEqualToReceptiveAccountWhenIsTheOnlyAccountAdded

	| portfolio account |
	
	account := ReceptiveAccount  new.
	portfolio := self portfolioWithAccountWithDepositRegistered: account.
	
	self assert: account balance equals: portfolio balance.	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:20:50'!
test05PortfolioBalanceIsEqualToTheSumOfItsAccountsBalances

	| portfolio account account2 |
	
	account := ReceptiveAccount  new.
	portfolio := self portfolioWithAccountWithDepositRegistered: account.
		
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

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:45:58'!
test07PortfolioBalanceWhenCreatedAndAddedNonEmptyPortfolioIsThisLastPortfolioBalance

	| portfolio portfolio2 account |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount  new.
	portfolio2 := self portfolioWithAccountWithDepositRegistered: account.
	
	portfolio add: portfolio2.
		
	self assert: portfolio2 balance equals: portfolio balance.	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:46:19'!
test08PortfolioBalanceIsTheSumOfPortfoliosBalanceWhenAddedMultiplePortfoliosAndNotAnyAccount

	| portfolio portfolio2 account account2 portfolio3 |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount  new.
	portfolio2 := self portfolioWithAccountWithDepositRegistered: account.
	
	portfolio add: portfolio2.

	account2 := ReceptiveAccount new.
	portfolio3 := self portfolioWithAccountWithDepositRegistered: account2.
	Withdraw register: 50 on: account2.
	
	portfolio add: portfolio3.	
	
	self assert: (portfolio2 balance + portfolio3 balance) equals: portfolio balance.	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:27:19'!
test09PortfolioWithMultipleAccountsAndNonePortfoliosHasRegisteredTheAccountsTransactions

	| portfolio account deposit account2 withdraw |
	
	account := ReceptiveAccount  new.
	portfolio := Portfolio new.
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

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:36:04'!
test12PortfolioWithMultipleAccountsAndNonePortfoliosTransactionsAreTheAccountsTransactions

	| portfolio account account2 unionOfTransactions |
	
	account := ReceptiveAccount  new.
	portfolio := self portfolioWithAccountWithDepositRegistered: account.
	
	account2 := ReceptiveAccount  new.
	portfolio add: account2.
	Withdraw register: 100 on: account2.
	
	unionOfTransactions := account transactions.
	unionOfTransactions addAll: account2 transactions.
	
	self assert: (unionOfTransactions) equals: portfolio transactions
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:35:52'!
test13PortfolioWithMultipleAccountsAndPortfolioWithAccountsTransactionsAreTheUnionOfAccountsAndPortfolioTransactions

	| portfolio account account2 unionOfTransactions portfolio2 |
	
	account := ReceptiveAccount  new.
	portfolio := self portfolioWithAccountWithDepositRegistered: account.
	
	portfolio2 := Portfolio new.
	portfolio add: portfolio2.
	account2 := ReceptiveAccount new.
	Withdraw register: 150 on: account2.
	portfolio2 add: account2.
	
	unionOfTransactions := account transactions.
	unionOfTransactions addAll: portfolio2 transactions.
	
	self assert: unionOfTransactions equals: portfolio transactions
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:33:16'!
test14PortfolioCantAddAnAccountOrAPortfolioMoreThanOneTime

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: account.
	
	self assertShouldRaiseCantAddDuplicatesMessageAdding: account on: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:37:11'!
test15PortfolioCantAddAnAccountOrAPortfolioMoreThanOneTimeTwoOrMoreLevelsDown

	| portfolio account portfolioSon |
	
	portfolio := Portfolio new.
	portfolioSon := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: portfolioSon.
	portfolioSon add: account.
	
	self assertShouldRaiseCantAddDuplicatesMessageAdding: account on: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:32:09'!
test16PortfolioCantAddAPortfolioWithAnAccountOrPortfolioThatTheFirstPortfolioAlreadyHad

	| portfolio account portfolioSon |
	
	portfolio := Portfolio new.
	portfolioSon := Portfolio new.
	account := ReceptiveAccount  new.
	
	portfolio add: account.
	portfolioSon add: account.
	
	self assertShouldRaiseCantAddDuplicatesMessageAdding: portfolioSon on: portfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'EE 5/23/2022 15:31:15'!
test17PortfolioCantAddAnAccountWhenAParentPortfolioAlreadyHadIt

	| portfolio portfolioSon account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount  new.
	portfolio add: account.
	
	portfolioSon := Portfolio new.
	portfolio add: portfolioSon.
	
	self assertShouldRaiseCantAddDuplicatesMessageAdding: account on: portfolioSon.
! !


!PortfolioTest methodsFor: 'assertions' stamp: 'EE 5/23/2022 15:31:15'!
assertShouldRaiseCantAddDuplicatesMessageAdding: account on: portfolioSon

	^ self should: [portfolioSon add: account.] 
			raise: Error
			withExceptionDo: [:anError | self assert: anError messageText equals: (Portfolio cantAddDuplicatesMessage).]! !


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

!BankAccount methodsFor: 'testing' stamp: 'LT 5/22/2022 23:02:59'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!BankAccount methodsFor: 'transactions' stamp: 'LT 5/22/2022 23:03:35'!
transactions

	self subclassResponsibility ! !


!BankAccount methodsFor: 'balance' stamp: 'LT 5/22/2022 23:02:44'!
balance

	self subclassResponsibility ! !


!BankAccount methodsFor: 'assertions' stamp: 'LT 5/23/2022 00:00:11'!
assertIfCantBeAdded: anAccountOrPortfolioToAdd

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAccount subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios parentsPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'EE 5/23/2022 15:39:22'!
balance
	
	^accountsAndPortfolios sum: [:anAccountOrPortfolio | anAccountOrPortfolio balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'transactions' stamp: 'EE 5/19/2022 20:53:36'!
transactions

	| unionOfTransactions |
	
	unionOfTransactions := OrderedCollection new.
	
	accountsAndPortfolios do: [:anAccountOrPortfolio | unionOfTransactions addAll: anAccountOrPortfolio transactions ].
	
	^unionOfTransactions! !


!Portfolio methodsFor: 'testing' stamp: 'LT 5/23/2022 14:12:01'!
canAdd: anAccountOrPortfolioToAdd
	
	accountsAndPortfolios do: [ :anAccountOrPortfolio |
		
		anAccountOrPortfolio assertIfCantBeAdded: anAccountOrPortfolioToAdd.
		"Cant add: This account or portfolio is already added in the portfolio or in a child portfolio"
		
	].

	(anAccountOrPortfolioToAdd isKindOf: Portfolio) ifTrue: [
		
		anAccountOrPortfolioToAdd assertChildsCanBeAddedToPortfolio: self.	
		
	].
	
	^true! !

!Portfolio methodsFor: 'testing' stamp: 'LT 5/23/2022 14:14:21'!
fatherCantAdd: anAccountOrPortfolioToAdd

	parentsPortfolios ifEmpty: [
	
		^ ((self canAdd: anAccountOrPortfolioToAdd) not).
		
	].
	
	^ parentsPortfolios anySatisfy: [ :aPortfolio |
		
		(aPortfolio fatherCantAdd: anAccountOrPortfolioToAdd).
		
	].	! !

!Portfolio methodsFor: 'testing' stamp: 'EE 5/23/2022 15:42:15'!
hasRegistered: anAccountTransaction 
	
	^ accountsAndPortfolios anySatisfy: [:anAccountOrPortfolio | (anAccountOrPortfolio hasRegistered: anAccountTransaction)].
	
! !


!Portfolio methodsFor: 'initialization' stamp: 'LT 5/23/2022 00:31:05'!
initialize

	accountsAndPortfolios := OrderedCollection new.
	parentsPortfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'assertions' stamp: 'LT 5/23/2022 14:12:01'!
assertChildsCanBeAddedToPortfolio: aPortfolio

	accountsAndPortfolios do: [ : anAccountOrPortfolio |
		
		aPortfolio canAdd: anAccountOrPortfolio.
		
		].! !

!Portfolio methodsFor: 'assertions' stamp: 'LT 5/23/2022 14:37:46'!
assertIfCantBeAdded: anAccountOrPortfolioToAdd

	((self = anAccountOrPortfolioToAdd) or: 
	[(self canAdd: anAccountOrPortfolioToAdd) not]) ifTrue: [
			self class cantAddDuplicatesError.
	].! !


!Portfolio methodsFor: 'adding' stamp: 'LT 5/23/2022 14:51:26'!
add: anAccountOrPortfolio

	self canAdd: anAccountOrPortfolio.
	
	(self fatherCantAdd: anAccountOrPortfolio) ifTrue: [
		self class cantAddDuplicatesError.			
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

!Portfolio class methodsFor: 'errors' stamp: 'LT 5/23/2022 14:37:46'!
cantAddDuplicatesError
	
	self error: (self cantAddDuplicatesMessage).! !


!Portfolio class methodsFor: 'messages' stamp: 'LT 5/23/2022 14:52:00'!
cantAddDuplicatesMessage
	
	^ 'The account or portfolio cant be added'! !


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


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'assertions' stamp: 'LT 5/23/2022 14:47:13'!
assertIfCantBeAdded: anAccountOrPortfolioToAdd

	(self = anAccountOrPortfolioToAdd) ifTrue: [
			Portfolio cantAddDuplicatesError.
		].! !
