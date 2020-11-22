"
Used for testing these cases:
- it raises an error if nonexistent validator is specified in validateAs: pragma.

"
Class {
	#name : #PragmaValidatorsInvalidTestObject,
	#superclass : #Object,
	#instVars : [
		'lol'
	],
	#category : #'PragmaValidators-Tests'
}

{ #category : #accessing }
PragmaValidatorsInvalidTestObject >> lol [
	<validateAs: 'lol'> "this validator does not exist"
	^ lol
]

{ #category : #accessing }
PragmaValidatorsInvalidTestObject >> lol: anObject [
	lol := anObject
]
