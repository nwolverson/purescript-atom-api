// module Atom.Editor

exports.getTitle = function (e) { return function () { return e.getTitle(); }; };
exports.getLongTitle = function (e) { return function () { return e.getLongTitle(); }; };
exports.getPathImpl = function (e) { return function () { return e.getPath(); }; };

exports.getText = function (e) { return function () { return e.getText(); }; };
exports.getTextInRangeImpl = function(e) {
  return e.getTextInBufferRange.bind(e);
};
exports.getSelectedText = function (e) { return function () { return e.getSelectedText(); }; };

exports.setTextInBufferRangeImpl = function(e) { return e.setTextInBufferRange.bind(e); }
exports.setTextImpl = function(e) { return e.setText.bind(e); }
exports.insertTextImpl = function(e) { return e.insertText.bind(e); }


exports.onDidSaveImpl = function(e) { return e.onDidSave.bind(e); };

exports.getCursorBufferPosition = function (e) { return function () { return e.getCursorBufferPosition(); }; };
exports.moveToTop = function (e) { return function () { return e.moveToTop(); }; };
exports.moveToBottom = function (e) { return function () { return e.moveToBottom(); }; };

exports.moveUpImpl = function (e) { return e.moveUp.bind(e); };
exports.moveDownImpl = function (e) { return e.moveDown.bind(e); };

exports.moveToBeginningOfLine = function(e) { return function () { return e.moveToBeginningOfLine(); }; };

exports.isTextEditor = function (item) {
  var TextEditor = require('atom').TextEditor;
  return item instanceof TextEditor;
};

exports.getBuffer = function (editor) {
  return function() {
    return editor.getBuffer();
  };
};

exports.setGrammar = function (editor) {
  return function (grammar) {
    return function() {
      editor.setGrammar(grammar);
    };
  };
};
