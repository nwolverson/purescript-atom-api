// module Atom.GrammarRegistry


exports.getGrammars = function(gr) {
  return function() {
    return gr.getGrammars();
  };
};

exports.grammarForScopeName = function(gr) {
  return function (s) {
    return function() {
      return gr.grammarForScopeName(s);
    };
  };
};
