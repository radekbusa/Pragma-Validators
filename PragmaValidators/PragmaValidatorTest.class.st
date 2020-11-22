"
A PragmaValidatorTest is a test class for testing the behavior of PragmaValidator
"
Class {
	#name : #PragmaValidatorTest,
	#superclass : #TestCase,
	#category : #'PragmaValidators-Tests'
}

{ #category : #test }
PragmaValidatorTest >> testAssertTrue [
	self shouldnt: [ PragmaValidator assertTrue: true ] raise: PragmaValidationError.
	self should: [ PragmaValidator assertTrue: false ] raise: PragmaValidationError.
	self should: [ PragmaValidator assertTrue: nil ] raise: PragmaValidationError.
	self should: [ PragmaValidator assertTrue: '' ] raise: PragmaValidationError.
	self should: [ PragmaValidator assertTrue: 5 ] raise: PragmaValidationError.
	
]

{ #category : #test }
PragmaValidatorTest >> testBoolean [
	self shouldnt: [ PragmaValidator boolean: true ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator boolean: false ] raise: PragmaValidationError.
	self should: [ PragmaValidator boolean: nil ] raise: PragmaValidationError.
	self should: [ PragmaValidator boolean: '' ] raise: PragmaValidationError.
	self should: [ PragmaValidator boolean: Object new ] raise: PragmaValidationError.
	self should: [ PragmaValidator boolean: 5 ] raise: PragmaValidationError.
	
]

{ #category : #test }
PragmaValidatorTest >> testDatetimeString [
	self shouldnt: [ PragmaValidator datetimeString: '2020-10-26T06:37Z' ] raise: PragmaValidationError.
	self should: [ PragmaValidator datetimeString: 'xxx-10-26T06:37Z' ] raise: PragmaValidationError.
	self should: [ PragmaValidator datetimeString: nil ] raise: PragmaValidationError.
	self should: [ PragmaValidator datetimeString: 1000 ] raise: PragmaValidationError.
	self should: [ PragmaValidator datetimeString: '' ] raise: PragmaValidationError.
]

{ #category : #test }
PragmaValidatorTest >> testEmail [
	self shouldnt: [ PragmaValidator email: 'me@radekbusa.eu' ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator email: 'me.and-me@radek.busa.eu' ] raise: PragmaValidationError.
	self should: [ PragmaValidator email: 'me?and+me@radek.busa.eu' ] raise: PragmaValidationError.
	self should: [ PragmaValidator email: 'me?and+meradek.busa.eu' ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator email: 'me@localhost' ] raise: PragmaValidationError.

]

{ #category : #test }
PragmaValidatorTest >> testFuture [
	self shouldnt: [ PragmaValidator future: '2120-10-26T06:37Z' ] raise: PragmaValidationError.
	self should: [ PragmaValidator future: '1970-10-26T06:37Z' ] raise: PragmaValidationError.
	self should: [ PragmaValidator future: 'xxx-10-26T06:37Z' ] raise: Error.

]

{ #category : #test }
PragmaValidatorTest >> testMaxWithParams [
	self should: [ PragmaValidator max: 100 withParams: #(5) ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator max: 5 withParams: #(5) ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator max: 0 withParams: #(5) ] raise: PragmaValidationError.
	self should: [ PragmaValidator max: 100 withParams: #() ] raise: Error.
]

{ #category : #test }
PragmaValidatorTest >> testMinWithParams [
	self shouldnt: [ PragmaValidator min: 100 withParams: #(5) ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator min: 5 withParams: #(5) ] raise: PragmaValidationError.
	self should: [ PragmaValidator min: 0 withParams: #(5) ] raise: PragmaValidationError.
	self should: [ PragmaValidator min: 100 withParams: #() ] raise: Error.
]

{ #category : #test }
PragmaValidatorTest >> testNegative [
	self should: [ PragmaValidator negative: 5 ] raise: PragmaValidationError.
	self should: [ PragmaValidator negative: 0 ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator negative: -5 ] raise: PragmaValidationError.
]

{ #category : #test }
PragmaValidatorTest >> testNegativeOrZero [
	self should: [ PragmaValidator negativeOrZero: 5 ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator negativeOrZero: 0 ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator negativeOrZero: -5 ] raise: PragmaValidationError.
]

{ #category : #test }
PragmaValidatorTest >> testNotBlank [
	self shouldnt: [ PragmaValidator notBlank: 'abc' ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator notBlank: '   abc 	' ] raise: PragmaValidationError.
	self should: [ PragmaValidator notBlank: '' ] raise: PragmaValidationError.
	self should: [ PragmaValidator notBlank: '   ' ] raise: PragmaValidationError.

]

{ #category : #test }
PragmaValidatorTest >> testNotEmpty [
	self shouldnt: [ PragmaValidator notEmpty: 'abc' ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator notEmpty: { 'abc' } ] raise: PragmaValidationError.
	self should: [ PragmaValidator notEmpty: '' ] raise: PragmaValidationError.
	self should: [ PragmaValidator notEmpty: {  } ] raise: PragmaValidationError.
	self should: [ PragmaValidator notEmpty: OrderedCollection new ] raise: PragmaValidationError.
]

{ #category : #test }
PragmaValidatorTest >> testNotNil [
	self should: [ PragmaValidator notNil: nil ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator notNil: '' ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator notNil: 5 ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator notNil: true ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator notNil: false ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator notNil: Object new ] raise: PragmaValidationError.

]

{ #category : #test }
PragmaValidatorTest >> testNumber [
	self shouldnt: [ PragmaValidator number: 5 ] raise: PragmaValidationError.
	self should: [ PragmaValidator number: true ] raise: PragmaValidationError.
	self should: [ PragmaValidator number: false ] raise: PragmaValidationError.
	self should: [ PragmaValidator number: nil ] raise: PragmaValidationError.
	self should: [ PragmaValidator number: '' ] raise: PragmaValidationError.
	self should: [ PragmaValidator number: Object new ] raise: PragmaValidationError.

]

{ #category : #test }
PragmaValidatorTest >> testPast [
	self shouldnt: [ PragmaValidator past: '1970-10-26T06:37Z' ] raise: PragmaValidationError.
	self should: [ PragmaValidator past: '2120-10-26T06:37Z' ] raise: PragmaValidationError.
	self should: [ PragmaValidator past: 'xxx-10-26T06:37Z' ] raise: Error.
]

{ #category : #test }
PragmaValidatorTest >> testPositive [
	self shouldnt: [ PragmaValidator positive: 5 ] raise: PragmaValidationError.
	self should: [ PragmaValidator positive: 0 ] raise: PragmaValidationError.
	self should: [ PragmaValidator positive: -5 ] raise: PragmaValidationError.
]

{ #category : #test }
PragmaValidatorTest >> testPositiveOrZero [
	self shouldnt: [ PragmaValidator positiveOrZero: 5 ] raise: PragmaValidationError.
	self shouldnt: [ PragmaValidator positiveOrZero: 0 ] raise: PragmaValidationError.
	self should: [ PragmaValidator positiveOrZero: -5 ] raise: PragmaValidationError.

]

{ #category : #test }
PragmaValidatorTest >> testSequenceableCollection [
	self shouldnt: [
		PragmaValidator sequenceableCollection: { 'foo'. 'bar' } ] raise: PragmaValidationError.
	self shouldnt: [
		PragmaValidator sequenceableCollection: OrderedCollection new ] raise: PragmaValidationError.
	self should: [
		PragmaValidator sequenceableCollection: Dictionary new ] raise: PragmaValidationError.

]

{ #category : #test }
PragmaValidatorTest >> testSizeWithParams [
	self shouldnt: [
		PragmaValidator size: { 'foo'. 'bar' } withParams: #(1 3) ] raise: PragmaValidationError.
	self shouldnt: [
		PragmaValidator size: { 'foo' } withParams: #(1 3) ] raise: PragmaValidationError.
	self should: [
		PragmaValidator size: {  } withParams: #(1 3) ] raise: PragmaValidationError.
	self shouldnt: [
		PragmaValidator size: {  } withParams: #(0 3) ] raise: PragmaValidationError.
	self should: [
		PragmaValidator size: {  } withParams: #(0) ] raise: Error.
	self should: [
		PragmaValidator size: {  } withParams: #() ] raise: Error.

]

{ #category : #test }
PragmaValidatorTest >> testString [
	self shouldnt: [ PragmaValidator string: '' ] raise: PragmaValidationError.
	self should: [ PragmaValidator string: 5 ] raise: PragmaValidationError.
	self should: [ PragmaValidator string: true ] raise: PragmaValidationError.
	self should: [ PragmaValidator string: false ] raise: PragmaValidationError.
	self should: [ PragmaValidator string: nil ] raise: PragmaValidationError.
	self should: [ PragmaValidator string: Object new ] raise: PragmaValidationError.

]
