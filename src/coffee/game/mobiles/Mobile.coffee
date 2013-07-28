class Mobile extends PIXI.Sprite

	position 		: null
	owner			: null
	line			: null
	sprite 			: null
	isWaiting 		: false

	constructor:( texture, line = [], @owner = Country.Dots )->
		@line = []
		# @sprite = new PIXI.Sprite( texture )
		super texture
		return

	update:()->
		return