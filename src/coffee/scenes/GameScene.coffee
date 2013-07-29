class GameScene extends AScene


	image 				: null


	constructor:(stage)->
		super(stage)
		return


	onEnter:()->
		@image = new Image()
		@image.onload = @onLoad
		@image.src = "./data/map.png"


	onLoad:()=>
		
		DisplayController.instance.display(-375,-143,192,192,0,true)

		canvas = document.createElement('canvas')
		canvas.width = @image.width
		canvas.height = @image.height
		context = canvas.getContext('2d')
		context.width = @image.width
		context.height = @image.height
		context.drawImage(@image, 0, 0)
		
		imageData = context.getImageData(0, 0, @image.width, @image.height)

		Game.stage = @stage
		Game.instance.initWithData( imageData.data, @image.width, @image.height )

		StoryManager.instance.init()
		StoryManager.instance.start()
		console.log Game.instance.map.astar({x:0,y:0},{x:100,y:60})