class Test01 extends AScene

	# Test shape recognition

	thing			: null
	points 			: null

	constructor:(stage)->
		super(stage)
		return

	onEnter:()->
		@sample = new PIXI.Graphics()
		@sample.lineStyle(2, 0xFFFFFF, .05);
		@sample.moveTo( 50, 250 )
		@sample.lineTo( 150, 50 )
		@sample.lineTo( 250, 250 )
		@sample.lineTo( 50, 250 )
		@sample.lineStyle(2, 0xFFFFFF, .05);
		@sample.moveTo( 25, 275 )
		@sample.lineTo( 275, 275 )
		@sample.lineTo( 275, 25 )
		@sample.lineTo( 25, 25 )
		@sample.lineTo( 25, 275 )
		@stage.addChild @sample

		@graphic = new PIXI.Graphics()
		@graphic.position.x = 0
		@graphic.position.y = 0
		@stage.addChild(@graphic)

		@stage.mousedown = (mouseData)=>
			@points = []
			@graphic.clear()
			pos = mouseData.global
			@points.push({x:pos.x,y:pos.y})

			@stage.mousemove = (mouseData)=>
				pos = mouseData.global

				@points.push({x:pos.x,y:pos.y})
				@points = simplify(@points, 1, false)
				@graphic.clear()
				@graphic.lineStyle(2, 0xFFFFFF, 1);
				@graphic.moveTo(@points[0].x,@points[0].y)
				for p in @points
					@graphic.lineTo(p.x,p.y)
					@graphic.moveTo(p.x,p.y)

			
			@stage.mouseup = (mousedata)=>

				@graphic.clear()
				@graphic.lineStyle(2, 0xFFFFFF, .8);
				@corners = findCorner(@points);
				for p in @corners
					@graphic.moveTo( p.x, p.y )
					@graphic.drawCircle( p.x, p.y, 5)

				if isTriangle(@corners)
					$("#test").html("triangle")
				else if isSquare(@corners)
					$("#test").html("square")
				else
					$("#test").html("shape not recognize : try pyramid or square :)")
				

				# @points = simplify(@points, 2, false)
				@graphic.moveTo(@points[0].x,@points[0].y)
				for p in @points
					@graphic.lineTo(p.x,p.y)
					@graphic.moveTo(p.x,p.y)

				@stage.mouseup = null;
				@stage.mousemove = null;