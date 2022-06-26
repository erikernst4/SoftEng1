!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'assertions' stamp: 'EE 6/16/2022 20:53:04'!
assertAddressOn: aStreet numbered: aStreetNumber in: aTown withZipCode: aZipCode in: aProvince equalsAddress: address

	self assert: aStreet equals: address streetName.
	self assert: aStreetNumber equals: address streetNumber.
	self assert: aTown equals: address town.
	self assert: aZipCode equals: address zipCode.
	self assert: aProvince equals: address province! !

!ImportTest methodsFor: 'assertions' stamp: 'EE 6/16/2022 20:41:58'!
assertCustomerWithFirstName: aFirstName withLastName: aLastName identifiedAs: anIdType number: anIdNumber equalsCustomer: importedCustomer

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber! !

!ImportTest methodsFor: 'assertions' stamp: 'EE 6/16/2022 21:18:56'!
assertJuanAndItsAddressesArePersistedCorrectly: importedCustomer2

	self assertCustomerWithFirstName: 'Juan' withLastName: 'Perez' identifiedAs: 'C' number: '23-25666777-9' equalsCustomer: importedCustomer2.
	
	self assertAddressOn: 'Alem' numbered: 1122 in: 'CABA' withZipCode: 1001 in: 'CABA' equalsAddress: (importedCustomer2 addressAt: 'Alem')! !

!ImportTest methodsFor: 'assertions' stamp: 'EE 6/16/2022 21:16:18'!
assertPepeAndItsAddressesArePersistedCorrectly: importedCustomer

	self assertCustomerWithFirstName: 'Pepe' withLastName: 'Sanchez' identifiedAs: 'D' number: '22333444' equalsCustomer: importedCustomer.
	
	self assertAddressOn: 'San Martin' numbered: 3322 in: 'Olivos' withZipCode: 1636 in: 'BsAs' equalsAddress: (importedCustomer addressAt: 'San Martin').
	
	self assertAddressOn: 'Maipu' numbered: 888 in: 'Florida' withZipCode: 1122 in: 'Buenos Aires' equalsAddress: (importedCustomer addressAt: 'Maipu')! !


!ImportTest methodsFor: 'test configuration' stamp: 'EE 6/16/2022 19:43:08'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'test configuration' stamp: 'EE 6/16/2022 19:43:45'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'test' stamp: 'EE 6/23/2022 21:03:02'!
assertErrorIs: anErrorMessage for: aClass on: aDataset  

	^ self
		should: [CustomerImporter valueFor: aDataset of: session ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessage equals: anError messageText .
			self assert: 0 equals: (session selectAllOfType: aClass) size]! !

!ImportTest methodsFor: 'test' stamp: 'EE 6/23/2022 18:48:05'!
test01ValidDataIsImportedCorrectly

	(CustomerImporter from: (self validData) into: session) value.
	
	self assert: 2 equals: (session selectAllOfType: Customer) size.
	
	self assertPepeAndItsAddressesArePersistedCorrectly: (self customerIdentifiedAs: 'D' number: '22333444').
	
	self assertJuanAndItsAddressesArePersistedCorrectly: (self customerIdentifiedAs: 'C' number: '23-25666777-9').! !

!ImportTest methodsFor: 'test' stamp: 'EE 6/23/2022 21:03:09'!
test02CustomerRecordMustBeCStrictly

	self assertErrorIs: CustomerImporter invalidRecordTypeErrorDescription for: Customer on: self invalidCustomerRecord.! !

!ImportTest methodsFor: 'test' stamp: 'EE 6/23/2022 21:04:31'!
test03AddressRecordMustBeAStrictly

	self assertErrorIs: CustomerImporter invalidRecordTypeErrorDescription for: Address on: self invalidAddressRecord.! !

!ImportTest methodsFor: 'test' stamp: 'EE 6/23/2022 21:07:58'!
test04AddressRecordCantBeBeforeCustomerRecord

 	self assertErrorIs: CustomerImporter invalidRecordOrderErrorDescription for: Address on: self addressBeforeCustomerData.
! !

!ImportTest methodsFor: 'test' stamp: 'EE 6/23/2022 21:06:16'!
test05CustomerRecordMustHaveStrictly5Fields

	self assertErrorIs: CustomerImporter invalidRecordSizeErrorDescription for: Customer on: self invalidCustomerRecordLargerSize.
	
	self assertErrorIs: CustomerImporter invalidRecordSizeErrorDescription for: Customer on: self invalidCustomerRecordSmallerSize.
	! !

!ImportTest methodsFor: 'test' stamp: 'EE 6/23/2022 21:05:22'!
test06AddressRecordMustHaveStrictly6Fields

	self assertErrorIs: CustomerImporter invalidRecordSizeErrorDescription for: Address on: self invalidAddressRecordLargerSize.

	self assertErrorIs: CustomerImporter invalidRecordSizeErrorDescription for: Address on: self invalidAddressRecordSmallerSize.! !

!ImportTest methodsFor: 'test' stamp: 'EE 6/23/2022 21:08:37'!
test07RecordCanNotBeEmpty

	self assertErrorIs: CustomerImporter emptyRecordErrorDescription for: Address on: self emptyRecordData.
! !


!ImportTest methodsFor: 'instances' stamp: 'EE 6/23/2022 19:49:30'!
addressBeforeCustomerData

	^ ReadStream on:
'A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportTest methodsFor: 'instances' stamp: 'EE 6/23/2022 20:36:25'!
emptyRecordData

	^ ReadStream on:
