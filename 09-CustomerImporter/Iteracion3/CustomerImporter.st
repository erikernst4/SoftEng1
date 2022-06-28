!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'test configuration' stamp: 'LT 6/27/2022 20:56:18'!
setUp

	system := Environment current createCustomerSystem.
	system start.
	system beginTransaction.! !

!ImportTest methodsFor: 'test configuration' stamp: 'LT 6/27/2022 18:36:27'!
tearDown

	system commitTransaction.
	system stop.! !


!ImportTest methodsFor: 'test' stamp: 'LT 6/28/2022 00:10:07'!
test01ValidDataIsImportedCorrectly

	(CustomerImporter valueFor: (self validData) using: system) value.
	
	self assert: 2 equals: (system numberOf: Customer).
	
	self assertPepeAndItsAddressesArePersistedCorrectly: ( system customerIdentifiedAs: 'D' number: '22333444').
	
	self assertJuanAndItsAddressesArePersistedCorrectly: ( system customerIdentifiedAs: 'C' number: '23-25666777-9').! !

!ImportTest methodsFor: 'test' stamp: 'LT 6/27/2022 20:44:01'!
test02CustomerRecordMustBeCStrictly

	self assertImportingErrorIs: CustomerImporter invalidRecordTypeErrorDescription on: self invalidCustomerRecord asserting: [self assertNoCustomerWasImported.].! !

!ImportTest methodsFor: 'test' stamp: 'LT 6/27/2022 20:44:01'!
test03AddressRecordMustBeAStrictly


	self assertImportingErrorIs: CustomerImporter invalidRecordTypeErrorDescription on: self invalidAddressRecord 
	asserting: [	 self assertImportedOneCustomerWithoutAddresses. ].
		! !

!ImportTest methodsFor: 'test' stamp: 'LT 6/27/2022 20:44:01'!
test04AddressRecordCantBeBeforeCustomerRecord

 	self assertImportingErrorIs: CustomerImporter invalidRecordOrderErrorDescription on: self addressBeforeCustomerData asserting: [self assertNoCustomerWasImported ].
! !

!ImportTest methodsFor: 'test' stamp: 'LT 6/27/2022 20:48:18'!
test05CustomerRecordMustHaveStrictly5Fields

	self assertImportingErrorIs: CustomerImporter invalidRecordSizeErrorDescription on: self invalidCustomerRecordLargerSize 
	asserting: [ self assertNoCustomerWasImported ].
	
	self assertImportingErrorIs: CustomerImporter invalidRecordSizeErrorDescription on: self invalidCustomerRecordSmallerSize 
	asserting: [ self assertNoCustomerWasImported ].
	! !

!ImportTest methodsFor: 'test' stamp: 'LT 6/27/2022 20:49:33'!
test06AddressRecordMustHaveStrictly6Fields

	self assertImportingErrorIs: CustomerImporter invalidRecordSizeErrorDescription on: self invalidAddressRecordLargerSize 
	asserting: [ self assertImportedOneCustomerWithoutAddresses ].
	
	system restart.

	self assertImportingErrorIs: CustomerImporter invalidRecordSizeErrorDescription on: self invalidAddressRecordSmallerSize 
	asserting: [ self assertImportedOneCustomerWithoutAddresses ].! !

!ImportTest methodsFor: 'test' stamp: 'LT 6/27/2022 20:49:53'!
test07RecordCanNotBeEmpty

	self assertImportingErrorIs: CustomerImporter emptyRecordErrorDescription on: self emptyRecordData asserting: [self assertNoCustomerWasImported ].
! !


!ImportTest methodsFor: 'assertions' stamp: 'LT 6/28/2022 00:12:57'!
assertAddressOn: aStreet numbered: aStreetNumber in: aTown withZipCode: aZipCode in: aProvince equalsAddress: address

	self assert: aStreet equals: address streetName.
	self assert: aStreetNumber equals: address streetNumber.
	self assert: aTown equals: address town.
	self assert: aZipCode equals: address zipCode.
	self assert: aProvince equals: address province.! !

!ImportTest methodsFor: 'assertions' stamp: 'LT 6/28/2022 00:11:46'!
assertCustomerWithFirstName: aFirstName withLastName: aLastName identifiedAs: anIdType number: anIdNumber equalsCustomer: importedCustomer

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber! !

!ImportTest methodsFor: 'assertions' stamp: 'LT 6/28/2022 17:48:12'!
assertImportedOneCustomerWithoutAddresses

	| importedCustomer |
	
	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerIdentifiedAs: 'D' number: 	'22333444'.
	self assert: importedCustomer isAddressesEmpty! !

