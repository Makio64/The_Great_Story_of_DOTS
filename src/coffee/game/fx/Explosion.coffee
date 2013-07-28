class Explosion extends PIXI.Sprite

	constructor:()->
		super PIXI.Texture.fromImage "./img/attack_A.png"
		@anchor.x = .5
		@anchor.y = .5
		@scale.x = 0
		@scale.y = 0
		TweenLite.to(@scale,.3,{x:1,y:1})
		TweenLite.to(@,.3,{alpha:0,onComplete:@dispose})
		return

	dispose:()=>
		if @parent
			@parent.removeChild(@)