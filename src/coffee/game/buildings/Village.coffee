class Village extends Building
	
	constructor:(owner)->
		super owner, PIXI.Texture.fromImage "./img/village.png"
		@name = "village"
		return

	update:(dt)->
		
		return