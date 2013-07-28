class StartScene extends AScene


	line 				: null
	instruction 		: null
	graphic 			: null


	constructor:(stage)->
		super(stage)
		return


	onEnter:()->		

		@line = new PIXI.Sprite(PIXI.Texture.fromImage "./img/01_line.png")
		@line.position.x = 50
		@line.position.y = 70
		@instruction = new PIXI.Sprite(PIXI.Texture.fromImage "./img/01_text.png")
		@instruction.position.x = 30;

		@stage.addChild(@line)
		@stage.addChild(@instruction)

		DisplayController.instance.display(0,0,300,200,0,false)
		@graphic = new PIXI.Graphics()
		@graphic.position.x = 0
		@graphic.position.y = 0
		@stage.addChild(@graphic)

		@stage.mousedown = @onMouseDown 
		return

	onMouseDown : (mouseData)=>
		@points = []
		@graphic.clear()
		@graphic.alpha = 1
		pos = mouseData.global
		@points.push({x:pos.x,y:pos.y})

		@stage.mousemove = (mouseData)=>
			pos = mouseData.global

			@points.push({x:pos.x,y:pos.y})
			@points = simplify(@points, 1, false)
			@graphic.clear()
			@graphic.lineStyle(2, 0xFFFFFF, 1)
			@graphic.moveTo(@points[0].x,@points[0].y)
			for p in @points
				@graphic.lineTo(p.x,p.y)
				@graphic.moveTo(p.x,p.y)

			if(@calculateDistance() > 250)
				@onEnd()
		
		@stage.mouseup = (mousedata)=>
			if(@calculateDistance() > 200)
				@onEnd()
			else
				@stage.mouseup = null
				@stage.mousemove = null
				TweenLite.to(@graphic,.4,{alpha:0})

		return

	onEnd:()->
		console.log "end"
		@stage.mousedown = null
		TweenLite.to(@line,.5,{alpha:0})
		TweenLite.to(@instruction,.5,{alpha:0})
		TweenLite.to(@graphic,.7,{alpha:0,onComplete:@onComplete})
		@stage.mouseup = null
		@stage.mousemove = null
		return

	onComplete:()=>
		$("#container").css({width:"0px",height:"0px"})
		$(".gameRenderer").css({left:"-375px",top:"-143px"})
		SceneTraveler.getInstance().travelTo(new GameScene(@stage))
		return

	calculateDistance:()=>
		distance = 0
		if @points.length >=2
			for i in [1...@points.length] by 1
				p = @points[i]
				p2 = @points[i-1]
				d = Math.abs(p.x-p2.x)+Math.abs(p.y-p2.y)
				if !isNaN(d)
					distance += d
		return distance

