// module Atom.Editor

exports.getTitle = function (e) { return function () { return e.getTitle(); }; };
exports.getLongTitle = function (e) { return function () { return e.getLongTitle(); }; };
exports.getPathImpl = function (e) { return function () { return e.getPath(); }; };

exports.getText = function (e) { return function () { return e.getText(); }; };
exports.getTextInRangeImpl = function(e) {
  return e.getTextInBufferRange.bind(e);
};

exports.setTextInBufferRangeImpl = function(e) { return e.setTextInBufferRange.bind(e); }
exports.setTextImpl = function(e) { return e.setText.bind(e); }

exports.onDidSaveImpl = function(e) { return e.onDidSave.bind(e); };

exports.getCursorBufferPosition = function (e) { return function () { return e.getCursorBufferPosition(); }; };

exports.isTextEditor = function (item) {
  var TextEditor = require('atom').TextEditor;
  return item instanceof TextEditor;
};

exports.getBuffer = function (editor) {
  return function() {
    return editor.getBuffer();
  };
};
