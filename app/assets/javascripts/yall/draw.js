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

  // middle mouse scroll
  var mouseWheelEvent = (/Firefox/i.test(navigator.userAgent)) ? "DOMMouseScroll" : "mousewheel"
  canvas.on(mouseWheelEvent, function(e) {
    e.preventDefault();
    var event = e.originalEvent;
    yall.mouseWheel(event.wheelDelta, event.offsetX, event.offsetY);
  });

  yall.init(rawCanvas, vectors);
});
