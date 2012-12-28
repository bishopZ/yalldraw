var yall = (function(my) {
  var zoomDelta = .15
  var centerLimiter = .2

  my.mouseWheel = function(delta, x, y) {
    var zX = (x - paper.view.center.x) * centerLimiter;
    var zY = (y - paper.view.center.y) * centerLimiter;
    paper.view.scrollBy(new paper.Point(zX, zY));

    if (delta > 0) {
      paper.view.zoom += zoomDelta;
    } else {
      paper.view.zoom -= zoomDelta;
    }

  };

  return my;
})(yall || {});
