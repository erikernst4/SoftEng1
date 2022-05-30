!classDefinition: #PortfolioTest category: 'Portfolio2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio2'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 01:01:54'!
test01NewAccountAccountSummaryOnlyReturnsZeroBalance

	| account expectedSummary accountSummary |
	
	account := ReceptiveAccount new.
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: 'Balance = 0.'.
	
	accountSummary := SummaryPrinter with: account.

	self assert: expectedSummary equals: accountSummary printSummary.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 01:05:29'!
test02AccountWithOneDepositAccountSummaryReturnsTheReportOfTheDepositAndTheBalance

	| account deposit expectedSummary accountSummary |
	
	account := ReceptiveAccount  new.
	deposit := Deposit register: 100 on: account.
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: ('Depósito por ', deposit value asString,'.').
	expectedSummary add: ('Balance = ', deposit value asString,'.').
		
	accountSummary := SummaryPrinter with: account.
		
	self assert: expectedSummary
		equals: accountSummary printSummary.
		! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 01:06:13'!
test03AccountWithMultipleDepositsAccountSummaryReturnsTheReportOfTheDepositsAndTheBalance

	| account deposit1 deposit2 expectedSummary accountSummary |
	
	account := ReceptiveAccount  new.
	deposit1 := Deposit register: 100 on: account.
	deposit2 := Deposit register: 44 on: account.		
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: ('Depósito por ', deposit1 value asString,'.').
	expectedSummary add: ('Depósito por ', deposit2 value asString,'.').
	expectedSummary add: ('Balance = ', (deposit1 value + deposit2 value) asString,'.').

	accountSummary := SummaryPrinter with: account.

	self assert: expectedSummary 
		equals: accountSummary printSummary.
		! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 01:06:55'!
test04AccountWithMultipleDepositsAndWithdrawsAccountSummaryReturnsTheReportOfTheDepositsWithdrawsAndTheBalance

	| account deposit1 deposit2 withdraw1 withdraw2 expectedSummary accountSummary |
	
	account := ReceptiveAccount  new.
	deposit1 := Deposit register: 100 on: account.
	deposit2 := Deposit register: 44 on: account.	
	withdraw1 := Withdraw register: 50 on: account.
	withdraw2 := Withdraw register: 48 on: account.
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: ('Depósito por ', deposit1 value asString,'.').
	expectedSummary add: ('Depósito por ', deposit2 value asString,'.').
	expectedSummary add: ('Extracción por ', withdraw1 value asString,'.').
	expectedSummary add: ('Extracción por ', withdraw2 value asString,'.').
	expectedSummary add: ('Balance = ', account balance asString,'.').
	
	accountSummary := SummaryPrinter with: account.
	
	self assert: expectedSummary 
		equals: accountSummary printSummary.
		! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 01:09:14'!
test05ATransferGetsReportedInTheSenderAndTheReceiver

	| accountReceiver accountSender transfer expectedSummaryForSender expectedSummaryForReceiver accountSummarySender accountSummaryReceiver|
	
	accountSender := ReceptiveAccount  new.
	accountReceiver := ReceptiveAccount  new.

	transfer := Transfer for: 100 from: accountSender to: accountReceiver.
	
	expectedSummaryForSender := OrderedCollection new.
	expectedSummaryForSender add: ('Salida por transferencia de ', transfer value asString,'.').
	expectedSummaryForSender add: ('Balance = ', accountSender balance asString,'.').
	
	expectedSummaryForReceiver := OrderedCollection new.
	expectedSummaryForReceiver add: ('Entrada por transferencia de ', transfer value asString,'.').
	expectedSummaryForReceiver add: ('Balance = ', accountReceiver balance asString,'.').
	
	accountSummarySender := SummaryPrinter with: accountSender. 
	accountSummaryReceiver := SummaryPrinter with: accountReceiver.
	
	self assert: expectedSummaryForSender 
		equals: accountSummarySender printSummary.
		
	self assert: expectedSummaryForReceiver 
		equals: accountSummaryReceiver printSummary.
! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 00:26:04'!
test06transferNetForAnAccountWithoutTransfersIsZero

	| account transferNet |
	
	account := ReceptiveAccount  new.
	
	transferNet := TransferNetCalculator with: account.
	
	self assert: transferNet calculateTransferNet equals: 0.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 00:07:56'!
test07transferNetForAnAccountWithOnlyReceivedTransfersIsTheSumOfTheTransfersValues

		| accountReceiver accountSender transfer1 transfer2 transferNet|
	
	accountSender := ReceptiveAccount  new.
	accountReceiver := ReceptiveAccount  new.

	transfer1 := Transfer for: 100 from: accountSender to: accountReceiver.

	transfer2 := Transfer for: 44 from: accountSender to: accountReceiver.	
	
	transferNet := TransferNetCalculator with: accountReceiver.
	
	self assert: (transfer1 value + transfer2 value) equals: (transferNet calculateTransferNet).! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 00:13:56'!
test08transferNetForOfAnAccountSubstractsWhenSendingAndAddsWhenReceivingTransfer

	| accountReceiver accountSender transfer1 transfer2 transferNetReceiver transferNetSender |
	
	accountSender := ReceptiveAccount  new.
	accountReceiver := ReceptiveAccount  new.

	transfer1 := Transfer for: 100 from: accountSender to: accountReceiver.
	transfer2 := Transfer for: 44 from: accountSender to: accountReceiver.	
	
	transferNetSender := TransferNetCalculator with: accountSender.
	transferNetReceiver := TransferNetCalculator with: accountReceiver.
	
	self assert: (transfer1 value + transfer2 value) equals: transferNetReceiver calculateTransferNet.
	self assert: (0 - transfer1 value - transfer2 value) equals: transferNetSender calculateTransferNet.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 01:09:50'!
test09NewPortfolioAccountSummaryOnlyReturnsZeroBalance

	| portfolio expectedSummary accountSummary |
	
	portfolio := Portfolio new.
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: 'Balance = 0.'.
	
	accountSummary := SummaryPrinter with: portfolio.

	self assert: expectedSummary equals: accountSummary printSummary.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 01:10:28'!
test10PortfolioWithMultipleReceptiveAccountsAccountSummaryReturnsTheAccoutsTransactionsAndItsBalance

	| portfolio account1 account2 deposit withdraw expectedSummary accountSummary |
	
	account1 := ReceptiveAccount  new.
	deposit := Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	withdraw := Withdraw register: 20 on: account2.
	
	portfolio := Portfolio with: account1 with: account2.  
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: ('Depósito por ', deposit value asString,'.').
	expectedSummary add: ('Extracción por ', withdraw value asString,'.').
	expectedSummary add: ('Balance = ', portfolio balance asString,'.').
		
	accountSummary := SummaryPrinter with: portfolio.
		
	self assert: expectedSummary
		equals: accountSummary printSummary.
		! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 01:11:07'!
test11PortfolioWithMultiplePortfoliosAccountSummaryReturnsThePortfoliosAccountsTransactionsAndItsBalance

	| portfolioToTest portfolio1 portfolio2 account1 account2 account3 expectedSummary accountSummary |
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 on: account1.
	
	account2 := ReceptiveAccount new.
	Withdraw register: 20 on: account2.
	
	portfolio1 := Portfolio with: account1 with: account2.
	
	account3 := ReceptiveAccount  new.
	Deposit register: 50 on: account3.
	
	portfolio2 := Portfolio with: account3.
	
	portfolioToTest := Portfolio with: portfolio1 with: portfolio2 .  
	
	expectedSummary := OrderedCollection new.
	expectedSummary add: ('Depósito por 100.').
	expectedSummary add: ('Extracción por 20.').
	expectedSummary add: ('Depósito por 50.').
	expectedSummary add: ('Balance = ', portfolioToTest balance asString,'.').
		
	accountSummary := SummaryPrinter with: portfolioToTest.
		
	self assert: expectedSummary
		equals: accountSummary printSummary.
		! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 00:26:45'!
test12transferNetForAnEmptyPortfolioIsZero

	| portfolio transferNet |
	
	portfolio := Portfolio new.
	
	transferNet := TransferNetCalculator with: portfolio.
	
	self assert: transferNet calculateTransferNet equals: 0.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 00:16:39'!
