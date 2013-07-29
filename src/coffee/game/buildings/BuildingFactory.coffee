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
		else if r == 0x66 and g == 0 and b == 0xFF
			area = new ConstructionArea()
			mine = new Mine(Country.Square)
			area.add( mine )
			return area
		
		else if r == 0xFF and g == 0 and b == 0xCC
			area = new ConstructionArea()
			village = new Village(Country.Square)
			area.add( village )
			return area
		
		else if r == 0x99 and g == 0x99 and b == 0xFF
			area = new ConstructionAreaBig()
			castle = new CastleBig(Country.Square)
			area.add( castle )
			return area
		
		else if r == 0x99 and g == 0xFF and b == 0xCC
			area = new ConstructionAreaBig()
			monster = new Monster()
			area.add( monster )
			return area
		
		else if r == 0x66 and g == 0x66 and b == 0x33
			area = new ConstructionAreaBig()
			monster = new Snake()
			area.add( monster )
			return area

		else if r == 0xFF and g == 0x99 and b == 0x99
			area = new ConstructionAreaBig()
			village = new DwarfVillage()
			area.add( village )
			return area

		return null