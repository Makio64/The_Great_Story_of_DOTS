class ShapeCreation

	stage 				: null
	graphic 			: null
	drawArea 			: null
	helper				: null
	points 				: null
	area 				: null

	constructor:(@area, @stage, x, y)->
		
		stage.mousemove 	= @onMove
		stage.touchmove 	= @onMove
		stage.mouseup	 	= @onEnd
		stage.toucstop 		= @onEnd

		@drawArea = new PIXI.Sprite(PIXI.Texture.fromImage "./img/area_over_circle.png")
		@drawArea.anchor.x = .5
		@drawArea.anchor.y = .5
		@drawArea.position.x = area.position.x
		@drawArea.position.y = area.position.y-20
		@drawArea.scale.x = .8
		@drawArea.scale.y = .8
		@drawArea.alpha = 0
		TweenLite.to(@drawArea.scale,.3,{x:1,y:1})
		TweenLite.to(@drawArea,.3,{alpha:1})

		if Game.instance.canTriangle and !Game.instance.canSquare
			@helper = new PIXI.Sprite(PIXI.Texture.fromImage "./img/area_over_pyramid.png")
		else if !Game.instance.canTriangle and Game.instance.canSquare
			@helper = new PIXI.Sprite(PIXI.Texture.fromImage "./img/area_over_box.png")
		else
			@helper = new PIXI.Sprite(PIXI.Texture.fromImage "./img/area_over_shapes.png")

		@helper.anchor.x = .5
		@helper.anchor.y = .5
		@helper.position.x = area.position.x
		@helper.position.y = area.position.y-20
		@helper.scale.x = .8
		@helper.scale.y = .8
		@helper.alpha = 0
		TweenLite.to(@helper.scale,.3,{x:1,y:1})
		TweenLite.to(@helper,.3,{alpha:1})
		Game.stage.addChild(@helper)

		Game.stage.addChild(@drawArea)

		@graphic = new PIXI.Graphics()
		@graphic.position.x = 0
		@graphic.position.y = 0
		@stage.addChild(@graphic)

		@points = []
		@points.push({x,y})

		return


	onMove:(data)=>
		pos = data.global

		@points.push({x:pos.x,y:pos.y})
		@points = simplify(@points, 1, false)
		@graphic.clear()
		@graphic.lineStyle(2, 0x000000, 1)
		@graphic.moveTo(@points[0].x,@points[0].y)
		
		for p in @points
			@graphic.lineTo(p.x,p.y)
			@graphic.moveTo(p.x,p.y)

		return


	onEnd:(data)=>
		
		@graphic.clear()
		@graphic.lineStyle(2, 0x000000, .8)
		@corners = findCorner(@points)
		@graphic.moveTo(@points[0].x,@points[0].y)

		for p in @points
			@graphic.lineTo(p.x,p.y)
			@graphic.moveTo(p.x,p.y)

		if Game.instance.lineG < 100
			
			msg = new NotEnoughtMoneyMsg()
			msg.position.x = @area.position.x
			msg.position.y = @area.position.y
			Game.stage.addChild( msg )

		else if @area.building != null
			@clean()
			return

		else if Game.instance.canTriangle and isTriangle(@corners)
			Game.instance.lineG -= 100
			Game.instance.lineGBox.spend( 100 )
			@area.build( new Castle(Country.Dots) )

		else if Game.instance.canSquare and isSquare(@corners)
			Game.instance.lineG -= 100
			Game.instance.lineGBox.spend( 100 )
			@area.build( new Mine(Country.Dots) )

		@clean()

		return

	clean:()->

		TweenLite.to(@drawArea.scale,.3,{x:.8,y:.8})
		TweenLite.to(@drawArea,.3,{alpha:0})
		TweenLite.to(@helper.scale,.3,{x:.8,y:.8})
		TweenLite.to(@helper,.3,{alpha:0})
		TweenLite.to(@graphic,.3,{alpha:0})

		# remove reference
		@stage.mousemove 	= null
		@stage.touchmove 	= null
		@stage.mouseup	 	= null
		@stage.toucstop 	= null
		InteractiveController.instance.moveDelegate = null