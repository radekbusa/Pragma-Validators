Extension { #name : #Object }

{ #category : #'*PragmaValidators' }
Object >> validate [
	"Will validate self using PragmaValidators executed according to validateAs: pragmas"
	| accessorPragmas |
	
	accessorPragmas := PragmaValidationProcessor collectAccessorPragmasFrom: (Pragma allNamed: #validateAs: in: self class).
	
	accessorPragmas keysAndValuesDo: [ :methodSelector :validatorDeclarations |
		validatorDeclarations do: [ :validatorDeclaration |
			| validationBlock |
			validationBlock := PragmaValidationProcessor getValidationBlock: validatorDeclaration.
		
			(validatorDeclaration includesSubstring: '#') ifTrue: [
				| propertyValue |
				propertyValue := self perform: methodSelector.
				
				propertyValue isCollection ifFalse: [
					Error new messageText: 'Accessor ',methodSelector asString,' does not return a collection which is required for collection validators.' ].
				
				propertyValue do: [ :each | validationBlock value: each ].
			] ifFalse: [
				validationBlock value: (self perform: methodSelector).
			].
		]
	].

]
