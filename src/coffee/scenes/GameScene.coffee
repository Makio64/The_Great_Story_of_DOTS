class GameScene extends AScene


	image 				: null


	constructor:(stage)->
		super(stage)
		return


	onEnter:()->
		@image = new Image()
		@image.onload = @onLoad
		@image.src = "./img/map.png"
		return

	onLoad:()=>

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