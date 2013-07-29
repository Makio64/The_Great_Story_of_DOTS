class ColorArea extends PIXI.Sprite

	constructor:(owner)->
		if owner == Country.Dots
			super(PIXI.Texture.fromImage "./img/base_dot_s.png")

		else if owner == Country.Square
			super(PIXI.Texture.fromImage "./img/base_square_s.png")
		
		@alpha = 0
		@anchor.x = .5
		@anchor.y = .5
		TweenLite.to(@,3,{alpha:1})
		
		return

	remove:()->
		TweenLite.to(@,3,{alpha:0,onComplete:@dispose})
		return

	dispose:()->
		if @parent
			@parent.removeChild(@)