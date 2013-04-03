// Generated by CoffeeScript 1.6.2
var Polygon;

Polygon = (function() {
  function Polygon(r) {
    var controls, dashed, linecurve, path;

    this.r = r;
    dashed = {
      fill: "#F99",
      stroke: "#666",
      "stroke-dasharray": "- "
    };
    controls = void 0;
    path = void 0;
    linecurve = void 0;
  }

  Polygon.prototype.movePoint = function(dx, dy) {
    this.update(dx - (this.dx || 0), dy - (this.dy || 0));
    this.dx = dx;
    this.dy = dy;
  };

  Polygon.prototype.move = function(dx, dy) {
    this.translate(dx - this.dx, dy - this.dy);
    this.dx = dx;
    return this.dy = dy;
  };

  Polygon.prototype.up = function() {
    this.dx = this.dy = 0;
    this.animate({
      "fill-opacity": 1
    }, 500);
  };

  Polygon.prototype.start = function() {
    this.odx = 0;
    this.ody = 0;
    this.animate({
      "fill-opacity": 0.2
    }, 500);
  };

  Polygon.prototype.curve = function(color) {
    var ax, ay, cx, cy, path, x, y, zx, zy;

    x = this.bezier[0];
    y = this.bezier[1];
    ax = this.bezier[2];
    ay = this.bezier[3];
    cx = this.bezier[4];
    cy = this.bezier[5];
    zx = this.bezier[6];
    zy = this.bezier[7];
    path = [["M", x, y], ["C", ax, ay, cx, cy, zx, zy]];
    this.linecurve = this.r.path(path).attr({
      stroke: color || this.raphael.getColor(),
      "stroke-width": 4,
      "stroke-linecap": "round"
    });
    this.edit();
  };

  Polygon.prototype.edit = function() {
    var ax, ay, controls, cx, cy, discattr, linecurve, path, path2, x, y, zx, zy;

    x = this.bezier[0];
    y = this.bezier[1];
    ax = this.bezier[2];
    ay = this.bezier[3];
    cx = this.bezier[4];
    cy = this.bezier[5];
    zx = this.bezier[6];
    zy = this.bezier[7];
    path = [["M", x, y], ["C", ax, ay, cx, cy, zx, zy]];
    path2 = [["M", x, y], ["L", ax, ay], ["M", cx, cy], ["L", zx, zy]];
    discattr = {
      fill: "#F99",
      stroke: "none"
    };
    controls = this.r.set(this.r.path(path2).attr({
      stroke: "#ccc",
      "stroke-dasharray": ". "
    }), this.r.circle(x, y, 5).attr(discattr), this.r.circle(ax, ay, 5).attr(discattr), this.r.circle(cx, cy, 5).attr(discattr), this.r.circle(zx, zy, 5).attr(discattr));
    this.controls = controls;
    linecurve = this.linecurve;
    controls[1].update = function(x, y) {
      var X, Y;

      X = this.attr("cx") + x;
      Y = this.attr("cy") + y;
      this.attr({
        cx: X,
        cy: Y
      });
      path[0][1] = X;
      path[0][2] = Y;
      path2[0][1] = X;
      path2[0][2] = Y;
      controls[2].update(x, y);
      '@bezier[0] = X\n@bezier[1] = Y';
    };
    controls[2].update = function(x, y) {
      var X, Y;

      X = this.attr("cx") + x;
      Y = this.attr("cy") + y;
      this.attr({
        cx: X,
        cy: Y
      });
      path[1][1] = X;
      path[1][2] = Y;
      path2[1][1] = X;
      path2[1][2] = Y;
      linecurve.attr({
        path: path
      });
      controls[0].attr({
        path: path2
      });
      '@bezier[2] = X\n@bezier[3] = Y';
    };
    controls[3].update = function(x, y) {
      var X, Y;

      X = this.attr("cx") + x;
      Y = this.attr("cy") + y;
      this.attr({
        cx: X,
        cy: Y
      });
      path[1][3] = X;
      path[1][4] = Y;
      path2[2][1] = X;
      path2[2][2] = Y;
      linecurve.attr({
        path: path
      });
      controls[0].attr({
        path: path2
      });
      '@bezier[4] = X\n@bezier[5] = Y';
    };
    controls[4].update = function(x, y) {
      var X, Y;

      X = this.attr("cx") + x;
      Y = this.attr("cy") + y;
      this.attr({
        cx: X,
        cy: Y
      });
      path[1][5] = X;
      path[1][6] = Y;
      path2[3][1] = X;
      path2[3][2] = Y;
      controls[3].update(x, y);
      '@bezier[6] = X\n\n@bezier[7] = Y';
    };
    controls.drag(this.movePoint, this.start, this.up);
    this.ft = this.r.freeTransform(this.path);
  };

  Polygon.prototype.add = function(points, bezier) {
    var l, lines, pathString, point, _i, _len;

    this.points = points;
    this.bezier = bezier;
    l = "M";
    lines = "";
    for (_i = 0, _len = points.length; _i < _len; _i++) {
      point = points[_i];
      lines += l + point[0] + "," + point[1] + " ";
      l = "L";
    }
    pathString = lines + "z";
    this.path = this.r.path(pathString);
    this.path.attr(this.dashed);
    this.curve("hsb(.1, .75, .75)");
    return this.path;
  };

  Polygon.prototype.noEdit = function() {
    this.ft.unplug();
    this.bezier[0] = this.controls[1].attr("cx");
    this.bezier[1] = this.controls[1].attr("cy");
    this.bezier[2] = this.controls[2].attr("cx");
    this.bezier[3] = this.controls[2].attr("cy");
    this.bezier[4] = this.controls[3].attr("cx");
    this.bezier[5] = this.controls[3].attr("cy");
    this.bezier[6] = this.controls[4].attr("cx");
    this.bezier[7] = this.controls[4].attr("cy");
    return this.controls.remove();
  };

  return Polygon;

})();