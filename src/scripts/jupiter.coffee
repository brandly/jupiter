el = document.getElementById 'jupiter'
width = window.innerWidth
height = window.innerHeight

# make a square that fits centered onscreen
if height > width
  height = width
else
  width = height

el.width = width
el.height = height
el.style.width = width
el.style.height = height

jupiter =  el.getContext '2d'
jupiter.lineWidth = .7

# from the right-hand side, top down
colors = [
  '#4FA8D8'
  '#2F629E'
  '#E77D2E'
  '#CF5B52'
  '#762643'
  '#412F21'
  '#7F9752'
  '#F9700F'
  '#FF5601'
  '#913700'
  '#4C5076'
  '#53ADD0'
  '#8BBB33'
  '#405932'
  '#D0BB5E'
  '#ACB3A1'
  '#4C5076'
  # ------
  '#4AAADC'
  '#2E629C'
  '#C95E52'
  '#D0BB5E'
  '#DA5B66'
  '#AB7D4C'
  '#8BBB31'
  '#5C9200'
  '#FFCD1E'
  '#FF5601'
  '#78B8DB'
  '#2F639C'
  '#ABB4A3'
  '#7FA14B'
  '#4BAADA'
  '#695F51'
  '#6E2A43'
  '#FFC700'
  '#C49A9A'
]

randomNumber = (max) ->
  Math.floor(Math.random() * max)

randomColor = ->
  colors[randomNumber colors.length]

beginTriangle = ({a, b, c, color}, fill = false) ->
  jupiter.fillStyle = color
  jupiter.beginPath()
  jupiter.moveTo a.x, a.y
  jupiter.lineTo b.x, b.y
  jupiter.lineTo c.x, c.y
  jupiter.lineTo a.x, a.y

triangleBorder = (options) ->
  beginTriangle options
  jupiter.stroke()

triangeFill = (options) ->
  beginTriangle options
  jupiter.closePath()
  jupiter.fill()

drawPatch = (options) ->
  # draw the colored triangle
  triangeFill options
  # and the border around it
  {a, b, c} = options
  triangleBorder {a, b, c, color: '#000'}

triangleHeight  = height / 36
midX = width / 2

drawHalfJupiter = (side) ->
  # `a` is the stationary point the entire side is "pointing" to.
  # `b` and `c` maintain a constant `x` coord, but each move their `y` by a
  # fixed factor of `triangleHeight`.
  a = x: null, y: (height / 2)
  b = x: midX, y: 0
  c = x: midX, y: triangleHeight

  # assume 'right', if not 'left'
  a.x = if side is 'left' then 0 else width

  while c.y <= height
    drawPatch {a, b, c, color: randomColor()}
    b.y += triangleHeight
    c.y += triangleHeight

setInterval ->
  drawHalfJupiter 'left'
  drawHalfJupiter 'right'
, 200
