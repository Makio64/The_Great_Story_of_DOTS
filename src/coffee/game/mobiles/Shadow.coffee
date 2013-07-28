class Shadow extends PIXI.Sprite

	mobile		: null

	constructor:(@mobile)->
		super PIXI.Texture.fromImage "./img/soldier_dot_S_shadow.png"
		@anchor.x = 0.1
		@anchor.y = -1.5
		return

	update:()->
		@position.x = @mobile.position.x
		@position.y = @mobile.position.y
		return

	destroy:()->
		TweenLite.to(@scale,.1,{x:0,y:0,onComplete:@dispose})
		return

	dispose:()->
		@mobile = null
		if @parent
			@parent.removeChild(@)
		return