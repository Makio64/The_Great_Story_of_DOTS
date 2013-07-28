class Castle extends Building

	lastUnit 			: 0
	unitDuration		: 100
	units				: null
	line				: null
	maxUnit 			: 10

	constructor:(owner, texture=null)->
		if owner == Country.Dots
			texture ?= PIXI.Texture.fromImage "./img/castle_A.png"
		else if owner == Country.Square
			texture ?= PIXI.Texture.fromImage "./img/castle_B1.png"

		super owner, texture

		@life = 50
		@units = new Array()
		@line = []

		@lastUnit = @unitDuration
		return

	removeLine:()->
		@line = []
		return

	update:(dt)->
		@lastUnit -= dt
		if @lastUnit <= 0
			@lastUnit = @unitDuration
			if @line.length > 0
				for unit in @units
					if unit.isWaiting
						unit.followLine(@line)
						return	
			@createUnit()
			
		
		return

	createUnit:()->
		if @units.length >= @maxUnit
			return
		
		if @line == null or @line.length == 0
			b = 0
			for unit in @units
				if unit.state == MobileState.Waiting
					b += 15
			
			x = @parent.position.x + Math.cos((5+b)*Math.PI/180)*45-4
			y = @parent.position.y + Math.sin((5+b)*Math.PI/180)*26
		
		else
			x = @line[0].x
			y = @line[0].y

		unit = new Soldier(@owner,@)
		unit.position.x = @parent.position.x
		unit.position.y = @parent.position.y
		unit.moveTo(x,y)
		@units.push(unit)
		
		Game.instance.addMobile(unit)
		if @line.length == 0
			unit.state = MobileState.Waiting
		else 
			unit.followLine( @line )
		
		return

	removeUnit:(unit)->
		idx = @units.indexOf(unit)
		@units.splice(idx,1)
		unit = null
		return
		
