//= require yall/yall
//= require yall/serialize

module('yall.serialize');

test('yall.serializePath can parse a 2 point segments', function () {
  var path = {
    segments: [
      {
        point: { x: 1, y: 2 },
        handleIn: { x: 3, y: 4 },
        handleOut: { x: 5, y: 6 },
      },
      {
        point: { x: 11, y: 12 },
        handleIn: { x: 13, y: 14 },
        handleOut: { x: 15, y: 16 },
      }
    ],
    style: {
      fillColor: { red: 4, green: 7, blue: 2 },
      strokeColor: { red: 2, green: 8, blue: 2 },
      miterLimit: 3,
      strokeCap: 6,
      strokeJoin: 5,
      strokeWidth: 5
    },
    graphic_id: 12,
    type: 'cheese'
  };

  var expecting = {
    points: [
      [ 1, 2, 3, 4, 5, 6 ],
      [ 11, 12, 13, 14, 15, 16 ]
    ],
    graphic_id: path.graphic_id,
    type: path.type,
    style: path.style
  };

  deepEqual(yall.serializePath(path), expecting);
});
