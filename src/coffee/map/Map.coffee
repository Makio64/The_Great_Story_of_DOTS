class Map

	width		: 0
	height		: 0
	gridSize 	: 8
	tiles		: null
	graph 		: null

	constructor:(@width,@height)->
		console.log "Map size : #{@width},#{@height}"
		@tiles = new Array(@width)
		for x in [0...width] by 1
			for y in [0...height] by 1
				@tiles[x] = new Array(@height)
				@tiles[x][y] = TileFlag.Walkable
		return
	

	initWithData:(data)->

		height 	= @height*@gridSize
		width 	= @width*@gridSize

		for y in [0...height] by @gridSize
			for x in [0...width] by @gridSize
				r = data[((width * y) + x) * 4]
				g = data[((width * y) + x) * 4 + 1]
				b = data[((width * y) + x) * 4 + 2]
				a = data[((width * y) + x) * 4 + 3]

				@tiles[x/@gridSize][y/@gridSize] = TileFlag.convertDataToFlag(r,g,b,a)

		@graph = @createGraph()

		return

	astar:(start,end)->
		start 	= @graph.nodes[start.y][start.x]
		end 	= @graph.nodes[end.y][end.x]
		


		line = astar.search(@graph.nodes, start, end, true)
		points = []
		for i in [0...line.length] by 1
			points[i] = {x:line[i].y*8,y:line[i].x*8}
		return simplify(points,1,false)

	isWalkable:(x,y)->
		return @tiles[x][y] & TileFlag.Walkable

	isWater:(x,y)->
		return @tiles[x][y] & TileFlag.Water

	isMarsh:(x,y)->
		return @tiles[x][y] & TileFlag.Marsh

	toGraphic:()->
		graphic = new PIXI.Graphics()
		for x in [0...@width] by 1
			for y in [0...@height] by 1
				if @isWater(x,y)
					graphic.beginFill( 0x0000FF,.5 )
				else if @isMarsh(x,y)
					graphic.beginFill( 0xFF00FF,.5 )
				else if @isWalkable(x,y)
					graphic.beginFill( 0x000000,.5 )
				else 
					graphic.beginFill( 0xFF0000,.5 )
				graphic.drawRect(x*@gridSize,y*@gridSize,@gridSize,@gridSize)
				graphic.endFill()

		return graphic

	createGraph:()->

		marshWeight = 4
		waterWeight = 5
		normalWeight = 1

		array = new Array(@height)
		for i in [0...@height] by 1
			array[i] = new Array(@width)
		

		for x in [0...@width] by 1
			for y in [0...@height] by 1

				if @isWater(x,y)
					array[y][x] = waterWeight
				else if @isMarsh(x,y)
					array[y][x] = marshWeight
				else if @isWalkable(x,y)
					array[y][x] = normalWeight
				else 
					array[y][x] = 0

		return graph = new Graph(array)






class TileFlag

	@None 		: 0x000000
	@Walkable 	: 0x000001
	@Water 		: 0x000002
	@Marsh 		: 0x000004


	@convertDataToFlag:(r,g,b,a)=>

		if r == 0xFF && g == 0 && b == 0
			return TileFlag.None

		if r == 0x33 && g == 0x99 && b == 0x66
			return TileFlag.Marsh + TileFlag.Walkable
		
		if r == 0x66 && g == 0x99 && b == 0
			return TileFlag.Water + TileFlag.Walkable
		
		return TileFlag.Walkable


