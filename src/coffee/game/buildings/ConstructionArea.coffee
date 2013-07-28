class ConstructionArea extends PIXI.Sprite

	building 		: null

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
		@addChild(building)
		return

	update:(dt)->
		if @building != null
			@building.update(dt)

	hitTest:(x,y)->
		return HitTest.testElipse(new Point(x,y),@,40,25)