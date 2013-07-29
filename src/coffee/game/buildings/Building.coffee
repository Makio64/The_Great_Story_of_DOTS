class Building extends PIXI.Sprite

	owner 				: null
	activate			: true
	life 				: 10
	name 				: ""
	area 				: null

	constructor:(@owner,texture)->
		super texture
		@name = ""
		@anchor.x = .5
		@anchor.y = 1
		@position.y = 14
		return


	update:(dt)->
		return


	animIn:(delay)->
		@alpha = 0.7
		@scale.x = 0
		@scale.y = 0

		TweenLite.to(@,.4,{alpha:1,delay:delay})
		TweenLite.to(@scale,.5,{x:1,y:1,delay:delay, ease:Back.easeOut})

		return

	damage:(amount)->
		if @life <= 0
			return
		
		@life -= amount
		
		if @life == 0
			@destroy()

		explosion = new Explosion()
		explosion.position.x = Math.random()*30-15
		explosion.position.y = -Math.random()*60
		@addChild(explosion)

		@scale.x = 1
		@scale.y = 1
		TweenLite.to(@scale,.05,{x:1.1,y:1.1})
		TweenLite.to(@scale,.05,{x:1,y:1, delay:.5})

		return

	destroy:()->
		@parent.building = null
		@area = null
		TweenLite.killTweensOf(@scale)
		TweenLite.to(@scale,.4,{x:0.8,y:0.8,ease:Back.easeIn})
		TweenLite.to(@,.4,{alpha:0, onComplete:@dispose})

	isDestroy:()->
		return life>0

	dispose:()->
		if @parent
			@parent.removeChild(@)
