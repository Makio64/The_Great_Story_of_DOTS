class VillageConditionChecker

	constructor:()->
		return

	check:()->
		for area in Game.instance.areas
			if area.building != null and area.building.name == "village"
				return

		StoryManager.instance.nextStep()
		
		return