!ImportTest methodsFor: 'assertions' stamp: 'LT 6/27/2022 20:44:01'!
assertImportingErrorIs: anErrorMessage on: aDataset asserting: anAssertBlock   

	^ self
		should: [CustomerImporter valueFor: aDataset using: system ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessage equals: anError messageText .
			anAssertBlock value.]! !

!ImportTest methodsFor: 'assertions' stamp: 'LT 6/28/2022 00:15:22'!
assertJuanAndItsAddressesArePersistedCorrectly: importedCustomer2

	self assertCustomerWithFirstName: 'Juan' withLastName: 'Perez' identifiedAs: 'C' number: '23-25666777-9' equalsCustomer: importedCustomer2.
	
	self assertAddressOn: 'Alem' numbered: 1122 in: 'CABA' withZipCode: 1001 in: 'CABA' equalsAddress: (importedCustomer2 addressAt: 'Alem').! !

!ImportTest methodsFor: 'assertions' stamp: 'LT 6/27/2022 20:23:19'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'LT 6/28/2022 00:11:07'!
assertPepeAndItsAddressesArePersistedCorrectly: importedCustomer

	self assertCustomerWithFirstName: 'Pepe' withLastName: 'Sanchez' identifiedAs: 'D' number: '22333444' equalsCustomer: importedCustomer.
	
	self assertAddressOn: 'San Martin' numbered: 3322 in: 'Olivos' withZipCode: 1636 in: 'BsAs' equalsAddress: (importedCustomer addressAt: 'San Martin').
	
	self assertAddressOn: 'Maipu' numbered: 888 in: 'Florida' withZipCode: 1122 in: 'Buenos Aires' equalsAddress: (importedCustomer addressAt: 'Maipu').! !


!ImportTest methodsFor: 'data' stamp: 'LT 6/28/2022 00:30:02'!
addressBeforeCustomerData

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportTest methodsFor: 'data' stamp: 'LT 6/28/2022 00:33:57'!
emptyRecordData

	^ ReadStream on:
'
'! !

!ImportTest methodsFor: 'data' stamp: 'LT 6/28/2022 00:28:26'!
invalidAddressRecord
	
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'
		! !

!ImportTest methodsFor: 'data' stamp: 'LT 6/28/2022 00:32:31'!
invalidAddressRecordLargerSize
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,12,2,2,2,2,2,2,2,'! !

!ImportTest methodsFor: 'data' stamp: 'LT 6/28/2022 00:32:57'!
invalidAddressRecordSmallerSize
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,'! !

!ImportTest methodsFor: 'data' stamp: 'LT 6/28/2022 00:17:53'!
invalidCustomerRecord
	
	^ ReadStream on:
'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'data' stamp: 'LT 6/28/2022 00:31:32'!
invalidCustomerRecordLargerSize
	
	^ ReadStream on:
'C,Pepe,Sanchez,12321,13213,1231,1223'! !

!ImportTest methodsFor: 'data' stamp: 'LT 6/28/2022 00:32:00'!
invalidCustomerRecordSmallerSize
	
	^ ReadStream on:
'C,Pepe,Sanchez'! !

!ImportTest methodsFor: 'data' stamp: 'LT 6/27/2022 23:45:23'!
validData
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'LT 6/28/2022 00:14:34'!
isAt: aStreetName 
	
	^streetName  = aStreetName! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'LT 6/28/2022 00:13:44'!
addressAt: aStreet 
	
	^ addresses detect: [:anAddress | anAddress isAt: aStreet].! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'LT 6/27/2022 20:36:47'!
isAddressesEmpty
	
	^ self addresses isEmpty.! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'stream line newCustomer record newAddress system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'LT 6/28/2022 17:30:17'!
initializeFrom: aStream using: aSystem 

	stream := aStream.
	system := aSystem. ! !


!CustomerImporter methodsFor: 'asserting' stamp: 'LT 6/27/2022 23:58:32'!
assertAddressRecordAppearsAfterCustomerRecord

	^ newCustomer ifNil: [self error: (self class invalidRecordOrderErrorDescription)].! !

!CustomerImporter methodsFor: 'asserting' stamp: 'LT 6/27/2022 23:53:51'!
assertRecordIsNotEmpty

	^ record ifEmpty: [self error: (self class emptyRecordErrorDescription)].! !

!CustomerImporter methodsFor: 'asserting' stamp: 'LT 6/27/2022 23:58:38'!
assertValidAddressRecordSize

	^ self recordSizeIs: 6.! !

!CustomerImporter methodsFor: 'asserting' stamp: 'LT 6/27/2022 23:55:04'!
assertValidCustomerRecordSize

	^ self recordSizeIs: 5.! !

