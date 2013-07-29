class LineGBox extends PIXI.DisplayObjectContainer

	sprite 			: null
	bg 				: null
	text 			: null
	icon 			: null

	constructor:()->
		super
		@bg = new PIXI.Graphics()
		@bg.beginFill(0,0.8)
		@bg.drawRect(0,0,80,28)
		@bg.endFill()

		@icon = new PIXI.Sprite( PIXI.Texture.fromImage "./img/lineG_icon_s.png" )
		@icon.anchor.x = .5
		@icon.anchor.y = .5

		@icon.position.x = 17
		@icon.position.y = 14

		@text = new PIXI.BitmapText( "0000",  {font: "14px PMNCaeciliaLT", align: "right"} )
		@text.position.x = 35
		@text.position.y = 8
		@addChild @bg
		@addChild @icon
		@addChild @text
		return

	update:()->
		@text.setText(NumberUtils.addZero(Math.floor(Game.instance.lineG),4))
		return

	spend:(amount)->

		msg = new MoneyAnimation()
		# msg.position.x = 0
		
		@addChild( msg )
		
		return
