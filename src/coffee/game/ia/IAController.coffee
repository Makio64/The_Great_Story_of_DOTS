class IAController

	@instance 			: new IAController()

	difficulty 			: 0

	nextMoveDuration	: 0
	lastMove			: 0

	castles				: null


	constructor:()->
		if IAController.instance then throw new Error("You can t create an instance of IAController")
		@castles = []
		return

	update:(dt)->
		if @castles.length == 0
			return
		
		@lastMove -= dt
		if @lastMove <= 0
			@lastMove = @nextMoveDuration
			@newAttack()

		return

	newAttack:()->
		castle = @selectRandomCastle()
		target = @selectRandomEnnemyArea()

		if target == null or castle == null
			return

		x = Math.floor(castle.area.position.x / 8)
		y = Math.floor(castle.area.position.y / 8)
		p1 = { x, y }
		x = Math.floor(target.position.x / 8)
		y = Math.floor(target.position.y / 8)
		p2 = { x, y }

		line = Game.instance.map.astar(p1, p2)

		castle.line = line
		return


	addCastle:(castle)->
		if @castles.indexOf(castle) == -1
			@castles.push(castle)
		return

	removeCastle:(castle)->
		idx = @castles.indexOf(castle)
		if idx != -1
			@castles.splice(idx,1)
		return

	selectRandomCastle:()->
		if @castles.length == 0
			return null
		
		return @castles[Math.floor(Math.random()*@castles.length)]

	selectRandomEnnemyArea:()->
		areas = []
		for area in Game.instance.areas
			if area.building!=null and area.building.owner == Country.Dots
				areas.push(area)
		
		if areas.length == 0
			return null
		
		return areas[Math.floor(Math.random()*areas.length)]


	setup:(@difficulty)->
		switch difficulty
			when Difficulty.EASY
				@nextMoveDuration = 5000 
				break
			when Difficulty.MEDIUM
				@nextMoveDuration = 4000 
				break
			when Difficulty.ADVANCED
				@nextMoveDuration = 3000 
				break
			when Difficulty.EXPERT
				@nextMoveDuration = 1000 
				break

		@lastMove = @nextMoveDuration
		
		return



class Difficulty

	@EASY 		: 0x000001
	@MEDIUM 	: 0x000002
	@ADVANCED 	: 0x000004
	@EXPERT 	: 0x000008