class Building extends PIXI.Sprite

	owner 				: null
	activate			: true

	constructor:(@owner,texture)->
		super texture
		@anchor.x = .5
		@anchor.y = 1
		return


	update:(dt)->
		return


	animIn:(delay)->
		@alpha = 0.7
		@scale.x = 0
		@scale.y = 0

		TweenLite.to(@,.4,{alpha:1,delay:delay})
		TweenLite.to(@scale,.5,{x:1,y:1,delay:delay, ease:Back.easeOut})

		return