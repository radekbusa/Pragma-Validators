"
SUnit tests for objects
"
Class {
	#name : #ObjectTest,
	#superclass : #ClassTestCase,
	#category : #'PragmaValidators-Tests'
}

{ #category : #'as yet unclassified' }
ObjectTest >> testValidate [
	| validObject invalidObject |
	
	validObject := PragmaValidatorsTestObject new
		bar: 'hello';
		baz: 50;
		foo: { 'it'. 'works' };
		collection: { 'nonblank string'. 'another nonblank string' }.
		
	invalidObject := PragmaValidatorsInvalidTestObject new lol: 'lol'.
		
	"works under assumption that the underlying particular validators
	strictly check for parameter presence by raising Error exceptions"

	"it should pass zero validation parameters correctly"
	self shouldnt: [ validObject validate ] raise: Error.
	"it should pass one validation parameter correctly"
	self shouldnt: [ validObject validate ] raise: Error.
	"it should pass two validation parameters correctly"
	self shouldnt: [ validObject validate ] raise: Error.
	
	"it should raise an error if the validator does not exist on the PragmaValidator class"
	self should: [ invalidObject validate ] raise: Error.
	
	"it should validate collection items properly"
	validObject collection: { 'nonblank'. '   ' }.
	self should: [ validObject validate ] raise: PragmaValidationError.

]
