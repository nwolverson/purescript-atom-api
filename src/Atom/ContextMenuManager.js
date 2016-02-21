// module Atom.ContextMenuManager

exports.add = function add(c) {
  return function (name) {
    return function (object) {
      return function (options) {
        return function () {
          c.add(name, object, options);
        };
      };
    };
  };
};

exports.showForEvent = function showForEvent(c) {
  return function (event) {
    return function () {

    };
  };
};
