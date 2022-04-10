!classDefinition: #I category: 'Numeros-Naturales-Ejemplares'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros-Naturales-Ejemplares'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next' stamp: 'ARM 3/31/2022 21:18:47'!
next

	^II! !

!I class methodsFor: 'next' stamp: 'LT 4/4/2022 20:30:57'!
sustraeteDe: minuendo

	^minuendo previous! !


!I class methodsFor: 'operations' stamp: 'LT 4/10/2022 02:48:47'!
* unMultiplicando

	^ unMultiplicando! !

!I class methodsFor: 'operations' stamp: 'LT 4/10/2022 02:49:02'!
+ unSumando

	^unSumando next! !

!I class methodsFor: 'operations' stamp: 'LT 4/10/2022 03:01:53'!
- unSustraendo

	self error: self negativeNumbersNotSupportedErrorDescription.! !

!I class methodsFor: 'operations' stamp: 'LT 4/10/2022 03:03:55'!
/ unDivisor
	unDivisor = I 
		ifTrue:[^I].
	self error: self canNotDivideByBiggerNumberErrorDescription.
! !

!I class methodsFor: 'operations' stamp: 'LT 4/10/2022 02:46:11'!
> unNumero

	^ false.! !


!I class methodsFor: 'mensajes de error' stamp: 'LT 4/10/2022 03:03:45'!
canNotDivideByBiggerNumberErrorDescription

	^'canNotDivideByBiggerNumberErrorDescription'! !

!I class methodsFor: 'mensajes de error' stamp: 'LT 4/10/2022 03:02:33'!
negativeNumbersNotSupportedErrorDescription

	^'negativeNumbersNotSupportedErrorDescription'! !


!classDefinition: #II category: 'Numeros-Naturales-Ejemplares'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros-Naturales-Ejemplares'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operaciones' stamp: 'LT 4/10/2022 02:49:46'!
* unMultiplicando

	^unMultiplicando + (self previous * unMultiplicando)! !

!II class methodsFor: 'operaciones' stamp: 'LT 4/10/2022 02:50:47'!
+ unSumando

	^previous + unSumando next! !

!II class methodsFor: 'operaciones' stamp: 'LT 4/10/2022 02:52:07'!
- unSustraendo

	^unSustraendo sustraeteDe: self.! !

!II class methodsFor: 'operaciones' stamp: 'LT 4/10/2022 03:04:02'!
/ unDivisor
	unDivisor > self 
		ifTrue:[^ self error: self canNotDivideByBiggerNumberErrorDescription].
	unDivisor=self 
		ifTrue:[^I].
	unDivisor=I 
		ifTrue:[^self].
	^I+((self-unDivisor)/unDivisor).
! !

!II class methodsFor: 'operaciones' stamp: 'LT 4/10/2022 02:54:56'!
> unNumero
	unNumero=I 
		ifTrue:[^true].
	^self previous > unNumero previous.

! !

!II class methodsFor: 'operaciones' stamp: 'LT 4/4/2022 20:30:24'!
sustraeteDe: minuendo

	^minuendo previous - self previous! !


!II class methodsFor: 'next & previous' stamp: 'LT 4/10/2022 02:39:10'!
nameOfNext

	(self name endsWith: 'CMXCIX') ifTrue:[^(self name withoutSuffix:'CMXCIX'), 'M'].		
	(self name endsWith: 'DCCCXCIX') ifTrue:[^(self name withoutSuffix:'DCCCXCIX'), 'CM'].		
	(self name endsWith: 'CDXCIX') ifTrue:[^(self name withoutSuffix:'CDXCIX'), 'D'].		
	(self name endsWith: 'CCCXCIX') ifTrue:[^(self name withoutSuffix:'CCCXCIX'), 'CD'].			
	(self name endsWith: 'XCIX') ifTrue:[^(self name withoutSuffix:'XCIX'), 'C'].		
	(self name endsWith: 'LXXXIX') ifTrue:[^(self name withoutSuffix:'LXXXIX'), 'XC'].	
	(self name endsWith: 'XLIX') ifTrue:[^(self name withoutSuffix:'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue:[^(self name withoutSuffix:'XXXIX'), 'XL'].	
	(self name endsWith: 'IX') ifTrue:[^(self name withoutSuffix:'IX'), 'X'].	
	(self name endsWith: 'VIII') ifTrue:[^(self name withoutSuffix:'VIII'), 'IX'].
	(self name endsWith: 'IV') ifTrue:[^(self name withoutSuffix:'IV'), 'V'].
	(self name endsWith: 'III') ifTrue:[^(self name withoutSuffix:'III'), 'IV'].
	^ self name, 'I'! !

!II class methodsFor: 'next & previous' stamp: 'LT 4/4/2022 21:30:50'!
next
	next ifNotNil:[^next].
	next _ II createChildNamed: self nameOfNext.
	next previous: self.
	^next! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:26:45'!
previous

	^previous! !

!II class methodsFor: 'next & previous' stamp: 'ARM 3/31/2022 21:20:55'!
previous: unNatural 
	
	previous _ unNatural! !


!II class methodsFor: 'mensajes de error' stamp: 'LT 4/10/2022 03:04:16'!
canNotDivideByBiggerNumberErrorDescription

	^'canNotDivideByBiggerNumberErrorDescription'! !

!II class methodsFor: 'mensajes de error' stamp: 'LT 4/10/2022 03:01:38'!
negativeNumbersNotSupportedErrorDescription

	^'negativeNumbersNotSupportedErrorDescription'! !


!II class methodsFor: 'as yet unclassified' stamp: 'LT 4/4/2022 21:40:22'!
removeAllNext
	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
		]! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'LT 4/10/2022 03:04:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros-Naturales-Ejemplares'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros-Naturales-Ejemplares'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'LT 4/10/2022 03:04:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'Numeros-Naturales-Ejemplares'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'Numeros-Naturales-Ejemplares'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'LT 4/10/2022 03:04:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := V.
	previous := III.! !


!classDefinition: #V category: 'Numeros-Naturales-Ejemplares'!
II subclass: #V
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'V class' category: 'Numeros-Naturales-Ejemplares'!
V class
	instanceVariableNames: ''!

!V class methodsFor: '--** private fileout/in **--' stamp: 'LT 4/10/2022 03:04:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VI.
	previous := IV.! !


!classDefinition: #VI category: 'Numeros-Naturales-Ejemplares'!
II subclass: #VI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VI class' category: 'Numeros-Naturales-Ejemplares'!
VI class
	instanceVariableNames: ''!

!VI class methodsFor: '--** private fileout/in **--' stamp: 'LT 4/10/2022 03:04:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VII.
	previous := V.! !


!classDefinition: #VII category: 'Numeros-Naturales-Ejemplares'!
II subclass: #VII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VII class' category: 'Numeros-Naturales-Ejemplares'!
VII class
	instanceVariableNames: ''!

!VII class methodsFor: '--** private fileout/in **--' stamp: 'LT 4/10/2022 03:04:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := VIII.
	previous := VI.! !


!classDefinition: #VIII category: 'Numeros-Naturales-Ejemplares'!
II subclass: #VIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales-Ejemplares'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VIII class' category: 'Numeros-Naturales-Ejemplares'!
VIII class
	instanceVariableNames: ''!

!VIII class methodsFor: '--** private fileout/in **--' stamp: 'LT 4/10/2022 03:04:33'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := VII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!
V initializeAfterFileIn!
VI initializeAfterFileIn!
VII initializeAfterFileIn!
VIII initializeAfterFileIn!