// module Atom.Range

exports.getStart = function(r) {
  return r.start;
};
exports.getEnd = function(r) {
  return r.end;
};
exports.mkRangeImpl = function(p1, p2) {
  var Range = require('atom').Range;
  return new Range(p1,p2);
};