test13transferNetForAPortfolioWithAccountsIsTheSumOfAccountsTransferNet

	| portfolioSender portfolioReceiver accountSender accountReceiver transferNetSender transferNetReceiver |
	
	accountSender := ReceptiveAccount  new.
	accountReceiver := ReceptiveAccount  new.

	Transfer for: 100 from: accountSender to: accountReceiver.
	Transfer for: 44 from: accountSender to: accountReceiver.	
	
	portfolioSender := Portfolio with: accountSender.
	portfolioReceiver := Portfolio with: accountReceiver.
	
	transferNetSender := TransferNetCalculator with: portfolioSender.
	transferNetReceiver := TransferNetCalculator with: portfolioReceiver.
	
	self assert: -144 equals: transferNetSender calculateTransferNet.
	self assert: 144 equals: transferNetReceiver calculateTransferNet.! !


!classDefinition: #TransferTest category: 'Portfolio2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferTest methodsFor: 'test suite' stamp: 'EE 5/28/2022 17:07:22'!
test01SendingAWireTrasactionSubstractsFromFirstAccountAndAddsToTheSecondOne

	| accountSender accountReceiver |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.	
	
	Transfer for: 100 from: accountSender to: accountReceiver.
	
	self assert: accountSender balance equals: -100.
	
	self assert: accountReceiver balance equals: 100.! !

!TransferTest methodsFor: 'test suite' stamp: 'EE 5/28/2022 17:07:51'!
test02AccountCantMakeWireWireTransactionToItself

	| account |
	
	account := ReceptiveAccount new.
	
	self should: [Transfer for: 100 from: account to: account.]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Transfer cantTransferToItselfMessage]! !

!TransferTest methodsFor: 'test suite' stamp: 'EE 5/28/2022 17:08:29'!
test03WireTransactionAmountCantBeLessOrEqualThanZero

	| accountSender accountReceiver |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.	
	
	self should: [Transfer for: 0 from: accountSender to: accountReceiver.]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText equals: Transfer cantTransferLessOrEqualThanZeroMessage]! !

!TransferTest methodsFor: 'test suite' stamp: 'LT 5/29/2022 20:54:20'!
test04SendingAWireTrasactionGetsRegisteredInTheSenderAccountAndTheReceiverAccount

	| accountSender accountReceiver transfer |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.	
	
	transfer := Transfer for: 100 from: accountSender to: accountReceiver.
	
	self assert: (accountSender hasRegistered: (transfer sender)).
	
	self assert: (accountReceiver hasRegistered: (transfer receiver)).! !

!TransferTest methodsFor: 'test suite' stamp: 'EE 5/28/2022 17:08:51'!
test05AWireTrasactionValueIsTheAmountOfMoneyTransfered
	
	| accountSender accountReceiver transfer |
	
	accountSender := ReceptiveAccount new.
	accountReceiver := ReceptiveAccount new.	
	
	transfer := Transfer for: 100 from: accountSender to: accountReceiver.
	
	self assert: 100 equals: transfer value.! !


!classDefinition: #Account category: 'Portfolio2'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reporting' stamp: 'LT 5/30/2022 00:46:54'!
accountSummary: aSummaryPrinter
	
	accounts do: [ :account | 
		
		account accountSummary: aSummaryPrinter.
		
	].
	! !

!Portfolio methodsFor: 'reporting' stamp: 'LT 5/29/2022 23:56:21'!
calculateAccountTransferNet: aTransferNetCalculator

	accounts do: [ :account | account calculateAccountTransferNet: aTransferNetCalculator ]

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'LT 5/29/2022 20:19:45'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reporting' stamp: 'LT 5/30/2022 00:42:43'!
accountSummary: aSummaryPrinter
	
	self addLinesToSummary: aSummaryPrinter.! !

!ReceptiveAccount methodsFor: 'reporting' stamp: 'LT 5/30/2022 00:48:38'!
addLinesToSummary: aSummaryPrinter
	
	transactions do:[:transaction |
		
		transaction reportTransaction: aSummaryPrinter.
		
	].! !

