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
				# @introStoryStep
				@buildCastleStep
				@buildCastleSucessStep
				@ennemyVillageStep
				@moveYourUnitStep
				@winFirstBattleStep
				@buildMineSucessStep
				@firstBattleStep
				@startBattleStep
				@castleDestroyStep
				@flyingCastleStep
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
		setTimeout( StoryManager.instance.nextStep, 2000)
		return

	
	ennemyVillageStep:()->
		DisplayController.instance.display(-375,-143,384,192,0,false)
		StoryManager.instance.displayText("#story_04", 2)
		setTimeout( StoryManager.instance.nextStep, 6000)
		Game.instance.canLine = true
		Game.instance.lineGBox.position.x = 680
		Game.instance.lineGBox.position.y = 140
		return

	
	moveYourUnitStep:()->
		StoryManager.instance.conditionChecker = new VillageConditionChecker()
		StoryManager.instance.displayText("#story_05", 0)
		return

	winFirstBattleStep:()->
		StoryManager.instance.displayText("#story_06", 0)
		StoryManager.instance.displayText("#story_07", 3)
		StoryManager.instance.conditionChecker = new MineConditionChecker()
		Game.instance.canSquare = true
		Game.instance.canLine = false
		Game.instance.canConstruct = true
		return


	buildMineSucessStep:()->
		Game.instance.lineGBox.position.x = 680
		Game.instance.lineGBox.position.y = 140
		StoryManager.instance.displayText("#story_08", 0)
		Game.instance.canTriangle = true
		Game.instance.canSquare = true
		Game.instance.canConstruct = true
		Game.instance.canLine = true

		setTimeout( StoryManager.instance.nextStep, 3000 )
		return

	firstBattleStep:()->
		StoryManager.instance.displayText("#story_09", 1.5)
		DisplayController.instance.display(-375,-143,384,672,0,false)
		setTimeout( StoryManager.instance.nextStep, 0 )
		return

	startBattleStep:()->
		IAController.instance.setup( Difficulty.EASY )
		castles = Game.instance.findCastles( 375, 143, 384, 672 )
		
		for castle in castles
			if castle.owner == Country.Square
				IAController.instance.addCastle( castle )

		StoryManager.instance.conditionChecker = new BigCastleConditionChecker()

		return

	castleDestroyStep:()->
		Game.instance.pause = true
		DisplayController.instance.display(0,0,1152,672,0,false)
		setTimeout( StoryManager.instance.nextStep, 0 )
		return

	flyingCastleStep:()->
		Game.instance.shakeScreen(2000)
		return
