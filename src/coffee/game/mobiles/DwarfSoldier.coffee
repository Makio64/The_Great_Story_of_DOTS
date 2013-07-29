class DwarfSoldier extends AMobile

	castle : null

	constructor:(owner,@castle)->
		texture = new PIXI.Texture.fromImage("./img/soldier_triangle_S.png")
		super( texture, owner )