var yall = (function(my) {
  my.persister = (function(path) {
    return function(path) {
      console.log('hello');
      str = JSON.stringify(yall.serializePath(path));
      console.log(str);
      $.post(
        location.pathname + '/add',
        {
          value: JSON.stringify(yall.serializePath(path)),
          drawing_id: 0
        },
        function(e) {
          console.log(e);
        }
      )
    };
  })();

  return my;
})(yall || {});
