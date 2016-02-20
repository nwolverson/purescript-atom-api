// module Atom.Point

exports.getRow = function(p) { return p.row; };
exports.getColumn = function(p) { return p.column; };
exports.mkPoint = function (x) {
  return function (y) {
    var Point = require('atom').Point;
    return new Point(x,y);
  };
};
exports.fromObject = function (o) {
  var Point = require('atom').Point;
  return Point.fromObject(o, true);
};
