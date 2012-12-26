var yall = (function(my) {
  my.persister = (function(path) {
    return {
      'add': function(path) {
        str = JSON.stringify(yall.serializePath(path));
        console.log(str);
        $.post(
          location.pathname + '/add',
          {
            value: JSON.stringify(yall.serializePath(path)),
          },
          function(e) {
            console.log(e);
          }
        )
      },
      'modify': function(path) {
        $.ajax(
          location.pathname,
          {
            type: 'put',
            data: {
              value: JSON.stringify(yall.serializePath(path)),
              graphic_id: path.graphic_id
            }
          }
        );
      },
      'remove': function(path) {
        $.ajax(
          location.pathname + '/remove',
          {
            type: 'delete',
            data: { graphic_id: path.graphic_id },
          }
        );
      }
    };
  })();

  return my;
})(yall || {});
