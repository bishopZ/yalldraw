var yall = (function(my) {
  my.render = function(vectors) {
    var path = yall.renderVectors(vectors);
    yall.refresh();
    return path;
  };

  my.renderVectors = function(vectors) {
    var paths = [];

    vectors.map(function(path) { paths.push(yall.renderPath(path)); });
    return paths;
  };

  my.renderPath = function(vector) {
    var path = new paper.Path();
    path.style = vector.style;
    path.graphic_id = vector.graphic_id;
    path.closed = vector.type !== 'Freeform';

    vector.points.map(function(point) {
      path.add(yall.renderSegment(point));
    });
    return path;
  };

  my.renderSegment = function (point) {
    return new paper.Segment(
      new paper.Point(point[0], point[1]),
      new paper.Point(point[2], point[3]),
      new paper.Point(point[4], point[5])
    );
  };

  return my;
})(yall || {});
