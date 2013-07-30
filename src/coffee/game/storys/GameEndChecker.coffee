class GameEndChecker

	isWin		: false
	isLoose		: false

	constructor:()->
		return

	check:()->
		if @checkPlayerWin()
			@isWin = true
			return true

		if @checkPlayerLoose()
			@isLoose = true
			return true

		return false

	checkPlayerLoose:()->
		for area in Game.instance.areas
			if area.building != null and area.building.owner == Country.Dots
				return false

		return true

	checkPlayerWin:()->
		for area in Game.instance.areas
			if area.building != null and area.building.name == "bigCastle"
				return false
		
		return true