!ReceptiveAccount methodsFor: 'reporting' stamp: 'LT 5/29/2022 23:56:40'!
calculateAccountTransferNet: aTransferNetCalculator

	transactions do: [ :transaction | 
		 transaction affectTransferNet: aTransferNetCalculator.
	].! !


!classDefinition: #AccountTransaction category: 'Portfolio2'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!AccountTransaction methodsFor: 'value' stamp: 'EE 5/28/2022 15:03:57'!
value 

	^ value.! !


!AccountTransaction methodsFor: 'balance' stamp: 'LT 5/29/2022 20:22:03'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'initialization' stamp: 'EE 5/28/2022 15:06:06'!
initializeFor: aValue

	value := aValue.! !


!AccountTransaction methodsFor: 'reporting' stamp: 'LT 5/29/2022 23:57:33'!
affectTransferNet: aTransferNetCalculator

	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'reporting' stamp: 'LT 5/29/2022 21:12:57'!
reportTransaction

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio2'!
AccountTransaction class
	instanceVariableNames: 'value'!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'EE 5/28/2022 15:09:22'!
for: aValue

	^ self new initializeFor: aValue.! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'EE 5/28/2022 15:07:08'!
register: aValue on: account

	| transaction |
	
	transaction := self new initializeFor: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Deposit methodsFor: 'reporting' stamp: 'LT 5/29/2022 23:59:52'!
affectTransferNet: aTransferNetCalculator

	^ aTransferNetCalculator depositAffectsTransferNet: self.! !

!Deposit methodsFor: 'reporting' stamp: 'LT 5/30/2022 00:51:37'!
reportTransaction: aSummaryPrinter

	aSummaryPrinter reportDeposit: self.! !


!Deposit methodsFor: 'balance' stamp: 'LT 5/29/2022 20:21:52'!
affectBalance: aBalance

	^aBalance + value! !


!classDefinition: #Transfer category: 'Portfolio2'!
AccountTransaction subclass: #Transfer
	instanceVariableNames: 'mySender myReceiver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Transfer methodsFor: 'accessing' stamp: 'LT 5/29/2022 21:22:09'!
receiver

	^ myReceiver.! !

!Transfer methodsFor: 'accessing' stamp: 'LT 5/29/2022 21:22:19'!
sender

	^ mySender.! !


!Transfer methodsFor: 'initialization' stamp: 'LT 5/29/2022 21:21:57'!
initializeFor: anAmountOfMoney from: aReceptiveAccountSender to: aReceptiveAccountReceiver 

	self assertCanTransferFrom: aReceptiveAccountSender to: aReceptiveAccountReceiver ofAmount: anAmountOfMoney.
	
	value := anAmountOfMoney.

	mySender := SenderLeg for: anAmountOfMoney from: self.
	aReceptiveAccountSender register: mySender.
	
	myReceiver := ReceiverLeg for: anAmountOfMoney from: self.
	aReceptiveAccountReceiver register: myReceiver.
	! !


!Transfer methodsFor: 'assertions' stamp: 'SHAMOUN 5/23/2022 21:55:07'!
assertCanTransferFrom: aReceptiveAccountSender to: aReceptiveAccountReceiver ofAmount: anAmountOfMoney .

	(aReceptiveAccountSender = aReceptiveAccountReceiver) ifTrue: [self class cantTransferToItself ].
	
	(anAmountOfMoney > 0) ifFalse: [self class cantTransferLessOrEqualThanZero ]! !


!Transfer methodsFor: 'balance' stamp: 'LT 5/29/2022 21:11:19'!
affectBalance: aBalance

	self subclassResponsibility.! !


!Transfer methodsFor: 'reporting' stamp: 'LT 5/29/2022 21:21:47'!
affectTransferNet: aTransferNet

	self subclassResponsibility.! !

!Transfer methodsFor: 'reporting' stamp: 'LT 5/30/2022 00:49:28'!
reportTransaction: aSummaryPrinter

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'SHAMOUN 5/23/2022 21:52:41'!
cantTransferLessOrEqualThanZero

	self error: self cantTransferLessOrEqualThanZeroMessage. ! !

