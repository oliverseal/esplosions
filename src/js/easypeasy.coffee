#
#  easing.c
#
#  Copyright (c) 2011, Auerhaus Development, LLC
#
#  This program is free software. It comes without any warranty, to
#  the extent permitted by applicable law. You can redistribute it
#  and/or modify it under the terms of the Do What The Fuck You Want
#  To Public License, Version 2, as published by Sam Hocevar. See
#  http://sam.zoy.org/wtfpl/COPYING for more details.
#
window.easypeasy = {}
window.M_PI = Math.PI
window.M_PI_2 = Math.PI/2
window.M_PI_4 = Math.PI/4
window.M_TAU = Math.PI*2

# Modeled after the line y = x
easypeasy.linearInterpolation = (p) ->
  return p

# Modeled after the parabola y = x^2
easypeasy.quadraticIn = (p) ->
  return p * p

# Modeled after the parabola y = -x^2 + 2x
easypeasy.quadraticOut = (p) ->
  return -(p * (p - 2))

# Modeled after the piecewise quadratic
# y = (1/2)((2x)^2)              [0, 0.5)
# y = -(1/2)((2x-1)*(2x-3) - 1)  [0.5, 1]
easypeasy.quadraticInOut = (p) ->
  if(p < 0.5)
    return 2 * p * p
  else
    return (-2 * p * p) + (4 * p) - 1

# Modeled after the cubic y = x^3
easypeasy.cubicIn = (p) ->
  return p * p * p

# Modeled after the cubic y = (x - 1)^3 + 1
easypeasy.cubicOut = (p) ->
  f = (p - 1)
  return f * f * f + 1

# Modeled after the piecewise cubic
# y = (1/2)((2x)^3)        [0, 0.5)
# y = (1/2)((2x-2)^3 + 2)  [0.5, 1]
easypeasy.cubicInOut = (p) ->
  if(p < 0.5)
    return 4 * p * p * p
  else
    f = ((2 * p) - 2)
  return 0.5 * f * f * f + 1

# Modeled after the quartic x^4
easypeasy.quarticIn = (p) ->
  return p * p * p * p

# Modeled after the quartic y = 1 - (x - 1)^4
easypeasy.quarticOut = (p) ->
  f = (p - 1)
  return f * f * f * (1 - p) + 1

# Modeled after the piecewise quartic
# y = (1/2)((2x)^4)         [0, 0.5)
# y = -(1/2)((2x-2)^4 - 2)  [0.5, 1]
easypeasy.quarticInOut = (p)  ->
  if(p < 0.5)
    return 8 * p * p * p * p
  else
    f = (p - 1)
  return -8 * f * f * f * f + 1

# Modeled after the quintic y = x^5
easypeasy.quinticIn = (p)  ->
  return p * p * p * p * p

# Modeled after the quintic y = (x - 1)^5 + 1
easypeasy.quinticOut = (p)  ->
  f = (p - 1)
  return f * f * f * f * f + 1

# Modeled after the piecewise quintic
# y = (1/2)((2x)^5)        [0, 0.5)
# y = (1/2)((2x-2)^5 + 2)  [0.5, 1]
easypeasy.quinticInOut = (p)  ->
  if(p < 0.5)
    return 16 * p * p * p * p * p
  else
    f = ((2 * p) - 2)
  return  0.5 * f * f * f * f * f + 1

# Modeled after quarter-cycle of sine wave
easypeasy.sineIn = (p) ->
  return Math.sin((p - 1) * M_PI_2) + 1

# Modeled after quarter-cycle of sine wave (different phase)
easypeasy.sineOut = (p) ->
  return Math.sin(p * M_PI_2)

# Modeled after half sine wave
easypeasy.sineInOut = (p) ->
  return 0.5 * (1 - Math.cos(p * M_PI))

# Modeled after shifted quadrant IV of unit circle
easypeasy.circularIn = (p) ->
  return 1 - Math.sqrt(1 - (p * p))

# Modeled after shifted quadrant II of unit circle
easypeasy.circularOut = (p) ->
  return Math.sqrt((2 - p) * p)

