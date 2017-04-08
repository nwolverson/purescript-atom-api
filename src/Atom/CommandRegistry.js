exports.addImpl = function (cr) { return cr.add.bind(cr); };

exports.dispatchImpl = function (cr) { return function (target, commandName) { return cr.dispatch(target, commandName); }; };

exports.dispatchRootImpl = function (cr) {
  return function (commandName) {
    var elt = atom.views.getView(atom.workspace.getActivePane().getActiveEditor());
    return cr.dispatch(elt, commandName);
  };
};
