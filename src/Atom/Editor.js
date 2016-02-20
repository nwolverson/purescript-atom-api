// module Atom.Editor

exports.getTitle = function (e) { return function () { return e.getTitle(); }; };
exports.getLongTitle = function (e) { return function () { return e.getLongTitle(); }; };
exports.getPath = function (e) { return function () { return e.getPath(); }; };

exports.getText = function (e) { return function () { return e.getText(); }; };
exports.getTextInRangeImpl = function(e) {
  return e.getTextInBufferRange.bind(e);
};
exports.onDidSaveImpl = function(e) { return e.onDidSave.bind(e); };

exports.isTextEditor = function (item) {
  var TextEditor = require('atom').TextEditor;
  return item instanceof TextEditor;
};
