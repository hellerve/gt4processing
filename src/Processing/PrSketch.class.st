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
	| prCanvas form |
	prCanvas := self create.
	^ aView explicit
		title: 'Live';
		stencil: [ (form := prCanvas canvas asForm) asElement ];
		actionDropdownButtonIcon: BrGlamorousVectorIcons folder
			tooltip: 'Save as file'
			content: [ | content selector fileEditor |
				content := BrVerticalPane new fitContent
						margin: (BlInsets all: 5);
						width: 400;
						addAptitude: BrGlamorousWithHorizontalResizerAptitude
								+ BrGlamorousWithVerticalResizerAptitude.
				content
					addChild: (selector := BrFileSelector new
								margin: (BlInsets bottom: 5);
								buttonLabel: 'Select directory';
								fileFilterBlock: [ :_ | false ]).
				content
					addChild: (BrHorizontalPane new fitContent
							addChild: (BrLabel new
									aptitude: BrGlamorousLabelAptitude new;
									text: 'File Name: ';
									constraintsDo: [ :c | c grid vertical alignCenter ]);
							addChild: (fileEditor := BrEditableLabel new
										aptitude: BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
										text: '';
										height: 23;
										margin: (BlInsets left: 10 right: 10);
										width: 100;
										constraintsDo: [ :c | c grid vertical alignCenter ];
										switchToEditor);
							addChild: (BrButton new
									aptitude: BrGlamorousButtonWithIconAptitude;
									icon: BrGlamorousVectorIcons accept;
									action: [ :aButton | 
										form writeBMPfileNamed: (selector folder / fileEditor text asString) pathString.
										aButton fireEvent: BrDropdownHideWish new ])) ];
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
