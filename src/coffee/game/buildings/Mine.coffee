class Mine

	lastTick 			: 0

	tickDuration		: 1000

	constructor:(owner)->
		texture = PIXI.Texture.fromImage "./img/castle_A.png"
		super owner, texture
		@lastUnit = @tickDuration
		return

	update:(dt)->
		@lastTick += dt
		if @lastTick - dt <= 0
			@lastTick = @tickDuration
			@addMoney()
		return

	addMoney:()->
		return