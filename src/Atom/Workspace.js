// module Atom.Workspace

exports.observeTextEditorsImpl = function (w) { return w.observeTextEditors.bind(w); };

exports.observePaneItemsImpl = function (w) { return w.observePaneItems.bind(w); };

exports.onDidChangeActivePaneItemImpl = function (w) { return w.onDidChangeActivePaneItem.bind(w); };

exports.onDidStopChangingActivePaneItemImpl = function (w) { return w.onDidStopChangingActivePaneItem.bind(w); };

exports.observeActivePaneItemImpl = function (w) { return w.observeActivePaneItem.bind(w); };

exports.onDidOpenImpl = function (w) { return w.onDidOpen.bind(w); };

exports.getActiveTextEditorImpl = function (w) {
  return function() {
    return w.getActiveTextEditor();
  };
};

exports.addModalPanelImpl = function (w) {
  return w.addModalPanel.bind(w);
};

exports.destroyPanel = function (p) {
  return function() {
    p.destroy();
  };
};

exports.openImpl = function (w) {
  return function (name, opt, cb, err) {
    return w.open(name,opt).then(cb, err);
  };
};

exports.getActivePane = function (w) {
  return function() {
    return w.getActivePane();
  };
};

exports.addOpenerImpl = function (w) {
  return w.addOpener.bind(w);
};
