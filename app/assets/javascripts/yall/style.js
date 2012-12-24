var yall = (function(my) {
  my.style = function () {
    return {
      strokeColor: $('input#fg-color').val(),
      strokeWidth:  $('#brush-size-text').val(),
      fillColor:    $('input#bg-color').val()
    };
  };

  my.updateStyle = function () {
    if (my.getTool()) {
      my.getTool().styleChange(my.style());
    }
  };

  $.colorpicker.setDefaults({
    onSelect: my.updateStyle
  });

  return my;
})(yall || {});
