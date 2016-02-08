// module Atom.Clipboard

exports.read = function read(c) {
  return function() {
    return c.read();
  };
};

exports.readWithMetadata = function readWithMetadata(c) {
  return function() {
    return c.readWithMetadata();
  };
};

exports.write = function write(c) {
  return function (t) {
    return function (m) {
      return function () {
        c.write(t, m);
      };
    };
  };
};
