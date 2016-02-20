// module Atom.Config

exports.getConfigImpl = function(config) { return config.get.bind(config); };

exports.setConfigImpl = function(config) { return config.set.bind(config); };