!Transfer class methodsFor: 'errors' stamp: 'SHAMOUN 5/23/2022 21:46:01'!
cantTransferToItself

	self error: self cantTransferToItselfMessage. ! !

!Transfer class methodsFor: 'errors' stamp: 'SHAMOUN 5/23/2022 21:46:29'!
cantTransferToItselfMessage

	^'An account cant transfer to itself'! !


!Transfer class methodsFor: 'error messages' stamp: 'SHAMOUN 5/23/2022 21:52:25'!
cantTransferLessOrEqualThanZeroMessage

	^'Cant transfer less or equal than zero'! !


!Transfer class methodsFor: 'instance creation' stamp: 'EE 5/28/2022 17:05:01'!
for: aValue from: aReceptiveAccountSender to: aReceiverAccount

	^self new initializeFor: aValue from: aReceptiveAccountSender to: aReceiverAccount ! !


!classDefinition: #ReceiverLeg category: 'Portfolio2'!
Transfer subclass: #ReceiverLeg
	instanceVariableNames: 'amountOfMoney'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!ReceiverLeg methodsFor: 'initialization' stamp: 'LT 5/29/2022 20:09:47'!
initializeFor: aValue from: aTransfer

	value := aValue.
	mySender := aTransfer. ! !


!ReceiverLeg methodsFor: 'as yet unclassified' stamp: 'LT 5/29/2022 20:14:44'!
affectBalance: aBalance

	^ aBalance + value.! !

!ReceiverLeg methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 00:00:13'!
affectTransferNet: aTransferNetCalculator

	^ aTransferNetCalculator receiverLegAffectsTransferNet: self.! !

!ReceiverLeg methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 00:56:28'!
reportTransaction: aSummaryPrinter

	aSummaryPrinter reportReceiverLeg: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceiverLeg class' category: 'Portfolio2'!
ReceiverLeg class
	instanceVariableNames: ''!

!ReceiverLeg class methodsFor: 'as yet unclassified' stamp: 'LT 5/29/2022 20:12:20'!
for: aValue from: aTransfer

	^ self new initializeFor: aValue from: aTransfer.! !


!classDefinition: #SenderLeg category: 'Portfolio2'!
Transfer subclass: #SenderLeg
	instanceVariableNames: 'amountOfMoney'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!SenderLeg methodsFor: 'initialization' stamp: 'LT 5/29/2022 20:10:02'!
initializeFor: aValue from: aTransfer

	value := aValue.
	myReceiver := aTransfer. ! !


!SenderLeg methodsFor: 'as yet unclassified' stamp: 'LT 5/29/2022 20:14:52'!
affectBalance: aBalance

	^ aBalance - value.! !

!SenderLeg methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 00:00:31'!
affectTransferNet: aTransferNetCalculator

	^ aTransferNetCalculator senderLegAffectsTransferNet: self.! !

!SenderLeg methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 00:57:29'!
reportTransaction: aSummaryPrinter

	aSummaryPrinter reportSenderLeg: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SenderLeg class' category: 'Portfolio2'!
SenderLeg class
	instanceVariableNames: ''!

!SenderLeg class methodsFor: 'as yet unclassified' stamp: 'LT 5/29/2022 20:12:29'!
for: aValue from: aTransfer

	^ self new initializeFor: aValue from: aTransfer.! !


!classDefinition: #Withdraw category: 'Portfolio2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Withdraw methodsFor: 'balance' stamp: 'LT 5/29/2022 21:24:15'!
affectBalance: aBalance

	^ aBalance - value.! !


!Withdraw methodsFor: 'reporting' stamp: 'LT 5/29/2022 23:59:43'!
affectTransferNet: aTransferNetCalculator

	^ aTransferNetCalculator withdrawAffectsTransferNet: self.! !

!Withdraw methodsFor: 'reporting' stamp: 'LT 5/30/2022 00:54:18'!
reportTransaction: aSummaryPrinter

	aSummaryPrinter reportWithdraw: self.! !


