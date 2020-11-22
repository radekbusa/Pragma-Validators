"
I encapsulate implementation details of Object>>validate extension method.

"
Class {
	#name : #PragmaValidationProcessor,
	#superclass : #Object,
	#category : #'PragmaValidators-PragmaProcessing'
}

{ #category : #'pragma extraction' }
PragmaValidationProcessor class >> collectAccessorPragmasFrom: availablePragmas [
	"I collect all validator declarations from validateAs: pragmas found in accessor methods in a given object."
	| accessorPragmas |
	
	accessorPragmas := Dictionary new.
	
	availablePragmas do: [ :each |
		| method |
		method := each method.
		
		each arguments isEmpty ifTrue: [ Error new messageText: 'validateAs pragma requires at least one parameter.'; signal ].
		
		(method protocol == #accessing) ifTrue: [
			accessorPragmas at: method selector
				ifPresent: [ (accessorPragmas at: method selector) add: (each argumentAt: 1) ]
				ifAbsent: [ accessorPragmas at: method selector put: (OrderedCollection newFrom: { each argumentAt: 1 }) ]
		]
	].

	^ accessorPragmas.

]

{ #category : #'building actions' }
PragmaValidationProcessor class >> getValidationBlock: validatorDeclaration [
	"I parse validator declaration and create single-parameter block which accepts a value and validates it."
	| methodName validationBlock |
	methodName := validatorDeclaration copyReplaceAll: '#' with: ''.
			
	(methodName includesSubstring: ':') ifTrue: [ 
		| validatorParts validatorName validatorParams |
		validatorParts := methodName splitOn: ':'.
		validatorName := validatorParts at: 1.
		validatorParams := (validatorParts at: 2) splitOn: ','.
				
		validationBlock := [ :val |
			PragmaValidator
				perform: ((validatorName,':withParams:') asSymbol)
				with: val
				with: validatorParams.
		].
		
	] ifFalse: [ 
		validationBlock := [ :val | PragmaValidator perform: ((methodName,':') asSymbol) with: val ].
	].
		
	^ validationBlock.

]
