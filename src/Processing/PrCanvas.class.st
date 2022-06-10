Class {
	#name : #PrCanvas,
	#superclass : #Canvas,
	#instVars : [
		'color',
		'fill',
		'canvas',
		'strokeWeight'
	],
	#category : #'Processing-Core'
}

{ #category : #accessing }
PrCanvas >> arcFrom: aPoint to: anotherPoint withAngle: aNumber [
	| path |
	path := self path
			moveTo: aPoint;
			cwArcTo: anotherPoint angle: aNumber;
			finish.

	self
		fillPath: path;
		drawPath: path
]

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
PrCanvas >> circleAt: aPoint withRadius: anInteger [
	| path |
	path := canvas shape circleAt: aPoint radius: anInteger.

	self
		fillPath: path;
		drawPath: path
]

{ #category : #accessing }
PrCanvas >> drawPath: aPath [
	canvas stroke
		paint: color;
		path: aPath;
		width: strokeWeight;
		alpha: color alpha;
		draw
]

{ #category : #accessing }
PrCanvas >> ellipseAt: aPoint withSize: anotherPoint [
	| path |
	path := SpartaEllipse origin: aPoint extent: anotherPoint.

	self
		fillPath: path;
		drawPath: path
]

{ #category : #accessing }
PrCanvas >> fill [
	^ fill
]

{ #category : #accessing }
PrCanvas >> fill: aColor [
	fill := aColor
]

{ #category : #accessing }
PrCanvas >> fillPath: aPath [
	canvas fill
		paint: fill;
		path: aPath;
		alpha: fill alpha;
		draw
]

{ #category : #accessing }
PrCanvas >> gtLiveFor: aView [
	<gtView>
	| prCanvas |
	^ aView explicit
		title: 'Live';
		stencil: [ canvas asForm asElement ]
]

{ #category : #accessing }
PrCanvas >> initialize [
	color := Color black.
	fill := Color black.
	strokeWeight := 1.
]

{ #category : #accessing }
PrCanvas >> lineFrom: aPoint to: anotherPoint [
	canvas stroke
		path: (canvas shape line: aPoint to: anotherPoint);
		paint: color;
		width: strokeWeight;
		draw.
]

{ #category : #accessing }
PrCanvas >> noFill [
	fill := Color transparent
]

{ #category : #accessing }
PrCanvas >> noStroke [
	color := Color transparent
]

{ #category : #accessing }
PrCanvas >> path [
	^ canvas path
]

{ #category : #accessing }
PrCanvas >> pointAt: aPoint [
	self drawPath: (canvas shape line: aPoint to: aPoint)
]

{ #category : #accessing }
PrCanvas >> quadBottomLeft: bottomLeftPoint topLeft: topLeftPoint topRight: topRightPoint bottomRight: bottomRightPoint [
	| path |
	path := self path
			moveTo: bottomLeftPoint;
			lineTo: topLeftPoint;
			lineTo: topRightPoint;
			lineTo: bottomRightPoint;
			close;
			finish.

	self
		fillPath: path;
		drawPath: path
]

{ #category : #accessing }
PrCanvas >> rectangleAt: aPoint withSize: anotherPoint [
	| path |
	path := SpartaRectangle origin: aPoint extent: anotherPoint.

	self
		fillPath: path;
		drawPath: path
]

{ #category : #accessing }
PrCanvas >> size: aPoint [
	canvas := SkiaCanvas extent: aPoint
]

{ #category : #accessing }
PrCanvas >> squareAt: aPoint withSize: aNumber [
	| path |
	path := SpartaRectangle origin: aPoint extent: aNumber @ aNumber.

	self
		fillPath: path;
		drawPath: path
]

{ #category : #accessing }
PrCanvas >> stroke [
	^ color
]

{ #category : #accessing }
PrCanvas >> stroke: aColor [
	color := aColor
]

{ #category : #accessing }
PrCanvas >> strokeWeight: aNumber [
	strokeWeight := aNumber
]
