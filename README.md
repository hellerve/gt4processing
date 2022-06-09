# gt4processing

is a simple clone of Processing for GT. It’s also a work in progress.

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
			color: Color green;
			rectangleAt: 10 @ 10 withSize: 100 @ 100;
			color: Color red;
			lineFrom: 110 @ 110 to: 300 @ 300;
			fill: Color orange;
			color: Color white;
			circleAt: 350 @ 350 withRadius: 100 ])
	frameRate: 0
```

## Demo

https://user-images.githubusercontent.com/7725188/172896827-99023dd0-c395-4b2a-8d0a-5f90f0f8c366.mov

<hr/>

Have fun!
