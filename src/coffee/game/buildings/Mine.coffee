class Mine extends Building

	lastTick 			: 0

	tickDuration		: 1000

	constructor:(owner)->
		super owner, PIXI.Texture.fromImage "./img/mine.png"
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