!CustomerImporter methodsFor: 'asserting' stamp: 'LT 6/28/2022 00:18:26'!
signalInvalidTypeRecord

	^ self error: (self class invalidRecordTypeErrorDescription)! !


!CustomerImporter methodsFor: 'testing' stamp: 'LT 6/27/2022 23:51:46'!
hasLineToImport

	line := stream nextLine. 
	^ line notNil! !

!CustomerImporter methodsFor: 'testing' stamp: 'LT 6/27/2022 23:56:28'!
isAddressRecord

	^ record first = 'A'.! !

!CustomerImporter methodsFor: 'testing' stamp: 'LT 6/27/2022 23:54:23'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'testing' stamp: 'LT 6/27/2022 23:56:24'!
recordSizeIs: aRecordSize

	^ (record size = aRecordSize) ifFalse: [self error: (self class invalidRecordSizeErrorDescription )].! !


!CustomerImporter methodsFor: 'importing' stamp: 'LT 6/27/2022 19:56:09'!
addCustomer

	^ system addCustomer: newCustomer.! !

!CustomerImporter methodsFor: 'importing' stamp: 'LT 6/27/2022 23:52:23'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'importing' stamp: 'LT 6/27/2022 23:57:12'!
importAddress
	 
	self assertAddressRecordAppearsAfterCustomerRecord.
	
	self assertValidAddressRecordSize.
	
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth.! !

!CustomerImporter methodsFor: 'importing' stamp: 'LT 6/27/2022 19:52:30'!
importCustomer

	self assertValidCustomerRecordSize.

	newCustomer := Customer new.
			newCustomer firstName: record second.
			newCustomer lastName: record third.
			newCustomer identificationType: record fourth.
			newCustomer identificationNumber: record fifth.
			self addCustomer! !

!CustomerImporter methodsFor: 'importing' stamp: 'LT 6/27/2022 23:53:11'!
importRecord

	self assertRecordIsNotEmpty.
	
	(self isCustomerRecord) ifTrue: [ ^ self importCustomer ].

	(self isAddressRecord) ifTrue: [ ^ self importAddress ].
	
	self signalInvalidTypeRecord.! !

!CustomerImporter methodsFor: 'importing' stamp: 'LT 6/27/2022 23:51:12'!
value	 

	[self hasLineToImport ] whileTrue: [  
		self createRecord.
		self importRecord]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'LT 6/27/2022 19:48:50'!
valueFor: aReadStream using: aSystem  

	^(self new initializeFrom: aReadStream using: aSystem) value! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'LT 6/28/2022 00:33:26'!
emptyRecordErrorDescription
	
	^'Can not have an empty record'.! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'LT 6/28/2022 00:29:21'!
invalidRecordOrderErrorDescription
	
	^ 'Address record before customer record'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'LT 6/28/2022 00:30:50'!
invalidRecordSizeErrorDescription
	
	^'Invalid record amount of fields'.! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'LT 6/28/2022 00:17:12'!
invalidRecordTypeErrorDescription
	
	^ 'Record type is not valid'! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'interface' stamp: 'LT 6/28/2022 00:46:43'!
addCustomer: aCustomer

	self subclassResponsibility. ! !

!CustomerSystem methodsFor: 'interface' stamp: 'LT 6/28/2022 00:46:59'!
beginTransaction

	self subclassResponsibility. ! !

!CustomerSystem methodsFor: 'interface' stamp: 'LT 6/28/2022 00:47:14'!
commitTransaction

	self subclassResponsibility. ! !

!CustomerSystem methodsFor: 'interface' stamp: 'LT 6/28/2022 00:47:27'!
customerIdentifiedAs: idType number: idNumber 

	self subclassResponsibility. ! !

!CustomerSystem methodsFor: 'interface' stamp: 'LT 6/28/2022 17:36:37'!
numberOf: aClass

	self subclassResponsibility. ! !

!CustomerSystem methodsFor: 'interface' stamp: 'LT 6/28/2022 00:46:41'!
numberOfCustomers

	self subclassResponsibility. ! !

!CustomerSystem methodsFor: 'interface' stamp: 'LT 6/28/2022 17:36:52'!
restart

	self subclassResponsibility. ! !

!CustomerSystem methodsFor: 'interface' stamp: 'LT 6/28/2022 17:37:10'!
start

	self subclassResponsibility. ! !

!CustomerSystem methodsFor: 'interface' stamp: 'LT 6/28/2022 17:37:13'!
stop

	self subclassResponsibility. ! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'ending' stamp: 'LT 6/27/2022 18:36:18'!
stop

	session close! !


!PersistentCustomerSystem methodsFor: 'transaction' stamp: 'LT 6/27/2022 18:35:04'!
beginTransaction

	session beginTransaction.! !

