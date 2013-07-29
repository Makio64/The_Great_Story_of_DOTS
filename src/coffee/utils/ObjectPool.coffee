class ObjectPool 


	constructor: (@create, @minSize, @maxSize) ->

		@list = []
		@add() for [0...@minSize]



	add: () ->

		@list.push @create()



	checkOut: () ->

		if @list.length == 0
			i = @create()
		else
			i = @list.pop()


	checkIn: (item) ->

		if @list.length < @maxSize
			@list.push item