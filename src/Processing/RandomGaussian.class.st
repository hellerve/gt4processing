Class {
	#name : #RandomGaussian,
	#superclass : #Object,
	#instVars : [
		'previous'
	],
	#classInstVars : [
		'global'
	],
	#category : #'Processing-Core'
}

{ #category : #accessing }
RandomGaussian class >> initialize [
	global := self new
]

{ #category : #accessing }
RandomGaussian class >> nextIn: aNumber [
	^ global nextIn: aNumber
]

{ #category : #accessing }
RandomGaussian class >> nextIn: aNumber usingStandardDeviation: anotherNumber [
	^ global nextIn: aNumber usingStandardDeviation: anotherNumber
]

{ #category : #random }
RandomGaussian >> nextIn: aNumber [
	^ self nextIn: aNumber usingStandardDeviation: 1
]

{ #category : #random }
RandomGaussian >> nextIn: aNumber usingStandardDeviation: anInteger [
	| y1 w x1 x2 |
	w := 1.
	previous
		ifNil: [ [ w >= 1 ]
				whileTrue: [ x1 := self randomTo: 2 - 1.
					x2 := self randomTo: 2 - 1.
					w := (x1 * x1 + x2) * x2 ].
			w := (-2 * w log / w) sqrt.
			y1 := x1 * w.
			previous := x2 * w ]
		ifNotNil: [ y1 := previous.
			previous := nil ].
	^ y1 * anInteger + aNumber
]

{ #category : #private }
RandomGaussian >> randomTo: aNumber [
	^ SharedRandom globalGenerator next * aNumber
]
