Class {
	#name : #PrCanvas,
	#superclass : #Canvas,
	#instVars : [
		'color',
		'fill',
		'canvas',
		'strokeWeight'
	],
	#category : #Processing
}

{ #category : #accessing }
PrCanvas >> background: aColor [
	canvas fill
		path: canvas bounds;
		paint: aColor;
		draw
]

{ #category : #accessing }
PrCanvas >> canvas [
	^ canvas
]

{ #category : #accessing }
PrCanvas >> circle: aPoint withRadius: anInteger [
	| path |
	path := canvas shape circleAt: aPoint radius: anInteger.

	canvas fill
		paint: fill;
		path: path;
		draw.

	canvas stroke
		paint: color;
		path: path;
		width: strokeWeight;
		draw
]

{ #category : #accessing }
PrCanvas >> color: aColor [
	color := aColor
]

{ #category : #accessing }
PrCanvas >> fill: aColor [
	fill := aColor
]

{ #category : #accessing }
PrCanvas >> gtLiveFor: aView [
	^ canvas gtLiveFor: aView
]

{ #category : #accessing }
PrCanvas >> initialize [
	color := Color black.
	fill := Color black.
	strokeWeight := 1.
]

{ #category : #accessing }
PrCanvas >> line: aPoint to: anotherPoint [
	canvas stroke
		path: (canvas shape line: aPoint to: anotherPoint);
		paint: color;
		width: strokeWeight;
		draw.
]

{ #category : #accessing }
PrCanvas >> rectangle: aPoint to: anotherPoint [
	| path |
	path := SpartaRectangle origin: aPoint extent: anotherPoint.

	canvas fill
		paint: fill;
		path: path;
		draw.

	canvas stroke
		paint: color;
		path: path;
		width: strokeWeight;
		draw
]

{ #category : #accessing }
PrCanvas >> size: aPoint [
	canvas := SkiaCanvas extent: aPoint
]

{ #category : #accessing }
PrCanvas >> strokeWeight: aNumber [
	strokeWeight := aNumber
]
