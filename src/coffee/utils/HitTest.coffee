class HitTest

	constructor:()->
		return

	@testCircle:(position,object,radius) ->
		radius ?= object.radius
		dx = object.position.x - position.x
		dy = object.position.y - position.y
		int dist = Math.sqrt(dx*dx + dy*dy)
		return dist <= object.radius

	@testElipse:(position,object,width,height) ->
		dx = object.position.x - position.x
		dy = object.position.y - position.y
		console.log ((dx * dx)  / (width * width)) + ((dy * dy) / (height * height)) <= 1.0
		return ((dx * dx)  / (width * width)) + ((dy * dy) / (height * height)) <= 1.0

	@testRect:(position, object)->
		return position.x >= object.position.x && position.y >= object.position.y && position.x <= object.position.x + object.width && position.y <= object.position.y + object.height

	@testRect:(position, object, centred)->
		position.x+=object.width/2
		position.y+=object.height/2
		return HitTest.testRect(position,object)
