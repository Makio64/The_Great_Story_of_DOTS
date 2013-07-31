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
		$("#container").append(@renderer.view)
		
		DisplayController.instance.init($("#container"), @renderer.view)
		
		SceneTraveler.getInstance().travelTo(new StartScene(@stage))

		@lastTime = Date.now()

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
		IAController.instance.update(dt)

		return

main = null
$(document).ready ->
	window.IS_CHROME = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
	window.IS_FIREFOX = navigator.userAgent.toLowerCase().indexOf('firefox') > -1;

	main = new Main()
	return