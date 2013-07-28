class DisplayController

	@instance = new DisplayController()

	domElement				: null
	canvasElement 			: null

	constructor:()->
		if DisplayController.instance then throw new Error("You can t create an instance of DisplayController")
		return

	init:(@domElement, @canvasElement)->
		return

	display:(x,y,width,height,delay,scroll)->
		scroll?=true
		
		if scroll
			top = (window.innerHeight - height)/2 + $(@domElement).offset().top
			TweenLite.to($("body"), 1.5, { scrollTop:top,ease:Quad.easeOut, delay:delay})

		TweenLite.to(@domElement, .8, {width:width+"px",height:height+"px",delay:delay,ease:Quad.easeOut})
		TweenLite.to(@canvasElement, .8, {left:x+"px",top:y+"px",delay:delay,ease:Quad.easeOut})
		return