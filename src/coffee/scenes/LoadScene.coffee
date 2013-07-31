class LoadScene extends AScene

	# Load image and readData

	image 				: null
	map 				: null
	

	constructor:(stage)->
		super(stage)
		return

	onEnter:()->
		assetsToLoader = ["./fonts/Number.fnt"];
		loader = new PIXI.AssetLoader(assetsToLoader)
		loader.onComplete = @onAssetsLoaded
		loader.load()
		return

	onAssetsLoaded:()=>
		if !window.IS_CHROME
			SceneTraveler.getInstance().travelTo(new GameScene(@stage))
			return

		@urlList = [
			"./sounds/construction.mp3"
			"./sounds/explosion.mp3"
			"./sounds/loop.mp3"
			"./sounds/victory.mp3"
			"./sounds/gameover.mp3"
			"./sounds/attack01.mp3"
			"./sounds/attack02.mp3"
			"./sounds/attack03.mp3"
			"./sounds/attack04.mp3"
			"./sounds/attack05.mp3"
			"./sounds/attack06.mp3"
			"./sounds/attack07.mp3"
			"./sounds/attack08.mp3"
			"./sounds/attack00.mp3"
		]
		
		@soundLoader = new BufferLoader(SoundManager.instance.context, @urlList, @onSoundLoaded);
		@soundLoader.load()
		return

	onSoundLoaded:()=>
		for i in [0...@urlList.length] by 1
			SoundManager.instance.add(@soundLoader.bufferList[i],@urlList[i])

		source = SoundManager.instance.play("./sounds/loop.mp3",true,"loop")
		source.disconnect(0)
		gainNode = SoundManager.instance.context.createGain()
		gainNode.connect(SoundManager.instance.context.destination)
		gainNode.gain.value = 0
		source.connect(gainNode)
		SoundManager.instance.addGain(gainNode,"loop")
		TweenLite.to(gainNode.gain,3,{value:.4})


		for i in [0..8] by 1
			source = SoundManager.instance.getSource("./sounds/attack0"+i+".mp3")

		SceneTraveler.getInstance().travelTo(new GameScene(@stage))