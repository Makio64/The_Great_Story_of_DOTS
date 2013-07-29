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
		
		@color = new ColorArea(building.owner)
		@addChild(@color)
		
		building.area = @
		@addChild(building)
		return

	removeBuilding:()->
		@color.remove()
		@removeChild(@building)
		@building.area = null
		@building = null


	update:(dt)->
		if @building != null
			@building.update(dt)

	hitTest:(x,y)->
		return HitTest.testElipse(new Point(x,y),@,40,25)