!PersistentCustomerSystem methodsFor: 'transaction' stamp: 'LT 6/27/2022 18:35:45'!
commitTransaction

	session commit! !

!PersistentCustomerSystem methodsFor: 'transaction' stamp: 'LT 6/27/2022 18:30:27'!
session: aSession

	session := aSession.! !


!PersistentCustomerSystem methodsFor: 'adding' stamp: 'LT 6/27/2022 19:56:47'!
addCustomer: aCustomer

	^ session persist: aCustomer.! !


!PersistentCustomerSystem methodsFor: 'accesing' stamp: 'LT 6/27/2022 18:37:25'!
customerIdentifiedAs: idType number: idNumber 

	^ (session select: [:aCustomer | aCustomer identificationType = idType and: [aCustomer identificationNumber = idNumber]] ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'accesing' stamp: 'LT 6/27/2022 18:41:34'!
numberOf: aClass

	^ (session selectAllOfType: aClass) size! !

!PersistentCustomerSystem methodsFor: 'accesing' stamp: 'LT 6/28/2022 00:48:38'!
numberOfCustomers

	^ self numberOf: Customer.! !


!PersistentCustomerSystem methodsFor: 'initialization' stamp: 'LT 6/27/2022 20:49:20'!
restart

	self stop.
	self start.! !

!PersistentCustomerSystem methodsFor: 'initialization' stamp: 'LT 6/27/2022 18:33:31'!
start

	self session: (DataBaseSession for: (Array with: Address with: Customer)).! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'initialization' stamp: 'LT 6/27/2022 20:48:40'!
restart
	
	self stop.	
	self start.! !

!TransientCustomerSystem methodsFor: 'initialization' stamp: 'LT 6/27/2022 20:01:59'!
start
	
	customers := OrderedCollection new.! !


!TransientCustomerSystem methodsFor: 'adding' stamp: 'LT 6/27/2022 20:02:44'!
addCustomer: aCustomer 
	
	customers add: aCustomer.! !


!TransientCustomerSystem methodsFor: 'accesing' stamp: 'LT 6/27/2022 20:07:26'!
customerIdentifiedAs: idType number: idNumber 

	^ (customers select: [:aCustomer | aCustomer identificationType = idType and: [aCustomer identificationNumber = idNumber]]) anyOne! !

!TransientCustomerSystem methodsFor: 'accesing' stamp: 'LT 6/27/2022 20:03:18'!
numberOf: aClass 
	
	^ customers size.! !

!TransientCustomerSystem methodsFor: 'accesing' stamp: 'LT 6/27/2022 20:29:56'!
numberOfCustomers
	
	^ customers size.! !


!TransientCustomerSystem methodsFor: 'transactions' stamp: 'LT 6/27/2022 20:02:16'!
beginTransaction
	
	! !

!TransientCustomerSystem methodsFor: 'transactions' stamp: 'LT 6/27/2022 20:07:50'!
commitTransaction
	
	! !


!TransientCustomerSystem methodsFor: 'ending' stamp: 'LT 6/27/2022 20:08:49'!
stop
	
	customers := nil.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'LT 6/28/2022 01:00:49'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'LT 6/28/2022 00:59:47'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Environment category: 'CustomerImporter'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'as yet unclassified' stamp: 'yy 6/27/2022 21:14:23'!
current

	^ (self subclasses detect: [ :aSubclass | aSubclass isCurrent.]) new.! !


!classDefinition: #DevEnvironment category: 'CustomerImporter'!
Environment subclass: #DevEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DevEnvironment methodsFor: 'as yet unclassified' stamp: 'LT 6/27/2022 21:00:38'!
createCustomerSystem

	^ TransientCustomerSystem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevEnvironment class' category: 'CustomerImporter'!
DevEnvironment class
	instanceVariableNames: ''!

!DevEnvironment class methodsFor: 'as yet unclassified' stamp: 'LT 6/27/2022 20:59:37'!
isCurrent

	^ ((Smalltalk at: #ENV) = #DEV).! !


!classDefinition: #ProdEnvironment category: 'CustomerImporter'!
Environment subclass: #ProdEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ProdEnvironment methodsFor: 'as yet unclassified' stamp: 'LT 6/27/2022 21:00:50'!
createCustomerSystem

	^ PersistentCustomerSystem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProdEnvironment class' category: 'CustomerImporter'!
ProdEnvironment class
	instanceVariableNames: ''!

!ProdEnvironment class methodsFor: 'as yet unclassified' stamp: 'LT 6/27/2022 20:59:45'!
isCurrent

	^ ((Smalltalk at: #ENV) = #PROD).! !
