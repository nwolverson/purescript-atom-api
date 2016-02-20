// module Atom.Project

exports.getPaths = function(project) {
  return function() {
    return project.getPaths();
  };
};
