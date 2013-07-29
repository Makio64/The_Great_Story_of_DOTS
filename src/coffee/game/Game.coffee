class Game

	@instance 			: new Game()
	@stage 				: null

	canConstruct 		: false
	canLine				: false
	canSquare			: false
	canTriangle 		: false

	pause 				: false

	map 				: null
	areas 				: null
	mobiles 			: null

	gameEndChecker 		: null

	lineG				: 900
	lineGBox			: null

	constructor:()->
		if Game.instance then throw new Error("You can't create an instance of Game, use Game.instance")
		@mobiles 		= []
		@areas 			= []
		
		return

	update:(dt)->
		if @pause
			return

		if @gameEndChecker
			@gameEndChecker.check()
		if @lineGBox 
			@lineGBox.update()

		for area in @areas
			area.update(dt)
		for mobile in @mobiles
			mobile.update(dt)

		# @lineG += 1

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

	removeBuilding:(building)->
		idx = areas.indexOf(building)
		areas.slice(idx,1)
		Game.stage.removeChild(building)
		return

	addMobile:(mobile)->
		@mobiles.push(mobile)
		Game.stage.addChild(mobile)
		return

	removeMobile:(mobile)->
		idx = @mobiles.indexOf(mobile)
		@mobiles.slice(idx,1)
		try
			Game.stage.removeChild(mobile)
		catch e
			
		return