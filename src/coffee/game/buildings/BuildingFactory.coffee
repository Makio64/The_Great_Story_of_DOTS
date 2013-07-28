class BuildingFactory

	constructor:()->
		return

	@withData:(r,g,b,a)->
		if r == 0xFF and g == 0xF0 and b == 0
			return new ConstructionArea()
		else if r == 0 and g == 0 and b == 0xFF
			area = new ConstructionArea()
			castle = new Castle()
			castle.owner = "square"
			area.add( castle )
			return area
		return null