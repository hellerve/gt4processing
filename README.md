# gt4processing

is a simple clone of Processing for GT. It’s also a work in progress.

## Installation

The repository contains a Metacello baseline, such that you should be able to execute the following to get the code:

```smalltalk
Metacello new
	baseline: 'Processing';
	repository: 'github://hellerve/gt4processing:main/src';
	load.
```

## Usage

```smalltalk
(PrSketch
	setup: [ :aCanvas | 
		aCanvas
			size: 500 @ 500;
			background: Color veryVeryLightGray ]
	run: [ :aCanvas :frameNumber | 
		aCanvas
			fill: Color blue;
			stroke: Color green;
			rectangleAt: 10 @ 10 withSize: 100 @ 100;
			stroke: Color red;
			lineFrom: 110 @ 110 to: 300 @ 300;
			fill: Color orange;
			stroke: Color white;
			circleAt: 350 @ 350 withRadius: 100 ])
	frameRate: 0
```

## Demo

https://user-images.githubusercontent.com/7725188/173018892-7ec58b7f-d62c-4ea3-8e26-167696a1c493.mov

<hr/>

Have fun!
