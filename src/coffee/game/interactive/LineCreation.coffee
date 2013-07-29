class LineCreation

	stage 				: null
	graphic 			: null
	points 				: null
	area 				: null
	costBox				: null

	constructor:(@area, @stage, x, y)->
		
		stage.mousemove 	= @onMove
		stage.touchmove 	= @onMove
		stage.mouseup	 	= @onEnd
		stage.toucstop 		= @onEnd

		@graphic = new PIXI.Graphics()
		@stage.addChild(@graphic)

		@points = []
		@points.push({x,y})

		@costBox = new LineCost()
		@costBox.position.x = x+10
		@costBox.position.y = y-5
		@stage.addChild(@costBox)

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

		cost = @calculateCost()

		@costBox.setCost(Math.floor(cost))
		@costBox.position.x = pos.x+10
		@costBox.position.y = pos.y-5

		return

	calculateCost:()->
		cost = 0
		coeff = .1

		lastP = null
		for p in @points
			@graphic.lineTo(p.x,p.y)
			@graphic.moveTo(p.x,p.y)

			if lastP != null
				cost += @distance(p,lastP)*coeff
			lastP = p

		return cost

	distance:(p1,p2)->
		return Math.abs(p1.x-p2.x)+Math.abs(p1.y-p2.y)


	onError:()=>
		error = new ErrorLineMsg()
		error.position.x = @points[@points.length-1].x
		error.position.y = @points[@points.length-1].y
		Game.stage.addChild(error)
		@clean()
		return


	onEnd:(data)=>
		
		@clean()

		cost = @calculateCost()

		if cost > Game.instance.lineG
			msg = new NotEnoughtMoneyMsg()
			msg.position.x = @points[@points.length-1].x
			msg.position.y = @points[@points.length-1].y
			@stage.addChild msg
			return

		if @area.building != null
			@area.building.setLine(@points)
			Game.instance.lineG -= cost

		return


	clean:()->
		@costBox.remove()
		@graphic.clear()

		TweenLite.to(@graphic,.3,{alpha:0})

		# remove reference
		@stage.mousemove 	= null
		@stage.touchmove 	= null
		@stage.mouseup	 	= null
		@stage.toucstop 	= null
		InteractiveController.instance.moveDelegate = null
		return