# Modeled after the piecewise circular function
# y = (1/2)(1 - Math.sqrt(1 - 4x^2))            [0, 0.5)
# y = (1/2)(Math.sqrt(-(2x - 3)*(2x - 1)) + 1)  [0.5, 1]
easypeasy.circularInOut = (p) ->
  if(p < 0.5)
    return 0.5 * (1 - Math.sqrt(1 - 4 * (p * p)))
  else
    return 0.5 * (Math.sqrt(-((2 * p) - 3) * ((2 * p) - 1)) + 1)

# Modeled after the exponential function y = 2^(10(x - 1))
easypeasy.exponentialIn = (p) ->
  return (p == 0.0) ? p : Math.pow(2, 10 * (p - 1))

# Modeled after the exponential function y = -2^(-10x) + 1
easypeasy.exponentialOut = (p) ->
  return (p == 1.0) ? p : 1 - Math.pow(2, -10 * p)

# Modeled after the piecewise exponential
# y = (1/2)2^(10(2x - 1))          [0,0.5)
# y = -(1/2)*2^(-10(2x - 1))) + 1  [0.5,1]
easypeasy.exponentialInOut = (p) ->
  if(p == 0.0 || p == 1.0) then return p

  if(p < 0.5)
    return 0.5 * Math.pow(2, (20 * p) - 10)
  else
    return -0.5 * Math.pow(2, (-20 * p) + 10) + 1

# Modeled after the damped sine wave y = Math.sin(13pi/2*x)*Math.pow(2, 10 * (x - 1))
easypeasy.elasticIn = (p) ->
  return Math.sin(13 * M_PI_2 * p) * Math.pow(2, 10 * (p - 1))

# Modeled after the damped sine wave y = Math.sin(-13pi/2*(x + 1))*Math.pow(2, -10x) + 1
easypeasy.elasticOut = (p) ->
  return Math.sin(-13 * M_PI_2 * (p + 1)) * Math.pow(2, -10 * p) + 1

# Modeled after the piecewise exponentially-damped sine wave:
# y = (1/2)*Math.sin(13pi/2*(2*x))*Math.pow(2, 10 * ((2*x) - 1))       [0,0.5)
# y = (1/2)*(Math.sin(-13pi/2*((2x-1)+1))*Math.pow(2,-10(2*x-1)) + 2)  [0.5, 1]
easypeasy.elasticInOut = (p) ->
  if(p < 0.5)
    return 0.5 * Math.sin(13 * M_PI_2 * (2 * p)) * Math.pow(2, 10 * ((2 * p) - 1))
  else
    return 0.5 * (Math.sin(-13 * M_PI_2 * ((2 * p - 1) + 1)) * Math.pow(2, -10 * (2 * p - 1)) + 2)

# Modeled after the overshooting cubic y = x^3-x*Math.sin(x*pi)
easypeasy.backIn = (p) ->
  return p * p * p - p * Math.sin(p * M_PI)

# Modeled after overshooting cubic y = 1-((1-x)^3-(1-x)*Math.sin((1-x)*pi))
easypeasy.backOut = (p) ->
  f = (1 - p)
  return 1 - (f * f * f - f * Math.sin(f * M_PI))

# Modeled after the piecewise overshooting cubic function:
# y = (1/2)*((2x)^3-(2x)*Math.sin(2*x*pi))            [0, 0.5)
# y = (1/2)*(1-((1-x)^3-(1-x)*Math.sin((1-x)*pi))+1)  [0.5, 1]
easypeasy.backInOut = (p) ->
  if(p < 0.5)
    f = 2 * p
    return 0.5 * (f * f * f - f * Math.sin(f * M_PI))
  else
    f = (1 - (2*p - 1))
    return 0.5 * (1 - (f * f * f - f * Math.sin(f * M_PI))) + 0.5

easypeasy.bounceIn = (p) ->
  return 1 - bounceOut(1 - p)

easypeasy.bounceOut = (p) ->
  if(p < 4/11.0)
    return (121 * p * p)/16.0
  else if(p < 8/11.0)
    return (363/40.0 * p * p) - (99/10.0 * p) + 17/5.0
  else if(p < 9/10.0)
    return (4356/361.0 * p * p) - (35442/1805.0 * p) + 16061/1805.0
  else
    return (54/5.0 * p * p) - (513/25.0 * p) + 268/25.0

easypeasy.bounceInOut = (p) ->
  if(p < 0.5)
    return 0.5 * bounceIn(p*2)
  else
    return 0.5 * bounceOut(p * 2 - 1) + 0.5