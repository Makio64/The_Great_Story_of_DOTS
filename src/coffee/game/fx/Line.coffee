class Line extends PIXI.Graphics
	
	points			: null
	color 			: 0
	state 			: 0
	distance 		: 0
	
	constructor:(@points, @color)->
		super
		@state = 1
		return

	update:(dt)->
		if @state != 1
			return

		@distance += dt*.3

		@clear()
		@lineStyle(3, 0xed0060, .05)
		@moveTo(@points[0].x,@points[0].y)

		distanceAvaible = @distance
		p = @points[0]

		for i in [1...@points.length] by 1
			
			moveX = @points[i].x-@points[i-1].x
			moveY = @points[i].y-@points[i-1].y
			
			distance = Math.abs(moveX) + Math.abs(moveY)
			
			if distance < distanceAvaible
				@lineTo(@points[i].x,@points[i].y)
				distanceAvaible -= distance
			else
				percent = distanceAvaible/distance
				vectorX = (@points[i].x - @points[i-1].x)*percent+@points[i-1].x
				vectorY = (@points[i].y - @points[i-1].y)*percent+@points[i-1].y
				@lineTo(vectorX, vectorY)
				break

		return

	fadeOut:()->
		TweenLite.to(@,.3,{alpha:0,onComplete:@dispose})
		return

	dispose:()->
		if @parent
			@parent.removeChild(@)
		return
		