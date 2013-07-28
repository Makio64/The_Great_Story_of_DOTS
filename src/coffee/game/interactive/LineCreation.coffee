class LineCreation

	stage 				: null
	graphics 			: null
	drawArea 			: null
	points 				: null
	area 				: null

	constructor:(@area, @stage, x, y)->
		
		stage.mousemove 	= @onMove
		stage.touchmove 	= @onMove
		stage.mouseup	 	= @onEnd
		stage.toucstop 		= @onEnd

		@graphic = new PIXI.Graphics()
		@graphic.position.x = 0
		@graphic.position.y = 0
		@stage.addChild(@graphic)

		@points = []
		@points.push({x,y})

		return


	onMove:(data)=>
		pos = data.global

		if(!Game.instance.map.isWalkable(Math.floor(pos.x/8),Math.floor(pos.y/8)))
			@onError(data)

		@points.push({x:pos.x,y:pos.y})
		@points = simplify(@points, 1, false)
		@graphic.clear()
		@graphic.lineStyle(2, 0x000000, 1)
		@graphic.moveTo(@points[0].x,@points[0].y)

		
		for p in @points
			@graphic.lineTo(p.x,p.y)
			@graphic.moveTo(p.x,p.y)

		return

	onError:()=>
		@clean()
		return


	onEnd:(data)=>
		@clean()
		return

	clean:()->
		@graphic.clear()
		@graphic.lineStyle(2, 0x000000, .8)
		@graphic.moveTo(@points[0].x,@points[0].y)
		for p in @points
			@graphic.lineTo(p.x,p.y)
			@graphic.moveTo(p.x,p.y)

		TweenLite.to(@graphic,.3,{alpha:0})

		# remove reference
		@stage.mousemove 	= null
		@stage.touchmove 	= null
		@stage.mouseup	 	= null
		@stage.toucstop 	= null
		InteractiveController.instance.moveDelegate = null
