class CastleBig extends Castle

	constructor:(owner)->
		texture = PIXI.Texture.fromImage "./img/castle_B2.png"
		super owner, texture
		@life = 100
		@name = "bigCastle"