class ConstructionAreaBig extends ConstructionArea

	constructor:()->
		super(PIXI.Texture.fromImage "./img/empty_s.png")
		return

	hitTest:(x,y)->
		return HitTest.testElipse(new Point(x,y),@,60,45)