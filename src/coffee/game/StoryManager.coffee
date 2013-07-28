class StoryManager

	@instance 					: new StoryManager()
	
	currentStep 				: 0
	steps 						: null
	conditionChecker 			: null
	text 						: null
	oldID						: ""


	constructor:()->
		if StoryManager.instance then throw new Error("you can t create an instance of StoryManager") 
		return

	init:()->
		@steps =
			[
				# @introStoryStep,
				@buildCastleStep,
				@buildCastleSucessStep,
				@ennemyVillageStep,
				@moveYourUnitStep,
				@winFirstBattleStep
			]
		return


	displayText:(id,delay)->
		
		if @text!=null
			i = @oldID
			TweenLite.to(@text,.3,{delay:delay,opacity:0,onComplete:()=>
				# $(i).hide()
				# $(i).css("display","none")
				$(i).get(0).style.display = "none"
			})
			delay += .35
		else
			$(id).show()
		@text = $(id)
		@oldID = id

		TweenLite.to($(id),.6,{delay:delay+.3,autoAlpha:1,onStart:()=>
			$(id).show()
		})
		return


	update:()->
		if @conditionChecker != null
			@conditionChecker.check()
		
		return


	start:()->
		@nextStep()
		return


	nextStep:()->
		StoryManager.instance.conditionChecker = null;
		StoryManager.instance.playStep()
		StoryManager.instance.currentStep++
		return


	playStep:()->
		@steps[@currentStep]()
		return


	introStoryStep:()->
		StoryManager.instance.displayText("#story_01", 0)

		king = new King()
		king.position.x = 350
		king.position.y = 300
		Game.instance.addChild(king)

		TweenLite.to(king.position, 1.5, { x:450, ease:Linear.easeNone, delay:2 } )
		TweenLite.to(king.position, 1.5, { x:350, ease:Linear.easeNone, delay:3.5, onComplete: ()->
			Game.stage.removeChild(king)
			StoryManager.instance.nextStep()
		} )
		
		return


	buildCastleStep:()->
		StoryManager.instance.displayText("#story_02", 0)
		Game.instance.canConstruct = true
		Game.instance.canTriangle = true
		StoryManager.instance.conditionChecker = new CastleConditionChecker()
		return


	buildCastleSucessStep:()->
		Game.instance.canConstruct = false
		Game.instance.canTriangle = false
		StoryManager.instance.displayText("#story_03", 0)
		setTimeout( StoryManager.instance.nextStep, 1500)
		return

	
	ennemyVillageStep:()->
		DisplayController.instance.display(-375,-143,384,192,0,false)
		StoryManager.instance.displayText("#story_04", 0)
		setTimeout( StoryManager.instance.nextStep, 1500)
		return

	
	moveYourUnitStep:()->
		Game.instance.canLine = true
		StoryManager.instance.displayText("#story_05", 0)
		return

	winFirstBattleStep:()->
		return

