var yall = (function(my) {
  my.serializePath = function (path) {
    var segments = [];

    path.segments.forEach(function (s) {
      segments.push([
        s.point.x,
        s.point.y,
        s.handleIn.x,
        s.handleIn.y,
        s.handleOut.x,
        s.handleOut.y
      ]);

    });

    return {
      points: segments,
      style: yall.serializeStyle(path.style),
      graphic_id: path.graphic_id,
      type: path.type
    };
  };

  my.serializeColor = function (color) {
    return {
      red: color.red,
      green: color.green,
      blue: color.blue
    };
  };

  my.serializeStyle = function (style) {
    return {
      fillColor: yall.serializeColor(style.fillColor),
      miterLimit: style.miterLimit,
      strokeColor: yall.serializeColor(style.strokeColor),
      strokeCap: style.strokeCap,
      strokeJoin: style.strokeJoin,
      strokeWidth: style.strokeWidth
    };
  };

  return my;
})(yall || {});
