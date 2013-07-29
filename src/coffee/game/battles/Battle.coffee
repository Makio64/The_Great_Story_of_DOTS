class Battle extends PIXI.MovieClip

	constructor:()->
		textures = [
			new PIXI.Texture.fromImage "./img/attack_B01.png"
			new PIXI.Texture.fromImage "./img/attack_B02.png"
			new PIXI.Texture.fromImage "./img/attack_B03.png"
			new PIXI.Texture.fromImage "./img/attack_B04.png"
			new PIXI.Texture.fromImage "./img/attack_B05.png"
			new PIXI.Texture.fromImage "./img/attack_B06.png"
			new PIXI.Texture.fromImage "./img/attack_B07.png"
			new PIXI.Texture.fromImage "./img/attack_B08.png"
			new PIXI.Texture.fromImage "./img/attack_B09.png"
			new PIXI.Texture.fromImage "./img/attack_B10.png"
		]
		super textures
		@onComplete = @dispose
		@loop = false
		@gotoAndPlay(0)
		@animationSpeed = .25
		@anchor.x = .5
		@anchor.y = .5
		return

	dispose:()=>
		@stop()
		# @parent.updateTransform()
		# if @parent
		# 	@parent.removeChild(@)
		@visible = false
		BattlePool.getInstance().checkIn(@)


class BattlePool

	@instance : null

	@getInstance :()->
		if BattlePool.instance == null
			BattlePool.instance = new ObjectPool(
				()->
					return new Battle();
				,30,50)
		return BattlePool.instance
