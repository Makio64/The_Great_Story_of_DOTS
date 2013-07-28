class Main

	stage 			: null
	renderer 		: null
	dt 				: 0
	lastTime 		: 0

	constructor:()->		
		@stage = new PIXI.Stage(0x000000, true)
		@renderer = PIXI.autoDetectRenderer(1152, 672, null)
		@renderer.view.style.display = "block"
		@renderer.view.className = "gameRenderer"
		@renderer.view.style.cursor = "../img/pen.png"

		@lastTime = Date.now()
		
		$("#container").append(@renderer.view)
		
		DisplayController.instance.init($("#container"), @renderer.view)
		# DisplayController.instance.display(-375,-143,192,192,0,false)
		
		SceneTraveler.getInstance().travelTo(new StartScene(@stage))
		
		requestAnimFrame( @animate )
		return

	animate:()=>
		requestAnimFrame( @animate )
		@renderer.render( @stage )
		t = Date.now()
		dt = t - @lastTime
		@lastTime = t
		StoryManager.instance.update()
		Game.instance.update(dt)

		return

$(document).ready ->
	main = new Main()