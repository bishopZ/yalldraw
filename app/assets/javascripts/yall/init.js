var yall = (function(my) {
  my.refresh = function() {
    paper.view.draw();
  };

  my.init = function (canvas) {
    this.canvas = canvas;
    paper.setup(canvas);
  };

  return my;
})(yall || {});
