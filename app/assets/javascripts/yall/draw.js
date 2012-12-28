$(function() {
  var canvas    = $('canvas')
  if (!canvas.length) { return; }

  // prepare canvas size
  var rawCanvas = canvas[0];
  var context = rawCanvas.getContext('2d');
  var w = canvas.parent().width();
  var h = canvas.parent().height();
  rawCanvas.style.width = rawCanvas.width  = w;
  rawCanvas.style.height = rawCanvas.height = h;

  canvas.on('mousewheel', function(e) { yall.mouseWheel(e.originalEvent.wheelDelta); });

  yall.init(rawCanvas, vectors);
});
  /**
   * Perisister
   *    ajax remove
   *    ajax save
   *    ajax modify
   *
   * PathInitializer
   *    load dom json into paper initally
   *
   * Styler
   *    get current style
   *    set current style
   *
   */
