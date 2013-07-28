class BuildingFactory

	constructor:()->
		return

	@withData:(r,g,b,a)->
		if r == 0xFF and g == 0xF0 and b == 0
			return new ConstructionArea()
		else if r == 0 and g == 0 and b == 0xFF
			area = new ConstructionArea()
			castle = new Castle(Country.Square)
			area.add( castle )
			return area
		else if r == 0xFF and g == 0 and b == 0xCC
			area = new ConstructionArea()
			castle = new Village(Country.Square)
			area.add( castle )
			return area
		if r == 0x99 and g == 0x99 and b == 0xFF
			area = new ConstructionAreaBig()
			castle = new CastleBig(Country.Square)
			area.add( castle )
			return area

		return null