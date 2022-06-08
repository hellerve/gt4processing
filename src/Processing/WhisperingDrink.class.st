Class {
	#name : #WhisperingDrink,
	#superclass : #Object,
	#category : #'Processing-Examples'
}

{ #category : #example }
WhisperingDrink class >> play [
	<gtExample>
	^ (PrSketch
		setup: [ :aCanvas | aCanvas size: 500 @ 500 ]
		run: [ :aCanvas :frameNumber | 
			aCanvas
				background: Color black;
				color: Color veryVeryLightGray.
			300
				timesRepeat: [ | x y |
					x := (10 to: 490) atRandom.
					y := (10 to: 490) atRandom.
					aCanvas lineFrom: x @ y to: x @ x ] ]) frameRate: 1
]
