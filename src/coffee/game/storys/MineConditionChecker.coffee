class MineConditionChecker

	constructor:()->
		return

	check:()->
		for area in Game.instance.areas
			if area.building != null and area.building.owner == Country.Dots and area.building.name == "mine"
				StoryManager.instance.nextStep()
		
		return