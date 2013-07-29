class BigCastleConditionChecker

	constructor:()->
		return

	check:()->
		for area in Game.instance.areas
			if area.building != null and area.building.name == "bigCastle" and area.building.life < 50
				StoryManager.instance.nextStep()
		
		return