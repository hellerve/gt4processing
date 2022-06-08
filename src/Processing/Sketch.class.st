Class {
	#name : #Sketch,
	#superclass : #BrStencil,
	#instVars : [
		'setupBlock',
		'runBlock',
		'frameRate'
	],
	#category : #Processing
}

{ #category : #'instance creation' }
Sketch class >> setup: aBlock run: anotherBlock [
	^ self new setup: aBlock; run: anotherBlock
]

{ #category : #accessing }
Sketch >> allowance [
	^ (60 / frameRate) * 1000
]

{ #category : #accessing }
Sketch >> initialize [
	frameRate := 60
]
