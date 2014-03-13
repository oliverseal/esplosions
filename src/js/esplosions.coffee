window.esplosions = window.esplosions || {}

class esplosions.GroundZero
  constructor: (@canvasElement) ->
    # TODO: look into using something like Two.js
    @ctx = @canvasElement.getContext('2d');
    
    @tickProxy = @tick.bind(@)
    
    #always be animatin?
    @tick(0)
    
    @lastReportIndex = 0
    @reports = {}
    
  addReport: (report) ->
    @lastReportIndex++
    report.id = @lastReportIndex
    @reports[@lastReportIndex.toString()] = report
    
  tick: (t) ->
    requestAnimationFrame(@tickProxy)
    @ctx.clearRect(0, 0, @canvasElement.width, @canvasElement.height)
    
    for id, report of @reports
      report.draw(@ctx)
    
    

class esplosions.Esplosion
  ### The big bad base class ###
  constructor: (@point, @options=null) ->
    #id should be set by GroundZero
    @options = @options || {}
    # in fps
    @options.duration = @options.duration || 30
    @options.repeatCount = @options.repeatCount || 0
    @currentFrame = 0
    @currentIteration = 0
    @finished = false
    
  draw: (ctx) ->
    #increments frames
    @currentFrame++
    if @currentFrame > @options.duration
      if @currentIteration >= @options.repeatCount
        @finished = true
      else
        @currentFrame = 0
        @currentIteration++
    

class Sparkline
  constructor: (@spark, @angle, @thickness, @startRadius, @endRadius, @duration) ->
    @spark.lines.push(@)
    @currentFrame = 0
    @diffRadius = @endRadius - @startRadius
    
  draw: (ctx) ->
    if @currentFrame > @duration
      return
    p = @currentFrame/@duration
    startRadius = (@endRadius * easypeasy.circularOut(p)) + @startRadius
    outerRadius = (@endRadius * easypeasy.circularInOut(p)) + @startRadius
    
    x1 = @spark.point.x + startRadius * Math.cos(@angle)
    y1 = @spark.point.y + startRadius * Math.sin(@angle)
    x2 = @spark.point.x + outerRadius * Math.cos(@angle)
    y2 = @spark.point.y + outerRadius * Math.sin(@angle)
    #draw it
    ctx.strokeStyle = @spark.options.color
    ctx.lineWidth = @thickness
    ctx.beginPath()
    ctx.moveTo(x1, y1)
    ctx.lineTo(x2, y2)
    ctx.closePath()
    ctx.stroke()
    
    @currentFrame++
      

class esplosions.Spark1 extends esplosions.Esplosion
  ### Circle and lines simultaneouysly ###
  constructor: (@point, @options) ->
    super(@point, @options)
    @options.size = @options.size || 75
    @options.thickness = @options.thickness || 4
    @options.rotationOffset = @options.rotationOffset || 0
    @lines = []
    # 1 at 50deg
    baseRadius = @options.size * 0.33
    sparkline1 = new Sparkline(@, 2.17 + @options.rotationOffset, @options.thickness, baseRadius, (@options.size * 0.38) - baseRadius, @options.duration)
    sparkline2 = new Sparkline(@, 5.42 + @options.rotationOffset, @options.thickness, baseRadius, (@options.size) - baseRadius, @options.duration)
    sparkline3 = new Sparkline(@, 3.96 + @options.rotationOffset, @options.thickness, baseRadius, (@options.size * 0.85) - baseRadius, @options.duration)
    sparkline4 = new Sparkline(@, 0.85 + @options.rotationOffset, @options.thickness, @options.size * 0.65, @options.size - @options.size * 0.65, @options.duration)
    
    @circleStart = 1
    @circleDiff = (@options.size * 0.85) - @circleStart
    @circleThickness = @options.size * 0.08
      
  draw: (ctx) ->
    super(ctx)
    if not @finished
      ctx.fillStyle = @options.color
      for line in @lines
        line.draw(ctx)
        
      # draw the circle
      p = (@currentFrame / @options.duration)
      #if p > 0.5
      #p = (p-0.5)*2
      thickness = Math.floor(@circleThickness - (@circleThickness * easypeasy.circularInOut(p)))
      radius = (@circleDiff * easypeasy.circularInOut(p)) + @circleStart
      
      ctx.strokeStyle = @options.color
      ctx.lineWidth = thickness
      ctx.beginPath()
      ctx.arc(@point.x, @point.y, radius, 0, M_TAU)
      ctx.closePath()
      ctx.stroke()
  
  
      
class esplosions.Spark2 extends esplosions.Esplosion
  ### Circle, then lines ###
  constructor: (@point, @options) ->
    super(@point, @options)
    @options.size = @options.size || 75
    @options.thickness = @options.thickness || 4
    @options.rotationOffset = @options.rotationOffset || 0
    @lines = []
    # 1 at 50deg
    halfDuration = Math.floor(@options.duration/2)
    baseRadius = @options.size * 0.35
    sparkline1 = new Sparkline(@, (1.04*1) + @options.rotationOffset, @options.thickness, baseRadius, (@options.size * 0.42) - baseRadius, halfDuration)
    sparkline2 = new Sparkline(@, (1.04*2) + @options.rotationOffset, @options.thickness, baseRadius, (@options.size) - baseRadius, halfDuration)
    sparkline3 = new Sparkline(@, (1.04*3) + @options.rotationOffset, @options.thickness, baseRadius, (@options.size) - baseRadius, halfDuration)
    sparkline4 = new Sparkline(@, (1.04*4) + @options.rotationOffset, @options.thickness, baseRadius, (@options.size * 0.85) - baseRadius, halfDuration)
    sparkline5 = new Sparkline(@, (1.04*5) + @options.rotationOffset, @options.thickness, baseRadius, (@options.size * 0.85) - baseRadius, halfDuration)
    sparkline6 = new Sparkline(@, (1.04*6) + @options.rotationOffset, @options.thickness, @options.size * 0.65, @options.size - @options.size * 0.65, halfDuration)
    
    @circleStart = 1
    @circleDiff = (@options.size * 0.33) - @circleStart
    @circleThickness = @options.size * 0.08
      
  draw: (ctx) ->
    super(ctx)
    if not @finished
      ctx.fillStyle = @options.color
        
      # draw the circle
      p = (@currentFrame / @options.duration)
      
      if p < 0.5
        p = p*2
        radius = (@circleDiff * easypeasy.circularIn(p)) + @circleStart
        thickness = Math.floor(@circleThickness - (@circleThickness * easypeasy.circularIn(p)))
          
        ctx.strokeStyle = @options.color
        ctx.lineWidth = thickness
        ctx.beginPath()
        ctx.arc(@point.x, @point.y, radius, 0, M_TAU)
        ctx.closePath()
        ctx.stroke()
      else
        p = (p-0.5)*2
        for line in @lines
          line.currentFrame = Math.floor(p*(@options.duration/2))
          line.draw(ctx)
      
      
      