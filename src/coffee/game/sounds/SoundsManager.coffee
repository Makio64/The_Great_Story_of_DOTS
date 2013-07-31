class SoundManager

	@instance		: new SoundManager()

	buffers 		: null
	sources 		: null
	gains			: null

	context			: null

	@advancedBrowser 		: false

	constructor:()->
		if SoundManager.instance then throw new Error("You can't create an instance of SoundManager")
	
		window.AudioContext = window.AudioContext || window.webkitAudioContext
		if window.AudioContext 
			@advancedBrowser = true

		if @advancedBrowser
			@context = new AudioContext()
		
		@buffers = {}
		@sources = {}
		@gains = {}
		return

	add:(buffer,id)->
		if !@advancedBrowser
			return

		@buffers[id] = buffer
		return

	play:(id,looped=false,newID)->

		if !@advancedBrowser
			return

		newID ?= id
		source = @context.createBufferSource()
		source.buffer = @buffers[id]
		source.connect(@context.destination)
		source.start(0)
		source.loop = looped;
		@sources[newID] = source;
		return source


	playWithVolume:(id,volume)->
		source = @context.createBufferSource()
		source.buffer = @buffers[id]
		gainNode = @context.createGain()
		gainNode.connect(@context.destination)
		gainNode.gain.value = volume
		source.connect(gainNode)
		source.start(0)
		return source

	getSource:(id)->
		if !@advancedBrowser
			return

		return @sources[id]

	addGain:(gain,id)->
		@gains[id] = gain
		return

	getGain:(id)->
		if !@advancedBrowser
			return

		return @gains[id]