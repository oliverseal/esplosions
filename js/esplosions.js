//# sourceMappingURL=esplosions.js.map
(function() {
  var Sparkline,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.esplosions = window.esplosions || {};

  esplosions.GroundZero = (function() {
    function GroundZero(canvasElement) {
      this.canvasElement = canvasElement;
      this.ctx = this.canvasElement.getContext('2d');
      this.tickProxy = this.tick.bind(this);
      this.tick(0);
      this.lastReportIndex = 0;
      this.reports = {};
    }

    GroundZero.prototype.addReport = function(report) {
      this.lastReportIndex++;
      report.id = this.lastReportIndex;
      return this.reports[this.lastReportIndex.toString()] = report;
    };

    GroundZero.prototype.tick = function(t) {
      var id, report, _ref, _results;
      requestAnimationFrame(this.tickProxy);
      this.ctx.clearRect(0, 0, this.canvasElement.width, this.canvasElement.height);
      _ref = this.reports;
      _results = [];
      for (id in _ref) {
        report = _ref[id];
        _results.push(report.draw(this.ctx));
      }
      return _results;
    };

    return GroundZero;

  })();

  esplosions.Esplosion = (function() {

    /* The big bad base class */
    function Esplosion(point, options) {
      this.point = point;
      this.options = options != null ? options : null;
      this.options = this.options || {};
      this.options.duration = this.options.duration || 30;
      this.options.repeatCount = this.options.repeatCount || 0;
      this.currentFrame = 0;
      this.currentIteration = 0;
      this.finished = false;
    }

    Esplosion.prototype.draw = function(ctx) {
      this.currentFrame++;
      if (this.currentFrame > this.options.duration) {
        if (this.currentIteration >= this.options.repeatCount) {
          return this.finished = true;
        } else {
          this.currentFrame = 0;
          return this.currentIteration++;
        }
      }
    };

    return Esplosion;

  })();

  Sparkline = (function() {
    function Sparkline(spark, angle, thickness, startRadius, endRadius, duration) {
      this.spark = spark;
      this.angle = angle;
      this.thickness = thickness;
      this.startRadius = startRadius;
      this.endRadius = endRadius;
      this.duration = duration;
      this.spark.lines.push(this);
      this.currentFrame = 0;
      this.diffRadius = this.endRadius - this.startRadius;
    }

    Sparkline.prototype.draw = function(ctx) {
      var outerRadius, p, startRadius, x1, x2, y1, y2;
      if (this.currentFrame > this.duration) {
        return;
      }
      p = this.currentFrame / this.duration;
      startRadius = (this.endRadius * easypeasy.circularOut(p)) + this.startRadius;
      outerRadius = (this.endRadius * easypeasy.circularInOut(p)) + this.startRadius;
      x1 = this.spark.point.x + startRadius * Math.cos(this.angle);
      y1 = this.spark.point.y + startRadius * Math.sin(this.angle);
      x2 = this.spark.point.x + outerRadius * Math.cos(this.angle);
      y2 = this.spark.point.y + outerRadius * Math.sin(this.angle);
      ctx.strokeStyle = this.spark.options.color;
      ctx.lineWidth = this.thickness;
      ctx.beginPath();
      ctx.moveTo(x1, y1);
      ctx.lineTo(x2, y2);
      ctx.closePath();
      ctx.stroke();
      return this.currentFrame++;
    };

    return Sparkline;

  })();

  esplosions.Spark1 = (function(_super) {
    __extends(Spark1, _super);


    /* Circle and lines simultaneouysly */

    function Spark1(point, options) {
      var baseRadius, sparkline1, sparkline2, sparkline3, sparkline4;
      this.point = point;
      this.options = options;
      Spark1.__super__.constructor.call(this, this.point, this.options);
      this.options.size = this.options.size || 75;
      this.options.thickness = this.options.thickness || 4;
      this.options.rotationOffset = this.options.rotationOffset || 0;
      this.lines = [];
      baseRadius = this.options.size * 0.33;
      sparkline1 = new Sparkline(this, 2.17 + this.options.rotationOffset, this.options.thickness, baseRadius, (this.options.size * 0.38) - baseRadius, this.options.duration);
      sparkline2 = new Sparkline(this, 5.42 + this.options.rotationOffset, this.options.thickness, baseRadius, this.options.size - baseRadius, this.options.duration);
      sparkline3 = new Sparkline(this, 3.96 + this.options.rotationOffset, this.options.thickness, baseRadius, (this.options.size * 0.85) - baseRadius, this.options.duration);
      sparkline4 = new Sparkline(this, 0.85 + this.options.rotationOffset, this.options.thickness, this.options.size * 0.65, this.options.size - this.options.size * 0.65, this.options.duration);
      this.circleStart = 1;
      this.circleDiff = (this.options.size * 0.85) - this.circleStart;
      this.circleThickness = this.options.size * 0.08;
    }

    Spark1.prototype.draw = function(ctx) {
      var line, p, radius, thickness, _i, _len, _ref;
      Spark1.__super__.draw.call(this, ctx);
      if (!this.finished) {
        ctx.fillStyle = this.options.color;
        _ref = this.lines;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          line = _ref[_i];
          line.draw(ctx);
        }
        p = this.currentFrame / this.options.duration;
        thickness = Math.floor(this.circleThickness - (this.circleThickness * easypeasy.circularInOut(p)));
        radius = (this.circleDiff * easypeasy.circularInOut(p)) + this.circleStart;
        ctx.strokeStyle = this.options.color;
        ctx.lineWidth = thickness;
        ctx.beginPath();
        ctx.arc(this.point.x, this.point.y, radius, 0, M_TAU);
        ctx.closePath();
        return ctx.stroke();
      }
    };

    return Spark1;

  })(esplosions.Esplosion);

  esplosions.Spark2 = (function(_super) {
    __extends(Spark2, _super);


    /* Circle, then lines */

    function Spark2(point, options) {
      var baseRadius, halfDuration, sparkline1, sparkline2, sparkline3, sparkline4, sparkline5, sparkline6;
      this.point = point;
      this.options = options;
      Spark2.__super__.constructor.call(this, this.point, this.options);
      this.options.size = this.options.size || 75;
      this.options.thickness = this.options.thickness || 4;
      this.options.rotationOffset = this.options.rotationOffset || 0;
      this.lines = [];
      halfDuration = Math.floor(this.options.duration / 2);
      baseRadius = this.options.size * 0.35;
      sparkline1 = new Sparkline(this, (1.04 * 1) + this.options.rotationOffset, this.options.thickness, baseRadius, (this.options.size * 0.42) - baseRadius, halfDuration);
      sparkline2 = new Sparkline(this, (1.04 * 2) + this.options.rotationOffset, this.options.thickness, baseRadius, this.options.size - baseRadius, halfDuration);
      sparkline3 = new Sparkline(this, (1.04 * 3) + this.options.rotationOffset, this.options.thickness, baseRadius, this.options.size - baseRadius, halfDuration);
      sparkline4 = new Sparkline(this, (1.04 * 4) + this.options.rotationOffset, this.options.thickness, baseRadius, (this.options.size * 0.85) - baseRadius, halfDuration);
      sparkline5 = new Sparkline(this, (1.04 * 5) + this.options.rotationOffset, this.options.thickness, baseRadius, (this.options.size * 0.85) - baseRadius, halfDuration);
      sparkline6 = new Sparkline(this, (1.04 * 6) + this.options.rotationOffset, this.options.thickness, this.options.size * 0.65, this.options.size - this.options.size * 0.65, halfDuration);
      this.circleStart = 1;
      this.circleDiff = (this.options.size * 0.33) - this.circleStart;
      this.circleThickness = this.options.size * 0.08;
    }

    Spark2.prototype.draw = function(ctx) {
      var line, p, radius, thickness, _i, _len, _ref, _results;
      Spark2.__super__.draw.call(this, ctx);
      if (!this.finished) {
        ctx.fillStyle = this.options.color;
        p = this.currentFrame / this.options.duration;
        if (p < 0.5) {
          p = p * 2;
          radius = (this.circleDiff * easypeasy.circularIn(p)) + this.circleStart;
          thickness = Math.floor(this.circleThickness - (this.circleThickness * easypeasy.circularIn(p)));
          ctx.strokeStyle = this.options.color;
          ctx.lineWidth = thickness;
          ctx.beginPath();
          ctx.arc(this.point.x, this.point.y, radius, 0, M_TAU);
          ctx.closePath();
          return ctx.stroke();
        } else {
          p = (p - 0.5) * 2;
          _ref = this.lines;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            line = _ref[_i];
            line.currentFrame = Math.floor(p * (this.options.duration / 2));
            _results.push(line.draw(ctx));
          }
          return _results;
        }
      }
    };

    return Spark2;

  })(esplosions.Esplosion);

}).call(this);
