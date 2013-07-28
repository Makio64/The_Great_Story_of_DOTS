TAN_HALF_PI = Math.tan(Math.PI/2)

vector = (x, y) ->
	x: x
	y: y

delta = (a, b) ->
	vector a.x - b.x, a.y - b.y

angle = (d) ->
	Math.atan (1.0 * d.y) / d.x

angle_between = (a, b) ->
	return Math.acos (a.x * b.x + a.y * b.y) / (len(a) * len(b))

len = (v) ->
	return Math.sqrt v.x * v.x + v.y * v.y

add = (a, b) ->
	return vector(a.x + b.x, a.y + b.y)

average = (l) ->
	x = 0
	y = 0
	i = 0

	while i < l.length
		x += l[i].x
		y += l[i].y
		i++
	
	return vector(x / l.length, y / l.length)

findCorner = (line) ->
	corners = [line[0]]
	lastCorner = line[0]

	for i in [1...line.length-1] by 1
		
		pt = line[i]
		d = delta(lastCorner, pt)

		if Math.abs(len(d)) > 10 
			ac = delta(pt, line[i+1])

			if Math.abs(angle_between(ac, d)) > Math.PI / 4
				pt.index = i
				corners.push pt
				lastCorner = pt

	corners.push(line[line.length-1])

	for i in [1..corners.length] by 1
		c = corners[i%corners.length]
		c2 = corners[i-1]
		if(Math.abs(c.x-c2.x)+Math.abs(c.y-c2.y))<30
			corners.splice(i-1,1);
			break

	return corners;

isTriangle = (corners) ->
	if corners.length != 3
		return false
	corners.sort((a,b)->
		return a.x < b.x
	)
	c0 = corners[0]
	c1 = corners[1]
	c2 = corners[2]
	if( c0.y > c1.y && c2.y > c1.y )
		return true
	return false

isSquare = (corners) ->
	
	if corners.length != 4
		return false

	corners.sort((a,b)->
		return a.x < b.x
	)

	if corners[0].y < corners[1].y
		c0 = corners[0] 
		corners[0] = corners[1]
		corners[1] = c0
	if corners[2].y < corners[3].y
		c2 = corners[2] 
		corners[2] = corners[3]
		corners[3] = c2
		
	c0 = corners[0]
	c1 = corners[1]
	c2 = corners[2]
	c3 = corners[3]

	tolerance = 25
	if( Math.abs(c0.x-c1.x) < tolerance && Math.abs(c2.x-c3.x) < tolerance )
		return true
	return false
