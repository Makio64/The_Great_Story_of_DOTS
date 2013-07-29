class Snake extends Monster

	rotateTick			: 0

	constructor:()->
		
		textures = [
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake1.png" 
			PIXI.Texture.fromImage "./img/snake2.png" 
			PIXI.Texture.fromImage "./img/snake2.png" 
			PIXI.Texture.fromImage "./img/snake2.png" 
			PIXI.Texture.fromImage "./img/snake2.png" 
			PIXI.Texture.fromImage "./img/snake2.png" 
			PIXI.Texture.fromImage "./img/snake2.png" 
			PIXI.Texture.fromImage "./img/snake2.png" 
			PIXI.Texture.fromImage "./img/snake2.png" 
			PIXI.Texture.fromImage "./img/snake3.png" 
			PIXI.Texture.fromImage "./img/snake3.png" 
			PIXI.Texture.fromImage "./img/snake3.png" 
			PIXI.Texture.fromImage "./img/snake3.png" 
			PIXI.Texture.fromImage "./img/snake3.png" 
			PIXI.Texture.fromImage "./img/snake3.png" 
			PIXI.Texture.fromImage "./img/snake3.png" 
			PIXI.Texture.fromImage "./img/snake3.png" 
			PIXI.Texture.fromImage "./img/snake4.png" 
			PIXI.Texture.fromImage "./img/snake4.png" 
			PIXI.Texture.fromImage "./img/snake4.png" 
			PIXI.Texture.fromImage "./img/snake4.png" 
			PIXI.Texture.fromImage "./img/snake4.png" 
			PIXI.Texture.fromImage "./img/snake4.png" 
		]
		super(textures)

		@position.y = 0
		@position.x = 0
		@animationSpeed = 1

		@name = "monster"
		return


	update:(dt)->
		# @rotateTick += dt
		# if @rotateTick > 3000
		# 	@rotateTick = 0
		# 	@scale.x *= -1

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
		@stop
		anim = new MoneyAnimation(200, @area.position.x, @area.position.y)
		Game.instance.lineG += 200
		Game.stage.addChild(anim)

		@area.removeBuilding()
		TweenLite.killTweensOf(@scale)
		TweenLite.to(@scale,.4,{x:0.8,y:0.8,ease:Back.easeIn})
		TweenLite.to(@,.4,{alpha:0, onComplete:@dispose})


	isDestroy:()->
		return life>0


	dispose:()->
		if @parent
			@parent.removeChild(@)
