// module Atom.NotificationManager

exports.addSuccess = function addSuccess(nm) {
  return function(message) {
    return function() {
      nm.addSuccess(message);
    };
  };
};

exports.addInfo = function addInfo(nm) {
  return function(message) {
    return function() {
      nm.addInfo(message);
    };
  };
};

exports.addWarning = function addWarning(nm) {
  return function(message) {
    return function() {
      nm.addWarning(message);
    };
  };
};

exports.addError = function addError(nm) {
  return function(message) {
    return function() {
      nm.addError(message);
    };
  };
};

exports.addFatalError = function addFatalError(nm) {
  return function(message) {
    return function() {
      nm.addFatalError(message);
    };
  };
};
