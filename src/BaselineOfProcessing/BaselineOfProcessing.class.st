Class {
	#name : #BaselineOfProcessing,
	#superclass : #BaselineOf,
	#category : #BaselineOfProcessing
}

{ #category : #baseline }
BaselineOfProcessing >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'Processing' ]
]
