class Soldier extends AMobile

	castle : null

	constructor:(owner,@castle)->
		super( new PIXI.Texture.fromImage("./img/soldier_dot_S.png"), owner )