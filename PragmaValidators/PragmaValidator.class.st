"
I am a collection of class methods which contain various validation rules.
My validation rules are inspired by JSR-380 Java Bean Validation annotations to a great extent.

I am ought to be used in conjunction with the pragma <validateAs: ...> and the extension method Object>>validate.

Author & Maintainer: Radek Busa (www.radekbusa.eu, me@radekbusa.eu)
Pull requests and Issue reports are welcome, file them to https://github.com/radekbusa/Pragma-Validators

-=-=-= Usage scenario =-=-=-
1. Make a class, declare several inst vars and generate their corresponsing accessors.
Object subclass: #RegistrationRequest
	instanceVariableNames: 'username name password emails'
	classVariableNames: ''
	package: 'MyApplication-DataTransfer'

2. Annotate the accessors with desired validators.*,**
2.1 Simple ""scalar"" validation
username
	<validateAs: 'string'> ""remember to write the least specific rules, such as notNil, number, string, etc. first""
	<validateAs: 'notBlank'> ""notBlank ~ should not be an empty string or whitespace - works under an assumption""
									 ""that username is string so it is declared below the <validateAs: 'string'> pragma.""
	^ username
2.2 Validating collection items (note that ALL collection elements must conform to the declared validation pragmas)
emails
	<validateAs: '#string'>
	<validateAs: '#email'> ""the '#' signifies that emails shoule be a collection""
								  ""the 'email' signifies that each element of the collection should be a string containing a valid email""
	^ emails
	
3. Validate the object once filled. If the validations find a problem, PragmaValidationError will be raised.
| r |
r := RegistrationRequest new username: 'john'; emails: {'john@smalltalk.com'. 'jsmith@acme.com'}; validate.

*) Note that annotating a mutator or an accessor with a protocol different than ""accessing"" will not work.
**) The accessors are called in the process of validation, thus one must add additional code to them with caution.
    - The accessors were chosen as the source of data for validation because object properties will be accessed using them from the outside.

Kindly see the PragmaValidatorsTestObject class for more usage examples.

-=-=-= Integration example =-=-=-
Let's say that we want to use the pragma validators for validating JSON request bodies in our RESTful API (in a fashion similar to Java validations).

1. In a controller or a Teapot filter, write:
...
| parsedBody |
body := aRequest entity string.
parsedBody := NeoJSONReader fromString: body as: RegistrationRequest.
parsedBody validate. ""will validate each incoming request body""
...

"
Class {
	#name : #PragmaValidator,
	#superclass : #Object,
	#category : #'PragmaValidators-Validators'
}

{ #category : #validation }
PragmaValidator class >> assertTrue: anObject [
	self validateValue: anObject withResult: anObject = true withName: 'assertTrue'.

]

{ #category : #validation }
PragmaValidator class >> boolean: aValue [
	self validateValue: aValue withResult: ((aValue = true) | (aValue = false)) withName: 'boolean'.

]

{ #category : #validation }
PragmaValidator class >> datetimeString: anObject [
	| isValidDateTime |
	
	self validateValue: anObject withResult: anObject isString withName: 'datetime'.
	
	isValidDateTime := true.
	
	[ DateAndTime fromString: anObject ] on: Error do: [ isValidDateTime := false ].

	self validateValue: anObject withResult: isValidDateTime withName: 'datetime'.

]

{ #category : #validation }
PragmaValidator class >> email: anObject [
	self validateValue: anObject
		withResult: ('^[-\w.]+@([-\w]+.)+[-\w]{2,4}$' asRegex matches: anObject)
		withName: 'email'.

]

{ #category : #validation }
PragmaValidator class >> future: anObject [
	self validateValue: anObject
		withResult: (DateAndTime fromString: anObject) > DateAndTime now
		withName: 'future'.

]

{ #category : #validation }
PragmaValidator class >> max: aNumber withParams: params [
	| maxValue |
	
	params isEmpty ifTrue: [
		Error new messageText: 'PragmaValidator "max" must have at least one parameter.';
		signal.
	].
	
	maxValue := (params at: 1) asNumber.
	
	self validateValue: aNumber withResult: aNumber <= maxValue withName: 'max(',maxValue asString,')'.

]

{ #category : #validation }
PragmaValidator class >> min: aNumber withParams: params [
	| minValue |
	
	params isEmpty ifTrue: [
		Error new messageText: 'PragmaValidator "min" must have at least one parameter.';
		signal.
	].
	
	minValue := (params at: 1) asNumber.
	
	self validateValue: aNumber withResult: aNumber >= minValue withName: 'min(',minValue asString,')'.

]

{ #category : #validation }
PragmaValidator class >> negative: aNumber [
	self validateValue: aNumber withResult: aNumber < 0 withName: 'negative'.

]

{ #category : #validation }
PragmaValidator class >> negativeOrZero: aNumber [
	self validateValue: aNumber withResult: aNumber <= 0 withName: 'negativeOrZero'.

]

{ #category : #validation }
PragmaValidator class >> notBlank: anObject [
	self validateValue: anObject withResult: anObject isNotNil withName: 'notBlank'.
	
	anObject isString ifTrue: [
		self validateValue: anObject withResult: anObject trim isNotEmpty withName: 'notBlank'.
	].

]

{ #category : #validation }
PragmaValidator class >> notEmpty: anObject [
	self validateValue: anObject withResult: anObject isNotNil withName: 'notEmpty'.
	
	anObject isCollection ifTrue: [
		self validateValue: anObject withResult: anObject isNotEmpty withName: 'notEmpty'.
	].

]

{ #category : #validation }
PragmaValidator class >> notNil: anObject [
	self validateValue: anObject withResult: anObject isNotNil withName: 'notNil'.

]

{ #category : #validation }
PragmaValidator class >> number: aValue [
	self validateValue: aValue withResult: aValue isNumber withName: 'number'.

]

{ #category : #validation }
PragmaValidator class >> past: anObject [
	self validateValue: anObject
		withResult: (DateAndTime fromString: anObject) < DateAndTime now
		withName: 'past'.

]

{ #category : #validation }
PragmaValidator class >> positive: aNumber [
	self validateValue: aNumber withResult: aNumber > 0 withName: 'positive'.

]

{ #category : #validation }
PragmaValidator class >> positiveOrZero: aNumber [
	self validateValue: aNumber withResult: aNumber >= 0 withName: 'positiveOrZero'.

]

{ #category : #validation }
PragmaValidator class >> sequenceableCollection: aValue [
	self validateValue: aValue withResult: (aValue isCollection & aValue isSequenceable) withName: 'array'.

]

{ #category : #validation }
PragmaValidator class >> size: aCollection withParams: params [
	| minSize maxSize |

	params size < 2
		ifTrue: [ Error new
				messageText: 'PragmaValidator "size" must have at least two parameters.';
				signal.
			].

	minSize := (params at: 1) asNumber.
	maxSize := (params at: 2) asNumber.

	self
		validateValue: aCollection
		withResult: (aCollection size between: minSize and: maxSize)
		withName: 'size(' , minSize asString , ',' , maxSize asString , ')'.
]

{ #category : #validation }
PragmaValidator class >> string: aValue [
	self validateValue: aValue withResult: aValue isString withName: 'string'.

]

{ #category : #private }
PragmaValidator class >> validateValue: aValue withResult: aBoolean withName: aString [
	aBoolean ifFalse: [
		PragmaValidationError new messageText: 'Value "',aValue asString,'" does not conform to validator "',aString,'".'; signal 	].

]
