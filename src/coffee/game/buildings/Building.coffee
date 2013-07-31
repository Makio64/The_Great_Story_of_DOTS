class Building extends PIXI.Sprite

	owner 				: null
	life 				: 10
	name 				: ""
	area 				: null
	state				: ""

	constructor:(@owner,texture)->
		super texture
		@name = ""
		@state = BuildingFlag.Construct
		@anchor.x = .5
		@anchor.y = 1
		@position.y = 26
		return


	update:(dt)->
		return


	animIn:(delay)->
		if @owner == Country.Dots and window.IS_CHROME
			SoundManager.instance.play("./sounds/construction.mp3")

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

		if window.IS_CHROME
			SoundManager.instance.playWithVolume("./sounds/attack"+NumberUtils.addZero(Math.floor(Math.random()*9),2)+".mp3",.15)

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
		@area.removeBuilding()

		if(window.IS_CHROME)
			SoundManager.instance.play("./sounds/explosion.mp3")
		
		TweenLite.killTweensOf(@scale)
		TweenLite.to(@scale,.4,{x:0.8,y:0.8,ease:Back.easeIn})
		TweenLite.to(@,.4,{alpha:0, onComplete:@dispose})

	isDestroy:()->
		return life>0

	dispose:()->
		if @parent
			@parent.removeChild(@)

class BuildingFlag

	@None			: 0x000000
	@Construct 		: 0x000001
	@Destroy 		: 0x000002