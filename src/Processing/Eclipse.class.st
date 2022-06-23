Class {
	#name : #Eclipse,
	#superclass : #Factories,
	#category : #'Processing-Examples'
}

{ #category : #accessing }
Eclipse class >> play [
	<gtExample>
	^ (PrSketch
		setup: [ :aCanvas | 
			aCanvas
				size: 800 @ 800;
				background: Color black ]
		run: [ :aCanvas | 
			30
				timesRepeat: [ self
						watercolorOn: aCanvas
						at: (100 + (RandomGaussian nextIn: 200 usingStandardDeviation: 50)) @ (130 + (RandomGaussian nextIn: 200))
						usingColor: (Color
								r: 255
								g: 255
								b: 255
								alpha: 0.1) ].

			aCanvas
				fill: Color black;
				circleAt: 350 @ 350 withRadius: 100.
				self
						watercolorOn: aCanvas
						at: (100 + (RandomGaussian nextIn: 200 usingStandardDeviation: 50)) @ (130 + (RandomGaussian nextIn: 200))
						usingColor: (Color
								r: 255
								g: 255
								b: 255
								alpha: 0.1) ]) frameRate: 0
]
