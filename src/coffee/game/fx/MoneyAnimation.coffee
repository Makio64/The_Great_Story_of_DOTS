class MoneyAnimation extends PIXI.DisplayObjectContainer

	constructor:(amount)->
		super

		if amount>0
			@bg = new PIXI.Sprite( PIXI.Texture.fromImage("./img/lineG_up_1fig.png"))
			@text = new PIXI.BitmapText( "+"+amount,  {font: "14px PMNCaeciliaLT", align: "right"} )
		else 
			@text = new PIXI.BitmapText( "-"+amount,  {font: "14px PMNCaeciliaLT", align: "right"} )
			@bg = new PIXI.Sprite( PIXI.Texture.fromImage("./img/lineG_down_3fig.png"))
		
		@text.position.x = 25
		@text.position.y = 5
		
		@alpha = 0
		@addChild(@bg)
		@addChild(@text)
		
		@position.y = -20
		if amount > 0
			@position.x = -30

		TweenLite.to(@,.2,{alpha:1})
		if amount>0
			TweenLite.to(@position,1,{y:-70})
		else
			TweenLite.to(@position,1,{y:30})

		TweenLite.to(@,.2,{alpha:0,delay:.8,onComplete:@dispose})
		return

	dispose:()->
		if @parent
			@parent.removeChild(@)