class Village extends Building
	
	constructor:(owner)->
		super owner, PIXI.Texture.fromImage "./img/village.png"
		@name = "village"
		@position.y = 14
		return

	update:(dt)->
		
		return