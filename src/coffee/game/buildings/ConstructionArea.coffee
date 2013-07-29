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
		
		if building.owner == Country.Dots
			color = new PIXI.Sprite(PIXI.Texture.fromImage "./img/base_dot_s.png")

		else if building.owner == Country.Square
			color = new PIXI.Sprite(PIXI.Texture.fromImage "./img/base_square_s.png")
		
		@addChild(color)
		color.alpha = 0
		color.anchor.x = .5
		color.anchor.y = .5
		TweenLite.to(color,3,{alpha:1})
		
		building.area = @
		@addChild(building)
		return

	update:(dt)->
		if @building != null
			@building.update(dt)

	hitTest:(x,y)->
		return HitTest.testElipse(new Point(x,y),@,40,25)