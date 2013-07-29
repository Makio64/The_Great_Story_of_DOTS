class ConstructionArea extends PIXI.Sprite

	building 		: null
	color			: null

	constructor:(texture)->
		texture ?= PIXI.Texture.fromImage "./img/empty_s.png"
		super( texture )
		@anchor.x = .5
		@anchor.y = .5
		return

	build:(building)->
		@add(building)
		building.animIn()
		return

	add:(@building)->
		if @building.owner == Country.Dots or @building.owner == Country.Square
			@color = new ColorArea(building.owner)
			@addChild(@color)
		
		building.area = @
		@addChild(building)
		return

	removeBuilding:()->
		if @color != null
			try
				@color.remove()
				@color = null
			catch e
			
		@removeChild(@building)
		@building.area = null
		@building = null


	update:(dt)->
		if @building != null
			@building.update(dt)

	hitTest:(x,y)->
		return HitTest.testElipse(new Point(x,y),@,40,25)