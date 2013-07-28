class LoadScene extends AScene

	# Load image and readData

	image 				: null
	map 				: null
	

	constructor:(stage)->
		super(stage)

		return

	onEnter:()->
		@image = new Image()
		@image.onload = @onLoad
		@image.src = "./data/map.png"


	onLoad:()=>
		canvas = document.createElement('canvas')
		canvas.width = @image.width
		canvas.height = @image.height
		context = canvas.getContext('2d')
		context.width = @image.width
		context.height = @image.height
		context.drawImage(@image, 0, 0)
		
		imageData = context.getImageData(0, 0, @image.width, @image.height)
		data = imageData.data;
		
		iw = @image.width
		ih = @image.height
		gridSize = 8

		@map = new Map(Math.floor(iw/gridSize),Math.floor(ih/gridSize))

		for y in [0..ih] by gridSize
			for x in [0..iw] by gridSize
				r = data[((iw * y) + x) * 4]
				g = data[((iw * y) + x) * 4 + 1]
				b = data[((iw * y) + x) * 4 + 2]
				a = data[((iw * y) + x) * 4 + 3]

				@map.tiles[x/gridSize][y/gridSize] = TileFlag.convertDataToFlag(r,g,b,a)

		Game.instance.map = @map;
		# Game.initCastleWithData( data )