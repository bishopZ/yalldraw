$(function() {
  var canvas    = $('canvas')
  if (!canvas.length) { return; }
  var rawCanvas = canvas[0];
  var context = rawCanvas.getContext('2d');
  var w = canvas.parent().width();
  var h = canvas.parent().height();
  rawCanvas.style.width = rawCanvas.width  = w;
  rawCanvas.style.height = rawCanvas.height = h;

  var colorOptions = {
    realtime: true,
    invertControls: false,
    controlStyle: 'raised',
    alpha: false
  };

  $('input#fg-color').colorpicker(colorOptions);
  $('input#bg-color').colorpicker(colorOptions);

  $('#brush-size-slider').slider({
    min: 0,
    max: 10,
    step: .1,
    value: 6,
    slide: function() {
      $('#brush-size-text').val($('#brush-size-slider').slider('value'))
    }
  });

  yall.init(rawCanvas);
  yall.initTool();
});
  /**
   * get canvas context
   * refresh
   * serializePath
   * interface slider
   * interface colorpicker
   * call paper setup on canvas
   * set tools onto paper.tool
   *
   * ColorSerializer
   * StyleSerializer
   * PathSerializer
   *
   * init
   *
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
