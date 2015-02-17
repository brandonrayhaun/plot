Elm.Native.Formatting = {};
Elm.Native.Formatting.make = function(localRunTime) {
  localRunTime.Native = localRunTime.Native || {};
  localRunTime.Native.Formatting = localRunTime.Native.Formatting || {};

  var Utils = Elm.Native.Utils.make(localRunTime);

  if (localRunTime.Native.Formatting.values) {
    return localRunTime.Native.Formatting.values;
  }

  function toFixed(num,prec) {
    return num.toFixed(prec);
  }
  function toExponential(num,prec) {
    return num.toExponential(prec);
  }

  return localRunTime.Native.Formatting.values = {
    toFixed:F2(toFixed), toExponential:F2(toExponential)
  }
};