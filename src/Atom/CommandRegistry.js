// module Atom.CommandRegistry

exports.addImpl = function (cr) { return cr.add.bind(cr); }
