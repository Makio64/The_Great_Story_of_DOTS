class CastleConditionChecker

	constructor:()->
		return

	check:()->
		for area in Game.instance.areas
			if area.building != null and area.building.owner == Country.Dots
				StoryManager.instance.nextStep()
		
		return