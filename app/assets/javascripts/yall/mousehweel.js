var yall = (function(my) {
  var zoomDelta = .15

  my.mouseWheel = function(delta) {
    if (delta > 0) {
      paper.view.zoom += zoomDelta;
    } else {
      paper.view.zoom -= zoomDelta;
    }
  };

  return my;
})(yall || {});
