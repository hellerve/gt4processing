Class {
	#name : #ForestFire,
	#superclass : #Object,
	#classInstVars : [
		'trees'
	],
	#category : #'Processing-Examples'
}

{ #category : #accessing }
ForestFire class >> checkedInto: aCollection at: anIndex put: aValue [
	((aCollection atWrap: anIndex) = 0 and: [ self survivalRate ])
		ifTrue: [ aCollection atWrap: anIndex put: aValue ]
]

{ #category : #accessing }
ForestFire class >> newTrees [
	^ Array new: 80 * 80 withAll: 0
]

{ #category : #accessing }
ForestFire class >> play [
	<gtExample>
	trees := self newTrees.
	trees at: (80 * 80) atRandom put: 1.

	^ (PrSketch
		setup: [ :aCanvas | 
			aCanvas
				size: 800 @ 800;
				background: Color white;
				noStroke ]
		run: [ :aCanvas :frameNumber | 
			| nTrees |
			nTrees := self newTrees.
			trees
				withIndexDo: [ :v :i | 
					v = 0 ifTrue: [ aCanvas fill: (Color green adjustBrightness: -0.4) ].
					v = 2
						ifTrue: [ aCanvas fill: Color brown.
							nTrees at: i put: 2 ].

					v = 1
						ifTrue: [ aCanvas fill: (Color red adjustBrightness: -0.2).
							nTrees at: i put: 2.
							self
								checkedInto: nTrees
								at: i - 1
								put: 1.
							self
								checkedInto: nTrees
								at: i + 1
								put: 1.
							self
								checkedInto: nTrees
								at: i - 80
								put: 1.
							self
								checkedInto: nTrees
								at: i + 80
								put: 1 ]
						ifFalse: [ (nTrees at: i) = 0 ifTrue: [ nTrees at: i put: v ] ].
					aCanvas
						rectangleAt: ((i // 80 - 1) * 10) @ ((i \\ 80 - 1) * 10)
						withSize: 10 @ 10 ].
			trees := nTrees ]) frameRate: 3
]

{ #category : #accessing }
ForestFire class >> survivalRate [
	^ 10 atRandom > 4
]
