Class {
	#name : #Factories,
	#superclass : #Object,
	#category : #'Processing-Examples'
}

{ #category : #example }
Factories class >> circleOn: aCanvas [
	| a x1 y1 vx vy length x3 y3 dir x2 y2 x y |
	aCanvas
		noFill;
		color: Color black;
		strokeWeight: 0.1.

	2000
		timesRepeat: [ a := SharedRandom globalGenerator next * 2 * Float pi.
			x1 := 250 + (a cos * 150).
			y1 := 250 + (a sin * 150).
			vx := x1 - 250.
			vy := y1 - 250.
			length := ((vx * vx) + (vy * vy)) sqrt.
			a := SharedRandom globalGenerator next * 2 * Float pi.
			x3 := 250 + (a cos * 150).
			y3 := 250 + (a sin * 150).
			aCanvas lineFrom: x1 @ y1 to: x3 @ y3.

			80 atRandom > 79
				ifTrue: [ dir := (RandomGaussian nextIn: 0 usingStandardDeviation: 2) asInteger.
					x2 := vx / length + x1 + dir + dir atRandom.
					y2 := vy / length + y1 + ((dir + dir atRandom) * 3).
					aCanvas lineFrom: x1 @ y1 to: x2 @ y2.
					aCanvas lineFrom: x3 @ y3 to: x3 @ y3.

					30 atRandom + 10
						timesRepeat: [ a := SharedRandom globalGenerator next * 2 * Float pi.
							x := 250 + (a cos * 150).
							y := 250 + (a sin * 150).
							aCanvas lineFrom: x @ y to: x2 @ y2 ] ] ]
]

{ #category : #example }
Factories class >> deformPolygon: aPolygon [
	| newPolygon randomX randomY |
	newPolygon := OrderedCollection new.

	aPolygon size - 1
		timesCollect: [ :anIndex | 
			| current next newX newY |
			current := aPolygon at: anIndex.
			next := aPolygon at: anIndex + 1.
			newX := RandomGaussian nextIn: (current x + next x) / 2 usingStandardDeviation: 3.
			newY := RandomGaussian nextIn: (current y + next y) / 2 usingStandardDeviation: 3.
			newPolygon add: current.
			newPolygon add: newX @ newY ].
	newPolygon add: aPolygon last.

	^ newPolygon
]

{ #category : #example }
Factories class >> drawPolygon: polygon on: aCanvas [
	| path |
	path := aCanvas path moveTo: polygon first.
	polygon allButFirstDo: [ :aPoint | path lineTo: aPoint ].
	path close.
	aCanvas fillPath: path finish
]

{ #category : #example }
Factories class >> play [
	<gtExample>
	^ (PrSketch
		setup: [ :aCanvas | 
			aCanvas
				size: 500 @ 500;
				background: Color white ]
		run: [ :aCanvas | 
			30
				timesRepeat: [ self
						watercolorOn: aCanvas
						at: 500 atRandom @ 500 atRandom
						usingColor: (Color
								r: 40 / 255
								g: 60 / 255
								b: 90 / 255
								alpha: 0.1) ].
			10
				timesRepeat: [ self
						watercolorOn: aCanvas
						at: (100 + 20 atRandom) @ (100 + 20 atRandom)
						usingColor: (Color
								r: 90 / 255
								g: 30 / 255
								b: 20 / 255
								alpha: 0.1) ].
								
			self circleOn: aCanvas ]) frameRate: 0
]

{ #category : #example }
Factories class >> polygonX: x y: y radius: radius points: numberOfPoints [
	| angle points |
	angle := Float pi * 2 / numberOfPoints.
	points := OrderedCollection new.
	(0 to: Float pi * 2 by: angle)
		do: [ :each | points add: (x + (each cos * radius)) @ (y + (each sin * radius)) ].
	^ points
]

{ #category : #example }
Factories class >> watercolorOn: aCanvas at: aPoint usingColor: aColor [
	| randomX randomY |
	aCanvas
		noStroke;
		fill: aColor.
	5 + 10 atRandom
		timesRepeat: [ | polygon |
			polygon := self
					polygonX: (RandomGaussian nextIn: aPoint x usingStandardDeviation: 10)
					y: (RandomGaussian nextIn: aPoint y usingStandardDeviation: 10)
					radius: 50 + 100 atRandom
					points: 20.
			4 timesRepeat: [ polygon := self deformPolygon: polygon ].
			self drawPolygon: polygon on: aCanvas ]
]
