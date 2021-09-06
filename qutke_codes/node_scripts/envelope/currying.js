function unCurrying(fn) {
  return function (thisValue, ...args) {
    return Function.prototype.apply.call(fn, thisValue, args);
    // return fn.call(...args)
  };
}
let toString = unCurrying(Object.prototype.toString);
console.log(toString("hello"));
