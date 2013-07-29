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
		SceneTraveler.getInstance().travelTo(new GameScene(@stage))
		return