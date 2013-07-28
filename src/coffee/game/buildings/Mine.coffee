class Mine extends Building

	lastTick 			: 0

	tickDuration		: 1000

	constructor:(owner)->
		super owner, PIXI.Texture.fromImage "./img/mine.png"
		@lastUnit = @tickDuration
		@name = "mine"
		return

	update:(dt)->
		@lastTick += dt
		if @lastTick - dt <= 0
			@lastTick = @tickDuration
			@addMoney()
		return

	addMoney:()->
		return