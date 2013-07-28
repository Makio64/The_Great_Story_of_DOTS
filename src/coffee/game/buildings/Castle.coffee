class Castle extends Building

	lastUnit 			: 0
	unitDuration		: 1000
	units				: null
	line				: null
	maxUnit 			: 10

	constructor:(owner)->
		super owner, PIXI.Texture.fromImage "./img/castle_A.png"
		
		@units = new Array()
		@line = []

		@lastUnit = @unitDuration
		return

	update:(dt)->
		@lastUnit -= dt
		if @lastUnit <= 0
			@lastUnit = @unitDuration
			@createUnit()
		return

	createUnit:()->
		if @units.length >= @maxUnit
			return
		
		unit = new Soldier()
		unit.position.x = @position.x
		unit.position.y = @position.y
		Game.instance.addMobile(unit)
		if @line.length == 0
			unit.isWaiting = true
		else 
			unit.line = @line
		
		return