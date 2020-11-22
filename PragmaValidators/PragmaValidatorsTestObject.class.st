"
Used for testing these cases:
- it runs the right validation method correctly.
- it passes parameters to the validation methods correctly.
- it validates collection elements correctly.

"
Class {
	#name : #PragmaValidatorsTestObject,
	#superclass : #Object,
	#instVars : [
		'foo',
		'bar',
		'baz',
		'collection'
	],
	#category : #'PragmaValidators-Tests'
}

{ #category : #accessing }
PragmaValidatorsTestObject >> bar [
	<validateAs: 'notNil'>
	^ bar
]

{ #category : #accessing }
PragmaValidatorsTestObject >> bar: anObject [
	bar := anObject
]

{ #category : #accessing }
PragmaValidatorsTestObject >> baz [
	<validateAs: 'number'>
	<validateAs: 'min:10'>
	^ baz
]

{ #category : #accessing }
PragmaValidatorsTestObject >> baz: anObject [
	baz := anObject
]

{ #category : #accessing }
PragmaValidatorsTestObject >> collection [
	<validateAs: '#string'>
	<validateAs: '#notBlank'>
	^ collection
]

{ #category : #accessing }
PragmaValidatorsTestObject >> collection: anObject [
	collection := anObject
]

{ #category : #accessing }
PragmaValidatorsTestObject >> foo [
	<validateAs: 'sequenceableCollection'>
	<validateAs: 'size:1,3'>
	^ foo
]

{ #category : #accessing }
PragmaValidatorsTestObject >> foo: anObject [
	foo := anObject
]
