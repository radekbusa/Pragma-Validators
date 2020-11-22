Class {
	#name : #BaselineOfPragmaValidators,
	#superclass : #BaselineOf,
	#category : #BaselineOfPragmaValidators
}

{ #category : #baselines }
BaselineOfPragmaValidators >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"project packages"
			spec package: 'PragmaValidators'.
		].

]

{ #category : #accessing }
BaselineOfPragmaValidators >> projectClass [
	^ MetacelloCypressBaselineProject.

]
