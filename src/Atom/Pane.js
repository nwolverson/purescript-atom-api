// module Atom.Pane

exports.destroyItemImpl = function (p) {
  return p.destroyItem.bind(p);
};
