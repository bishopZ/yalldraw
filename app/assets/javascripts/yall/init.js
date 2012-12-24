var yall = (function(my) {
  my.refresh = function() {
    paper.view.draw();
  };

  my.init = function (canvas) {
    this.canvas = canvas;
    paper.setup(canvas);
    yall.initTool();
  };

  return my;
})(yall || {});
