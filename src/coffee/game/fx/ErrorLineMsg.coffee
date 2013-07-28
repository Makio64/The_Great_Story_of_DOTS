class ErrorLineMsg extends PIXI.Sprite

	constructor:()->
		super PIXI.Texture.fromImage "./img/attention.png"
		@alpha = 0
		@anchor.x = .5
		@anchor.y = .5
		@scale.x = .8
		@scale.y = .8
		TweenLite.to(@scale,.5,{x:1,y:1,ease:Back.easeOut})
		TweenLite.to(@,.4,{alpha:1})
		TweenLite.to(@,.4,{alpha:0,delay:2})
		TweenLite.to(@scale,.5,{x:.8,y:.8,ease:Back.easeIn,delay:2,onComplete:@dispose})

	dispose:()=>
		if @parent
			@parent.removeChild(@)