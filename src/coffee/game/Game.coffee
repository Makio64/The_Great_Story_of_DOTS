class Game

	@instance 			: new Game()
	@stage 				: null

	canConstruct 		: false
	canLine				: false
	canSquare			: false
	canTriangle 		: false
	isStart 			: false

	pause 				: false

	map 				: null
	areas 				: null
	mobiles 			: null

	gameEndChecker 		: null

	lineG				: 900
	lineGBox			: null

	mobilesToRemove		: null

	constructor:()->
		if Game.instance then throw new Error("You can't create an instance of Game, use Game.instance")
		@mobiles 			= []
		@mobilesToRemove 	= []
		@areas 				= []
		
		return

	update:(dt)->
		
		for mobile in @mobilesToRemove
			idx = @mobiles.indexOf(mobile)
			@mobiles.splice(idx,1)
			Game.stage.removeChild(mobile)
		@mobilesToRemove = []

		if @pause
			return

		if @gameEndChecker
			if @gameEndChecker.check() and @isStart
				@pause = true
				if @gameEndChecker.isWin
					@onWin()
				else
					@onLoose()

		if @lineGBox 
			@lineGBox.update()

		for area in @areas
			area.update(dt)

		for mobile in @mobiles
			mobile.update(dt)

		return

	onWin:()->
		image = new PIXI.Sprite(PIXI.Texture.fromImage "./img/win_text.png")
		image.anchor.x = .5
		image.anchor.y = .5
		image.scale.x = .8
		image.scale.y = .8
		image.position.x = 528
		image.position.y = 336 
		image.alpha = 0
		Game.stage.addChild image

		if window.IS_CHROME
			gainNode = SoundManager.instance.getGain("loop")
			TweenLite.to(gainNode.gain,.5,{value:0, ease:Quad.easeIn})
			SoundManager.instance.play("./sounds/victory.mp3")
		
		TweenLite.to(image.scale,.8,{x:1,y:1,ease:Back.easeOut})
		TweenLite.to(image,.8,{alpha:1})
		
		$("h1").addClass("win")
		
		setTimeout(Game.instance.closeGame,4000)
		return

	closeGame:()->
		DisplayController.instance.display(0,0,0,0,0)
		TweenLite.to($("body"), 1.5, { scrollTop:0,delay:.5,ease:Quad.easeOut})
		return

	onLoose:()->

		$("h1").addClass("loose")

		if window.IS_CHROME
			gainNode = SoundManager.instance.getGain("loop")
			TweenLite.to(gainNode.gain,.5,{value:0, ease:Quad.easeIn})
			SoundManager.instance.play("./sounds/gameover.mp3")

		TweenLite.to($("#squareWin"),4,{autoAlpha:1,delay:2,onStart:()->$("#squareWin").css("display","block")})
		DisplayController.instance.display(0,0,0,0,0)
		TweenLite.to($("body"), 1.5, { scrollTop:0,delay:.5,ease:Quad.easeOut})
		
		return

	initWithData:(data, width, height)->
		
		@gameEndChecker = new GameEndChecker()
		@lineGBox 		= new LineGBox()

		Game.stage.addChild( new PIXI.Sprite(PIXI.Texture.fromImage "./img/bg.png") )
		@map = new Map(Math.floor(width / 8),Math.floor(height / 8))
		@map.initWithData( data )

		for y in [0..height] by @map.gridSize
			for x in [0..width] by @map.gridSize
				r = data[((width * y) + x) * 4]
				g = data[((width * y) + x) * 4 + 1]
				b = data[((width * y) + x) * 4 + 2]
				a = data[((width * y) + x) * 4 + 3]

				building = BuildingFactory.withData(r,g,b,a) 
				if building != null
					building.position = new Point(x,y)
					@addBuilding( building )

				mobile = MobileFactory.withData(r,g,b,a)
				if mobile != null
					mobile.position = new Point(x,y)
					@addMobile( mobile )

		Game.stage.addChild(@lineGBox)

		InteractiveController.instance.init(Game.stage)
		return
		

	findCastles:(x,y,width,height)->
		
		castles = []

		for i in [x...x+width] by 8
			for j in [y...y+height] by 8
				area = @areaAtPosition(i,j)
				if area!=null and area.building!=null and (area.building.name == "castle" or area.building.name == "bigCastle")
					if castles.indexOf(area.building)==-1
						castles.push(area.building)

		return castles

			
	addChild:(child)->
		Game.stage.addChild(child)
		return


	areaAtPosition:(x,y)->
		for area in @areas
			if area.hitTest(x,y)
				return area
		return null


	addBuilding:(building)->
		@areas.push(building)
		building.position = building.position
		Game.stage.addChild( building )
		return

	removeBuilding:(area)->
		idx = areas.indexOf(area)
		areas.splice(idx,1)
		Game.stage.removeChild(area)
		return

	addMobile:(mobile)->
		@mobiles.push(mobile)
		Game.stage.addChild(mobile)
		return

	removeMobile:(mobile)->
		@mobilesToRemove.push(mobile)			
		return