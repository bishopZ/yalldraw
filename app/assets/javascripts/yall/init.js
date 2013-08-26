var yall = (function(my) {
  my.refresh = function() {
    paper.view.draw();
  };

  my.init = function (canvas, vectors) {
    this.canvas = canvas;
    paper.setup(canvas);
    yall.initTool();
    yall.render(vectors);
  };

  return my;
})(yall || {});

$(function () {
  yall.init($('canvas')[0], vectors);
});
