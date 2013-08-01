class Castle extends Building

	lastUnit 			: 0
	unitDuration		: 100
	units				: null
	line				: null
	maxUnit 			: 10
	lastTick 			: 0
	tickDuration        : 9000


	constructor:(owner, texture=null)->
		if owner == Country.Dots
			texture ?= PIXI.Texture.fromImage "./img/castle_A.png"
		else if owner == Country.Square
			texture ?= PIXI.Texture.fromImage "./img/castle_B1.png"

		super owner, texture

		if owner == Country.Square
			@position.y = 20

		@name = "castle"

		@life = 20
		@units = new Array()

		@lastUnit = @unitDuration
		return

	setLine:(points, draw=true)->
		if @line
			@line.fadeOut()
		@line = new Line(points,0xed0060)
		if draw
			Game.stage.addChild(@line)
		return

	update:(dt)->
		if @state & BuildingFlag.Destroy
			return

		if @line != null
			@line.update(dt)
		
		@lastUnit -= dt
		if @lastUnit <= 0
			@lastUnit = @unitDuration
			if @line != null
				for unit in @units
					if unit.isWaiting
						unit.followLine(@line.points)
						return	
			@createUnit()
		
		if @owner != Country.Dots
			return
		
		@lastTick -= dt
		if @lastTick <= 0
			@lastTick = @tickDuration
			@addMoney()
		return


	createUnit:()->
		if @units.length >= @maxUnit
			return
		
		if @line == null
			b = 0
			for unit in @units
				if unit.state == MobileState.Waiting
					b += 15
			
			x = @parent.position.x + Math.cos((5+b)*Math.PI/180)*45-4
			y = @parent.position.y + Math.sin((5+b)*Math.PI/180)*26
		
		else
			x = @line.points[0].x
			y = @line.points[0].y

		unit = new Soldier(@owner,@)
		unit.position.x = @parent.position.x
		unit.position.y = @parent.position.y
		unit.moveTo(x,y)
		@units.push(unit)

		if @line == null
			unit.state = MobileState.Waiting
		else 
			unit.followLine( @line.points )
		
		Game.instance.addMobile(unit)
		return


	removeLine:()->
		if @line
			@line.fadeOut()
			@line = null
		return


	removeUnit:(unit)->
		idx = @units.indexOf(unit)
		@units.splice(idx,1)
		unit = null
		return


	destroy:()->
		super
		if owner = Country.Square
			IAController.instance.removeCastle(@)

		for i in [@units.length-1..0] by -1
			unit = @units[i]
			unit.onDie()
		
		if(@line != null)
			@line.fadeOut()
			@line = null

		@state += BuildingFlag.Destroy
		return
		

	addMoney:()->
		Game.instance.lineG += 5
		anim = new MoneyAnimation(5)
		@addChild(anim)
		return
		
