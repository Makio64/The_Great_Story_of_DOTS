class InteractiveController

	@instance 				: new InteractiveController()

	stage 					: null

	moveDelegate 			: null

	constructor:()->
		if(InteractiveController.instance) then throw new Error("You can't create an instance of InteractiveController, use static property")
		return

	init:(@stage)->
		stage.mousedown = @onTouch 
		stage.touch = @onTouch
		return

	onTouch:(data)->

		if Game.instance.pause
			return

		area = Game.instance.areaAtPosition(data.global.x,data.global.y)
		if area != null
			if area.building == null 
				if Game.instance.canConstruct
					@moveDelegate = new ShapeCreation(area, Game.stage, data.global.x, data.global.y)
			else if Game.instance.canLine and area.building.owner == Country.Dots
				@moveDelegate = new LineCreation(area, Game.stage, data.global.x, data.global.y)
		return