'
'! !

!ImportTest methodsFor: 'instances' stamp: 'EE 6/23/2022 19:29:05'!
invalidAddressRecord
	
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'instances' stamp: 'EE 6/23/2022 20:39:52'!
invalidAddressRecordLargerSize
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,12,2,2,2,2,2,2,2,'! !

!ImportTest methodsFor: 'instances' stamp: 'EE 6/23/2022 20:40:05'!
invalidAddressRecordSmallerSize
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,'! !

!ImportTest methodsFor: 'instances' stamp: 'EE 6/23/2022 18:53:41'!
invalidCustomerRecord
	
	^ ReadStream on:
'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'instances' stamp: 'EE 6/23/2022 20:37:50'!
invalidCustomerRecordLargerSize
	
	^ ReadStream on:
'C,Pepe,Sanchez,12321,13213,1231,1223'! !

!ImportTest methodsFor: 'instances' stamp: 'EE 6/23/2022 20:38:01'!
invalidCustomerRecordSmallerSize
	
	^ ReadStream on:
'C,Pepe,Sanchez'! !

!ImportTest methodsFor: 'instances' stamp: 'EE 6/16/2022 21:14:42'!
validData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!ImportTest methodsFor: 'accessing' stamp: 'EE 6/16/2022 20:06:46'!
customerIdentifiedAs: idType number: idNumber 

	^ (session select: [:aCustomer | aCustomer identificationType = idType and: [aCustomer identificationNumber = idNumber]] ofType: Customer) anyOne! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

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


!Address methodsFor: 'testing' stamp: 'EE 6/16/2022 20:00:05'!
isAt: aStreetName 
	
	^streetName  = aStreetName! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'EE 6/16/2022 19:59:38'!
addressAt: aStreet 
	
	^ addresses detect: [:anAddress | anAddress isAt: aStreet].! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


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
	instanceVariableNames: 'session stream line newCustomer record newAddress'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'EE 6/16/2022 20:13:59'!
initializeFrom: anAStream into: aSession
	session := aSession.
	stream := anAStream.! !


!CustomerImporter methodsFor: 'assertions' stamp: 'EE 6/23/2022 20:11:21'!
assertAddressRecordAppearsAfterCustomerRecord

	^ newCustomer ifNil: [self error: (self class invalidRecordOrderErrorDescription)]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'EE 6/23/2022 20:44:21'!
assertRecordIsNotEmpty

	^ record ifEmpty: [self error: (self class emptyRecordErrorDescription)]! !

!CustomerImporter methodsFor: 'assertions' stamp: 'EE 6/23/2022 20:20:05'!
assertValidAddressRecordSize

	^ self recordSizeIs: 6! !

!CustomerImporter methodsFor: 'assertions' stamp: 'EE 6/23/2022 20:20:37'!
assertValidCustomerRecordSize

	^ self recordSizeIs: 5! !

!CustomerImporter methodsFor: 'assertions' stamp: 'EE 6/23/2022 20:39:01'!
recordSizeIs: aRecordSize

	^ (record size = aRecordSize) ifFalse: [self error: (self class invalidRecordSizeErrorDescription )]! !


!CustomerImporter methodsFor: 'errors' stamp: 'EE 6/23/2022 20:44:55'!
signalInvalidTypeRecord

	^ self error: (self class invalidRecordTypeErrorDescription)! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'EE 6/23/2022 18:34:52'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'EE 6/23/2022 18:37:13'!
hasLineToImport

	line := stream nextLine. 
	^ line notNil! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'EE 6/23/2022 20:17:30'!
importAddress
	 
	self assertAddressRecordAppearsAfterCustomerRecord.
	
	self assertValidAddressRecordSize.
	
	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'EE 6/23/2022 20:18:06'!
importCustomer

	self assertValidCustomerRecordSize.

	newCustomer := Customer new.
			newCustomer firstName: record second.
			newCustomer lastName: record third.
			newCustomer identificationType: record fourth.
			newCustomer identificationNumber: record fifth.
			session persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'EE 6/23/2022 20:44:55'!
importRecord

	self assertRecordIsNotEmpty.
	
	(self isCustomerRecord) ifTrue: [ ^ self importCustomer ].

	(self isAddressRecord) ifTrue: [ ^ self importAddress ].
	
	self signalInvalidTypeRecord.
	
	! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'EE 6/23/2022 19:33:56'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'EE 6/23/2022 18:52:41'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'EE 6/23/2022 20:06:56'!
value	 

	[self hasLineToImport ] whileTrue: [  
		self createRecord.
		self importRecord]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'EE 6/16/2022 20:13:59'!
from: anAStream into: aSession
	^self new initializeFrom: anAStream into: aSession! !

!CustomerImporter class methodsFor: 'instance creation' stamp: 'EE 6/23/2022 18:54:29'!
valueFor: aReadStream of: aDataBaseSession 

	^(self new initializeFrom: aReadStream into: aDataBaseSession) value! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'EE 6/23/2022 20:42:05'!
emptyRecordErrorDescription
	
	^'Can not have an empty record'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'EE 6/23/2022 20:02:31'!
invalidRecordOrderErrorDescription
	
	^ 'Address record before customer record'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'EE 6/23/2022 19:38:59'!
invalidRecordSizeErrorDescription
	
	^'Invalid record amount of fields'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'EE 6/23/2022 18:56:56'!
invalidRecordTypeErrorDescription
	
	^ 'Record type is not valid'! !


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


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
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


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
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
