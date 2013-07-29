class AMobile extends PIXI.Sprite

	position 		: null
	owner			: null
	line			: null
	state 			: 0
	destination		: null
	speed 			: 0.1
	shadow 			: null
	damage 			: 1

	constructor:( texture, owner )->
		super texture

		@shadow =  new Shadow(@)
		Game.stage.addChild(@shadow)
		@owner = owner
		@line = []
		@state = MobileState.Waiting
		return

	update:(dt)->
		# attacking, do nothing
		if @isDie() or @isAttacking()
			return

		# move
		if @destination != null
			@move(dt)
			if @shadow
				@shadow.update()

			ennemy = @ennemyInZone()
			if ennemy
				@attackEnnemy(ennemy)
				return

			area = Game.instance.areaAtPosition(@position.x,@position.y) 
			if area != null and area.building != null and area.building.owner != @owner
				@attackArea(area)
				return
		
		# next move
		else if @line.length > 0
			@destination = @line.splice(0,1)[0]
			@update(dt)

		# last move
		else if @state == MobileState.Moving
			@onDie()

		return

	isWaiting:()->
		return @state & MobileState.Waiting

	isAttacking:()->
		return @state & MobileState.Attacking

	isDie:()->
		return @state & MobileState.Die

	attackArea:(area)->
		@line = []
		@state = MobileState.Attacking
		if @shadow
			@shadow.destroy()
			@shadow = null
		TweenLite.to(@position,.15,{x:area.position.x,y:area.position.y-area.building.height})
		TweenLite.to(@position,.15,{delay:.15,x:area.position.x,y:area.position.y,onComplete:@onAttackComplete})
		return

	ennemyInZone:()->
		for mobile in Game.instance.mobiles
			if mobile.owner != @owner and HitTest.testCircle(@position,mobile,10)
				return mobile
		return null

	attackEnnemy:(ennemy)->
		@onDie()
		ennemy.onDie()
		battle = BattlePool.getInstance().checkOut()
		battle.position.x = @position.x
		battle.visible = true;
		battle.position.y = @position.y
		battle.gotoAndPlay(0)
		battle.play()
		Game.stage.addChild battle

		return

	moveTo:(x,y)->
		@state = MobileState.Moving
		@destination = {x,y}
		return

	move:(dt)->

		speedDT = @speed*dt
		
		while speedDT > 0

			moveX = Math.max(Math.min(@destination.x-@position.x,speedDT),-speedDT)
			moveY = Math.max(Math.min(@destination.y-@position.y,speedDT),-speedDT)
			
			@position.x += moveX
			@position.y += moveY
			
			if Game.instance.map.isWater(Math.floor(@position.x/8),Math.floor(@position.y/8))
				if Math.random() > .95
					@onDie()
				
			
			distance = Math.abs(moveX) + Math.abs(moveY)
			speedDT -= distance 
				
			if @position.x == @destination.x and @position.y == @destination.y
				if @line.length > 0 and speedDT > 0
					@destination = @line.splice(0,1)[0]
				else 
					@destination = null
					break
		return
	
	followLine:(line)->
		@state = MobileState.Moving
		@line = line.clone()
		@isWaiting = false
		return

	stop:()->
		@destination = null
		return

	onAttackComplete:()=>
		area = Game.instance.areaAtPosition(@position.x,@position.y) 
		
		if area.building == null #already destroyed
			@onDie()
			return

		else #damage
			area.building.damage(@damage)

		if area.building == null #destroyed by attack
			@castle.removeLine()
		
		@onDie()

	onDie:()=>
		if @state & MobileState.Die
			return
		
		if @shadow != null
			@shadow.destroy()
			@shadow = null
		
		@state += MobileState.Die
		@castle.removeUnit(@)
		Game.instance.removeMobile(@)
		return

class MobileState

	@Waiting 		: 0x000001
	@Moving 		: 0x000002
	@Attacking 		: 0x000004
	@Sleeping 		: 0x000008
	@Die 			: 0x000010
