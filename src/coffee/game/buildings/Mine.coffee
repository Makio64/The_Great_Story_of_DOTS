class Mine extends Building

	lastTick 			: 0

	tickDuration		: 1000

	constructor:(owner)->
		if owner == Country.Dots
			super owner, PIXI.Texture.fromImage "./img/mine.png"
		else
			super owner, PIXI.Texture.fromImage "./img/mine_square.png"
			
		@position.y = 12

		@lastUnit = @tickDuration
		@name = "mine"
		return

	update:(dt)->
		if @owner != Country.Dots
			return
		
		@lastTick -= dt
		if @lastTick <= 0
			@lastTick = @tickDuration
			@addMoney()

		return

	addMoney:()->
		Game.instance.lineG += 10
		anim = new MoneyAnimation(10)
		@addChild(anim)
		return