!classDefinition: #Reporter category: 'Portfolio2'!
Object subclass: #Reporter
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!Reporter methodsFor: 'initialize' stamp: 'LT 5/29/2022 19:21:31'!
initializeWith: anAccount

	self subclassResponsibility.! !


!classDefinition: #SummaryPrinter category: 'Portfolio2'!
Reporter subclass: #SummaryPrinter
	instanceVariableNames: 'summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!SummaryPrinter methodsFor: 'initialize' stamp: 'LT 5/30/2022 01:04:30'!
initializeWith: anAccount

	account := anAccount.
	summary := OrderedCollection new.! !


!SummaryPrinter methodsFor: 'printing' stamp: 'LT 5/30/2022 01:02:39'!
printSummary

	account accountSummary: self.
	
	self addBalanceLineToSummary.

	^ summary.! !


!SummaryPrinter methodsFor: 'report' stamp: 'LT 5/30/2022 00:53:13'!
reportDeposit: aDeposit

	| line |

	line := 'Depósito por ', aDeposit value asString ,'.'.
	summary add: line.! !

!SummaryPrinter methodsFor: 'report' stamp: 'LT 5/30/2022 00:56:54'!
reportReceiverLeg: aReceiverLeg

	| line |

	line := 'Entrada por transferencia de ', aReceiverLeg value asString, '.'.
	summary add: line.! !

!SummaryPrinter methodsFor: 'report' stamp: 'LT 5/30/2022 00:58:01'!
reportSenderLeg: aSenderLeg

	| line |

	line := 'Salida por transferencia de ', aSenderLeg value asString, '.'.
	summary add: line.! !

!SummaryPrinter methodsFor: 'report' stamp: 'LT 5/30/2022 00:54:40'!
reportWithdraw: aWithdraw

	| line |

	line := 'Extracción por ', aWithdraw value asString ,'.'.
	summary add: line.! !


!SummaryPrinter methodsFor: 'addLines' stamp: 'LT 5/30/2022 01:03:43'!
addBalanceLineToSummary

	summary add: ('Balance = ', account balance asString,'.').! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SummaryPrinter class' category: 'Portfolio2'!
SummaryPrinter class
	instanceVariableNames: ''!

!SummaryPrinter class methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 01:00:46'!
with: anAccount

	^ self new initializeWith: anAccount.! !


!classDefinition: #TransferNetCalculator category: 'Portfolio2'!
Reporter subclass: #TransferNetCalculator
	instanceVariableNames: 'currentTransferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2'!

!TransferNetCalculator methodsFor: 'initialize' stamp: 'LT 5/30/2022 00:03:16'!
initializeWith: anAccount

	account := anAccount.
	currentTransferNet := 0.! !


!TransferNetCalculator methodsFor: 'affectTransferNet' stamp: 'LT 5/30/2022 00:03:45'!
depositAffectsTransferNet: aDeposit

	currentTransferNet := currentTransferNet + aDeposit value.! !

!TransferNetCalculator methodsFor: 'affectTransferNet' stamp: 'LT 5/30/2022 00:05:51'!
receiverLegAffectsTransferNet: aReceiverLeg

	currentTransferNet := currentTransferNet + aReceiverLeg value.! !

!TransferNetCalculator methodsFor: 'affectTransferNet' stamp: 'LT 5/30/2022 00:05:10'!
senderLegAffectsTransferNet: aSenderLeg

	currentTransferNet := currentTransferNet - aSenderLeg value.! !

!TransferNetCalculator methodsFor: 'affectTransferNet' stamp: 'LT 5/30/2022 00:04:25'!
withdrawAffectsTransferNet: aWithdraw

	currentTransferNet := currentTransferNet - aWithdraw value.! !


!TransferNetCalculator methodsFor: 'calculate' stamp: 'LT 5/30/2022 00:10:29'!
calculateTransferNet

	account calculateAccountTransferNet: self.
	
	^ currentTransferNet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNetCalculator class' category: 'Portfolio2'!
TransferNetCalculator class
	instanceVariableNames: ''!

!TransferNetCalculator class methodsFor: 'as yet unclassified' stamp: 'LT 5/30/2022 01:00:42'!
with: anAccount

	^ self new initializeWith: anAccount.! !
