class DwarfVillage extends Castle

	constructor:()->
		super Country.Triangle, PIXI.Texture.fromImage "./img/triangle_house_A.png" 
		@position.y = 14
		@name = "dwarf"

		return
