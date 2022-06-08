Class {
	#name : #PrSketch,
	#superclass : #BrStencil,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'setupBlock',
		'runBlock',
		'frameRate',
		'size',
		'announcer',
		'frameNumber'
	],
	#category : #'Processing-Core'
}

{ #category : #'instance creation' }
PrSketch class >> setup: aSetupBlock run: aRunBlock [
	^ self new
		setup: aSetupBlock;
		run: aRunBlock
]

{ #category : #accessing }
PrSketch >> allowance [
	^ (1000 / frameRate) milliSeconds
]

{ #category : #announcer }
PrSketch >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
PrSketch >> create [
	| canvas |
	canvas := PrCanvas new size: size.
	self setupCanvas: canvas.
	[ self runCanvas: canvas ] asAsyncFuture await.
	^ canvas
]

{ #category : #accessing }
PrSketch >> frameRate: aNumber [
	frameRate := aNumber
]

{ #category : #accessing }
PrSketch >> gtLiveFor: aView [
	| prCanvas |
	prCanvas := self create.
	^ aView explicit
		title: 'Live';
		stencil: [  prCanvas canvas asForm asElement ];
		updateWhen: PrRendered in: self announcer
]

{ #category : #accessing }
PrSketch >> initialize [
	frameRate := 60.
	size := 100@100.
	frameNumber := 1.
]

{ #category : #accessing }
PrSketch >> run: aBlock [
	runBlock := aBlock
]

{ #category : #accessing }
PrSketch >> runCanvas: aCanvas [
	| before elapsed allowance |
	before := DateAndTime now.
	runBlock cull: aCanvas cull: frameNumber.
	elapsed := DateAndTime now - before.
	self announce: PrRendered new.
	frameNumber := frameNumber + 1.
	frameRate = 0 ifTrue: [ ^ self ].
	allowance := self allowance - elapsed.
	allowance > Duration zero ifTrue: [ allowance wait ].
	[ self runCanvas: aCanvas ] asAsyncFuture await
]

{ #category : #accessing }
PrSketch >> setup: aBlock [
	setupBlock := aBlock
]

{ #category : #accessing }
PrSketch >> setupCanvas: aCanvas [
	setupBlock cull: aCanvas
]

{ #category : #accessing }
PrSketch >> size: aPoint [
	size := aPoint
]
