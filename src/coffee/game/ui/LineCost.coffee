class LineCost extends PIXI.DisplayObjectContainer

	text 		: null
	bg 			: null
	icon 		: null

	constructor:()->
		super

		
		@bg = new PIXI.Graphics()
		@bg.beginFill(0x9966ff,0.8)
		@bg.drawRect(0,0,40,20)
		@bg.endFill()

		@text = new PIXI.BitmapText( "0",  {font: "14px PMNCaeciliaLT", align: "left"} )
		@text.position.x = 10
		@text.position.y = 0
		
		@icon = new PIXI.Sprite( PIXI.Texture.fromImage "./img/lineG_icon.png" )
		@icon.position.x = 0
		@icon.position.y = 0

		@addChild(@bg)
		@addChild(@text)

		return


	remove:()->
		TweenLite.to(@,.2,{alpha:0})
		TweenLite.to(@scale,.2,{x:.8,y:.8,onComplete:@dispose})
		return

	setCost:(cost)->
		
		@text.setText(String(cost))
		return


	dispose:()->
		if @parent
			@parent.removeChild(@)
		return