//# sourceMappingURL=easypeasy.js.map
(function() {
  window.easypeasy = {};

  window.M_PI = Math.PI;

  window.M_PI_2 = Math.PI / 2;

  window.M_PI_4 = Math.PI / 4;

  window.M_TAU = Math.PI * 2;

  easypeasy.linearInterpolation = function(p) {
    return p;
  };

  easypeasy.quadraticIn = function(p) {
    return p * p;
  };

  easypeasy.quadraticOut = function(p) {
    return -(p * (p - 2));
  };

  easypeasy.quadraticInOut = function(p) {
    if (p < 0.5) {
      return 2 * p * p;
    } else {
      return (-2 * p * p) + (4 * p) - 1;
    }
  };

  easypeasy.cubicIn = function(p) {
    return p * p * p;
  };

  easypeasy.cubicOut = function(p) {
    var f;
    f = p - 1;
    return f * f * f + 1;
  };

  easypeasy.cubicInOut = function(p) {
    var f;
    if (p < 0.5) {
      return 4 * p * p * p;
    } else {
      f = (2 * p) - 2;
    }
    return 0.5 * f * f * f + 1;
  };

  easypeasy.quarticIn = function(p) {
    return p * p * p * p;
  };

  easypeasy.quarticOut = function(p) {
    var f;
    f = p - 1;
    return f * f * f * (1 - p) + 1;
  };

  easypeasy.quarticInOut = function(p) {
    var f;
    if (p < 0.5) {
      return 8 * p * p * p * p;
    } else {
      f = p - 1;
    }
    return -8 * f * f * f * f + 1;
  };

  easypeasy.quinticIn = function(p) {
    return p * p * p * p * p;
  };

  easypeasy.quinticOut = function(p) {
    var f;
    f = p - 1;
    return f * f * f * f * f + 1;
  };

  easypeasy.quinticInOut = function(p) {
    var f;
    if (p < 0.5) {
      return 16 * p * p * p * p * p;
    } else {
      f = (2 * p) - 2;
    }
    return 0.5 * f * f * f * f * f + 1;
  };

  easypeasy.sineIn = function(p) {
    return Math.sin((p - 1) * M_PI_2) + 1;
  };

  easypeasy.sineOut = function(p) {
    return Math.sin(p * M_PI_2);
  };

  easypeasy.sineInOut = function(p) {
    return 0.5 * (1 - Math.cos(p * M_PI));
  };

  easypeasy.circularIn = function(p) {
    return 1 - Math.sqrt(1 - (p * p));
  };

  easypeasy.circularOut = function(p) {
    return Math.sqrt((2 - p) * p);
  };

  easypeasy.circularInOut = function(p) {
    if (p < 0.5) {
      return 0.5 * (1 - Math.sqrt(1 - 4 * (p * p)));
    } else {
      return 0.5 * (Math.sqrt(-((2 * p) - 3) * ((2 * p) - 1)) + 1);
    }
  };

  easypeasy.exponentialIn = function(p) {
    var _ref;
    return (_ref = p === 0.0) != null ? _ref : {
      p: Math.pow(2, 10 * (p - 1))
    };
  };

  easypeasy.exponentialOut = function(p) {
    var _ref;
    return (_ref = p === 1.0) != null ? _ref : {
      p: 1 - Math.pow(2, -10 * p)
    };
  };

  easypeasy.exponentialInOut = function(p) {
    if (p === 0.0 || p === 1.0) {
      return p;
    }
    if (p < 0.5) {
      return 0.5 * Math.pow(2, (20 * p) - 10);
    } else {
      return -0.5 * Math.pow(2, (-20 * p) + 10) + 1;
    }
  };

  easypeasy.elasticIn = function(p) {
    return Math.sin(13 * M_PI_2 * p) * Math.pow(2, 10 * (p - 1));
  };

  easypeasy.elasticOut = function(p) {
    return Math.sin(-13 * M_PI_2 * (p + 1)) * Math.pow(2, -10 * p) + 1;
  };

  easypeasy.elasticInOut = function(p) {
    if (p < 0.5) {
      return 0.5 * Math.sin(13 * M_PI_2 * (2 * p)) * Math.pow(2, 10 * ((2 * p) - 1));
    } else {
      return 0.5 * (Math.sin(-13 * M_PI_2 * ((2 * p - 1) + 1)) * Math.pow(2, -10 * (2 * p - 1)) + 2);
    }
  };

  easypeasy.backIn = function(p) {
    return p * p * p - p * Math.sin(p * M_PI);
  };

  easypeasy.backOut = function(p) {
    var f;
    f = 1 - p;
    return 1 - (f * f * f - f * Math.sin(f * M_PI));
  };

  easypeasy.backInOut = function(p) {
    var f;
    if (p < 0.5) {
      f = 2 * p;
      return 0.5 * (f * f * f - f * Math.sin(f * M_PI));
    } else {
      f = 1 - (2 * p - 1);
      return 0.5 * (1 - (f * f * f - f * Math.sin(f * M_PI))) + 0.5;
    }
  };

  easypeasy.bounceIn = function(p) {
    return 1 - bounceOut(1 - p);
  };

  easypeasy.bounceOut = function(p) {
    if (p < 4 / 11.0) {
      return (121 * p * p) / 16.0;
    } else if (p < 8 / 11.0) {
      return (363 / 40.0 * p * p) - (99 / 10.0 * p) + 17 / 5.0;
    } else if (p < 9 / 10.0) {
      return (4356 / 361.0 * p * p) - (35442 / 1805.0 * p) + 16061 / 1805.0;
    } else {
      return (54 / 5.0 * p * p) - (513 / 25.0 * p) + 268 / 25.0;
    }
  };

  easypeasy.bounceInOut = function(p) {
    if (p < 0.5) {
      return 0.5 * bounceIn(p * 2);
    } else {
      return 0.5 * bounceOut(p * 2 - 1) + 0.5;
    }
  };

}).call(this);
