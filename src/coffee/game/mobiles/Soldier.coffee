class Soldier extends AMobile

	castle : null

	constructor:(owner,@castle)->
		if owner == Country.Dots
			texture = new PIXI.Texture.fromImage("./img/soldier_dot_S.png")
		else if owner == Country.Square
			texture = new PIXI.Texture.fromImage("./img/soldier_square_S.png")
		else 
			texture = new PIXI.Texture.fromImage("./img/soldier_triangle_S.png")
		super( texture, owner )