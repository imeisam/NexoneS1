(function () {
  const t = document.createElement("link").relList;
  if (t && t.supports && t.supports("modulepreload")) return;
  for (const o of document.querySelectorAll('link[rel="modulepreload"]')) r(o);
  new MutationObserver((o) => {
    for (const i of o)
      if (i.type === "childList")
        for (const s of i.addedNodes)
          s.tagName === "LINK" && s.rel === "modulepreload" && r(s);
  }).observe(document, { childList: !0, subtree: !0 });
  function n(o) {
    const i = {};
    return (
      o.integrity && (i.integrity = o.integrity),
      o.referrerPolicy && (i.referrerPolicy = o.referrerPolicy),
      o.crossOrigin === "use-credentials"
        ? (i.credentials = "include")
        : o.crossOrigin === "anonymous"
        ? (i.credentials = "omit")
        : (i.credentials = "same-origin"),
      i
    );
  }
  function r(o) {
    if (o.ep) return;
    o.ep = !0;
    const i = n(o);
    fetch(o.href, i);
  }
})();
function Br(e, t) {
  const n = Object.create(null),
    r = e.split(",");
  for (let o = 0; o < r.length; o++) n[r[o]] = !0;
  return t ? (o) => !!n[o.toLowerCase()] : (o) => !!n[o];
}
const ue = {},
  qt = [],
  He = () => {},
  Us = () => !1,
  Ks = /^on[^a-z]/,
  In = (e) => Ks.test(e),
  $r = (e) => e.startsWith("onUpdate:"),
  pe = Object.assign,
  Nr = (e, t) => {
    const n = e.indexOf(t);
    n > -1 && e.splice(n, 1);
  },
  Ws = Object.prototype.hasOwnProperty,
  re = (e, t) => Ws.call(e, t),
  Z = Array.isArray,
  It = (e) => Ln(e) === "[object Map]",
  xi = (e) => Ln(e) === "[object Set]",
  G = (e) => typeof e == "function",
  be = (e) => typeof e == "string",
  jr = (e) => typeof e == "symbol",
  fe = (e) => e !== null && typeof e == "object",
  Ci = (e) => fe(e) && G(e.then) && G(e.catch),
  ki = Object.prototype.toString,
  Ln = (e) => ki.call(e),
  Qs = (e) => Ln(e).slice(8, -1),
  Si = (e) => Ln(e) === "[object Object]",
  Hr = (e) =>
    be(e) && e !== "NaN" && e[0] !== "-" && "" + parseInt(e, 10) === e,
  wn = Br(
    ",key,ref,ref_for,ref_key,onVnodeBeforeMount,onVnodeMounted,onVnodeBeforeUpdate,onVnodeUpdated,onVnodeBeforeUnmount,onVnodeUnmounted"
  ),
  Bn = (e) => {
    const t = Object.create(null);
    return (n) => t[n] || (t[n] = e(n));
  },
  Js = /-(\w)/g,
  Qe = Bn((e) => e.replace(Js, (t, n) => (n ? n.toUpperCase() : ""))),
  Zs = /\B([A-Z])/g,
  jt = Bn((e) => e.replace(Zs, "-$1").toLowerCase()),
  $n = Bn((e) => e.charAt(0).toUpperCase() + e.slice(1)),
  tr = Bn((e) => (e ? `on${$n(e)}` : "")),
  en = (e, t) => !Object.is(e, t),
  nr = (e, t) => {
    for (let n = 0; n < e.length; n++) e[n](t);
  },
  kn = (e, t, n) => {
    Object.defineProperty(e, t, { configurable: !0, enumerable: !1, value: n });
  },
  Ys = (e) => {
    const t = parseFloat(e);
    return isNaN(t) ? e : t;
  },
  Xs = (e) => {
    const t = be(e) ? Number(e) : NaN;
    return isNaN(t) ? e : t;
  };
let fo;
const gr = () =>
  fo ||
  (fo =
    typeof globalThis < "u"
      ? globalThis
      : typeof self < "u"
      ? self
      : typeof window < "u"
      ? window
      : typeof global < "u"
      ? global
      : {});
function zr(e) {
  if (Z(e)) {
    const t = {};
    for (let n = 0; n < e.length; n++) {
      const r = e[n],
        o = be(r) ? nl(r) : zr(r);
      if (o) for (const i in o) t[i] = o[i];
    }
    return t;
  } else {
    if (be(e)) return e;
    if (fe(e)) return e;
  }
}
const Gs = /;(?![^(]*\))/g,
  el = /:([^]+)/,
  tl = new RegExp("\\/\\*.*?\\*\\/", "gs");
function nl(e) {
  const t = {};
  return (
    e
      .replace(tl, "")
      .split(Gs)
      .forEach((n) => {
        if (n) {
          const r = n.split(el);
          r.length > 1 && (t[r[0].trim()] = r[1].trim());
        }
      }),
    t
  );
}
function Dr(e) {
  let t = "";
  if (be(e)) t = e;
  else if (Z(e))
    for (let n = 0; n < e.length; n++) {
      const r = Dr(e[n]);
      r && (t += r + " ");
    }
  else if (fe(e)) for (const n in e) e[n] && (t += n + " ");
  return t.trim();
}
const rl =
    "itemscope,allowfullscreen,formnovalidate,ismap,nomodule,novalidate,readonly",
  ol = Br(rl);
function Ei(e) {
  return !!e || e === "";
}
const il = (e) =>
    be(e)
      ? e
      : e == null
      ? ""
      : Z(e) || (fe(e) && (e.toString === ki || !G(e.toString)))
      ? JSON.stringify(e, Mi, 2)
      : String(e),
  Mi = (e, t) =>
    t && t.__v_isRef
      ? Mi(e, t.value)
      : It(t)
      ? {
          [`Map(${t.size})`]: [...t.entries()].reduce(
            (n, [r, o]) => ((n[`${r} =>`] = o), n),
            {}
          ),
        }
      : xi(t)
      ? { [`Set(${t.size})`]: [...t.values()] }
      : fe(t) && !Z(t) && !Si(t)
      ? String(t)
      : t;
let Te;
class Pi {
  constructor(t = !1) {
    (this.detached = t),
      (this._active = !0),
      (this.effects = []),
      (this.cleanups = []),
      (this.parent = Te),
      !t && Te && (this.index = (Te.scopes || (Te.scopes = [])).push(this) - 1);
  }
  get active() {
    return this._active;
  }
  run(t) {
    if (this._active) {
      const n = Te;
      try {
        return (Te = this), t();
      } finally {
        Te = n;
      }
    }
  }
  on() {
    Te = this;
  }
  off() {
    Te = this.parent;
  }
  stop(t) {
    if (this._active) {
      let n, r;
      for (n = 0, r = this.effects.length; n < r; n++) this.effects[n].stop();
      for (n = 0, r = this.cleanups.length; n < r; n++) this.cleanups[n]();
      if (this.scopes)
        for (n = 0, r = this.scopes.length; n < r; n++) this.scopes[n].stop(!0);
      if (!this.detached && this.parent && !t) {
        const o = this.parent.scopes.pop();
        o &&
          o !== this &&
          ((this.parent.scopes[this.index] = o), (o.index = this.index));
      }
      (this.parent = void 0), (this._active = !1);
    }
  }
}
function Ti(e) {
  return new Pi(e);
}
function sl(e, t = Te) {
  t && t.active && t.effects.push(e);
}
function Ri() {
  return Te;
}
function ll(e) {
  Te && Te.cleanups.push(e);
}
const Vr = (e) => {
    const t = new Set(e);
    return (t.w = 0), (t.n = 0), t;
  },
  Ai = (e) => (e.w & ut) > 0,
  Fi = (e) => (e.n & ut) > 0,
  al = ({ deps: e }) => {
    if (e.length) for (let t = 0; t < e.length; t++) e[t].w |= ut;
  },
  ul = (e) => {
    const { deps: t } = e;
    if (t.length) {
      let n = 0;
      for (let r = 0; r < t.length; r++) {
        const o = t[r];
        Ai(o) && !Fi(o) ? o.delete(e) : (t[n++] = o),
          (o.w &= ~ut),
          (o.n &= ~ut);
      }
      t.length = n;
    }
  },
  Sn = new WeakMap();
let Wt = 0,
  ut = 1;
const mr = 30;
let Ne;
const kt = Symbol(""),
  pr = Symbol("");
class Ur {
  constructor(t, n = null, r) {
    (this.fn = t),
      (this.scheduler = n),
      (this.active = !0),
      (this.deps = []),
      (this.parent = void 0),
      sl(this, r);
  }
  run() {
    if (!this.active) return this.fn();
    let t = Ne,
      n = st;
    for (; t; ) {
      if (t === this) return;
      t = t.parent;
    }
    try {
      return (
        (this.parent = Ne),
        (Ne = this),
        (st = !0),
        (ut = 1 << ++Wt),
        Wt <= mr ? al(this) : ho(this),
        this.fn()
      );
    } finally {
      Wt <= mr && ul(this),
        (ut = 1 << --Wt),
        (Ne = this.parent),
        (st = n),
        (this.parent = void 0),
        this.deferStop && this.stop();
    }
  }
  stop() {
    Ne === this
      ? (this.deferStop = !0)
      : this.active &&
        (ho(this), this.onStop && this.onStop(), (this.active = !1));
  }
}
function ho(e) {
  const { deps: t } = e;
  if (t.length) {
    for (let n = 0; n < t.length; n++) t[n].delete(e);
    t.length = 0;
  }
}
let st = !0;
const Oi = [];
function Ht() {
  Oi.push(st), (st = !1);
}
function zt() {
  const e = Oi.pop();
  st = e === void 0 ? !0 : e;
}
function Ee(e, t, n) {
  if (st && Ne) {
    let r = Sn.get(e);
    r || Sn.set(e, (r = new Map()));
    let o = r.get(n);
    o || r.set(n, (o = Vr())), qi(o);
  }
}
function qi(e, t) {
  let n = !1;
  Wt <= mr ? Fi(e) || ((e.n |= ut), (n = !Ai(e))) : (n = !e.has(Ne)),
    n && (e.add(Ne), Ne.deps.push(e));
}
function Ge(e, t, n, r, o, i) {
  const s = Sn.get(e);
  if (!s) return;
  let l = [];
  if (t === "clear") l = [...s.values()];
  else if (n === "length" && Z(e)) {
    const a = Number(r);
    s.forEach((c, f) => {
      (f === "length" || f >= a) && l.push(c);
    });
  } else
    switch ((n !== void 0 && l.push(s.get(n)), t)) {
      case "add":
        Z(e)
          ? Hr(n) && l.push(s.get("length"))
          : (l.push(s.get(kt)), It(e) && l.push(s.get(pr)));
        break;
      case "delete":
        Z(e) || (l.push(s.get(kt)), It(e) && l.push(s.get(pr)));
        break;
      case "set":
        It(e) && l.push(s.get(kt));
        break;
    }
  if (l.length === 1) l[0] && vr(l[0]);
  else {
    const a = [];
    for (const c of l) c && a.push(...c);
    vr(Vr(a));
  }
}
function vr(e, t) {
  const n = Z(e) ? e : [...e];
  for (const r of n) r.computed && go(r);
  for (const r of n) r.computed || go(r);
}
function go(e, t) {
  (e !== Ne || e.allowRecurse) && (e.scheduler ? e.scheduler() : e.run());
}
function cl(e, t) {
  var n;
  return (n = Sn.get(e)) == null ? void 0 : n.get(t);
}
const fl = Br("__proto__,__v_isRef,__isVue"),
  Ii = new Set(
    Object.getOwnPropertyNames(Symbol)
      .filter((e) => e !== "arguments" && e !== "caller")
      .map((e) => Symbol[e])
      .filter(jr)
  ),
  dl = Kr(),
  hl = Kr(!1, !0),
  gl = Kr(!0),
  mo = ml();
function ml() {
  const e = {};
  return (
    ["includes", "indexOf", "lastIndexOf"].forEach((t) => {
      e[t] = function (...n) {
        const r = te(this);
        for (let i = 0, s = this.length; i < s; i++) Ee(r, "get", i + "");
        const o = r[t](...n);
        return o === -1 || o === !1 ? r[t](...n.map(te)) : o;
      };
    }),
    ["push", "pop", "shift", "unshift", "splice"].forEach((t) => {
      e[t] = function (...n) {
        Ht();
        const r = te(this)[t].apply(this, n);
        return zt(), r;
      };
    }),
    e
  );
}
function pl(e) {
  const t = te(this);
  return Ee(t, "has", e), t.hasOwnProperty(e);
}
function Kr(e = !1, t = !1) {
  return function (r, o, i) {
    if (o === "__v_isReactive") return !e;
    if (o === "__v_isReadonly") return e;
    if (o === "__v_isShallow") return t;
    if (o === "__v_raw" && i === (e ? (t ? Fl : ji) : t ? Ni : $i).get(r))
      return r;
    const s = Z(r);
    if (!e) {
      if (s && re(mo, o)) return Reflect.get(mo, o, i);
      if (o === "hasOwnProperty") return pl;
    }
    const l = Reflect.get(r, o, i);
    return (jr(o) ? Ii.has(o) : fl(o)) || (e || Ee(r, "get", o), t)
      ? l
      : de(l)
      ? s && Hr(o)
        ? l
        : l.value
      : fe(l)
      ? e
        ? Hi(l)
        : Dt(l)
      : l;
  };
}
const vl = Li(),
  bl = Li(!0);
function Li(e = !1) {
  return function (n, r, o, i) {
    let s = n[r];
    if ($t(s) && de(s) && !de(o)) return !1;
    if (
      !e &&
      (!En(o) && !$t(o) && ((s = te(s)), (o = te(o))), !Z(n) && de(s) && !de(o))
    )
      return (s.value = o), !0;
    const l = Z(n) && Hr(r) ? Number(r) < n.length : re(n, r),
      a = Reflect.set(n, r, o, i);
    return (
      n === te(i) && (l ? en(o, s) && Ge(n, "set", r, o) : Ge(n, "add", r, o)),
      a
    );
  };
}
function _l(e, t) {
  const n = re(e, t);
  e[t];
  const r = Reflect.deleteProperty(e, t);
  return r && n && Ge(e, "delete", t, void 0), r;
}
function yl(e, t) {
  const n = Reflect.has(e, t);
  return (!jr(t) || !Ii.has(t)) && Ee(e, "has", t), n;
}
function wl(e) {
  return Ee(e, "iterate", Z(e) ? "length" : kt), Reflect.ownKeys(e);
}
const Bi = { get: dl, set: vl, deleteProperty: _l, has: yl, ownKeys: wl },
  xl = {
    get: gl,
    set(e, t) {
      return !0;
    },
    deleteProperty(e, t) {
      return !0;
    },
  },
  Cl = pe({}, Bi, { get: hl, set: bl }),
  Wr = (e) => e,
  Nn = (e) => Reflect.getPrototypeOf(e);
function dn(e, t, n = !1, r = !1) {
  e = e.__v_raw;
  const o = te(e),
    i = te(t);
  n || (t !== i && Ee(o, "get", t), Ee(o, "get", i));
  const { has: s } = Nn(o),
    l = r ? Wr : n ? Zr : tn;
  if (s.call(o, t)) return l(e.get(t));
  if (s.call(o, i)) return l(e.get(i));
  e !== o && e.get(t);
}
function hn(e, t = !1) {
  const n = this.__v_raw,
    r = te(n),
    o = te(e);
  return (
    t || (e !== o && Ee(r, "has", e), Ee(r, "has", o)),
    e === o ? n.has(e) : n.has(e) || n.has(o)
  );
}
function gn(e, t = !1) {
  return (
    (e = e.__v_raw), !t && Ee(te(e), "iterate", kt), Reflect.get(e, "size", e)
  );
}
function po(e) {
  e = te(e);
  const t = te(this);
  return Nn(t).has.call(t, e) || (t.add(e), Ge(t, "add", e, e)), this;
}
function vo(e, t) {
  t = te(t);
  const n = te(this),
    { has: r, get: o } = Nn(n);
  let i = r.call(n, e);
  i || ((e = te(e)), (i = r.call(n, e)));
  const s = o.call(n, e);
  return (
    n.set(e, t), i ? en(t, s) && Ge(n, "set", e, t) : Ge(n, "add", e, t), this
  );
}
function bo(e) {
  const t = te(this),
    { has: n, get: r } = Nn(t);
  let o = n.call(t, e);
  o || ((e = te(e)), (o = n.call(t, e))), r && r.call(t, e);
  const i = t.delete(e);
  return o && Ge(t, "delete", e, void 0), i;
}
function _o() {
  const e = te(this),
    t = e.size !== 0,
    n = e.clear();
  return t && Ge(e, "clear", void 0, void 0), n;
}
function mn(e, t) {
  return function (r, o) {
    const i = this,
      s = i.__v_raw,
      l = te(s),
      a = t ? Wr : e ? Zr : tn;
    return (
      !e && Ee(l, "iterate", kt), s.forEach((c, f) => r.call(o, a(c), a(f), i))
    );
  };
}
function pn(e, t, n) {
  return function (...r) {
    const o = this.__v_raw,
      i = te(o),
      s = It(i),
      l = e === "entries" || (e === Symbol.iterator && s),
      a = e === "keys" && s,
      c = o[e](...r),
      f = n ? Wr : t ? Zr : tn;
    return (
      !t && Ee(i, "iterate", a ? pr : kt),
      {
        next() {
          const { value: g, done: h } = c.next();
          return h
            ? { value: g, done: h }
            : { value: l ? [f(g[0]), f(g[1])] : f(g), done: h };
        },
        [Symbol.iterator]() {
          return this;
        },
      }
    );
  };
}
function tt(e) {
  return function (...t) {
    return e === "delete" ? !1 : this;
  };
}
function kl() {
  const e = {
      get(i) {
        return dn(this, i);
      },
      get size() {
        return gn(this);
      },
      has: hn,
      add: po,
      set: vo,
      delete: bo,
      clear: _o,
      forEach: mn(!1, !1),
    },
    t = {
      get(i) {
        return dn(this, i, !1, !0);
      },
      get size() {
        return gn(this);
      },
      has: hn,
      add: po,
      set: vo,
      delete: bo,
      clear: _o,
      forEach: mn(!1, !0),
    },
    n = {
      get(i) {
        return dn(this, i, !0);
      },
      get size() {
        return gn(this, !0);
      },
      has(i) {
        return hn.call(this, i, !0);
      },
      add: tt("add"),
      set: tt("set"),
      delete: tt("delete"),
      clear: tt("clear"),
      forEach: mn(!0, !1),
    },
    r = {
      get(i) {
        return dn(this, i, !0, !0);
      },
      get size() {
        return gn(this, !0);
      },
      has(i) {
        return hn.call(this, i, !0);
      },
      add: tt("add"),
      set: tt("set"),
      delete: tt("delete"),
      clear: tt("clear"),
      forEach: mn(!0, !0),
    };
  return (
    ["keys", "values", "entries", Symbol.iterator].forEach((i) => {
      (e[i] = pn(i, !1, !1)),
        (n[i] = pn(i, !0, !1)),
        (t[i] = pn(i, !1, !0)),
        (r[i] = pn(i, !0, !0));
    }),
    [e, n, t, r]
  );
}
const [Sl, El, Ml, Pl] = kl();
function Qr(e, t) {
  const n = t ? (e ? Pl : Ml) : e ? El : Sl;
  return (r, o, i) =>
    o === "__v_isReactive"
      ? !e
      : o === "__v_isReadonly"
      ? e
      : o === "__v_raw"
      ? r
      : Reflect.get(re(n, o) && o in r ? n : r, o, i);
}
const Tl = { get: Qr(!1, !1) },
  Rl = { get: Qr(!1, !0) },
  Al = { get: Qr(!0, !1) },
  $i = new WeakMap(),
  Ni = new WeakMap(),
  ji = new WeakMap(),
  Fl = new WeakMap();
function Ol(e) {
  switch (e) {
    case "Object":
    case "Array":
      return 1;
    case "Map":
    case "Set":
    case "WeakMap":
    case "WeakSet":
      return 2;
    default:
      return 0;
  }
}
function ql(e) {
  return e.__v_skip || !Object.isExtensible(e) ? 0 : Ol(Qs(e));
}
function Dt(e) {
  return $t(e) ? e : Jr(e, !1, Bi, Tl, $i);
}
function Il(e) {
  return Jr(e, !1, Cl, Rl, Ni);
}
function Hi(e) {
  return Jr(e, !0, xl, Al, ji);
}
function Jr(e, t, n, r, o) {
  if (!fe(e) || (e.__v_raw && !(t && e.__v_isReactive))) return e;
  const i = o.get(e);
  if (i) return i;
  const s = ql(e);
  if (s === 0) return e;
  const l = new Proxy(e, s === 2 ? r : n);
  return o.set(e, l), l;
}
function lt(e) {
  return $t(e) ? lt(e.__v_raw) : !!(e && e.__v_isReactive);
}
function $t(e) {
  return !!(e && e.__v_isReadonly);
}
function En(e) {
  return !!(e && e.__v_isShallow);
}
function zi(e) {
  return lt(e) || $t(e);
}
function te(e) {
  const t = e && e.__v_raw;
  return t ? te(t) : e;
}
function ct(e) {
  return kn(e, "__v_skip", !0), e;
}
const tn = (e) => (fe(e) ? Dt(e) : e),
  Zr = (e) => (fe(e) ? Hi(e) : e);
function Di(e) {
  st && Ne && ((e = te(e)), qi(e.dep || (e.dep = Vr())));
}
function Vi(e, t) {
  e = te(e);
  const n = e.dep;
  n && vr(n);
}
function de(e) {
  return !!(e && e.__v_isRef === !0);
}
function ce(e) {
  return Ll(e, !1);
}
function Ll(e, t) {
  return de(e) ? e : new Bl(e, t);
}
class Bl {
  constructor(t, n) {
    (this.__v_isShallow = n),
      (this.dep = void 0),
      (this.__v_isRef = !0),
      (this._rawValue = n ? t : te(t)),
      (this._value = n ? t : tn(t));
  }
  get value() {
    return Di(this), this._value;
  }
  set value(t) {
    const n = this.__v_isShallow || En(t) || $t(t);
    (t = n ? t : te(t)),
      en(t, this._rawValue) &&
        ((this._rawValue = t), (this._value = n ? t : tn(t)), Vi(this));
  }
}
function $l(e) {
  return de(e) ? e.value : e;
}
const Nl = {
  get: (e, t, n) => $l(Reflect.get(e, t, n)),
  set: (e, t, n, r) => {
    const o = e[t];
    return de(o) && !de(n) ? ((o.value = n), !0) : Reflect.set(e, t, n, r);
  },
};
function Ui(e) {
  return lt(e) ? e : new Proxy(e, Nl);
}
function jl(e) {
  const t = Z(e) ? new Array(e.length) : {};
  for (const n in e) t[n] = zl(e, n);
  return t;
}
class Hl {
  constructor(t, n, r) {
    (this._object = t),
      (this._key = n),
      (this._defaultValue = r),
      (this.__v_isRef = !0);
  }
  get value() {
    const t = this._object[this._key];
    return t === void 0 ? this._defaultValue : t;
  }
  set value(t) {
    this._object[this._key] = t;
  }
  get dep() {
    return cl(te(this._object), this._key);
  }
}
function zl(e, t, n) {
  const r = e[t];
  return de(r) ? r : new Hl(e, t, n);
}
class Dl {
  constructor(t, n, r, o) {
    (this._setter = n),
      (this.dep = void 0),
      (this.__v_isRef = !0),
      (this.__v_isReadonly = !1),
      (this._dirty = !0),
      (this.effect = new Ur(t, () => {
        this._dirty || ((this._dirty = !0), Vi(this));
      })),
      (this.effect.computed = this),
      (this.effect.active = this._cacheable = !o),
      (this.__v_isReadonly = r);
  }
  get value() {
    const t = te(this);
    return (
      Di(t),
      (t._dirty || !t._cacheable) &&
        ((t._dirty = !1), (t._value = t.effect.run())),
      t._value
    );
  }
  set value(t) {
    this._setter(t);
  }
}
function Vl(e, t, n = !1) {
  let r, o;
  const i = G(e);
  return (
    i ? ((r = e), (o = He)) : ((r = e.get), (o = e.set)),
    new Dl(r, o, i || !o, n)
  );
}
function at(e, t, n, r) {
  let o;
  try {
    o = r ? e(...r) : e();
  } catch (i) {
    jn(i, t, n);
  }
  return o;
}
function qe(e, t, n, r) {
  if (G(e)) {
    const i = at(e, t, n, r);
    return (
      i &&
        Ci(i) &&
        i.catch((s) => {
          jn(s, t, n);
        }),
      i
    );
  }
  const o = [];
  for (let i = 0; i < e.length; i++) o.push(qe(e[i], t, n, r));
  return o;
}
function jn(e, t, n, r = !0) {
  const o = t ? t.vnode : null;
  if (t) {
    let i = t.parent;
    const s = t.proxy,
      l = n;
    for (; i; ) {
      const c = i.ec;
      if (c) {
        for (let f = 0; f < c.length; f++) if (c[f](e, s, l) === !1) return;
      }
      i = i.parent;
    }
    const a = t.appContext.config.errorHandler;
    if (a) {
      at(a, null, 10, [e, s, l]);
      return;
    }
  }
  Ul(e, n, o, r);
}
function Ul(e, t, n, r = !0) {
  console.error(e);
}
let nn = !1,
  br = !1;
const Ce = [];
let We = 0;
const Lt = [];
let Je = null,
  yt = 0;
const Ki = Promise.resolve();
let Yr = null;
function Ze(e) {
  const t = Yr || Ki;
  return e ? t.then(this ? e.bind(this) : e) : t;
}
function Kl(e) {
  let t = We + 1,
    n = Ce.length;
  for (; t < n; ) {
    const r = (t + n) >>> 1;
    rn(Ce[r]) < e ? (t = r + 1) : (n = r);
  }
  return t;
}
function Xr(e) {
  (!Ce.length || !Ce.includes(e, nn && e.allowRecurse ? We + 1 : We)) &&
    (e.id == null ? Ce.push(e) : Ce.splice(Kl(e.id), 0, e), Wi());
}
function Wi() {
  !nn && !br && ((br = !0), (Yr = Ki.then(Ji)));
}
function Wl(e) {
  const t = Ce.indexOf(e);
  t > We && Ce.splice(t, 1);
}
function Ql(e) {
  Z(e)
    ? Lt.push(...e)
    : (!Je || !Je.includes(e, e.allowRecurse ? yt + 1 : yt)) && Lt.push(e),
    Wi();
}
function yo(e, t = nn ? We + 1 : 0) {
  for (; t < Ce.length; t++) {
    const n = Ce[t];
    n && n.pre && (Ce.splice(t, 1), t--, n());
  }
}
function Qi(e) {
  if (Lt.length) {
    const t = [...new Set(Lt)];
    if (((Lt.length = 0), Je)) {
      Je.push(...t);
      return;
    }
    for (Je = t, Je.sort((n, r) => rn(n) - rn(r)), yt = 0; yt < Je.length; yt++)
      Je[yt]();
    (Je = null), (yt = 0);
  }
}
const rn = (e) => (e.id == null ? 1 / 0 : e.id),
  Jl = (e, t) => {
    const n = rn(e) - rn(t);
    if (n === 0) {
      if (e.pre && !t.pre) return -1;
      if (t.pre && !e.pre) return 1;
    }
    return n;
  };
function Ji(e) {
  (br = !1), (nn = !0), Ce.sort(Jl);
  const t = He;
  try {
    for (We = 0; We < Ce.length; We++) {
      const n = Ce[We];
      n && n.active !== !1 && at(n, null, 14);
    }
  } finally {
    (We = 0),
      (Ce.length = 0),
      Qi(),
      (nn = !1),
      (Yr = null),
      (Ce.length || Lt.length) && Ji();
  }
}
function Zl(e, t, ...n) {
  if (e.isUnmounted) return;
  const r = e.vnode.props || ue;
  let o = n;
  const i = t.startsWith("update:"),
    s = i && t.slice(7);
  if (s && s in r) {
    const f = `${s === "modelValue" ? "model" : s}Modifiers`,
      { number: g, trim: h } = r[f] || ue;
    h && (o = n.map((x) => (be(x) ? x.trim() : x))), g && (o = n.map(Ys));
  }
  let l,
    a = r[(l = tr(t))] || r[(l = tr(Qe(t)))];
  !a && i && (a = r[(l = tr(jt(t)))]), a && qe(a, e, 6, o);
  const c = r[l + "Once"];
  if (c) {
    if (!e.emitted) e.emitted = {};
    else if (e.emitted[l]) return;
    (e.emitted[l] = !0), qe(c, e, 6, o);
  }
}
function Zi(e, t, n = !1) {
  const r = t.emitsCache,
    o = r.get(e);
  if (o !== void 0) return o;
  const i = e.emits;
  let s = {},
    l = !1;
  if (!G(e)) {
    const a = (c) => {
      const f = Zi(c, t, !0);
      f && ((l = !0), pe(s, f));
    };
    !n && t.mixins.length && t.mixins.forEach(a),
      e.extends && a(e.extends),
      e.mixins && e.mixins.forEach(a);
  }
  return !i && !l
    ? (fe(e) && r.set(e, null), null)
    : (Z(i) ? i.forEach((a) => (s[a] = null)) : pe(s, i),
      fe(e) && r.set(e, s),
      s);
}
function Hn(e, t) {
  return !e || !In(t)
    ? !1
    : ((t = t.slice(2).replace(/Once$/, "")),
      re(e, t[0].toLowerCase() + t.slice(1)) || re(e, jt(t)) || re(e, t));
}
let Re = null,
  zn = null;
function Mn(e) {
  const t = Re;
  return (Re = e), (zn = (e && e.type.__scopeId) || null), t;
}
function Yl(e) {
  zn = e;
}
function Xl() {
  zn = null;
}
function Qt(e, t = Re, n) {
  if (!t || e._n) return e;
  const r = (...o) => {
    r._d && Oo(-1);
    const i = Mn(t);
    let s;
    try {
      s = e(...o);
    } finally {
      Mn(i), r._d && Oo(1);
    }
    return s;
  };
  return (r._n = !0), (r._c = !0), (r._d = !0), r;
}
function rr(e) {
  const {
    type: t,
    vnode: n,
    proxy: r,
    withProxy: o,
    props: i,
    propsOptions: [s],
    slots: l,
    attrs: a,
    emit: c,
    render: f,
    renderCache: g,
    data: h,
    setupState: x,
    ctx: M,
    inheritAttrs: A,
  } = e;
  let F, V;
  const W = Mn(e);
  try {
    if (n.shapeFlag & 4) {
      const L = o || r;
      (F = Ke(f.call(L, L, g, i, x, h, M))), (V = a);
    } else {
      const L = t;
      (F = Ke(
        L.length > 1 ? L(i, { attrs: a, slots: l, emit: c }) : L(i, null)
      )),
        (V = t.props ? a : Gl(a));
    }
  } catch (L) {
    (Xt.length = 0), jn(L, e, 1), (F = me(Xe));
  }
  let Y = F;
  if (V && A !== !1) {
    const L = Object.keys(V),
      { shapeFlag: $ } = Y;
    L.length && $ & 7 && (s && L.some($r) && (V = ea(V, s)), (Y = ft(Y, V)));
  }
  return (
    n.dirs && ((Y = ft(Y)), (Y.dirs = Y.dirs ? Y.dirs.concat(n.dirs) : n.dirs)),
    n.transition && (Y.transition = n.transition),
    (F = Y),
    Mn(W),
    F
  );
}
const Gl = (e) => {
    let t;
    for (const n in e)
      (n === "class" || n === "style" || In(n)) && ((t || (t = {}))[n] = e[n]);
    return t;
  },
  ea = (e, t) => {
    const n = {};
    for (const r in e) (!$r(r) || !(r.slice(9) in t)) && (n[r] = e[r]);
    return n;
  };
function ta(e, t, n) {
  const { props: r, children: o, component: i } = e,
    { props: s, children: l, patchFlag: a } = t,
    c = i.emitsOptions;
  if (t.dirs || t.transition) return !0;
  if (n && a >= 0) {
    if (a & 1024) return !0;
    if (a & 16) return r ? wo(r, s, c) : !!s;
    if (a & 8) {
      const f = t.dynamicProps;
      for (let g = 0; g < f.length; g++) {
        const h = f[g];
        if (s[h] !== r[h] && !Hn(c, h)) return !0;
      }
    }
  } else
    return (o || l) && (!l || !l.$stable)
      ? !0
      : r === s
      ? !1
      : r
      ? s
        ? wo(r, s, c)
        : !0
      : !!s;
  return !1;
}
function wo(e, t, n) {
  const r = Object.keys(t);
  if (r.length !== Object.keys(e).length) return !0;
  for (let o = 0; o < r.length; o++) {
    const i = r[o];
    if (t[i] !== e[i] && !Hn(n, i)) return !0;
  }
  return !1;
}
function na({ vnode: e, parent: t }, n) {
  for (; t && t.subTree === e; ) ((e = t.vnode).el = n), (t = t.parent);
}
const ra = (e) => e.__isSuspense;
function oa(e, t) {
  t && t.pendingBranch
    ? Z(e)
      ? t.effects.push(...e)
      : t.effects.push(e)
    : Ql(e);
}
const vn = {};
function ve(e, t, n) {
  return Yi(e, t, n);
}
function Yi(
  e,
  t,
  { immediate: n, deep: r, flush: o, onTrack: i, onTrigger: s } = ue
) {
  var l;
  const a = Ri() === ((l = ye) == null ? void 0 : l.scope) ? ye : null;
  let c,
    f = !1,
    g = !1;
  if (
    (de(e)
      ? ((c = () => e.value), (f = En(e)))
      : lt(e)
      ? ((c = () => e), (r = !0))
      : Z(e)
      ? ((g = !0),
        (f = e.some((L) => lt(L) || En(L))),
        (c = () =>
          e.map((L) => {
            if (de(L)) return L.value;
            if (lt(L)) return Ct(L);
            if (G(L)) return at(L, a, 2);
          })))
      : G(e)
      ? t
        ? (c = () => at(e, a, 2))
        : (c = () => {
            if (!(a && a.isUnmounted)) return h && h(), qe(e, a, 3, [x]);
          })
      : (c = He),
    t && r)
  ) {
    const L = c;
    c = () => Ct(L());
  }
  let h,
    x = (L) => {
      h = W.onStop = () => {
        at(L, a, 4);
      };
    },
    M;
  if (sn)
    if (
      ((x = He),
      t ? n && qe(t, a, 3, [c(), g ? [] : void 0, x]) : c(),
      o === "sync")
    ) {
      const L = Ga();
      M = L.__watcherHandles || (L.__watcherHandles = []);
    } else return He;
  let A = g ? new Array(e.length).fill(vn) : vn;
  const F = () => {
    if (W.active)
      if (t) {
        const L = W.run();
        (r || f || (g ? L.some(($, U) => en($, A[U])) : en(L, A))) &&
          (h && h(),
          qe(t, a, 3, [L, A === vn ? void 0 : g && A[0] === vn ? [] : A, x]),
          (A = L));
      } else W.run();
  };
  F.allowRecurse = !!t;
  let V;
  o === "sync"
    ? (V = F)
    : o === "post"
    ? (V = () => Se(F, a && a.suspense))
    : ((F.pre = !0), a && (F.id = a.uid), (V = () => Xr(F)));
  const W = new Ur(c, V);
  t
    ? n
      ? F()
      : (A = W.run())
    : o === "post"
    ? Se(W.run.bind(W), a && a.suspense)
    : W.run();
  const Y = () => {
    W.stop(), a && a.scope && Nr(a.scope.effects, W);
  };
  return M && M.push(Y), Y;
}
function ia(e, t, n) {
  const r = this.proxy,
    o = be(e) ? (e.includes(".") ? Xi(r, e) : () => r[e]) : e.bind(r, r);
  let i;
  G(t) ? (i = t) : ((i = t.handler), (n = t));
  const s = ye;
  Nt(this);
  const l = Yi(o, i.bind(r), n);
  return s ? Nt(s) : St(), l;
}
function Xi(e, t) {
  const n = t.split(".");
  return () => {
    let r = e;
    for (let o = 0; o < n.length && r; o++) r = r[n[o]];
    return r;
  };
}
function Ct(e, t) {
  if (!fe(e) || e.__v_skip || ((t = t || new Set()), t.has(e))) return e;
  if ((t.add(e), de(e))) Ct(e.value, t);
  else if (Z(e)) for (let n = 0; n < e.length; n++) Ct(e[n], t);
  else if (xi(e) || It(e))
    e.forEach((n) => {
      Ct(n, t);
    });
  else if (Si(e)) for (const n in e) Ct(e[n], t);
  return e;
}
function Pn(e, t) {
  const n = Re;
  if (n === null) return e;
  const r = Qn(n) || n.proxy,
    o = e.dirs || (e.dirs = []);
  for (let i = 0; i < t.length; i++) {
    let [s, l, a, c = ue] = t[i];
    s &&
      (G(s) && (s = { mounted: s, updated: s }),
      s.deep && Ct(l),
      o.push({
        dir: s,
        instance: r,
        value: l,
        oldValue: void 0,
        arg: a,
        modifiers: c,
      }));
  }
  return e;
}
function mt(e, t, n, r) {
  const o = e.dirs,
    i = t && t.dirs;
  for (let s = 0; s < o.length; s++) {
    const l = o[s];
    i && (l.oldValue = i[s].value);
    let a = l.dir[r];
    a && (Ht(), qe(a, n, 8, [e.el, l, e, t]), zt());
  }
}
function sa() {
  const e = {
    isMounted: !1,
    isLeaving: !1,
    isUnmounting: !1,
    leavingVNodes: new Map(),
  };
  return (
    an(() => {
      e.isMounted = !0;
    }),
    ht(() => {
      e.isUnmounting = !0;
    }),
    e
  );
}
const Fe = [Function, Array],
  Gi = {
    mode: String,
    appear: Boolean,
    persisted: Boolean,
    onBeforeEnter: Fe,
    onEnter: Fe,
    onAfterEnter: Fe,
    onEnterCancelled: Fe,
    onBeforeLeave: Fe,
    onLeave: Fe,
    onAfterLeave: Fe,
    onLeaveCancelled: Fe,
    onBeforeAppear: Fe,
    onAppear: Fe,
    onAfterAppear: Fe,
    onAppearCancelled: Fe,
  },
  la = {
    name: "BaseTransition",
    props: Gi,
    setup(e, { slots: t }) {
      const n = ze(),
        r = sa();
      let o;
      return () => {
        const i = t.default && ts(t.default(), !0);
        if (!i || !i.length) return;
        let s = i[0];
        if (i.length > 1) {
          for (const A of i)
            if (A.type !== Xe) {
              s = A;
              break;
            }
        }
        const l = te(e),
          { mode: a } = l;
        if (r.isLeaving) return or(s);
        const c = xo(s);
        if (!c) return or(s);
        const f = _r(c, l, r, n);
        yr(c, f);
        const g = n.subTree,
          h = g && xo(g);
        let x = !1;
        const { getTransitionKey: M } = c.type;
        if (M) {
          const A = M();
          o === void 0 ? (o = A) : A !== o && ((o = A), (x = !0));
        }
        if (h && h.type !== Xe && (!wt(c, h) || x)) {
          const A = _r(h, l, r, n);
          if ((yr(h, A), a === "out-in"))
            return (
              (r.isLeaving = !0),
              (A.afterLeave = () => {
                (r.isLeaving = !1), n.update.active !== !1 && n.update();
              }),
              or(s)
            );
          a === "in-out" &&
            c.type !== Xe &&
            (A.delayLeave = (F, V, W) => {
              const Y = es(r, h);
              (Y[String(h.key)] = h),
                (F._leaveCb = () => {
                  V(), (F._leaveCb = void 0), delete f.delayedLeave;
                }),
                (f.delayedLeave = W);
            });
        }
        return s;
      };
    },
  },
  aa = la;
function es(e, t) {
  const { leavingVNodes: n } = e;
  let r = n.get(t.type);
  return r || ((r = Object.create(null)), n.set(t.type, r)), r;
}
function _r(e, t, n, r) {
  const {
      appear: o,
      mode: i,
      persisted: s = !1,
      onBeforeEnter: l,
      onEnter: a,
      onAfterEnter: c,
      onEnterCancelled: f,
      onBeforeLeave: g,
      onLeave: h,
      onAfterLeave: x,
      onLeaveCancelled: M,
      onBeforeAppear: A,
      onAppear: F,
      onAfterAppear: V,
      onAppearCancelled: W,
    } = t,
    Y = String(e.key),
    L = es(n, e),
    $ = (p, b) => {
      p && qe(p, r, 9, b);
    },
    U = (p, b) => {
      const _ = b[1];
      $(p, b),
        Z(p) ? p.every((P) => P.length <= 1) && _() : p.length <= 1 && _();
    },
    q = {
      mode: i,
      persisted: s,
      beforeEnter(p) {
        let b = l;
        if (!n.isMounted)
          if (o) b = A || l;
          else return;
        p._leaveCb && p._leaveCb(!0);
        const _ = L[Y];
        _ && wt(e, _) && _.el._leaveCb && _.el._leaveCb(), $(b, [p]);
      },
      enter(p) {
        let b = a,
          _ = c,
          P = f;
        if (!n.isMounted)
          if (o) (b = F || a), (_ = V || c), (P = W || f);
          else return;
        let m = !1;
        const N = (p._enterCb = (w) => {
          m ||
            ((m = !0),
            w ? $(P, [p]) : $(_, [p]),
            q.delayedLeave && q.delayedLeave(),
            (p._enterCb = void 0));
        });
        b ? U(b, [p, N]) : N();
      },
      leave(p, b) {
        const _ = String(e.key);
        if ((p._enterCb && p._enterCb(!0), n.isUnmounting)) return b();
        $(g, [p]);
        let P = !1;
        const m = (p._leaveCb = (N) => {
          P ||
            ((P = !0),
            b(),
            N ? $(M, [p]) : $(x, [p]),
            (p._leaveCb = void 0),
            L[_] === e && delete L[_]);
        });
        (L[_] = e), h ? U(h, [p, m]) : m();
      },
      clone(p) {
        return _r(p, t, n, r);
      },
    };
  return q;
}
function or(e) {
  if (Dn(e)) return (e = ft(e)), (e.children = null), e;
}
function xo(e) {
  return Dn(e) ? (e.children ? e.children[0] : void 0) : e;
}
function yr(e, t) {
  e.shapeFlag & 6 && e.component
    ? yr(e.component.subTree, t)
    : e.shapeFlag & 128
    ? ((e.ssContent.transition = t.clone(e.ssContent)),
      (e.ssFallback.transition = t.clone(e.ssFallback)))
    : (e.transition = t);
}
function ts(e, t = !1, n) {
  let r = [],
    o = 0;
  for (let i = 0; i < e.length; i++) {
    let s = e[i];
    const l = n == null ? s.key : String(n) + String(s.key != null ? s.key : i);
    s.type === Ue
      ? (s.patchFlag & 128 && o++, (r = r.concat(ts(s.children, t, l))))
      : (t || s.type !== Xe) && r.push(l != null ? ft(s, { key: l }) : s);
  }
  if (o > 1) for (let i = 0; i < r.length; i++) r[i].patchFlag = -2;
  return r;
}
function ua(e, t) {
  return G(e) ? (() => pe({ name: e.name }, t, { setup: e }))() : e;
}
const xn = (e) => !!e.type.__asyncLoader,
  Dn = (e) => e.type.__isKeepAlive;
function ns(e, t) {
  os(e, "a", t);
}
function rs(e, t) {
  os(e, "da", t);
}
function os(e, t, n = ye) {
  const r =
    e.__wdc ||
    (e.__wdc = () => {
      let o = n;
      for (; o; ) {
        if (o.isDeactivated) return;
        o = o.parent;
      }
      return e();
    });
  if ((Vn(t, r, n), n)) {
    let o = n.parent;
    for (; o && o.parent; )
      Dn(o.parent.vnode) && ca(r, t, n, o), (o = o.parent);
  }
}
function ca(e, t, n, r) {
  const o = Vn(t, e, r, !0);
  ss(() => {
    Nr(r[t], o);
  }, n);
}
function Vn(e, t, n = ye, r = !1) {
  if (n) {
    const o = n[e] || (n[e] = []),
      i =
        t.__weh ||
        (t.__weh = (...s) => {
          if (n.isUnmounted) return;
          Ht(), Nt(n);
          const l = qe(t, n, e, s);
          return St(), zt(), l;
        });
    return r ? o.unshift(i) : o.push(i), i;
  }
}
const et =
    (e) =>
    (t, n = ye) =>
      (!sn || e === "sp") && Vn(e, (...r) => t(...r), n),
  fa = et("bm"),
  an = et("m"),
  is = et("bu"),
  da = et("u"),
  ht = et("bum"),
  ss = et("um"),
  ha = et("sp"),
  ga = et("rtg"),
  ma = et("rtc");
function pa(e, t = ye) {
  Vn("ec", e, t);
}
const ls = "components";
function Co(e, t) {
  return ba(ls, e, !0, t) || e;
}
const va = Symbol.for("v-ndc");
function ba(e, t, n = !0, r = !1) {
  const o = Re || ye;
  if (o) {
    const i = o.type;
    if (e === ls) {
      const l = Za(i, !1);
      if (l && (l === t || l === Qe(t) || l === $n(Qe(t)))) return i;
    }
    const s = ko(o[e] || i[e], t) || ko(o.appContext[e], t);
    return !s && r ? i : s;
  }
}
function ko(e, t) {
  return e && (e[t] || e[Qe(t)] || e[$n(Qe(t))]);
}
const wr = (e) => (e ? (_s(e) ? Qn(e) || e.proxy : wr(e.parent)) : null),
  Yt = pe(Object.create(null), {
    $: (e) => e,
    $el: (e) => e.vnode.el,
    $data: (e) => e.data,
    $props: (e) => e.props,
    $attrs: (e) => e.attrs,
    $slots: (e) => e.slots,
    $refs: (e) => e.refs,
    $parent: (e) => wr(e.parent),
    $root: (e) => wr(e.root),
    $emit: (e) => e.emit,
    $options: (e) => Gr(e),
    $forceUpdate: (e) => e.f || (e.f = () => Xr(e.update)),
    $nextTick: (e) => e.n || (e.n = Ze.bind(e.proxy)),
    $watch: (e) => ia.bind(e),
  }),
  ir = (e, t) => e !== ue && !e.__isScriptSetup && re(e, t),
  _a = {
    get({ _: e }, t) {
      const {
        ctx: n,
        setupState: r,
        data: o,
        props: i,
        accessCache: s,
        type: l,
        appContext: a,
      } = e;
      let c;
      if (t[0] !== "$") {
        const x = s[t];
        if (x !== void 0)
          switch (x) {
            case 1:
              return r[t];
            case 2:
              return o[t];
            case 4:
              return n[t];
            case 3:
              return i[t];
          }
        else {
          if (ir(r, t)) return (s[t] = 1), r[t];
          if (o !== ue && re(o, t)) return (s[t] = 2), o[t];
          if ((c = e.propsOptions[0]) && re(c, t)) return (s[t] = 3), i[t];
          if (n !== ue && re(n, t)) return (s[t] = 4), n[t];
          xr && (s[t] = 0);
        }
      }
      const f = Yt[t];
      let g, h;
      if (f) return t === "$attrs" && Ee(e, "get", t), f(e);
      if ((g = l.__cssModules) && (g = g[t])) return g;
      if (n !== ue && re(n, t)) return (s[t] = 4), n[t];
      if (((h = a.config.globalProperties), re(h, t))) return h[t];
    },
    set({ _: e }, t, n) {
      const { data: r, setupState: o, ctx: i } = e;
      return ir(o, t)
        ? ((o[t] = n), !0)
        : r !== ue && re(r, t)
        ? ((r[t] = n), !0)
        : re(e.props, t) || (t[0] === "$" && t.slice(1) in e)
        ? !1
        : ((i[t] = n), !0);
    },
    has(
      {
        _: {
          data: e,
          setupState: t,
          accessCache: n,
          ctx: r,
          appContext: o,
          propsOptions: i,
        },
      },
      s
    ) {
      let l;
      return (
        !!n[s] ||
        (e !== ue && re(e, s)) ||
        ir(t, s) ||
        ((l = i[0]) && re(l, s)) ||
        re(r, s) ||
        re(Yt, s) ||
        re(o.config.globalProperties, s)
      );
    },
    defineProperty(e, t, n) {
      return (
        n.get != null
          ? (e._.accessCache[t] = 0)
          : re(n, "value") && this.set(e, t, n.value, null),
        Reflect.defineProperty(e, t, n)
      );
    },
  };
function So(e) {
  return Z(e) ? e.reduce((t, n) => ((t[n] = null), t), {}) : e;
}
let xr = !0;
function ya(e) {
  const t = Gr(e),
    n = e.proxy,
    r = e.ctx;
  (xr = !1), t.beforeCreate && Eo(t.beforeCreate, e, "bc");
  const {
    data: o,
    computed: i,
    methods: s,
    watch: l,
    provide: a,
    inject: c,
    created: f,
    beforeMount: g,
    mounted: h,
    beforeUpdate: x,
    updated: M,
    activated: A,
    deactivated: F,
    beforeDestroy: V,
    beforeUnmount: W,
    destroyed: Y,
    unmounted: L,
    render: $,
    renderTracked: U,
    renderTriggered: q,
    errorCaptured: p,
    serverPrefetch: b,
    expose: _,
    inheritAttrs: P,
    components: m,
    directives: N,
    filters: w,
  } = t;
  if ((c && wa(c, r, null), s))
    for (const y in s) {
      const z = s[y];
      G(z) && (r[y] = z.bind(n));
    }
  if (o) {
    const y = o.call(n, n);
    fe(y) && (e.data = Dt(y));
  }
  if (((xr = !0), i))
    for (const y in i) {
      const z = i[y],
        _e = G(z) ? z.bind(n, n) : G(z.get) ? z.get.bind(n, n) : He,
        ne = !G(z) && G(z.set) ? z.set.bind(n) : He,
        ie = I({ get: _e, set: ne });
      Object.defineProperty(r, y, {
        enumerable: !0,
        configurable: !0,
        get: () => ie.value,
        set: (E) => (ie.value = E),
      });
    }
  if (l) for (const y in l) as(l[y], r, n, y);
  if (a) {
    const y = G(a) ? a.call(n) : a;
    Reflect.ownKeys(y).forEach((z) => {
      Ma(z, y[z]);
    });
  }
  f && Eo(f, e, "c");
  function K(y, z) {
    Z(z) ? z.forEach((_e) => y(_e.bind(n))) : z && y(z.bind(n));
  }
  if (
    (K(fa, g),
    K(an, h),
    K(is, x),
    K(da, M),
    K(ns, A),
    K(rs, F),
    K(pa, p),
    K(ma, U),
    K(ga, q),
    K(ht, W),
    K(ss, L),
    K(ha, b),
    Z(_))
  )
    if (_.length) {
      const y = e.exposed || (e.exposed = {});
      _.forEach((z) => {
        Object.defineProperty(y, z, {
          get: () => n[z],
          set: (_e) => (n[z] = _e),
        });
      });
    } else e.exposed || (e.exposed = {});
  $ && e.render === He && (e.render = $),
    P != null && (e.inheritAttrs = P),
    m && (e.components = m),
    N && (e.directives = N);
}
function wa(e, t, n = He) {
  Z(e) && (e = Cr(e));
  for (const r in e) {
    const o = e[r];
    let i;
    fe(o)
      ? "default" in o
        ? (i = Bt(o.from || r, o.default, !0))
        : (i = Bt(o.from || r))
      : (i = Bt(o)),
      de(i)
        ? Object.defineProperty(t, r, {
            enumerable: !0,
            configurable: !0,
            get: () => i.value,
            set: (s) => (i.value = s),
          })
        : (t[r] = i);
  }
}
function Eo(e, t, n) {
  qe(Z(e) ? e.map((r) => r.bind(t.proxy)) : e.bind(t.proxy), t, n);
}
function as(e, t, n, r) {
  const o = r.includes(".") ? Xi(n, r) : () => n[r];
  if (be(e)) {
    const i = t[e];
    G(i) && ve(o, i);
  } else if (G(e)) ve(o, e.bind(n));
  else if (fe(e))
    if (Z(e)) e.forEach((i) => as(i, t, n, r));
    else {
      const i = G(e.handler) ? e.handler.bind(n) : t[e.handler];
      G(i) && ve(o, i, e);
    }
}
function Gr(e) {
  const t = e.type,
    { mixins: n, extends: r } = t,
    {
      mixins: o,
      optionsCache: i,
      config: { optionMergeStrategies: s },
    } = e.appContext,
    l = i.get(t);
  let a;
  return (
    l
      ? (a = l)
      : !o.length && !n && !r
      ? (a = t)
      : ((a = {}), o.length && o.forEach((c) => Tn(a, c, s, !0)), Tn(a, t, s)),
    fe(t) && i.set(t, a),
    a
  );
}
function Tn(e, t, n, r = !1) {
  const { mixins: o, extends: i } = t;
  i && Tn(e, i, n, !0), o && o.forEach((s) => Tn(e, s, n, !0));
  for (const s in t)
    if (!(r && s === "expose")) {
      const l = xa[s] || (n && n[s]);
      e[s] = l ? l(e[s], t[s]) : t[s];
    }
  return e;
}
const xa = {
  data: Mo,
  props: Po,
  emits: Po,
  methods: Jt,
  computed: Jt,
  beforeCreate: ke,
  created: ke,
  beforeMount: ke,
  mounted: ke,
  beforeUpdate: ke,
  updated: ke,
  beforeDestroy: ke,
  beforeUnmount: ke,
  destroyed: ke,
  unmounted: ke,
  activated: ke,
  deactivated: ke,
  errorCaptured: ke,
  serverPrefetch: ke,
  components: Jt,
  directives: Jt,
  watch: ka,
  provide: Mo,
  inject: Ca,
};
function Mo(e, t) {
  return t
    ? e
      ? function () {
          return pe(
            G(e) ? e.call(this, this) : e,
            G(t) ? t.call(this, this) : t
          );
        }
      : t
    : e;
}
function Ca(e, t) {
  return Jt(Cr(e), Cr(t));
}
function Cr(e) {
  if (Z(e)) {
    const t = {};
    for (let n = 0; n < e.length; n++) t[e[n]] = e[n];
    return t;
  }
  return e;
}
function ke(e, t) {
  return e ? [...new Set([].concat(e, t))] : t;
}
function Jt(e, t) {
  return e ? pe(Object.create(null), e, t) : t;
}
function Po(e, t) {
  return e
    ? Z(e) && Z(t)
      ? [...new Set([...e, ...t])]
      : pe(Object.create(null), So(e), So(t ?? {}))
    : t;
}
function ka(e, t) {
  if (!e) return t;
  if (!t) return e;
  const n = pe(Object.create(null), e);
  for (const r in t) n[r] = ke(e[r], t[r]);
  return n;
}
function us() {
  return {
    app: null,
    config: {
      isNativeTag: Us,
      performance: !1,
      globalProperties: {},
      optionMergeStrategies: {},
      errorHandler: void 0,
      warnHandler: void 0,
      compilerOptions: {},
    },
    mixins: [],
    components: {},
    directives: {},
    provides: Object.create(null),
    optionsCache: new WeakMap(),
    propsCache: new WeakMap(),
    emitsCache: new WeakMap(),
  };
}
let Sa = 0;
function Ea(e, t) {
  return function (r, o = null) {
    G(r) || (r = pe({}, r)), o != null && !fe(o) && (o = null);
    const i = us(),
      s = new Set();
    let l = !1;
    const a = (i.app = {
      _uid: Sa++,
      _component: r,
      _props: o,
      _container: null,
      _context: i,
      _instance: null,
      version: eu,
      get config() {
        return i.config;
      },
      set config(c) {},
      use(c, ...f) {
        return (
          s.has(c) ||
            (c && G(c.install)
              ? (s.add(c), c.install(a, ...f))
              : G(c) && (s.add(c), c(a, ...f))),
          a
        );
      },
      mixin(c) {
        return i.mixins.includes(c) || i.mixins.push(c), a;
      },
      component(c, f) {
        return f ? ((i.components[c] = f), a) : i.components[c];
      },
      directive(c, f) {
        return f ? ((i.directives[c] = f), a) : i.directives[c];
      },
      mount(c, f, g) {
        if (!l) {
          const h = me(r, o);
          return (
            (h.appContext = i),
            f && t ? t(h, c) : e(h, c, g),
            (l = !0),
            (a._container = c),
            (c.__vue_app__ = a),
            Qn(h.component) || h.component.proxy
          );
        }
      },
      unmount() {
        l && (e(null, a._container), delete a._container.__vue_app__);
      },
      provide(c, f) {
        return (i.provides[c] = f), a;
      },
      runWithContext(c) {
        Rn = a;
        try {
          return c();
        } finally {
          Rn = null;
        }
      },
    });
    return a;
  };
}
let Rn = null;
function Ma(e, t) {
  if (ye) {
    let n = ye.provides;
    const r = ye.parent && ye.parent.provides;
    r === n && (n = ye.provides = Object.create(r)), (n[e] = t);
  }
}
function Bt(e, t, n = !1) {
  const r = ye || Re;
  if (r || Rn) {
    const o = r
      ? r.parent == null
        ? r.vnode.appContext && r.vnode.appContext.provides
        : r.parent.provides
      : Rn._context.provides;
    if (o && e in o) return o[e];
    if (arguments.length > 1) return n && G(t) ? t.call(r && r.proxy) : t;
  }
}
function Pa(e, t, n, r = !1) {
  const o = {},
    i = {};
  kn(i, Kn, 1), (e.propsDefaults = Object.create(null)), cs(e, t, o, i);
  for (const s in e.propsOptions[0]) s in o || (o[s] = void 0);
  n ? (e.props = r ? o : Il(o)) : e.type.props ? (e.props = o) : (e.props = i),
    (e.attrs = i);
}
function Ta(e, t, n, r) {
  const {
      props: o,
      attrs: i,
      vnode: { patchFlag: s },
    } = e,
    l = te(o),
    [a] = e.propsOptions;
  let c = !1;
  if ((r || s > 0) && !(s & 16)) {
    if (s & 8) {
      const f = e.vnode.dynamicProps;
      for (let g = 0; g < f.length; g++) {
        let h = f[g];
        if (Hn(e.emitsOptions, h)) continue;
        const x = t[h];
        if (a)
          if (re(i, h)) x !== i[h] && ((i[h] = x), (c = !0));
          else {
            const M = Qe(h);
            o[M] = kr(a, l, M, x, e, !1);
          }
        else x !== i[h] && ((i[h] = x), (c = !0));
      }
    }
  } else {
    cs(e, t, o, i) && (c = !0);
    let f;
    for (const g in l)
      (!t || (!re(t, g) && ((f = jt(g)) === g || !re(t, f)))) &&
        (a
          ? n &&
            (n[g] !== void 0 || n[f] !== void 0) &&
            (o[g] = kr(a, l, g, void 0, e, !0))
          : delete o[g]);
    if (i !== l)
      for (const g in i) (!t || !re(t, g)) && (delete i[g], (c = !0));
  }
  c && Ge(e, "set", "$attrs");
}
function cs(e, t, n, r) {
  const [o, i] = e.propsOptions;
  let s = !1,
    l;
  if (t)
    for (let a in t) {
      if (wn(a)) continue;
      const c = t[a];
      let f;
      o && re(o, (f = Qe(a)))
        ? !i || !i.includes(f)
          ? (n[f] = c)
          : ((l || (l = {}))[f] = c)
        : Hn(e.emitsOptions, a) ||
          ((!(a in r) || c !== r[a]) && ((r[a] = c), (s = !0)));
    }
  if (i) {
    const a = te(n),
      c = l || ue;
    for (let f = 0; f < i.length; f++) {
      const g = i[f];
      n[g] = kr(o, a, g, c[g], e, !re(c, g));
    }
  }
  return s;
}
function kr(e, t, n, r, o, i) {
  const s = e[n];
  if (s != null) {
    const l = re(s, "default");
    if (l && r === void 0) {
      const a = s.default;
      if (s.type !== Function && !s.skipFactory && G(a)) {
        const { propsDefaults: c } = o;
        n in c ? (r = c[n]) : (Nt(o), (r = c[n] = a.call(null, t)), St());
      } else r = a;
    }
    s[0] &&
      (i && !l ? (r = !1) : s[1] && (r === "" || r === jt(n)) && (r = !0));
  }
  return r;
}
function fs(e, t, n = !1) {
  const r = t.propsCache,
    o = r.get(e);
  if (o) return o;
  const i = e.props,
    s = {},
    l = [];
  let a = !1;
  if (!G(e)) {
    const f = (g) => {
      a = !0;
      const [h, x] = fs(g, t, !0);
      pe(s, h), x && l.push(...x);
    };
    !n && t.mixins.length && t.mixins.forEach(f),
      e.extends && f(e.extends),
      e.mixins && e.mixins.forEach(f);
  }
  if (!i && !a) return fe(e) && r.set(e, qt), qt;
  if (Z(i))
    for (let f = 0; f < i.length; f++) {
      const g = Qe(i[f]);
      To(g) && (s[g] = ue);
    }
  else if (i)
    for (const f in i) {
      const g = Qe(f);
      if (To(g)) {
        const h = i[f],
          x = (s[g] = Z(h) || G(h) ? { type: h } : pe({}, h));
        if (x) {
          const M = Fo(Boolean, x.type),
            A = Fo(String, x.type);
          (x[0] = M > -1),
            (x[1] = A < 0 || M < A),
            (M > -1 || re(x, "default")) && l.push(g);
        }
      }
    }
  const c = [s, l];
  return fe(e) && r.set(e, c), c;
}
function To(e) {
  return e[0] !== "$";
}
function Ro(e) {
  const t = e && e.toString().match(/^\s*(function|class) (\w+)/);
  return t ? t[2] : e === null ? "null" : "";
}
function Ao(e, t) {
  return Ro(e) === Ro(t);
}
function Fo(e, t) {
  return Z(t) ? t.findIndex((n) => Ao(n, e)) : G(t) && Ao(t, e) ? 0 : -1;
}
const ds = (e) => e[0] === "_" || e === "$stable",
  eo = (e) => (Z(e) ? e.map(Ke) : [Ke(e)]),
  Ra = (e, t, n) => {
    if (t._n) return t;
    const r = Qt((...o) => eo(t(...o)), n);
    return (r._c = !1), r;
  },
  hs = (e, t, n) => {
    const r = e._ctx;
    for (const o in e) {
      if (ds(o)) continue;
      const i = e[o];
      if (G(i)) t[o] = Ra(o, i, r);
      else if (i != null) {
        const s = eo(i);
        t[o] = () => s;
      }
    }
  },
  gs = (e, t) => {
    const n = eo(t);
    e.slots.default = () => n;
  },
  Aa = (e, t) => {
    if (e.vnode.shapeFlag & 32) {
      const n = t._;
      n ? ((e.slots = te(t)), kn(t, "_", n)) : hs(t, (e.slots = {}));
    } else (e.slots = {}), t && gs(e, t);
    kn(e.slots, Kn, 1);
  },
  Fa = (e, t, n) => {
    const { vnode: r, slots: o } = e;
    let i = !0,
      s = ue;
    if (r.shapeFlag & 32) {
      const l = t._;
      l
        ? n && l === 1
          ? (i = !1)
          : (pe(o, t), !n && l === 1 && delete o._)
        : ((i = !t.$stable), hs(t, o)),
        (s = t);
    } else t && (gs(e, t), (s = { default: 1 }));
    if (i) for (const l in o) !ds(l) && !(l in s) && delete o[l];
  };
function Sr(e, t, n, r, o = !1) {
  if (Z(e)) {
    e.forEach((h, x) => Sr(h, t && (Z(t) ? t[x] : t), n, r, o));
    return;
  }
  if (xn(r) && !o) return;
  const i = r.shapeFlag & 4 ? Qn(r.component) || r.component.proxy : r.el,
    s = o ? null : i,
    { i: l, r: a } = e,
    c = t && t.r,
    f = l.refs === ue ? (l.refs = {}) : l.refs,
    g = l.setupState;
  if (
    (c != null &&
      c !== a &&
      (be(c)
        ? ((f[c] = null), re(g, c) && (g[c] = null))
        : de(c) && (c.value = null)),
    G(a))
  )
    at(a, l, 12, [s, f]);
  else {
    const h = be(a),
      x = de(a);
    if (h || x) {
      const M = () => {
        if (e.f) {
          const A = h ? (re(g, a) ? g[a] : f[a]) : a.value;
          o
            ? Z(A) && Nr(A, i)
            : Z(A)
            ? A.includes(i) || A.push(i)
            : h
            ? ((f[a] = [i]), re(g, a) && (g[a] = f[a]))
            : ((a.value = [i]), e.k && (f[e.k] = a.value));
        } else
          h
            ? ((f[a] = s), re(g, a) && (g[a] = s))
            : x && ((a.value = s), e.k && (f[e.k] = s));
      };
      s ? ((M.id = -1), Se(M, n)) : M();
    }
  }
}
const Se = oa;
function Oa(e) {
  return qa(e);
}
function qa(e, t) {
  const n = gr();
  n.__VUE__ = !0;
  const {
      insert: r,
      remove: o,
      patchProp: i,
      createElement: s,
      createText: l,
      createComment: a,
      setText: c,
      setElementText: f,
      parentNode: g,
      nextSibling: h,
      setScopeId: x = He,
      insertStaticContent: M,
    } = e,
    A = (
      u,
      d,
      v,
      k = null,
      C = null,
      R = null,
      B = !1,
      T = null,
      O = !!d.dynamicChildren
    ) => {
      if (u === d) return;
      u && !wt(u, d) && ((k = Le(u)), E(u, C, R, !0), (u = null)),
        d.patchFlag === -2 && ((O = !1), (d.dynamicChildren = null));
      const { type: S, ref: Q, shapeFlag: D } = d;
      switch (S) {
        case Un:
          F(u, d, v, k);
          break;
        case Xe:
          V(u, d, v, k);
          break;
        case sr:
          u == null && W(d, v, k, B);
          break;
        case Ue:
          m(u, d, v, k, C, R, B, T, O);
          break;
        default:
          D & 1
            ? $(u, d, v, k, C, R, B, T, O)
            : D & 6
            ? N(u, d, v, k, C, R, B, T, O)
            : (D & 64 || D & 128) && S.process(u, d, v, k, C, R, B, T, O, Et);
      }
      Q != null && C && Sr(Q, u && u.ref, R, d || u, !d);
    },
    F = (u, d, v, k) => {
      if (u == null) r((d.el = l(d.children)), v, k);
      else {
        const C = (d.el = u.el);
        d.children !== u.children && c(C, d.children);
      }
    },
    V = (u, d, v, k) => {
      u == null ? r((d.el = a(d.children || "")), v, k) : (d.el = u.el);
    },
    W = (u, d, v, k) => {
      [u.el, u.anchor] = M(u.children, d, v, k, u.el, u.anchor);
    },
    Y = ({ el: u, anchor: d }, v, k) => {
      let C;
      for (; u && u !== d; ) (C = h(u)), r(u, v, k), (u = C);
      r(d, v, k);
    },
    L = ({ el: u, anchor: d }) => {
      let v;
      for (; u && u !== d; ) (v = h(u)), o(u), (u = v);
      o(d);
    },
    $ = (u, d, v, k, C, R, B, T, O) => {
      (B = B || d.type === "svg"),
        u == null ? U(d, v, k, C, R, B, T, O) : b(u, d, C, R, B, T, O);
    },
    U = (u, d, v, k, C, R, B, T) => {
      let O, S;
      const { type: Q, props: D, shapeFlag: J, transition: X, dirs: ee } = u;
      if (
        ((O = u.el = s(u.type, R, D && D.is, D)),
        J & 8
          ? f(O, u.children)
          : J & 16 &&
            p(u.children, O, null, k, C, R && Q !== "foreignObject", B, T),
        ee && mt(u, null, k, "created"),
        q(O, u, u.scopeId, B, k),
        D)
      ) {
        for (const oe in D)
          oe !== "value" &&
            !wn(oe) &&
            i(O, oe, null, D[oe], R, u.children, k, C, ae);
        "value" in D && i(O, "value", null, D.value),
          (S = D.onVnodeBeforeMount) && Ve(S, k, u);
      }
      ee && mt(u, null, k, "beforeMount");
      const se = (!C || (C && !C.pendingBranch)) && X && !X.persisted;
      se && X.beforeEnter(O),
        r(O, d, v),
        ((S = D && D.onVnodeMounted) || se || ee) &&
          Se(() => {
            S && Ve(S, k, u), se && X.enter(O), ee && mt(u, null, k, "mounted");
          }, C);
    },
    q = (u, d, v, k, C) => {
      if ((v && x(u, v), k)) for (let R = 0; R < k.length; R++) x(u, k[R]);
      if (C) {
        let R = C.subTree;
        if (d === R) {
          const B = C.vnode;
          q(u, B, B.scopeId, B.slotScopeIds, C.parent);
        }
      }
    },
    p = (u, d, v, k, C, R, B, T, O = 0) => {
      for (let S = O; S < u.length; S++) {
        const Q = (u[S] = T ? it(u[S]) : Ke(u[S]));
        A(null, Q, d, v, k, C, R, B, T);
      }
    },
    b = (u, d, v, k, C, R, B) => {
      const T = (d.el = u.el);
      let { patchFlag: O, dynamicChildren: S, dirs: Q } = d;
      O |= u.patchFlag & 16;
      const D = u.props || ue,
        J = d.props || ue;
      let X;
      v && pt(v, !1),
        (X = J.onVnodeBeforeUpdate) && Ve(X, v, d, u),
        Q && mt(d, u, v, "beforeUpdate"),
        v && pt(v, !0);
      const ee = C && d.type !== "foreignObject";
      if (
        (S
          ? _(u.dynamicChildren, S, T, v, k, ee, R)
          : B || z(u, d, T, null, v, k, ee, R, !1),
        O > 0)
      ) {
        if (O & 16) P(T, d, D, J, v, k, C);
        else if (
          (O & 2 && D.class !== J.class && i(T, "class", null, J.class, C),
          O & 4 && i(T, "style", D.style, J.style, C),
          O & 8)
        ) {
          const se = d.dynamicProps;
          for (let oe = 0; oe < se.length; oe++) {
            const he = se[oe],
              Be = D[he],
              Mt = J[he];
            (Mt !== Be || he === "value") &&
              i(T, he, Be, Mt, C, u.children, v, k, ae);
          }
        }
        O & 1 && u.children !== d.children && f(T, d.children);
      } else !B && S == null && P(T, d, D, J, v, k, C);
      ((X = J.onVnodeUpdated) || Q) &&
        Se(() => {
          X && Ve(X, v, d, u), Q && mt(d, u, v, "updated");
        }, k);
    },
    _ = (u, d, v, k, C, R, B) => {
      for (let T = 0; T < d.length; T++) {
        const O = u[T],
          S = d[T],
          Q =
            O.el && (O.type === Ue || !wt(O, S) || O.shapeFlag & 70)
              ? g(O.el)
              : v;
        A(O, S, Q, null, k, C, R, B, !0);
      }
    },
    P = (u, d, v, k, C, R, B) => {
      if (v !== k) {
        if (v !== ue)
          for (const T in v)
            !wn(T) && !(T in k) && i(u, T, v[T], null, B, d.children, C, R, ae);
        for (const T in k) {
          if (wn(T)) continue;
          const O = k[T],
            S = v[T];
          O !== S && T !== "value" && i(u, T, S, O, B, d.children, C, R, ae);
        }
        "value" in k && i(u, "value", v.value, k.value);
      }
    },
    m = (u, d, v, k, C, R, B, T, O) => {
      const S = (d.el = u ? u.el : l("")),
        Q = (d.anchor = u ? u.anchor : l(""));
      let { patchFlag: D, dynamicChildren: J, slotScopeIds: X } = d;
      X && (T = T ? T.concat(X) : X),
        u == null
          ? (r(S, v, k), r(Q, v, k), p(d.children, v, Q, C, R, B, T, O))
          : D > 0 && D & 64 && J && u.dynamicChildren
          ? (_(u.dynamicChildren, J, v, C, R, B, T),
            (d.key != null || (C && d === C.subTree)) && ms(u, d, !0))
          : z(u, d, v, Q, C, R, B, T, O);
    },
    N = (u, d, v, k, C, R, B, T, O) => {
      (d.slotScopeIds = T),
        u == null
          ? d.shapeFlag & 512
            ? C.ctx.activate(d, v, k, B, O)
            : w(d, v, k, C, R, B, O)
          : j(u, d, O);
    },
    w = (u, d, v, k, C, R, B) => {
      const T = (u.component = Ua(u, k, C));
      if ((Dn(u) && (T.ctx.renderer = Et), Ka(T), T.asyncDep)) {
        if ((C && C.registerDep(T, K), !u.el)) {
          const O = (T.subTree = me(Xe));
          V(null, O, d, v);
        }
        return;
      }
      K(T, u, d, v, C, R, B);
    },
    j = (u, d, v) => {
      const k = (d.component = u.component);
      if (ta(u, d, v))
        if (k.asyncDep && !k.asyncResolved) {
          y(k, d, v);
          return;
        } else (k.next = d), Wl(k.update), k.update();
      else (d.el = u.el), (k.vnode = d);
    },
    K = (u, d, v, k, C, R, B) => {
      const T = () => {
          if (u.isMounted) {
            let { next: Q, bu: D, u: J, parent: X, vnode: ee } = u,
              se = Q,
              oe;
            pt(u, !1),
              Q ? ((Q.el = ee.el), y(u, Q, B)) : (Q = ee),
              D && nr(D),
              (oe = Q.props && Q.props.onVnodeBeforeUpdate) && Ve(oe, X, Q, ee),
              pt(u, !0);
            const he = rr(u),
              Be = u.subTree;
            (u.subTree = he),
              A(Be, he, g(Be.el), Le(Be), u, C, R),
              (Q.el = he.el),
              se === null && na(u, he.el),
              J && Se(J, C),
              (oe = Q.props && Q.props.onVnodeUpdated) &&
                Se(() => Ve(oe, X, Q, ee), C);
          } else {
            let Q;
            const { el: D, props: J } = d,
              { bm: X, m: ee, parent: se } = u,
              oe = xn(d);
            if (
              (pt(u, !1),
              X && nr(X),
              !oe && (Q = J && J.onVnodeBeforeMount) && Ve(Q, se, d),
              pt(u, !0),
              D && er)
            ) {
              const he = () => {
                (u.subTree = rr(u)), er(D, u.subTree, u, C, null);
              };
              oe
                ? d.type.__asyncLoader().then(() => !u.isUnmounted && he())
                : he();
            } else {
              const he = (u.subTree = rr(u));
              A(null, he, v, k, u, C, R), (d.el = he.el);
            }
            if ((ee && Se(ee, C), !oe && (Q = J && J.onVnodeMounted))) {
              const he = d;
              Se(() => Ve(Q, se, he), C);
            }
            (d.shapeFlag & 256 ||
              (se && xn(se.vnode) && se.vnode.shapeFlag & 256)) &&
              u.a &&
              Se(u.a, C),
              (u.isMounted = !0),
              (d = v = k = null);
          }
        },
        O = (u.effect = new Ur(T, () => Xr(S), u.scope)),
        S = (u.update = () => O.run());
      (S.id = u.uid), pt(u, !0), S();
    },
    y = (u, d, v) => {
      d.component = u;
      const k = u.vnode.props;
      (u.vnode = d),
        (u.next = null),
        Ta(u, d.props, k, v),
        Fa(u, d.children, v),
        Ht(),
        yo(),
        zt();
    },
    z = (u, d, v, k, C, R, B, T, O = !1) => {
      const S = u && u.children,
        Q = u ? u.shapeFlag : 0,
        D = d.children,
        { patchFlag: J, shapeFlag: X } = d;
      if (J > 0) {
        if (J & 128) {
          ne(S, D, v, k, C, R, B, T, O);
          return;
        } else if (J & 256) {
          _e(S, D, v, k, C, R, B, T, O);
          return;
        }
      }
      X & 8
        ? (Q & 16 && ae(S, C, R), D !== S && f(v, D))
        : Q & 16
        ? X & 16
          ? ne(S, D, v, k, C, R, B, T, O)
          : ae(S, C, R, !0)
        : (Q & 8 && f(v, ""), X & 16 && p(D, v, k, C, R, B, T, O));
    },
    _e = (u, d, v, k, C, R, B, T, O) => {
      (u = u || qt), (d = d || qt);
      const S = u.length,
        Q = d.length,
        D = Math.min(S, Q);
      let J;
      for (J = 0; J < D; J++) {
        const X = (d[J] = O ? it(d[J]) : Ke(d[J]));
        A(u[J], X, v, null, C, R, B, T, O);
      }
      S > Q ? ae(u, C, R, !0, !1, D) : p(d, v, k, C, R, B, T, O, D);
    },
    ne = (u, d, v, k, C, R, B, T, O) => {
      let S = 0;
      const Q = d.length;
      let D = u.length - 1,
        J = Q - 1;
      for (; S <= D && S <= J; ) {
        const X = u[S],
          ee = (d[S] = O ? it(d[S]) : Ke(d[S]));
        if (wt(X, ee)) A(X, ee, v, null, C, R, B, T, O);
        else break;
        S++;
      }
      for (; S <= D && S <= J; ) {
        const X = u[D],
          ee = (d[J] = O ? it(d[J]) : Ke(d[J]));
        if (wt(X, ee)) A(X, ee, v, null, C, R, B, T, O);
        else break;
        D--, J--;
      }
      if (S > D) {
        if (S <= J) {
          const X = J + 1,
            ee = X < Q ? d[X].el : k;
          for (; S <= J; )
            A(null, (d[S] = O ? it(d[S]) : Ke(d[S])), v, ee, C, R, B, T, O),
              S++;
        }
      } else if (S > J) for (; S <= D; ) E(u[S], C, R, !0), S++;
      else {
        const X = S,
          ee = S,
          se = new Map();
        for (S = ee; S <= J; S++) {
          const Pe = (d[S] = O ? it(d[S]) : Ke(d[S]));
          Pe.key != null && se.set(Pe.key, S);
        }
        let oe,
          he = 0;
        const Be = J - ee + 1;
        let Mt = !1,
          ao = 0;
        const Vt = new Array(Be);
        for (S = 0; S < Be; S++) Vt[S] = 0;
        for (S = X; S <= D; S++) {
          const Pe = u[S];
          if (he >= Be) {
            E(Pe, C, R, !0);
            continue;
          }
          let De;
          if (Pe.key != null) De = se.get(Pe.key);
          else
            for (oe = ee; oe <= J; oe++)
              if (Vt[oe - ee] === 0 && wt(Pe, d[oe])) {
                De = oe;
                break;
              }
          De === void 0
            ? E(Pe, C, R, !0)
            : ((Vt[De - ee] = S + 1),
              De >= ao ? (ao = De) : (Mt = !0),
              A(Pe, d[De], v, null, C, R, B, T, O),
              he++);
        }
        const uo = Mt ? Ia(Vt) : qt;
        for (oe = uo.length - 1, S = Be - 1; S >= 0; S--) {
          const Pe = ee + S,
            De = d[Pe],
            co = Pe + 1 < Q ? d[Pe + 1].el : k;
          Vt[S] === 0
            ? A(null, De, v, co, C, R, B, T, O)
            : Mt && (oe < 0 || S !== uo[oe] ? ie(De, v, co, 2) : oe--);
        }
      }
    },
    ie = (u, d, v, k, C = null) => {
      const { el: R, type: B, transition: T, children: O, shapeFlag: S } = u;
      if (S & 6) {
        ie(u.component.subTree, d, v, k);
        return;
      }
      if (S & 128) {
        u.suspense.move(d, v, k);
        return;
      }
      if (S & 64) {
        B.move(u, d, v, Et);
        return;
      }
      if (B === Ue) {
        r(R, d, v);
        for (let D = 0; D < O.length; D++) ie(O[D], d, v, k);
        r(u.anchor, d, v);
        return;
      }
      if (B === sr) {
        Y(u, d, v);
        return;
      }
      if (k !== 2 && S & 1 && T)
        if (k === 0) T.beforeEnter(R), r(R, d, v), Se(() => T.enter(R), C);
        else {
          const { leave: D, delayLeave: J, afterLeave: X } = T,
            ee = () => r(R, d, v),
            se = () => {
              D(R, () => {
                ee(), X && X();
              });
            };
          J ? J(R, ee, se) : se();
        }
      else r(R, d, v);
    },
    E = (u, d, v, k = !1, C = !1) => {
      const {
        type: R,
        props: B,
        ref: T,
        children: O,
        dynamicChildren: S,
        shapeFlag: Q,
        patchFlag: D,
        dirs: J,
      } = u;
      if ((T != null && Sr(T, null, v, u, !0), Q & 256)) {
        d.ctx.deactivate(u);
        return;
      }
      const X = Q & 1 && J,
        ee = !xn(u);
      let se;
      if ((ee && (se = B && B.onVnodeBeforeUnmount) && Ve(se, d, u), Q & 6))
        Me(u.component, v, k);
      else {
        if (Q & 128) {
          u.suspense.unmount(v, k);
          return;
        }
        X && mt(u, null, d, "beforeUnmount"),
          Q & 64
            ? u.type.remove(u, d, v, C, Et, k)
            : S && (R !== Ue || (D > 0 && D & 64))
            ? ae(S, d, v, !1, !0)
            : ((R === Ue && D & 384) || (!C && Q & 16)) && ae(O, d, v),
          k && le(u);
      }
      ((ee && (se = B && B.onVnodeUnmounted)) || X) &&
        Se(() => {
          se && Ve(se, d, u), X && mt(u, null, d, "unmounted");
        }, v);
    },
    le = (u) => {
      const { type: d, el: v, anchor: k, transition: C } = u;
      if (d === Ue) {
        Ie(v, k);
        return;
      }
      if (d === sr) {
        L(u);
        return;
      }
      const R = () => {
        o(v), C && !C.persisted && C.afterLeave && C.afterLeave();
      };
      if (u.shapeFlag & 1 && C && !C.persisted) {
        const { leave: B, delayLeave: T } = C,
          O = () => B(v, R);
        T ? T(u.el, R, O) : O();
      } else R();
    },
    Ie = (u, d) => {
      let v;
      for (; u !== d; ) (v = h(u)), o(u), (u = v);
      o(d);
    },
    Me = (u, d, v) => {
      const { bum: k, scope: C, update: R, subTree: B, um: T } = u;
      k && nr(k),
        C.stop(),
        R && ((R.active = !1), E(B, u, d, v)),
        T && Se(T, d),
        Se(() => {
          u.isUnmounted = !0;
        }, d),
        d &&
          d.pendingBranch &&
          !d.isUnmounted &&
          u.asyncDep &&
          !u.asyncResolved &&
          u.suspenseId === d.pendingId &&
          (d.deps--, d.deps === 0 && d.resolve());
    },
    ae = (u, d, v, k = !1, C = !1, R = 0) => {
      for (let B = R; B < u.length; B++) E(u[B], d, v, k, C);
    },
    Le = (u) =>
      u.shapeFlag & 6
        ? Le(u.component.subTree)
        : u.shapeFlag & 128
        ? u.suspense.next()
        : h(u.anchor || u.el),
    lo = (u, d, v) => {
      u == null
        ? d._vnode && E(d._vnode, null, null, !0)
        : A(d._vnode || null, u, d, null, null, null, v),
        yo(),
        Qi(),
        (d._vnode = u);
    },
    Et = {
      p: A,
      um: E,
      m: ie,
      r: le,
      mt: w,
      mc: p,
      pc: z,
      pbc: _,
      n: Le,
      o: e,
    };
  let Gn, er;
  return (
    t && ([Gn, er] = t(Et)), { render: lo, hydrate: Gn, createApp: Ea(lo, Gn) }
  );
}
function pt({ effect: e, update: t }, n) {
  e.allowRecurse = t.allowRecurse = n;
}
function ms(e, t, n = !1) {
  const r = e.children,
    o = t.children;
  if (Z(r) && Z(o))
    for (let i = 0; i < r.length; i++) {
      const s = r[i];
      let l = o[i];
      l.shapeFlag & 1 &&
        !l.dynamicChildren &&
        ((l.patchFlag <= 0 || l.patchFlag === 32) &&
          ((l = o[i] = it(o[i])), (l.el = s.el)),
        n || ms(s, l)),
        l.type === Un && (l.el = s.el);
    }
}
function Ia(e) {
  const t = e.slice(),
    n = [0];
  let r, o, i, s, l;
  const a = e.length;
  for (r = 0; r < a; r++) {
    const c = e[r];
    if (c !== 0) {
      if (((o = n[n.length - 1]), e[o] < c)) {
        (t[r] = o), n.push(r);
        continue;
      }
      for (i = 0, s = n.length - 1; i < s; )
        (l = (i + s) >> 1), e[n[l]] < c ? (i = l + 1) : (s = l);
      c < e[n[i]] && (i > 0 && (t[r] = n[i - 1]), (n[i] = r));
    }
  }
  for (i = n.length, s = n[i - 1]; i-- > 0; ) (n[i] = s), (s = t[s]);
  return n;
}
const La = (e) => e.__isTeleport,
  Ue = Symbol.for("v-fgt"),
  Un = Symbol.for("v-txt"),
  Xe = Symbol.for("v-cmt"),
  sr = Symbol.for("v-stc"),
  Xt = [];
let je = null;
function to(e = !1) {
  Xt.push((je = e ? null : []));
}
function Ba() {
  Xt.pop(), (je = Xt[Xt.length - 1] || null);
}
let on = 1;
function Oo(e) {
  on += e;
}
function ps(e) {
  return (
    (e.dynamicChildren = on > 0 ? je || qt : null),
    Ba(),
    on > 0 && je && je.push(e),
    e
  );
}
function $a(e, t, n, r, o, i) {
  return ps(Wn(e, t, n, r, o, i, !0));
}
function vs(e, t, n, r, o) {
  return ps(me(e, t, n, r, o, !0));
}
function Er(e) {
  return e ? e.__v_isVNode === !0 : !1;
}
function wt(e, t) {
  return e.type === t.type && e.key === t.key;
}
const Kn = "__vInternal",
  bs = ({ key: e }) => e ?? null,
  Cn = ({ ref: e, ref_key: t, ref_for: n }) => (
    typeof e == "number" && (e = "" + e),
    e != null
      ? be(e) || de(e) || G(e)
        ? { i: Re, r: e, k: t, f: !!n }
        : e
      : null
  );
function Wn(
  e,
  t = null,
  n = null,
  r = 0,
  o = null,
  i = e === Ue ? 0 : 1,
  s = !1,
  l = !1
) {
  const a = {
    __v_isVNode: !0,
    __v_skip: !0,
    type: e,
    props: t,
    key: t && bs(t),
    ref: t && Cn(t),
    scopeId: zn,
    slotScopeIds: null,
    children: n,
    component: null,
    suspense: null,
    ssContent: null,
    ssFallback: null,
    dirs: null,
    transition: null,
    el: null,
    anchor: null,
    target: null,
    targetAnchor: null,
    staticCount: 0,
    shapeFlag: i,
    patchFlag: r,
    dynamicProps: o,
    dynamicChildren: null,
    appContext: null,
    ctx: Re,
  };
  return (
    l
      ? (no(a, n), i & 128 && e.normalize(a))
      : n && (a.shapeFlag |= be(n) ? 8 : 16),
    on > 0 &&
      !s &&
      je &&
      (a.patchFlag > 0 || i & 6) &&
      a.patchFlag !== 32 &&
      je.push(a),
    a
  );
}
const me = Na;
function Na(e, t = null, n = null, r = 0, o = null, i = !1) {
  if (((!e || e === va) && (e = Xe), Er(e))) {
    const l = ft(e, t, !0);
    return (
      n && no(l, n),
      on > 0 &&
        !i &&
        je &&
        (l.shapeFlag & 6 ? (je[je.indexOf(e)] = l) : je.push(l)),
      (l.patchFlag |= -2),
      l
    );
  }
  if ((Ya(e) && (e = e.__vccOpts), t)) {
    t = ja(t);
    let { class: l, style: a } = t;
    l && !be(l) && (t.class = Dr(l)),
      fe(a) && (zi(a) && !Z(a) && (a = pe({}, a)), (t.style = zr(a)));
  }
  const s = be(e) ? 1 : ra(e) ? 128 : La(e) ? 64 : fe(e) ? 4 : G(e) ? 2 : 0;
  return Wn(e, t, n, r, o, s, i, !0);
}
function ja(e) {
  return e ? (zi(e) || Kn in e ? pe({}, e) : e) : null;
}
function ft(e, t, n = !1) {
  const { props: r, ref: o, patchFlag: i, children: s } = e,
    l = t ? za(r || {}, t) : r;
  return {
    __v_isVNode: !0,
    __v_skip: !0,
    type: e.type,
    props: l,
    key: l && bs(l),
    ref:
      t && t.ref ? (n && o ? (Z(o) ? o.concat(Cn(t)) : [o, Cn(t)]) : Cn(t)) : o,
    scopeId: e.scopeId,
    slotScopeIds: e.slotScopeIds,
    children: s,
    target: e.target,
    targetAnchor: e.targetAnchor,
    staticCount: e.staticCount,
    shapeFlag: e.shapeFlag,
    patchFlag: t && e.type !== Ue ? (i === -1 ? 16 : i | 16) : i,
    dynamicProps: e.dynamicProps,
    dynamicChildren: e.dynamicChildren,
    appContext: e.appContext,
    dirs: e.dirs,
    transition: e.transition,
    component: e.component,
    suspense: e.suspense,
    ssContent: e.ssContent && ft(e.ssContent),
    ssFallback: e.ssFallback && ft(e.ssFallback),
    el: e.el,
    anchor: e.anchor,
    ctx: e.ctx,
    ce: e.ce,
  };
}
function Ha(e = " ", t = 0) {
  return me(Un, null, e, t);
}
function Ke(e) {
  return e == null || typeof e == "boolean"
    ? me(Xe)
    : Z(e)
    ? me(Ue, null, e.slice())
    : typeof e == "object"
    ? it(e)
    : me(Un, null, String(e));
}
function it(e) {
  return (e.el === null && e.patchFlag !== -1) || e.memo ? e : ft(e);
}
function no(e, t) {
  let n = 0;
  const { shapeFlag: r } = e;
  if (t == null) t = null;
  else if (Z(t)) n = 16;
  else if (typeof t == "object")
    if (r & 65) {
      const o = t.default;
      o && (o._c && (o._d = !1), no(e, o()), o._c && (o._d = !0));
      return;
    } else {
      n = 32;
      const o = t._;
      !o && !(Kn in t)
        ? (t._ctx = Re)
        : o === 3 &&
          Re &&
          (Re.slots._ === 1 ? (t._ = 1) : ((t._ = 2), (e.patchFlag |= 1024)));
    }
  else
    G(t)
      ? ((t = { default: t, _ctx: Re }), (n = 32))
      : ((t = String(t)), r & 64 ? ((n = 16), (t = [Ha(t)])) : (n = 8));
  (e.children = t), (e.shapeFlag |= n);
}
function za(...e) {
  const t = {};
  for (let n = 0; n < e.length; n++) {
    const r = e[n];
    for (const o in r)
      if (o === "class")
        t.class !== r.class && (t.class = Dr([t.class, r.class]));
      else if (o === "style") t.style = zr([t.style, r.style]);
      else if (In(o)) {
        const i = t[o],
          s = r[o];
        s &&
          i !== s &&
          !(Z(i) && i.includes(s)) &&
          (t[o] = i ? [].concat(i, s) : s);
      } else o !== "" && (t[o] = r[o]);
  }
  return t;
}
function Ve(e, t, n, r = null) {
  qe(e, t, 7, [n, r]);
}
const Da = us();
let Va = 0;
function Ua(e, t, n) {
  const r = e.type,
    o = (t ? t.appContext : e.appContext) || Da,
    i = {
      uid: Va++,
      vnode: e,
      type: r,
      parent: t,
      appContext: o,
      root: null,
      next: null,
      subTree: null,
      effect: null,
      update: null,
      scope: new Pi(!0),
      render: null,
      proxy: null,
      exposed: null,
      exposeProxy: null,
      withProxy: null,
      provides: t ? t.provides : Object.create(o.provides),
      accessCache: null,
      renderCache: [],
      components: null,
      directives: null,
      propsOptions: fs(r, o),
      emitsOptions: Zi(r, o),
      emit: null,
      emitted: null,
      propsDefaults: ue,
      inheritAttrs: r.inheritAttrs,
      ctx: ue,
      data: ue,
      props: ue,
      attrs: ue,
      slots: ue,
      refs: ue,
      setupState: ue,
      setupContext: null,
      attrsProxy: null,
      slotsProxy: null,
      suspense: n,
      suspenseId: n ? n.pendingId : 0,
      asyncDep: null,
      asyncResolved: !1,
      isMounted: !1,
      isUnmounted: !1,
      isDeactivated: !1,
      bc: null,
      c: null,
      bm: null,
      m: null,
      bu: null,
      u: null,
      um: null,
      bum: null,
      da: null,
      a: null,
      rtg: null,
      rtc: null,
      ec: null,
      sp: null,
    };
  return (
    (i.ctx = { _: i }),
    (i.root = t ? t.root : i),
    (i.emit = Zl.bind(null, i)),
    e.ce && e.ce(i),
    i
  );
}
let ye = null;
const ze = () => ye || Re;
let ro,
  Pt,
  qo = "__VUE_INSTANCE_SETTERS__";
(Pt = gr()[qo]) || (Pt = gr()[qo] = []),
  Pt.push((e) => (ye = e)),
  (ro = (e) => {
    Pt.length > 1 ? Pt.forEach((t) => t(e)) : Pt[0](e);
  });
const Nt = (e) => {
    ro(e), e.scope.on();
  },
  St = () => {
    ye && ye.scope.off(), ro(null);
  };
function _s(e) {
  return e.vnode.shapeFlag & 4;
}
let sn = !1;
function Ka(e, t = !1) {
  sn = t;
  const { props: n, children: r } = e.vnode,
    o = _s(e);
  Pa(e, n, o, t), Aa(e, r);
  const i = o ? Wa(e, t) : void 0;
  return (sn = !1), i;
}
function Wa(e, t) {
  const n = e.type;
  (e.accessCache = Object.create(null)), (e.proxy = ct(new Proxy(e.ctx, _a)));
  const { setup: r } = n;
  if (r) {
    const o = (e.setupContext = r.length > 1 ? Ja(e) : null);
    Nt(e), Ht();
    const i = at(r, e, 0, [e.props, o]);
    if ((zt(), St(), Ci(i))) {
      if ((i.then(St, St), t))
        return i
          .then((s) => {
            Io(e, s, t);
          })
          .catch((s) => {
            jn(s, e, 0);
          });
      e.asyncDep = i;
    } else Io(e, i, t);
  } else ys(e, t);
}
function Io(e, t, n) {
  G(t)
    ? e.type.__ssrInlineRender
      ? (e.ssrRender = t)
      : (e.render = t)
    : fe(t) && (e.setupState = Ui(t)),
    ys(e, n);
}
let Lo;
function ys(e, t, n) {
  const r = e.type;
  if (!e.render) {
    if (!t && Lo && !r.render) {
      const o = r.template || Gr(e).template;
      if (o) {
        const { isCustomElement: i, compilerOptions: s } = e.appContext.config,
          { delimiters: l, compilerOptions: a } = r,
          c = pe(pe({ isCustomElement: i, delimiters: l }, s), a);
        r.render = Lo(o, c);
      }
    }
    e.render = r.render || He;
  }
  Nt(e), Ht(), ya(e), zt(), St();
}
function Qa(e) {
  return (
    e.attrsProxy ||
    (e.attrsProxy = new Proxy(e.attrs, {
      get(t, n) {
        return Ee(e, "get", "$attrs"), t[n];
      },
    }))
  );
}
function Ja(e) {
  const t = (n) => {
    e.exposed = n || {};
  };
  return {
    get attrs() {
      return Qa(e);
    },
    slots: e.slots,
    emit: e.emit,
    expose: t,
  };
}
function Qn(e) {
  if (e.exposed)
    return (
      e.exposeProxy ||
      (e.exposeProxy = new Proxy(Ui(ct(e.exposed)), {
        get(t, n) {
          if (n in t) return t[n];
          if (n in Yt) return Yt[n](e);
        },
        has(t, n) {
          return n in t || n in Yt;
        },
      }))
    );
}
function Za(e, t = !0) {
  return G(e) ? e.displayName || e.name : e.name || (t && e.__name);
}
function Ya(e) {
  return G(e) && "__vccOpts" in e;
}
const I = (e, t) => Vl(e, t, sn);
function H(e, t, n) {
  const r = arguments.length;
  return r === 2
    ? fe(t) && !Z(t)
      ? Er(t)
        ? me(e, null, [t])
        : me(e, t)
      : me(e, null, t)
    : (r > 3
        ? (n = Array.prototype.slice.call(arguments, 2))
        : r === 3 && Er(n) && (n = [n]),
      me(e, t, n));
}
const Xa = Symbol.for("v-scx"),
  Ga = () => Bt(Xa),
  eu = "3.3.2",
  tu = "http://www.w3.org/2000/svg",
  xt = typeof document < "u" ? document : null,
  Bo = xt && xt.createElement("template"),
  nu = {
    insert: (e, t, n) => {
      t.insertBefore(e, n || null);
    },
    remove: (e) => {
      const t = e.parentNode;
      t && t.removeChild(e);
    },
    createElement: (e, t, n, r) => {
      const o = t
        ? xt.createElementNS(tu, e)
        : xt.createElement(e, n ? { is: n } : void 0);
      return (
        e === "select" &&
          r &&
          r.multiple != null &&
          o.setAttribute("multiple", r.multiple),
        o
      );
    },
    createText: (e) => xt.createTextNode(e),
    createComment: (e) => xt.createComment(e),
    setText: (e, t) => {
      e.nodeValue = t;
    },
    setElementText: (e, t) => {
      e.textContent = t;
    },
    parentNode: (e) => e.parentNode,
    nextSibling: (e) => e.nextSibling,
    querySelector: (e) => xt.querySelector(e),
    setScopeId(e, t) {
      e.setAttribute(t, "");
    },
    insertStaticContent(e, t, n, r, o, i) {
      const s = n ? n.previousSibling : t.lastChild;
      if (o && (o === i || o.nextSibling))
        for (
          ;
          t.insertBefore(o.cloneNode(!0), n),
            !(o === i || !(o = o.nextSibling));

        );
      else {
        Bo.innerHTML = r ? `<svg>${e}</svg>` : e;
        const l = Bo.content;
        if (r) {
          const a = l.firstChild;
          for (; a.firstChild; ) l.appendChild(a.firstChild);
          l.removeChild(a);
        }
        t.insertBefore(l, n);
      }
      return [
        s ? s.nextSibling : t.firstChild,
        n ? n.previousSibling : t.lastChild,
      ];
    },
  };
function ru(e, t, n) {
  const r = e._vtc;
  r && (t = (t ? [t, ...r] : [...r]).join(" ")),
    t == null
      ? e.removeAttribute("class")
      : n
      ? e.setAttribute("class", t)
      : (e.className = t);
}
function ou(e, t, n) {
  const r = e.style,
    o = be(n);
  if (n && !o) {
    if (t && !be(t)) for (const i in t) n[i] == null && Mr(r, i, "");
    for (const i in n) Mr(r, i, n[i]);
  } else {
    const i = r.display;
    o ? t !== n && (r.cssText = n) : t && e.removeAttribute("style"),
      "_vod" in e && (r.display = i);
  }
}
const $o = /\s*!important$/;
function Mr(e, t, n) {
  if (Z(n)) n.forEach((r) => Mr(e, t, r));
  else if ((n == null && (n = ""), t.startsWith("--"))) e.setProperty(t, n);
  else {
    const r = iu(e, t);
    $o.test(n)
      ? e.setProperty(jt(r), n.replace($o, ""), "important")
      : (e[r] = n);
  }
}
const No = ["Webkit", "Moz", "ms"],
  lr = {};
function iu(e, t) {
  const n = lr[t];
  if (n) return n;
  let r = Qe(t);
  if (r !== "filter" && r in e) return (lr[t] = r);
  r = $n(r);
  for (let o = 0; o < No.length; o++) {
    const i = No[o] + r;
    if (i in e) return (lr[t] = i);
  }
  return t;
}
const jo = "http://www.w3.org/1999/xlink";
function su(e, t, n, r, o) {
  if (r && t.startsWith("xlink:"))
    n == null
      ? e.removeAttributeNS(jo, t.slice(6, t.length))
      : e.setAttributeNS(jo, t, n);
  else {
    const i = ol(t);
    n == null || (i && !Ei(n))
      ? e.removeAttribute(t)
      : e.setAttribute(t, i ? "" : n);
  }
}
function lu(e, t, n, r, o, i, s) {
  if (t === "innerHTML" || t === "textContent") {
    r && s(r, o, i), (e[t] = n ?? "");
    return;
  }
  const l = e.tagName;
  if (t === "value" && l !== "PROGRESS" && !l.includes("-")) {
    e._value = n;
    const c = l === "OPTION" ? e.getAttribute("value") : e.value,
      f = n ?? "";
    c !== f && (e.value = f), n == null && e.removeAttribute(t);
    return;
  }
  let a = !1;
  if (n === "" || n == null) {
    const c = typeof e[t];
    c === "boolean"
      ? (n = Ei(n))
      : n == null && c === "string"
      ? ((n = ""), (a = !0))
      : c === "number" && ((n = 0), (a = !0));
  }
  try {
    e[t] = n;
  } catch {}
  a && e.removeAttribute(t);
}
function au(e, t, n, r) {
  e.addEventListener(t, n, r);
}
function uu(e, t, n, r) {
  e.removeEventListener(t, n, r);
}
function cu(e, t, n, r, o = null) {
  const i = e._vei || (e._vei = {}),
    s = i[t];
  if (r && s) s.value = r;
  else {
    const [l, a] = fu(t);
    if (r) {
      const c = (i[t] = gu(r, o));
      au(e, l, c, a);
    } else s && (uu(e, l, s, a), (i[t] = void 0));
  }
}
const Ho = /(?:Once|Passive|Capture)$/;
function fu(e) {
  let t;
  if (Ho.test(e)) {
    t = {};
    let r;
    for (; (r = e.match(Ho)); )
      (e = e.slice(0, e.length - r[0].length)), (t[r[0].toLowerCase()] = !0);
  }
  return [e[2] === ":" ? e.slice(3) : jt(e.slice(2)), t];
}
let ar = 0;
const du = Promise.resolve(),
  hu = () => ar || (du.then(() => (ar = 0)), (ar = Date.now()));
function gu(e, t) {
  const n = (r) => {
    if (!r._vts) r._vts = Date.now();
    else if (r._vts <= n.attached) return;
    qe(mu(r, n.value), t, 5, [r]);
  };
  return (n.value = e), (n.attached = hu()), n;
}
function mu(e, t) {
  if (Z(t)) {
    const n = e.stopImmediatePropagation;
    return (
      (e.stopImmediatePropagation = () => {
        n.call(e), (e._stopped = !0);
      }),
      t.map((r) => (o) => !o._stopped && r && r(o))
    );
  } else return t;
}
const zo = /^on[a-z]/,
  pu = (e, t, n, r, o = !1, i, s, l, a) => {
    t === "class"
      ? ru(e, r, o)
      : t === "style"
      ? ou(e, n, r)
      : In(t)
      ? $r(t) || cu(e, t, n, r, s)
      : (
          t[0] === "."
            ? ((t = t.slice(1)), !0)
            : t[0] === "^"
            ? ((t = t.slice(1)), !1)
            : vu(e, t, r, o)
        )
      ? lu(e, t, r, i, s, l, a)
      : (t === "true-value"
          ? (e._trueValue = r)
          : t === "false-value" && (e._falseValue = r),
        su(e, t, r, o));
  };
function vu(e, t, n, r) {
  return r
    ? !!(
        t === "innerHTML" ||
        t === "textContent" ||
        (t in e && zo.test(t) && G(n))
      )
    : t === "spellcheck" ||
      t === "draggable" ||
      t === "translate" ||
      t === "form" ||
      (t === "list" && e.tagName === "INPUT") ||
      (t === "type" && e.tagName === "TEXTAREA") ||
      (zo.test(t) && be(n))
    ? !1
    : t in e;
}
const nt = "transition",
  Ut = "animation",
  un = (e, { slots: t }) => H(aa, bu(e), t);
un.displayName = "Transition";
const ws = {
  name: String,
  type: String,
  css: { type: Boolean, default: !0 },
  duration: [String, Number, Object],
  enterFromClass: String,
  enterActiveClass: String,
  enterToClass: String,
  appearFromClass: String,
  appearActiveClass: String,
  appearToClass: String,
  leaveFromClass: String,
  leaveActiveClass: String,
  leaveToClass: String,
};
un.props = pe({}, Gi, ws);
const vt = (e, t = []) => {
    Z(e) ? e.forEach((n) => n(...t)) : e && e(...t);
  },
  Do = (e) => (e ? (Z(e) ? e.some((t) => t.length > 1) : e.length > 1) : !1);
function bu(e) {
  const t = {};
  for (const m in e) m in ws || (t[m] = e[m]);
  if (e.css === !1) return t;
  const {
      name: n = "v",
      type: r,
      duration: o,
      enterFromClass: i = `${n}-enter-from`,
      enterActiveClass: s = `${n}-enter-active`,
      enterToClass: l = `${n}-enter-to`,
      appearFromClass: a = i,
      appearActiveClass: c = s,
      appearToClass: f = l,
      leaveFromClass: g = `${n}-leave-from`,
      leaveActiveClass: h = `${n}-leave-active`,
      leaveToClass: x = `${n}-leave-to`,
    } = e,
    M = _u(o),
    A = M && M[0],
    F = M && M[1],
    {
      onBeforeEnter: V,
      onEnter: W,
      onEnterCancelled: Y,
      onLeave: L,
      onLeaveCancelled: $,
      onBeforeAppear: U = V,
      onAppear: q = W,
      onAppearCancelled: p = Y,
    } = t,
    b = (m, N, w) => {
      bt(m, N ? f : l), bt(m, N ? c : s), w && w();
    },
    _ = (m, N) => {
      (m._isLeaving = !1), bt(m, g), bt(m, x), bt(m, h), N && N();
    },
    P = (m) => (N, w) => {
      const j = m ? q : W,
        K = () => b(N, m, w);
      vt(j, [N, K]),
        Vo(() => {
          bt(N, m ? a : i), rt(N, m ? f : l), Do(j) || Uo(N, r, A, K);
        });
    };
  return pe(t, {
    onBeforeEnter(m) {
      vt(V, [m]), rt(m, i), rt(m, s);
    },
    onBeforeAppear(m) {
      vt(U, [m]), rt(m, a), rt(m, c);
    },
    onEnter: P(!1),
    onAppear: P(!0),
    onLeave(m, N) {
      m._isLeaving = !0;
      const w = () => _(m, N);
      rt(m, g),
        xu(),
        rt(m, h),
        Vo(() => {
          m._isLeaving && (bt(m, g), rt(m, x), Do(L) || Uo(m, r, F, w));
        }),
        vt(L, [m, w]);
    },
    onEnterCancelled(m) {
      b(m, !1), vt(Y, [m]);
    },
    onAppearCancelled(m) {
      b(m, !0), vt(p, [m]);
    },
    onLeaveCancelled(m) {
      _(m), vt($, [m]);
    },
  });
}
function _u(e) {
  if (e == null) return null;
  if (fe(e)) return [ur(e.enter), ur(e.leave)];
  {
    const t = ur(e);
    return [t, t];
  }
}
function ur(e) {
  return Xs(e);
}
function rt(e, t) {
  t.split(/\s+/).forEach((n) => n && e.classList.add(n)),
    (e._vtc || (e._vtc = new Set())).add(t);
}
function bt(e, t) {
  t.split(/\s+/).forEach((r) => r && e.classList.remove(r));
  const { _vtc: n } = e;
  n && (n.delete(t), n.size || (e._vtc = void 0));
}
function Vo(e) {
  requestAnimationFrame(() => {
    requestAnimationFrame(e);
  });
}
let yu = 0;
function Uo(e, t, n, r) {
  const o = (e._endId = ++yu),
    i = () => {
      o === e._endId && r();
    };
  if (n) return setTimeout(i, n);
  const { type: s, timeout: l, propCount: a } = wu(e, t);
  if (!s) return r();
  const c = s + "end";
  let f = 0;
  const g = () => {
      e.removeEventListener(c, h), i();
    },
    h = (x) => {
      x.target === e && ++f >= a && g();
    };
  setTimeout(() => {
    f < a && g();
  }, l + 1),
    e.addEventListener(c, h);
}
function wu(e, t) {
  const n = window.getComputedStyle(e),
    r = (M) => (n[M] || "").split(", "),
    o = r(`${nt}Delay`),
    i = r(`${nt}Duration`),
    s = Ko(o, i),
    l = r(`${Ut}Delay`),
    a = r(`${Ut}Duration`),
    c = Ko(l, a);
  let f = null,
    g = 0,
    h = 0;
  t === nt
    ? s > 0 && ((f = nt), (g = s), (h = i.length))
    : t === Ut
    ? c > 0 && ((f = Ut), (g = c), (h = a.length))
    : ((g = Math.max(s, c)),
      (f = g > 0 ? (s > c ? nt : Ut) : null),
      (h = f ? (f === nt ? i.length : a.length) : 0));
  const x =
    f === nt && /\b(transform|all)(,|$)/.test(r(`${nt}Property`).toString());
  return { type: f, timeout: g, propCount: h, hasTransform: x };
}
function Ko(e, t) {
  for (; e.length < t.length; ) e = e.concat(e);
  return Math.max(...t.map((n, r) => Wo(n) + Wo(e[r])));
}
function Wo(e) {
  return Number(e.slice(0, -1).replace(",", ".")) * 1e3;
}
function xu() {
  return document.body.offsetHeight;
}
const Pr = {
  beforeMount(e, { value: t }, { transition: n }) {
    (e._vod = e.style.display === "none" ? "" : e.style.display),
      n && t ? n.beforeEnter(e) : Kt(e, t);
  },
  mounted(e, { value: t }, { transition: n }) {
    n && t && n.enter(e);
  },
  updated(e, { value: t, oldValue: n }, { transition: r }) {
    !t != !n &&
      (r
        ? t
          ? (r.beforeEnter(e), Kt(e, !0), r.enter(e))
          : r.leave(e, () => {
              Kt(e, !1);
            })
        : Kt(e, t));
  },
  beforeUnmount(e, { value: t }) {
    Kt(e, t);
  },
};
function Kt(e, t) {
  e.style.display = t ? e._vod : "none";
}
const Cu = pe({ patchProp: pu }, nu);
let Qo;
function ku() {
  return Qo || (Qo = Oa(Cu));
}
const Su = (...e) => {
  const t = ku().createApp(...e),
    { mount: n } = t;
  return (
    (t.mount = (r) => {
      const o = Eu(r);
      if (!o) return;
      const i = t._component;
      !G(i) && !i.render && !i.template && (i.template = o.innerHTML),
        (o.innerHTML = "");
      const s = n(o, !1, o instanceof SVGElement);
      return (
        o instanceof Element &&
          (o.removeAttribute("v-cloak"), o.setAttribute("data-v-app", "")),
        s
      );
    }),
    t
  );
};
function Eu(e) {
  return be(e) ? document.querySelector(e) : e;
}
var Mu = !1;
/*!
 * pinia v2.0.36
 * (c) 2023 Eduardo San Martin Morote
 * @license MIT
 */ let xs;
const Jn = (e) => (xs = e),
  Cs = Symbol();
function Tr(e) {
  return (
    e &&
    typeof e == "object" &&
    Object.prototype.toString.call(e) === "[object Object]" &&
    typeof e.toJSON != "function"
  );
}
var Gt;
(function (e) {
  (e.direct = "direct"),
    (e.patchObject = "patch object"),
    (e.patchFunction = "patch function");
})(Gt || (Gt = {}));
function Pu() {
  const e = Ti(!0),
    t = e.run(() => ce({}));
  let n = [],
    r = [];
  const o = ct({
    install(i) {
      Jn(o),
        (o._a = i),
        i.provide(Cs, o),
        (i.config.globalProperties.$pinia = o),
        r.forEach((s) => n.push(s)),
        (r = []);
    },
    use(i) {
      return !this._a && !Mu ? r.push(i) : n.push(i), this;
    },
    _p: n,
    _a: null,
    _e: e,
    _s: new Map(),
    state: t,
  });
  return o;
}
const ks = () => {};
function Jo(e, t, n, r = ks) {
  e.push(t);
  const o = () => {
    const i = e.indexOf(t);
    i > -1 && (e.splice(i, 1), r());
  };
  return !n && Ri() && ll(o), o;
}
function Tt(e, ...t) {
  e.slice().forEach((n) => {
    n(...t);
  });
}
function Rr(e, t) {
  e instanceof Map && t instanceof Map && t.forEach((n, r) => e.set(r, n)),
    e instanceof Set && t instanceof Set && t.forEach(e.add, e);
  for (const n in t) {
    if (!t.hasOwnProperty(n)) continue;
    const r = t[n],
      o = e[n];
    Tr(o) && Tr(r) && e.hasOwnProperty(n) && !de(r) && !lt(r)
      ? (e[n] = Rr(o, r))
      : (e[n] = r);
  }
  return e;
}
const Tu = Symbol();
function Ru(e) {
  return !Tr(e) || !e.hasOwnProperty(Tu);
}
const { assign: ot } = Object;
function Au(e) {
  return !!(de(e) && e.effect);
}
function Fu(e, t, n, r) {
  const { state: o, actions: i, getters: s } = t,
    l = n.state.value[e];
  let a;
  function c() {
    l || (n.state.value[e] = o ? o() : {});
    const f = jl(n.state.value[e]);
    return ot(
      f,
      i,
      Object.keys(s || {}).reduce(
        (g, h) => (
          (g[h] = ct(
            I(() => {
              Jn(n);
              const x = n._s.get(e);
              return s[h].call(x, x);
            })
          )),
          g
        ),
        {}
      )
    );
  }
  return (a = Ss(e, c, t, n, r, !0)), a;
}
function Ss(e, t, n = {}, r, o, i) {
  let s;
  const l = ot({ actions: {} }, n),
    a = { deep: !0 };
  let c,
    f,
    g = ct([]),
    h = ct([]),
    x;
  const M = r.state.value[e];
  !i && !M && (r.state.value[e] = {}), ce({});
  let A;
  function F(q) {
    let p;
    (c = f = !1),
      typeof q == "function"
        ? (q(r.state.value[e]),
          (p = { type: Gt.patchFunction, storeId: e, events: x }))
        : (Rr(r.state.value[e], q),
          (p = { type: Gt.patchObject, payload: q, storeId: e, events: x }));
    const b = (A = Symbol());
    Ze().then(() => {
      A === b && (c = !0);
    }),
      (f = !0),
      Tt(g, p, r.state.value[e]);
  }
  const V = i
    ? function () {
        const { state: p } = n,
          b = p ? p() : {};
        this.$patch((_) => {
          ot(_, b);
        });
      }
    : ks;
  function W() {
    s.stop(), (g = []), (h = []), r._s.delete(e);
  }
  function Y(q, p) {
    return function () {
      Jn(r);
      const b = Array.from(arguments),
        _ = [],
        P = [];
      function m(j) {
        _.push(j);
      }
      function N(j) {
        P.push(j);
      }
      Tt(h, { args: b, name: q, store: $, after: m, onError: N });
      let w;
      try {
        w = p.apply(this && this.$id === e ? this : $, b);
      } catch (j) {
        throw (Tt(P, j), j);
      }
      return w instanceof Promise
        ? w
            .then((j) => (Tt(_, j), j))
            .catch((j) => (Tt(P, j), Promise.reject(j)))
        : (Tt(_, w), w);
    };
  }
  const L = {
      _p: r,
      $id: e,
      $onAction: Jo.bind(null, h),
      $patch: F,
      $reset: V,
      $subscribe(q, p = {}) {
        const b = Jo(g, q, p.detached, () => _()),
          _ = s.run(() =>
            ve(
              () => r.state.value[e],
              (P) => {
                (p.flush === "sync" ? f : c) &&
                  q({ storeId: e, type: Gt.direct, events: x }, P);
              },
              ot({}, a, p)
            )
          );
        return b;
      },
      $dispose: W,
    },
    $ = Dt(L);
  r._s.set(e, $);
  const U = r._e.run(() => ((s = Ti()), s.run(() => t())));
  for (const q in U) {
    const p = U[q];
    if ((de(p) && !Au(p)) || lt(p))
      i ||
        (M && Ru(p) && (de(p) ? (p.value = M[q]) : Rr(p, M[q])),
        (r.state.value[e][q] = p));
    else if (typeof p == "function") {
      const b = Y(q, p);
      (U[q] = b), (l.actions[q] = p);
    }
  }
  return (
    ot($, U),
    ot(te($), U),
    Object.defineProperty($, "$state", {
      get: () => r.state.value[e],
      set: (q) => {
        F((p) => {
          ot(p, q);
        });
      },
    }),
    r._p.forEach((q) => {
      ot(
        $,
        s.run(() => q({ store: $, app: r._a, pinia: r, options: l }))
      );
    }),
    M && i && n.hydrate && n.hydrate($.$state, M),
    (c = !0),
    (f = !0),
    $
  );
}
function Ou(e, t, n) {
  let r, o;
  const i = typeof t == "function";
  typeof e == "string" ? ((r = e), (o = i ? n : t)) : ((o = e), (r = e.id));
  function s(l, a) {
    const c = ze();
    return (
      (l = l || (c && Bt(Cs, null))),
      l && Jn(l),
      (l = xs),
      l._s.has(r) || (i ? Ss(r, t, o, l) : Fu(r, o, l)),
      l._s.get(r)
    );
  }
  return (s.$id = r), s;
}
function cn(e, t, n, r) {
  return Object.defineProperty(e, t, { get: n, set: r, enumerable: !0 }), e;
}
const dt = ce(!1);
let Zn;
function qu(e, t) {
  const n =
    /(edg|edge|edga|edgios)\/([\w.]+)/.exec(e) ||
    /(opr)[\/]([\w.]+)/.exec(e) ||
    /(vivaldi)[\/]([\w.]+)/.exec(e) ||
    /(chrome|crios)[\/]([\w.]+)/.exec(e) ||
    /(version)(applewebkit)[\/]([\w.]+).*(safari)[\/]([\w.]+)/.exec(e) ||
    /(webkit)[\/]([\w.]+).*(version)[\/]([\w.]+).*(safari)[\/]([\w.]+)/.exec(
      e
    ) ||
    /(firefox|fxios)[\/]([\w.]+)/.exec(e) ||
    /(webkit)[\/]([\w.]+)/.exec(e) ||
    /(opera)(?:.*version|)[\/]([\w.]+)/.exec(e) ||
    [];
  return {
    browser: n[5] || n[3] || n[1] || "",
    version: n[2] || n[4] || "0",
    versionNumber: n[4] || n[2] || "0",
    platform: t[0] || "",
  };
}
function Iu(e) {
  return (
    /(ipad)/.exec(e) ||
    /(ipod)/.exec(e) ||
    /(windows phone)/.exec(e) ||
    /(iphone)/.exec(e) ||
    /(kindle)/.exec(e) ||
    /(silk)/.exec(e) ||
    /(android)/.exec(e) ||
    /(win)/.exec(e) ||
    /(mac)/.exec(e) ||
    /(linux)/.exec(e) ||
    /(cros)/.exec(e) ||
    /(playbook)/.exec(e) ||
    /(bb)/.exec(e) ||
    /(blackberry)/.exec(e) ||
    []
  );
}
const Es = "ontouchstart" in window || window.navigator.maxTouchPoints > 0;
function Lu(e) {
  (Zn = { is: { ...e } }), delete e.mac, delete e.desktop;
  const t =
    Math.min(window.innerHeight, window.innerWidth) > 414 ? "ipad" : "iphone";
  Object.assign(e, { mobile: !0, ios: !0, platform: t, [t]: !0 });
}
function Bu(e) {
  const t = e.toLowerCase(),
    n = Iu(t),
    r = qu(t, n),
    o = {};
  r.browser &&
    ((o[r.browser] = !0),
    (o.version = r.version),
    (o.versionNumber = parseInt(r.versionNumber, 10))),
    r.platform && (o[r.platform] = !0);
  const i =
    o.android ||
    o.ios ||
    o.bb ||
    o.blackberry ||
    o.ipad ||
    o.iphone ||
    o.ipod ||
    o.kindle ||
    o.playbook ||
    o.silk ||
    o["windows phone"];
  return (
    i === !0 || t.indexOf("mobile") > -1
      ? ((o.mobile = !0),
        o.edga || o.edgios
          ? ((o.edge = !0), (r.browser = "edge"))
          : o.crios
          ? ((o.chrome = !0), (r.browser = "chrome"))
          : o.fxios && ((o.firefox = !0), (r.browser = "firefox")))
      : (o.desktop = !0),
    (o.ipod || o.ipad || o.iphone) && (o.ios = !0),
    o["windows phone"] && ((o.winphone = !0), delete o["windows phone"]),
    (o.chrome ||
      o.opr ||
      o.safari ||
      o.vivaldi ||
      (o.mobile === !0 && o.ios !== !0 && i !== !0)) &&
      (o.webkit = !0),
    o.edg && ((r.browser = "edgechromium"), (o.edgeChromium = !0)),
    ((o.safari && o.blackberry) || o.bb) &&
      ((r.browser = "blackberry"), (o.blackberry = !0)),
    o.safari && o.playbook && ((r.browser = "playbook"), (o.playbook = !0)),
    o.opr && ((r.browser = "opera"), (o.opera = !0)),
    o.safari && o.android && ((r.browser = "android"), (o.android = !0)),
    o.safari && o.kindle && ((r.browser = "kindle"), (o.kindle = !0)),
    o.safari && o.silk && ((r.browser = "silk"), (o.silk = !0)),
    o.vivaldi && ((r.browser = "vivaldi"), (o.vivaldi = !0)),
    (o.name = r.browser),
    (o.platform = r.platform),
    t.indexOf("electron") > -1
      ? (o.electron = !0)
      : document.location.href.indexOf("-extension://") > -1
      ? (o.bex = !0)
      : (window.Capacitor !== void 0
          ? ((o.capacitor = !0),
            (o.nativeMobile = !0),
            (o.nativeMobileWrapper = "capacitor"))
          : (window._cordovaNative !== void 0 || window.cordova !== void 0) &&
            ((o.cordova = !0),
            (o.nativeMobile = !0),
            (o.nativeMobileWrapper = "cordova")),
        Es === !0 &&
          o.mac === !0 &&
          ((o.desktop === !0 && o.safari === !0) ||
            (o.nativeMobile === !0 &&
              o.android !== !0 &&
              o.ios !== !0 &&
              o.ipad !== !0)) &&
          Lu(o)),
    o
  );
}
const Zo = navigator.userAgent || navigator.vendor || window.opera,
  $u = { has: { touch: !1, webStorage: !1 }, within: { iframe: !1 } },
  Ae = {
    userAgent: Zo,
    is: Bu(Zo),
    has: { touch: Es },
    within: { iframe: window.self !== window.top },
  },
  Ar = {
    install(e) {
      const { $q: t } = e;
      dt.value === !0
        ? (e.onSSRHydrated.push(() => {
            Object.assign(t.platform, Ae), (dt.value = !1), (Zn = void 0);
          }),
          (t.platform = Dt(this)))
        : (t.platform = this);
    },
  };
{
  let e;
  cn(Ae.has, "webStorage", () => {
    if (e !== void 0) return e;
    try {
      if (window.localStorage) return (e = !0), !0;
    } catch {}
    return (e = !1), !1;
  }),
    Ae.is.ios === !0 && window.navigator.vendor.toLowerCase().indexOf("apple"),
    dt.value === !0 ? Object.assign(Ar, Ae, Zn, $u) : Object.assign(Ar, Ae);
}
const Yn = (e, t) => {
    const n = Dt(e);
    for (const r in e)
      cn(
        t,
        r,
        () => n[r],
        (o) => {
          n[r] = o;
        }
      );
    return t;
  },
  fn = { hasPassive: !1, passiveCapture: !0, notPassiveCapture: !0 };
try {
  const e = Object.defineProperty({}, "passive", {
    get() {
      Object.assign(fn, {
        hasPassive: !0,
        passive: { passive: !0 },
        notPassive: { passive: !1 },
        passiveCapture: { passive: !0, capture: !0 },
        notPassiveCapture: { passive: !1, capture: !0 },
      });
    },
  });
  window.addEventListener("qtest", null, e),
    window.removeEventListener("qtest", null, e);
} catch {}
function ln() {}
function Nu(e) {
  return (
    e.touches && e.touches[0]
      ? (e = e.touches[0])
      : e.changedTouches && e.changedTouches[0]
      ? (e = e.changedTouches[0])
      : e.targetTouches && e.targetTouches[0] && (e = e.targetTouches[0]),
    { top: e.clientY, left: e.clientX }
  );
}
function An(e) {
  e.stopPropagation();
}
function Ot(e) {
  e.cancelable !== !1 && e.preventDefault();
}
function _t(e) {
  e.cancelable !== !1 && e.preventDefault(), e.stopPropagation();
}
function ju(e, t, n) {
  const r = `__q_${t}_evt`;
  (e[r] = e[r] !== void 0 ? e[r].concat(n) : n),
    n.forEach((o) => {
      o[0].addEventListener(o[1], e[o[2]], fn[o[3]]);
    });
}
function Hu(e, t) {
  const n = `__q_${t}_evt`;
  e[n] !== void 0 &&
    (e[n].forEach((r) => {
      r[0].removeEventListener(r[1], e[r[2]], fn[r[3]]);
    }),
    (e[n] = void 0));
}
function Ms(e, t = 250, n) {
  let r = null;
  function o() {
    const i = arguments,
      s = () => {
        (r = null), n !== !0 && e.apply(this, i);
      };
    r !== null ? clearTimeout(r) : n === !0 && e.apply(this, i),
      (r = setTimeout(s, t));
  }
  return (
    (o.cancel = () => {
      r !== null && clearTimeout(r);
    }),
    o
  );
}
const cr = ["sm", "md", "lg", "xl"],
  { passive: Yo } = fn,
  zu = Yn(
    {
      width: 0,
      height: 0,
      name: "xs",
      sizes: { sm: 600, md: 1024, lg: 1440, xl: 1920 },
      lt: { sm: !0, md: !0, lg: !0, xl: !0 },
      gt: { xs: !1, sm: !1, md: !1, lg: !1 },
      xs: !0,
      sm: !1,
      md: !1,
      lg: !1,
      xl: !1,
    },
    {
      setSizes: ln,
      setDebounce: ln,
      install({ $q: e, onSSRHydrated: t }) {
        if (((e.screen = this), this.__installed === !0)) {
          e.config.screen !== void 0 &&
            (e.config.screen.bodyClasses === !1
              ? document.body.classList.remove(`screen--${this.name}`)
              : this.__update(!0));
          return;
        }
        const { visualViewport: n } = window,
          r = n || window,
          o = document.scrollingElement || document.documentElement,
          i =
            n === void 0 || Ae.is.mobile === !0
              ? () => [
                  Math.max(window.innerWidth, o.clientWidth),
                  Math.max(window.innerHeight, o.clientHeight),
                ]
              : () => [
                  n.width * n.scale + window.innerWidth - o.clientWidth,
                  n.height * n.scale + window.innerHeight - o.clientHeight,
                ],
          s = e.config.screen !== void 0 && e.config.screen.bodyClasses === !0;
        this.__update = (g) => {
          const [h, x] = i();
          if ((x !== this.height && (this.height = x), h !== this.width))
            this.width = h;
          else if (g !== !0) return;
          let M = this.sizes;
          (this.gt.xs = h >= M.sm),
            (this.gt.sm = h >= M.md),
            (this.gt.md = h >= M.lg),
            (this.gt.lg = h >= M.xl),
            (this.lt.sm = h < M.sm),
            (this.lt.md = h < M.md),
            (this.lt.lg = h < M.lg),
            (this.lt.xl = h < M.xl),
            (this.xs = this.lt.sm),
            (this.sm = this.gt.xs === !0 && this.lt.md === !0),
            (this.md = this.gt.sm === !0 && this.lt.lg === !0),
            (this.lg = this.gt.md === !0 && this.lt.xl === !0),
            (this.xl = this.gt.lg),
            (M =
              (this.xs === !0 && "xs") ||
              (this.sm === !0 && "sm") ||
              (this.md === !0 && "md") ||
              (this.lg === !0 && "lg") ||
              "xl"),
            M !== this.name &&
              (s === !0 &&
                (document.body.classList.remove(`screen--${this.name}`),
                document.body.classList.add(`screen--${M}`)),
              (this.name = M));
        };
        let l,
          a = {},
          c = 16;
        (this.setSizes = (g) => {
          cr.forEach((h) => {
            g[h] !== void 0 && (a[h] = g[h]);
          });
        }),
          (this.setDebounce = (g) => {
            c = g;
          });
        const f = () => {
          const g = getComputedStyle(document.body);
          g.getPropertyValue("--q-size-sm") &&
            cr.forEach((h) => {
              this.sizes[h] = parseInt(g.getPropertyValue(`--q-size-${h}`), 10);
            }),
            (this.setSizes = (h) => {
              cr.forEach((x) => {
                h[x] && (this.sizes[x] = h[x]);
              }),
                this.__update(!0);
            }),
            (this.setDebounce = (h) => {
              l !== void 0 && r.removeEventListener("resize", l, Yo),
                (l = h > 0 ? Ms(this.__update, h) : this.__update),
                r.addEventListener("resize", l, Yo);
            }),
            this.setDebounce(c),
            Object.keys(a).length !== 0
              ? (this.setSizes(a), (a = void 0))
              : this.__update(),
            s === !0 &&
              this.name === "xs" &&
              document.body.classList.add("screen--xs");
        };
        dt.value === !0 ? t.push(f) : f();
      },
    }
  ),
  xe = Yn(
    { isActive: !1, mode: !1 },
    {
      __media: void 0,
      set(e) {
        (xe.mode = e),
          e === "auto"
            ? (xe.__media === void 0 &&
                ((xe.__media = window.matchMedia(
                  "(prefers-color-scheme: dark)"
                )),
                (xe.__updateMedia = () => {
                  xe.set("auto");
                }),
                xe.__media.addListener(xe.__updateMedia)),
              (e = xe.__media.matches))
            : xe.__media !== void 0 &&
              (xe.__media.removeListener(xe.__updateMedia),
              (xe.__media = void 0)),
          (xe.isActive = e === !0),
          document.body.classList.remove(
            `body--${e === !0 ? "light" : "dark"}`
          ),
          document.body.classList.add(`body--${e === !0 ? "dark" : "light"}`);
      },
      toggle() {
        xe.set(xe.isActive === !1);
      },
      install({ $q: e, onSSRHydrated: t, ssrContext: n }) {
        const { dark: r } = e.config;
        if (((e.dark = this), this.__installed === !0 && r === void 0)) return;
        this.isActive = r === !0;
        const o = r !== void 0 ? r : !1;
        if (dt.value === !0) {
          const i = (l) => {
              this.__fromSSR = l;
            },
            s = this.set;
          (this.set = i),
            i(o),
            t.push(() => {
              (this.set = s), this.set(this.__fromSSR);
            });
        } else this.set(o);
      },
    }
  ),
  Ps = () => !0;
function Du(e) {
  return typeof e == "string" && e !== "" && e !== "/" && e !== "#/";
}
function Vu(e) {
  return (
    e.startsWith("#") === !0 && (e = e.substring(1)),
    e.startsWith("/") === !1 && (e = "/" + e),
    e.endsWith("/") === !0 && (e = e.substring(0, e.length - 1)),
    "#" + e
  );
}
function Uu(e) {
  if (e.backButtonExit === !1) return () => !1;
  if (e.backButtonExit === "*") return Ps;
  const t = ["#/"];
  return (
    Array.isArray(e.backButtonExit) === !0 &&
      t.push(...e.backButtonExit.filter(Du).map(Vu)),
    () => t.includes(window.location.hash)
  );
}
const Ku = {
    __history: [],
    add: ln,
    remove: ln,
    install({ $q: e }) {
      if (this.__installed === !0) return;
      const { cordova: t, capacitor: n } = Ae.is;
      if (t !== !0 && n !== !0) return;
      const r = e.config[t === !0 ? "cordova" : "capacitor"];
      if (
        (r !== void 0 && r.backButton === !1) ||
        (n === !0 &&
          (window.Capacitor === void 0 ||
            window.Capacitor.Plugins.App === void 0))
      )
        return;
      (this.add = (s) => {
        s.condition === void 0 && (s.condition = Ps), this.__history.push(s);
      }),
        (this.remove = (s) => {
          const l = this.__history.indexOf(s);
          l >= 0 && this.__history.splice(l, 1);
        });
      const o = Uu(Object.assign({ backButtonExit: !0 }, r)),
        i = () => {
          if (this.__history.length) {
            const s = this.__history[this.__history.length - 1];
            s.condition() === !0 && (this.__history.pop(), s.handler());
          } else o() === !0 ? navigator.app.exitApp() : window.history.back();
        };
      t === !0
        ? document.addEventListener("deviceready", () => {
            document.addEventListener("backbutton", i, !1);
          })
        : window.Capacitor.Plugins.App.addListener("backButton", i);
    },
  },
  Xo = {
    isoName: "en-US",
    nativeName: "English (US)",
    label: {
      clear: "Clear",
      ok: "OK",
      cancel: "Cancel",
      close: "Close",
      set: "Set",
      select: "Select",
      reset: "Reset",
      remove: "Remove",
      update: "Update",
      create: "Create",
      search: "Search",
      filter: "Filter",
      refresh: "Refresh",
      expand: (e) => (e ? `Expand "${e}"` : "Expand"),
      collapse: (e) => (e ? `Collapse "${e}"` : "Collapse"),
    },
    date: {
      days: "Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday".split(
        "_"
      ),
      daysShort: "Sun_Mon_Tue_Wed_Thu_Fri_Sat".split("_"),
      months:
        "January_February_March_April_May_June_July_August_September_October_November_December".split(
          "_"
        ),
      monthsShort: "Jan_Feb_Mar_Apr_May_Jun_Jul_Aug_Sep_Oct_Nov_Dec".split("_"),
      firstDayOfWeek: 0,
      format24h: !1,
      pluralDay: "days",
    },
    table: {
      noData: "No data available",
      noResults: "No matching records found",
      loading: "Loading...",
      selectedRecords: (e) =>
        e === 1
          ? "1 record selected."
          : (e === 0 ? "No" : e) + " records selected.",
      recordsPerPage: "Records per page:",
      allRows: "All",
      pagination: (e, t, n) => e + "-" + t + " of " + n,
      columns: "Columns",
    },
    editor: {
      url: "URL",
      bold: "Bold",
      italic: "Italic",
      strikethrough: "Strikethrough",
      underline: "Underline",
      unorderedList: "Unordered List",
      orderedList: "Ordered List",
      subscript: "Subscript",
      superscript: "Superscript",
      hyperlink: "Hyperlink",
      toggleFullscreen: "Toggle Fullscreen",
      quote: "Quote",
      left: "Left align",
      center: "Center align",
      right: "Right align",
      justify: "Justify align",
      print: "Print",
      outdent: "Decrease indentation",
      indent: "Increase indentation",
      removeFormat: "Remove formatting",
      formatting: "Formatting",
      fontSize: "Font Size",
      align: "Align",
      hr: "Insert Horizontal Rule",
      undo: "Undo",
      redo: "Redo",
      heading1: "Heading 1",
      heading2: "Heading 2",
      heading3: "Heading 3",
      heading4: "Heading 4",
      heading5: "Heading 5",
      heading6: "Heading 6",
      paragraph: "Paragraph",
      code: "Code",
      size1: "Very small",
      size2: "A bit small",
      size3: "Normal",
      size4: "Medium-large",
      size5: "Big",
      size6: "Very big",
      size7: "Maximum",
      defaultFont: "Default Font",
      viewSource: "View Source",
    },
    tree: {
      noNodes: "No nodes available",
      noResults: "No matching nodes found",
    },
  };
function Go() {
  const e =
    Array.isArray(navigator.languages) === !0 &&
    navigator.languages.length !== 0
      ? navigator.languages[0]
      : navigator.language;
  if (typeof e == "string")
    return e
      .split(/[-_]/)
      .map((t, n) =>
        n === 0
          ? t.toLowerCase()
          : n > 1 || t.length < 4
          ? t.toUpperCase()
          : t[0].toUpperCase() + t.slice(1).toLowerCase()
      )
      .join("-");
}
const $e = Yn(
  { __langPack: {} },
  {
    getLocale: Go,
    set(e = Xo, t) {
      const n = { ...e, rtl: e.rtl === !0, getLocale: Go };
      {
        if (
          ((n.set = $e.set),
          $e.__langConfig === void 0 || $e.__langConfig.noHtmlAttrs !== !0)
        ) {
          const r = document.documentElement;
          r.setAttribute("dir", n.rtl === !0 ? "rtl" : "ltr"),
            r.setAttribute("lang", n.isoName);
        }
        Object.assign($e.__langPack, n),
          ($e.props = n),
          ($e.isoName = n.isoName),
          ($e.nativeName = n.nativeName);
      }
    },
    install({ $q: e, lang: t, ssrContext: n }) {
      (e.lang = $e.__langPack),
        ($e.__langConfig = e.config.lang),
        this.__installed === !0
          ? t !== void 0 && this.set(t)
          : this.set(t || Xo);
    },
  }
);
function Wu(e, t, n = document.body) {
  if (typeof e != "string")
    throw new TypeError("Expected a string as propName");
  if (typeof t != "string") throw new TypeError("Expected a string as value");
  if (!(n instanceof Element)) throw new TypeError("Expected a DOM element");
  n.style.setProperty(`--q-${e}`, t);
}
let Ts = !1;
function Qu(e) {
  Ts = e.isComposing === !0;
}
function Rs(e) {
  return (
    Ts === !0 || e !== Object(e) || e.isComposing === !0 || e.qKeyEvent === !0
  );
}
function Fr(e, t) {
  return Rs(e) === !0 ? !1 : [].concat(t).includes(e.keyCode);
}
function As(e) {
  if (e.ios === !0) return "ios";
  if (e.android === !0) return "android";
}
function Ju({ is: e, has: t, within: n }, r) {
  const o = [
    e.desktop === !0 ? "desktop" : "mobile",
    `${t.touch === !1 ? "no-" : ""}touch`,
  ];
  if (e.mobile === !0) {
    const i = As(e);
    i !== void 0 && o.push("platform-" + i);
  }
  if (e.nativeMobile === !0) {
    const i = e.nativeMobileWrapper;
    o.push(i),
      o.push("native-mobile"),
      e.ios === !0 &&
        (r[i] === void 0 || r[i].iosStatusBarPadding !== !1) &&
        o.push("q-ios-padding");
  } else e.electron === !0 ? o.push("electron") : e.bex === !0 && o.push("bex");
  return n.iframe === !0 && o.push("within-iframe"), o;
}
function Zu() {
  const { is: e } = Ae,
    t = document.body.className,
    n = new Set(t.replace(/ {2}/g, " ").split(" "));
  if (Zn !== void 0)
    n.delete("desktop"), n.add("platform-ios"), n.add("mobile");
  else if (e.nativeMobile !== !0 && e.electron !== !0 && e.bex !== !0) {
    if (e.desktop === !0)
      n.delete("mobile"),
        n.delete("platform-ios"),
        n.delete("platform-android"),
        n.add("desktop");
    else if (e.mobile === !0) {
      n.delete("desktop"), n.add("mobile");
      const o = As(e);
      o !== void 0
        ? (n.add(`platform-${o}`),
          n.delete(`platform-${o === "ios" ? "android" : "ios"}`))
        : (n.delete("platform-ios"), n.delete("platform-android"));
    }
  }
  Ae.has.touch === !0 && (n.delete("no-touch"), n.add("touch")),
    Ae.within.iframe === !0 && n.add("within-iframe");
  const r = Array.from(n).join(" ");
  t !== r && (document.body.className = r);
}
function Yu(e) {
  for (const t in e) Wu(t, e[t]);
}
const Xu = {
    install(e) {
      if (this.__installed !== !0) {
        if (dt.value === !0) Zu();
        else {
          const { $q: t } = e;
          t.config.brand !== void 0 && Yu(t.config.brand);
          const n = Ju(Ae, t.config);
          document.body.classList.add.apply(document.body.classList, n);
        }
        Ae.is.ios === !0 && document.body.addEventListener("touchstart", ln),
          window.addEventListener("keydown", Qu, !0);
      }
    },
  },
  Gu = {
    name: "material-icons",
    type: {
      positive: "check_circle",
      negative: "warning",
      info: "info",
      warning: "priority_high",
    },
    arrow: {
      up: "arrow_upward",
      right: "arrow_forward",
      down: "arrow_downward",
      left: "arrow_back",
      dropdown: "arrow_drop_down",
    },
    chevron: { left: "chevron_left", right: "chevron_right" },
    colorPicker: { spectrum: "gradient", tune: "tune", palette: "style" },
    pullToRefresh: { icon: "refresh" },
    carousel: {
      left: "chevron_left",
      right: "chevron_right",
      up: "keyboard_arrow_up",
      down: "keyboard_arrow_down",
      navigationIcon: "lens",
    },
    chip: { remove: "cancel", selected: "check" },
    datetime: {
      arrowLeft: "chevron_left",
      arrowRight: "chevron_right",
      now: "access_time",
      today: "today",
    },
    editor: {
      bold: "format_bold",
      italic: "format_italic",
      strikethrough: "strikethrough_s",
      underline: "format_underlined",
      unorderedList: "format_list_bulleted",
      orderedList: "format_list_numbered",
      subscript: "vertical_align_bottom",
      superscript: "vertical_align_top",
      hyperlink: "link",
      toggleFullscreen: "fullscreen",
      quote: "format_quote",
      left: "format_align_left",
      center: "format_align_center",
      right: "format_align_right",
      justify: "format_align_justify",
      print: "print",
      outdent: "format_indent_decrease",
      indent: "format_indent_increase",
      removeFormat: "format_clear",
      formatting: "text_format",
      fontSize: "format_size",
      align: "format_align_left",
      hr: "remove",
      undo: "undo",
      redo: "redo",
      heading: "format_size",
      code: "code",
      size: "format_size",
      font: "font_download",
      viewSource: "code",
    },
    expansionItem: {
      icon: "keyboard_arrow_down",
      denseIcon: "arrow_drop_down",
    },
    fab: { icon: "add", activeIcon: "close" },
    field: { clear: "cancel", error: "error" },
    pagination: {
      first: "first_page",
      prev: "keyboard_arrow_left",
      next: "keyboard_arrow_right",
      last: "last_page",
    },
    rating: { icon: "grade" },
    stepper: { done: "check", active: "edit", error: "warning" },
    tabs: {
      left: "chevron_left",
      right: "chevron_right",
      up: "keyboard_arrow_up",
      down: "keyboard_arrow_down",
    },
    table: {
      arrowUp: "arrow_upward",
      warning: "warning",
      firstPage: "first_page",
      prevPage: "chevron_left",
      nextPage: "chevron_right",
      lastPage: "last_page",
    },
    tree: { icon: "play_arrow" },
    uploader: {
      done: "done",
      clear: "clear",
      add: "add_box",
      upload: "cloud_upload",
      removeQueue: "clear_all",
      removeUploaded: "done_all",
    },
  },
  Fn = Yn(
    { iconMapFn: null, __icons: {} },
    {
      set(e, t) {
        const n = { ...e, rtl: e.rtl === !0 };
        (n.set = Fn.set), Object.assign(Fn.__icons, n);
      },
      install({ $q: e, iconSet: t, ssrContext: n }) {
        e.config.iconMapFn !== void 0 && (this.iconMapFn = e.config.iconMapFn),
          (e.iconSet = this.__icons),
          cn(
            e,
            "iconMapFn",
            () => this.iconMapFn,
            (r) => {
              this.iconMapFn = r;
            }
          ),
          this.__installed === !0
            ? t !== void 0 && this.set(t)
            : this.set(t || Gu);
      },
    }
  ),
  ec = "_q_",
  tc = "_q_fo_",
  ei = {};
let Fs = !1;
function nc() {
  Fs = !0;
}
function ti(e) {
  return e !== null && typeof e == "object" && Array.isArray(e) !== !0;
}
const ni = [Ar, Xu, xe, zu, Ku, $e, Fn];
function ri(e, t) {
  t.forEach((n) => {
    n.install(e), (n.__installed = !0);
  });
}
function rc(e, t, n) {
  (e.config.globalProperties.$q = n.$q),
    e.provide(ec, n.$q),
    ri(n, ni),
    t.components !== void 0 &&
      Object.values(t.components).forEach((r) => {
        ti(r) === !0 && r.name !== void 0 && e.component(r.name, r);
      }),
    t.directives !== void 0 &&
      Object.values(t.directives).forEach((r) => {
        ti(r) === !0 && r.name !== void 0 && e.directive(r.name, r);
      }),
    t.plugins !== void 0 &&
      ri(
        n,
        Object.values(t.plugins).filter(
          (r) => typeof r.install == "function" && ni.includes(r) === !1
        )
      ),
    dt.value === !0 &&
      (n.$q.onSSRHydrated = () => {
        n.onSSRHydrated.forEach((r) => {
          r();
        }),
          (n.$q.onSSRHydrated = () => {});
      });
}
const oc = function (e, t = {}) {
    const n = { version: "2.12.0" };
    Fs === !1
      ? (t.config !== void 0 && Object.assign(ei, t.config),
        (n.config = { ...ei }),
        nc())
      : (n.config = t.config || {}),
      rc(e, t, {
        parentApp: e,
        $q: n,
        lang: t.lang,
        iconSet: t.iconSet,
        onSSRHydrated: [],
      });
  },
  ic = { version: "2.12.0", install: oc, lang: $e, iconSet: Fn },
  sc = {
    name: "fontawesome-v6",
    type: {
      positive: "fas fa-check",
      negative: "fas fa-triangle-exclamation",
      info: "fas fa-circle-info",
      warning: "fas fa-exclamation",
    },
    arrow: {
      up: "fas fa-arrow-up",
      right: "fas fa-arrow-right",
      down: "fas fa-arrow-down",
      left: "fas fa-arrow-left",
      dropdown: "fas fa-caret-down",
    },
    chevron: { left: "fas fa-chevron-left", right: "fas fa-chevron-right" },
    colorPicker: {
      spectrum: "fas fa-eye-dropper",
      tune: "fas fa-sliders",
      palette: "fas fa-swatchbook",
    },
    pullToRefresh: { icon: "fas fa-rotate" },
    carousel: {
      left: "fas fa-chevron-left",
      right: "fas fa-chevron-right",
      up: "fas fa-chevron-up",
      down: "fas fa-chevron-down",
      navigationIcon: "fas fa-circle",
    },
    chip: { remove: "fas fa-circle-xmark", selected: "fas fa-check" },
    datetime: {
      arrowLeft: "fas fa-chevron-left",
      arrowRight: "fas fa-chevron-right",
      now: "far fa-clock",
      today: "far fa-calendar-check",
    },
    editor: {
      bold: "fas fa-bold",
      italic: "fas fa-italic",
      strikethrough: "fas fa-strikethrough",
      underline: "fas fa-underline",
      unorderedList: "fas fa-list-ul",
      orderedList: "fas fa-list-ol",
      subscript: "fas fa-subscript",
      superscript: "fas fa-superscript",
      hyperlink: "fas fa-link",
      toggleFullscreen: "fas fa-maximize",
      quote: "fas fa-quote-right",
      left: "fas fa-align-left",
      center: "fas fa-align-center",
      right: "fas fa-align-right",
      justify: "fas fa-align-justify",
      print: "fas fa-print",
      outdent: "fas fa-outdent",
      indent: "fas fa-indent",
      removeFormat: "fas fa-eraser",
      formatting: "fas fa-heading",
      fontSize: "fas fa-text-height",
      align: "fas fa-align-left",
      hr: "far fa-square-minus",
      undo: "fas fa-rotate-left",
      redo: "fas fa-rotate-right",
      heading: "fas fa-heading",
      code: "fas fa-code",
      size: "fas fa-text-height",
      font: "fas fa-font",
      viewSource: "fas fa-code",
    },
    expansionItem: {
      icon: "fas fa-chevron-down",
      denseIcon: "fas fa-caret-down",
    },
    fab: { icon: "fas fa-plus", activeIcon: "fas fa-xmark" },
    field: { clear: "fas fa-circle-xmark", error: "fas fa-circle-exclamation" },
    pagination: {
      first: "fas fa-backward-step",
      prev: "fas fa-chevron-left",
      next: "fas fa-chevron-right",
      last: "fas fa-forward-step",
    },
    rating: { icon: "fas fa-star" },
    stepper: {
      done: "fas fa-check",
      active: "fas fa-pencil",
      error: "fas fa-triangle-exclamation",
    },
    tabs: {
      left: "fas fa-chevron-left",
      right: "fas fa-chevron-right",
      up: "fas fa-chevron-up",
      down: "fas fa-chevron-down",
    },
    table: {
      arrowUp: "fas fa-arrow-up",
      warning: "fas fa-triangle-exclamation",
      firstPage: "fas fa-backward-step",
      prevPage: "fas fa-chevron-left",
      nextPage: "fas fa-chevron-right",
      lastPage: "fas fa-forward-step",
    },
    tree: { icon: "fas fa-play" },
    uploader: {
      done: "fas fa-check",
      clear: "fas fa-xmark",
      add: "fas fa-square-plus",
      upload: "fas fa-upload",
      removeQueue: "fas fa-bars-staggered",
      removeUploaded: "fas fa-clipboard-check",
    },
  };
function lc(e) {
  return {
    all: (e = e || new Map()),
    on: function (t, n) {
      var r = e.get(t);
      r ? r.push(n) : e.set(t, [n]);
    },
    off: function (t, n) {
      var r = e.get(t);
      r && (n ? r.splice(r.indexOf(n) >>> 0, 1) : e.set(t, []));
    },
    emit: function (t, n) {
      var r = e.get(t);
      r &&
        r.slice().map(function (o) {
          o(n);
        }),
        (r = e.get("*")) &&
          r.slice().map(function (o) {
            o(t, n);
          });
    },
  };
}
const oo = Ou("store", {
    state: () => ({ resourcename: "av_dui" }),
    actions: {
      SendMessage(e, t) {
        fetch(`https://${this.resourcename}/${e}`, {
          method: "POST",
          headers: { "Content-Type": "application/json; charset=UTF-8" },
          body: JSON.stringify(t),
        });
      },
      SendMessageAsync(e, t) {
        return new Promise((n) => {
          fetch(`https://${this.resourcename}/${e}`, {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=UTF-8" },
            body: JSON.stringify(t),
          })
            .then((r) => r.json())
            .then((r) => n(r));
        });
      },
    },
    getters: {},
    setters: {},
  }),
  Or = { xs: 18, sm: 24, md: 32, lg: 38, xl: 46 },
  Os = { size: String };
function qs(e, t = Or) {
  return I(() =>
    e.size !== void 0
      ? { fontSize: e.size in t ? `${t[e.size]}px` : e.size }
      : null
  );
}
const ac = { size: { type: [Number, String], default: "1em" }, color: String };
function uc(e) {
  return {
    cSize: I(() => (e.size in Or ? `${Or[e.size]}px` : e.size)),
    classes: I(() => "q-spinner" + (e.color ? ` text-${e.color}` : "")),
  };
}
const gt = (e) => ct(ua(e)),
  cc = (e) => ct(e),
  io = gt({
    name: "QSpinner",
    props: { ...ac, thickness: { type: Number, default: 5 } },
    setup(e) {
      const { cSize: t, classes: n } = uc(e);
      return () =>
        H(
          "svg",
          {
            class: n.value + " q-spinner-mat",
            width: t.value,
            height: t.value,
            viewBox: "25 25 50 50",
          },
          [
            H("circle", {
              class: "path",
              cx: "50",
              cy: "50",
              r: "20",
              fill: "none",
              stroke: "currentColor",
              "stroke-width": e.thickness,
              "stroke-miterlimit": "10",
            }),
          ]
        );
    },
  }),
  fc = { ratio: [String, Number] };
function dc(e, t) {
  return I(() => {
    const n = Number(e.ratio || (t !== void 0 ? t.value : void 0));
    return isNaN(n) !== !0 && n > 0 ? { paddingBottom: `${100 / n}%` } : null;
  });
}
function Ye(e, t) {
  return (e !== void 0 && e()) || t;
}
function Zt(e, t) {
  return e !== void 0 ? t.concat(e()) : t;
}
const hc = 16 / 9,
  gc = gt({
    name: "QImg",
    props: {
      ...fc,
      src: String,
      srcset: String,
      sizes: String,
      alt: String,
      crossorigin: String,
      decoding: String,
      referrerpolicy: String,
      draggable: Boolean,
      loading: { type: String, default: "lazy" },
      fetchpriority: { type: String, default: "auto" },
      width: String,
      height: String,
      initialRatio: { type: [Number, String], default: hc },
      placeholderSrc: String,
      fit: { type: String, default: "cover" },
      position: { type: String, default: "50% 50%" },
      imgClass: String,
      imgStyle: Object,
      noSpinner: Boolean,
      noNativeMenu: Boolean,
      noTransition: Boolean,
      spinnerColor: String,
      spinnerSize: String,
    },
    emits: ["load", "error"],
    setup(e, { slots: t, emit: n }) {
      const r = ce(e.initialRatio),
        o = dc(e, r);
      let i = null,
        s = !1;
      const l = [ce(null), ce(F())],
        a = ce(0),
        c = ce(!1),
        f = ce(!1),
        g = I(() => `q-img q-img--${e.noNativeMenu === !0 ? "no-" : ""}menu`),
        h = I(() => ({ width: e.width, height: e.height })),
        x = I(
          () =>
            `q-img__image ${
              e.imgClass !== void 0 ? e.imgClass + " " : ""
            }q-img__image--with${e.noTransition === !0 ? "out" : ""}-transition`
        ),
        M = I(() => ({
          ...e.imgStyle,
          objectFit: e.fit,
          objectPosition: e.position,
        }));
      ve(() => A(), V);
      function A() {
        return e.src || e.srcset || e.sizes
          ? { src: e.src, srcset: e.srcset, sizes: e.sizes }
          : null;
      }
      function F() {
        return e.placeholderSrc !== void 0 ? { src: e.placeholderSrc } : null;
      }
      function V(p) {
        i !== null && (clearTimeout(i), (i = null)),
          (f.value = !1),
          p === null
            ? ((c.value = !1), (l[a.value ^ 1].value = F()))
            : (c.value = !0),
          (l[a.value].value = p);
      }
      function W({ target: p }) {
        s !== !0 &&
          (i !== null && (clearTimeout(i), (i = null)),
          (r.value =
            p.naturalHeight === 0 ? 0.5 : p.naturalWidth / p.naturalHeight),
          Y(p, 1));
      }
      function Y(p, b) {
        s === !0 ||
          b === 1e3 ||
          (p.complete === !0
            ? L(p)
            : (i = setTimeout(() => {
                (i = null), Y(p, b + 1);
              }, 50)));
      }
      function L(p) {
        s !== !0 &&
          ((a.value = a.value ^ 1),
          (l[a.value].value = null),
          (c.value = !1),
          (f.value = !1),
          n("load", p.currentSrc || p.src));
      }
      function $(p) {
        i !== null && (clearTimeout(i), (i = null)),
          (c.value = !1),
          (f.value = !0),
          (l[a.value].value = null),
          (l[a.value ^ 1].value = F()),
          n("error", p);
      }
      function U(p) {
        const b = l[p].value,
          _ = {
            key: "img_" + p,
            class: x.value,
            style: M.value,
            crossorigin: e.crossorigin,
            decoding: e.decoding,
            referrerpolicy: e.referrerpolicy,
            height: e.height,
            width: e.width,
            loading: e.loading,
            fetchpriority: e.fetchpriority,
            "aria-hidden": "true",
            draggable: e.draggable,
            ...b,
          };
        return (
          a.value === p
            ? ((_.class += " q-img__image--waiting"),
              Object.assign(_, { onLoad: W, onError: $ }))
            : (_.class += " q-img__image--loaded"),
          H(
            "div",
            { class: "q-img__container absolute-full", key: "img" + p },
            H("img", _)
          )
        );
      }
      function q() {
        return c.value !== !0
          ? H(
              "div",
              {
                key: "content",
                class: "q-img__content absolute-full q-anchor--skip",
              },
              Ye(t[f.value === !0 ? "error" : "default"])
            )
          : H(
              "div",
              {
                key: "loading",
                class: "q-img__loading absolute-full flex flex-center",
              },
              t.loading !== void 0
                ? t.loading()
                : e.noSpinner === !0
                ? void 0
                : [H(io, { color: e.spinnerColor, size: e.spinnerSize })]
            );
      }
      return (
        V(A()),
        ht(() => {
          (s = !0), i !== null && (clearTimeout(i), (i = null));
        }),
        () => {
          const p = [];
          return (
            o.value !== null &&
              p.push(H("div", { key: "filler", style: o.value })),
            f.value !== !0 &&
              (l[0].value !== null && p.push(U(0)),
              l[1].value !== null && p.push(U(1))),
            p.push(H(un, { name: "q-transition--fade" }, q)),
            H(
              "div",
              {
                class: g.value,
                style: h.value,
                role: "img",
                "aria-label": e.alt,
              },
              p
            )
          );
        }
      );
    },
  });
const so = (e, t) => {
    const n = e.__vccOpts || e;
    for (const [r, o] of t) n[r] = o;
    return n;
  },
  mc = {
    components: {},
    setup() {
      return { store: oo() };
    },
    data() {
      return { showing: !1, imageSrc: "", width: 1920, height: 1080 };
    },
    computed: {},
    methods: {},
    mounted() {
      this.eventBus.on("setDUIVariables", (e) => {
        (this.showing = !0),
          (this.imageSrc = e.imageSrc),
          (this.width = e.width),
          (this.height = e.height);
      });
    },
    unmounted() {
      this.eventBus.off("setDUIVariables");
    },
  };
function pc(e, t, n, r, o, i) {
  return Pn(
    (to(),
    vs(
      gc,
      {
        src: o.imageSrc,
        width: o.width + "px",
        height: o.height + "px",
        id: "chalkboard",
      },
      null,
      8,
      ["src", "width", "height"]
    )),
    [[Pr, o.showing]]
  );
}
const vc = so(mc, [
    ["render", pc],
    ["__scopeId", "data-v-b52e903b"],
  ]),
  oi = gt({
    name: "QCardSection",
    props: { tag: { type: String, default: "div" }, horizontal: Boolean },
    setup(e, { slots: t }) {
      const n = I(
        () =>
          `q-card__section q-card__section--${
            e.horizontal === !0 ? "horiz row no-wrap" : "vert"
          }`
      );
      return () => H(e.tag, { class: n.value }, Ye(t.default));
    },
  }),
  ii = "0 0 24 24",
  si = (e) => e,
  fr = (e) => `ionicons ${e}`,
  Is = {
    "mdi-": (e) => `mdi ${e}`,
    "icon-": si,
    "bt-": (e) => `bt ${e}`,
    "eva-": (e) => `eva ${e}`,
    "ion-md": fr,
    "ion-ios": fr,
    "ion-logo": fr,
    "iconfont ": si,
    "ti-": (e) => `themify-icon ${e}`,
    "bi-": (e) => `bootstrap-icons ${e}`,
  },
  Ls = { o_: "-outlined", r_: "-round", s_: "-sharp" },
  Bs = { sym_o_: "-outlined", sym_r_: "-rounded", sym_s_: "-sharp" },
  bc = new RegExp("^(" + Object.keys(Is).join("|") + ")"),
  _c = new RegExp("^(" + Object.keys(Ls).join("|") + ")"),
  li = new RegExp("^(" + Object.keys(Bs).join("|") + ")"),
  yc = /^[Mm]\s?[-+]?\.?\d/,
  wc = /^img:/,
  xc = /^svguse:/,
  Cc = /^ion-/,
  kc = /^(fa-(sharp|solid|regular|light|brands|duotone|thin)|[lf]a[srlbdk]?) /,
  On = gt({
    name: "QIcon",
    props: {
      ...Os,
      tag: { type: String, default: "i" },
      name: String,
      color: String,
      left: Boolean,
      right: Boolean,
    },
    setup(e, { slots: t }) {
      const {
          proxy: { $q: n },
        } = ze(),
        r = qs(e),
        o = I(
          () =>
            "q-icon" +
            (e.left === !0 ? " on-left" : "") +
            (e.right === !0 ? " on-right" : "") +
            (e.color !== void 0 ? ` text-${e.color}` : "")
        ),
        i = I(() => {
          let s,
            l = e.name;
          if (l === "none" || !l) return { none: !0 };
          if (n.iconMapFn !== null) {
            const f = n.iconMapFn(l);
            if (f !== void 0)
              if (f.icon !== void 0) {
                if (((l = f.icon), l === "none" || !l)) return { none: !0 };
              } else
                return {
                  cls: f.cls,
                  content: f.content !== void 0 ? f.content : " ",
                };
          }
          if (yc.test(l) === !0) {
            const [f, g = ii] = l.split("|");
            return {
              svg: !0,
              viewBox: g,
              nodes: f.split("&&").map((h) => {
                const [x, M, A] = h.split("@@");
                return H("path", { style: M, d: x, transform: A });
              }),
            };
          }
          if (wc.test(l) === !0) return { img: !0, src: l.substring(4) };
          if (xc.test(l) === !0) {
            const [f, g = ii] = l.split("|");
            return { svguse: !0, src: f.substring(7), viewBox: g };
          }
          let a = " ";
          const c = l.match(bc);
          if (c !== null) s = Is[c[1]](l);
          else if (kc.test(l) === !0) s = l;
          else if (Cc.test(l) === !0)
            s = `ionicons ion-${
              n.platform.is.ios === !0 ? "ios" : "md"
            }${l.substring(3)}`;
          else if (li.test(l) === !0) {
            s = "notranslate material-symbols";
            const f = l.match(li);
            f !== null && ((l = l.substring(6)), (s += Bs[f[1]])), (a = l);
          } else {
            s = "notranslate material-icons";
            const f = l.match(_c);
            f !== null && ((l = l.substring(2)), (s += Ls[f[1]])), (a = l);
          }
          return { cls: s, content: a };
        });
      return () => {
        const s = {
          class: o.value,
          style: r.value,
          "aria-hidden": "true",
          role: "presentation",
        };
        return i.value.none === !0
          ? H(e.tag, s, Ye(t.default))
          : i.value.img === !0
          ? H("span", s, Zt(t.default, [H("img", { src: i.value.src })]))
          : i.value.svg === !0
          ? H(
              "span",
              s,
              Zt(t.default, [
                H(
                  "svg",
                  { viewBox: i.value.viewBox || "0 0 24 24" },
                  i.value.nodes
                ),
              ])
            )
          : i.value.svguse === !0
          ? H(
              "span",
              s,
              Zt(t.default, [
                H("svg", { viewBox: i.value.viewBox }, [
                  H("use", { "xlink:href": i.value.src }),
                ]),
              ])
            )
          : (i.value.cls !== void 0 && (s.class += " " + i.value.cls),
            H(e.tag, s, Zt(t.default, [i.value.content])));
      };
    },
  }),
  $s = { dark: { type: Boolean, default: null } };
function Ns(e, t) {
  return I(() => (e.dark === null ? t.dark.isActive : e.dark));
}
function Sc({ validate: e, resetValidation: t, requiresQForm: n }) {
  const r = Bt(tc, !1);
  if (r !== !1) {
    const { props: o, proxy: i } = ze();
    Object.assign(i, { validate: e, resetValidation: t }),
      ve(
        () => o.disable,
        (s) => {
          s === !0
            ? (typeof t == "function" && t(), r.unbindComponent(i))
            : r.bindComponent(i);
        }
      ),
      an(() => {
        o.disable !== !0 && r.bindComponent(i);
      }),
      ht(() => {
        o.disable !== !0 && r.unbindComponent(i);
      });
  } else n === !0 && console.error("Parent QForm not found on useFormChild()!");
}
const ai = /^#[0-9a-fA-F]{3}([0-9a-fA-F]{3})?$/,
  ui = /^#[0-9a-fA-F]{4}([0-9a-fA-F]{4})?$/,
  ci = /^#([0-9a-fA-F]{3}|[0-9a-fA-F]{4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$/,
  bn =
    /^rgb\(((0|[1-9][\d]?|1[\d]{0,2}|2[\d]?|2[0-4][\d]|25[0-5]),){2}(0|[1-9][\d]?|1[\d]{0,2}|2[\d]?|2[0-4][\d]|25[0-5])\)$/,
  _n =
    /^rgba\(((0|[1-9][\d]?|1[\d]{0,2}|2[\d]?|2[0-4][\d]|25[0-5]),){2}(0|[1-9][\d]?|1[\d]{0,2}|2[\d]?|2[0-4][\d]|25[0-5]),(0|0\.[0-9]+[1-9]|0\.[1-9]+|1)\)$/,
  dr = {
    date: (e) => /^-?[\d]+\/[0-1]\d\/[0-3]\d$/.test(e),
    time: (e) => /^([0-1]?\d|2[0-3]):[0-5]\d$/.test(e),
    fulltime: (e) => /^([0-1]?\d|2[0-3]):[0-5]\d:[0-5]\d$/.test(e),
    timeOrFulltime: (e) => /^([0-1]?\d|2[0-3]):[0-5]\d(:[0-5]\d)?$/.test(e),
    email: (e) =>
      /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(
        e
      ),
    hexColor: (e) => ai.test(e),
    hexaColor: (e) => ui.test(e),
    hexOrHexaColor: (e) => ci.test(e),
    rgbColor: (e) => bn.test(e),
    rgbaColor: (e) => _n.test(e),
    rgbOrRgbaColor: (e) => bn.test(e) || _n.test(e),
    hexOrRgbColor: (e) => ai.test(e) || bn.test(e),
    hexaOrRgbaColor: (e) => ui.test(e) || _n.test(e),
    anyColor: (e) => ci.test(e) || bn.test(e) || _n.test(e),
  },
  Ec = [!0, !1, "ondemand"],
  Mc = {
    modelValue: {},
    error: { type: Boolean, default: null },
    errorMessage: String,
    noErrorIcon: Boolean,
    rules: Array,
    reactiveRules: Boolean,
    lazyRules: { type: [Boolean, String], validator: (e) => Ec.includes(e) },
  };
function Pc(e, t) {
  const { props: n, proxy: r } = ze(),
    o = ce(!1),
    i = ce(null),
    s = ce(null);
  Sc({ validate: M, resetValidation: x });
  let l = 0,
    a;
  const c = I(
      () => n.rules !== void 0 && n.rules !== null && n.rules.length !== 0
    ),
    f = I(() => n.disable !== !0 && c.value === !0),
    g = I(() => n.error === !0 || o.value === !0),
    h = I(() =>
      typeof n.errorMessage == "string" && n.errorMessage.length !== 0
        ? n.errorMessage
        : i.value
    );
  ve(
    () => n.modelValue,
    () => {
      A();
    }
  ),
    ve(
      () => n.reactiveRules,
      (V) => {
        V === !0
          ? a === void 0 &&
            (a = ve(
              () => n.rules,
              () => {
                A(!0);
              }
            ))
          : a !== void 0 && (a(), (a = void 0));
      },
      { immediate: !0 }
    ),
    ve(e, (V) => {
      V === !0
        ? s.value === null && (s.value = !1)
        : s.value === !1 &&
          ((s.value = !0),
          f.value === !0 &&
            n.lazyRules !== "ondemand" &&
            t.value === !1 &&
            F());
    });
  function x() {
    l++,
      (t.value = !1),
      (s.value = null),
      (o.value = !1),
      (i.value = null),
      F.cancel();
  }
  function M(V = n.modelValue) {
    if (f.value !== !0) return !0;
    const W = ++l,
      Y =
        t.value !== !0
          ? () => {
              s.value = !0;
            }
          : () => {},
      L = (U, q) => {
        U === !0 && Y(), (o.value = U), (i.value = q || null), (t.value = !1);
      },
      $ = [];
    for (let U = 0; U < n.rules.length; U++) {
      const q = n.rules[U];
      let p;
      if (
        (typeof q == "function"
          ? (p = q(V, dr))
          : typeof q == "string" && dr[q] !== void 0 && (p = dr[q](V)),
        p === !1 || typeof p == "string")
      )
        return L(!0, p), !1;
      p !== !0 && p !== void 0 && $.push(p);
    }
    return $.length === 0
      ? (L(!1), !0)
      : ((t.value = !0),
        Promise.all($).then(
          (U) => {
            if (U === void 0 || Array.isArray(U) === !1 || U.length === 0)
              return W === l && L(!1), !0;
            const q = U.find((p) => p === !1 || typeof p == "string");
            return W === l && L(q !== void 0, q), q === void 0;
          },
          (U) => (W === l && (console.error(U), L(!0)), !1)
        ));
  }
  function A(V) {
    f.value === !0 &&
      n.lazyRules !== "ondemand" &&
      (s.value === !0 || (n.lazyRules !== !0 && V !== !0)) &&
      F();
  }
  const F = Ms(M, 0);
  return (
    ht(() => {
      a !== void 0 && a(), F.cancel();
    }),
    Object.assign(r, { resetValidation: x, validate: M }),
    cn(r, "hasError", () => g.value),
    {
      isDirtyModel: s,
      hasRules: c,
      hasError: g,
      errorMessage: h,
      validate: M,
      resetValidation: x,
    }
  );
}
const fi = /^on[A-Z]/;
function Tc(e, t) {
  const n = { listeners: ce({}), attributes: ce({}) };
  function r() {
    const o = {},
      i = {};
    for (const s in e)
      s !== "class" && s !== "style" && fi.test(s) === !1 && (o[s] = e[s]);
    for (const s in t.props) fi.test(s) === !0 && (i[s] = t.props[s]);
    (n.attributes.value = o), (n.listeners.value = i);
  }
  return is(r), r(), n;
}
let hr,
  yn = 0;
const we = new Array(256);
for (let e = 0; e < 256; e++) we[e] = (e + 256).toString(16).substring(1);
const Rc = (() => {
    const e =
      typeof crypto < "u"
        ? crypto
        : typeof window < "u"
        ? window.crypto || window.msCrypto
        : void 0;
    if (e !== void 0) {
      if (e.randomBytes !== void 0) return e.randomBytes;
      if (e.getRandomValues !== void 0)
        return (t) => {
          const n = new Uint8Array(t);
          return e.getRandomValues(n), n;
        };
    }
    return (t) => {
      const n = [];
      for (let r = t; r > 0; r--) n.push(Math.floor(Math.random() * 256));
      return n;
    };
  })(),
  di = 4096;
function Ac() {
  (hr === void 0 || yn + 16 > di) && ((yn = 0), (hr = Rc(di)));
  const e = Array.prototype.slice.call(hr, yn, (yn += 16));
  return (
    (e[6] = (e[6] & 15) | 64),
    (e[8] = (e[8] & 63) | 128),
    we[e[0]] +
      we[e[1]] +
      we[e[2]] +
      we[e[3]] +
      "-" +
      we[e[4]] +
      we[e[5]] +
      "-" +
      we[e[6]] +
      we[e[7]] +
      "-" +
      we[e[8]] +
      we[e[9]] +
      "-" +
      we[e[10]] +
      we[e[11]] +
      we[e[12]] +
      we[e[13]] +
      we[e[14]] +
      we[e[15]]
  );
}
let qr = [],
  Fc = [];
function js(e) {
  Fc.length === 0 ? e() : qr.push(e);
}
function Oc(e) {
  qr = qr.filter((t) => t !== e);
}
function Ir(e) {
  return e === void 0 ? `f_${Ac()}` : e;
}
function Lr(e) {
  return e != null && ("" + e).length !== 0;
}
const qc = {
    ...$s,
    ...Mc,
    label: String,
    stackLabel: Boolean,
    hint: String,
    hideHint: Boolean,
    prefix: String,
    suffix: String,
    labelColor: String,
    color: String,
    bgColor: String,
    filled: Boolean,
    outlined: Boolean,
    borderless: Boolean,
    standout: [Boolean, String],
    square: Boolean,
    loading: Boolean,
    labelSlot: Boolean,
    bottomSlots: Boolean,
    hideBottomSpace: Boolean,
    rounded: Boolean,
    dense: Boolean,
    itemAligned: Boolean,
    counter: Boolean,
    clearable: Boolean,
    clearIcon: String,
    disable: Boolean,
    readonly: Boolean,
    autofocus: Boolean,
    for: String,
    maxlength: [Number, String],
  },
  Ic = [
    "update:modelValue",
    "clear",
    "focus",
    "blur",
    "popupShow",
    "popupHide",
  ];
function Lc() {
  const { props: e, attrs: t, proxy: n, vnode: r } = ze();
  return {
    isDark: Ns(e, n.$q),
    editable: I(() => e.disable !== !0 && e.readonly !== !0),
    innerLoading: ce(!1),
    focused: ce(!1),
    hasPopupOpen: !1,
    splitAttrs: Tc(t, r),
    targetUid: ce(Ir(e.for)),
    rootRef: ce(null),
    targetRef: ce(null),
    controlRef: ce(null),
  };
}
function Bc(e) {
  const { props: t, emit: n, slots: r, attrs: o, proxy: i } = ze(),
    { $q: s } = i;
  let l = null;
  e.hasValue === void 0 && (e.hasValue = I(() => Lr(t.modelValue))),
    e.emitValue === void 0 &&
      (e.emitValue = (y) => {
        n("update:modelValue", y);
      }),
    e.controlEvents === void 0 &&
      (e.controlEvents = { onFocusin: b, onFocusout: _ }),
    Object.assign(e, {
      clearValue: P,
      onControlFocusin: b,
      onControlFocusout: _,
      focus: q,
    }),
    e.computedCounter === void 0 &&
      (e.computedCounter = I(() => {
        if (t.counter !== !1) {
          const y =
              typeof t.modelValue == "string" || typeof t.modelValue == "number"
                ? ("" + t.modelValue).length
                : Array.isArray(t.modelValue) === !0
                ? t.modelValue.length
                : 0,
            z = t.maxlength !== void 0 ? t.maxlength : t.maxValues;
          return y + (z !== void 0 ? " / " + z : "");
        }
      }));
  const {
      isDirtyModel: a,
      hasRules: c,
      hasError: f,
      errorMessage: g,
      resetValidation: h,
    } = Pc(e.focused, e.innerLoading),
    x =
      e.floatingLabel !== void 0
        ? I(
            () =>
              t.stackLabel === !0 ||
              e.focused.value === !0 ||
              e.floatingLabel.value === !0
          )
        : I(
            () =>
              t.stackLabel === !0 ||
              e.focused.value === !0 ||
              e.hasValue.value === !0
          ),
    M = I(
      () =>
        t.bottomSlots === !0 ||
        t.hint !== void 0 ||
        c.value === !0 ||
        t.counter === !0 ||
        t.error !== null
    ),
    A = I(() =>
      t.filled === !0
        ? "filled"
        : t.outlined === !0
        ? "outlined"
        : t.borderless === !0
        ? "borderless"
        : t.standout
        ? "standout"
        : "standard"
    ),
    F = I(
      () =>
        `q-field row no-wrap items-start q-field--${A.value}` +
        (e.fieldClass !== void 0 ? ` ${e.fieldClass.value}` : "") +
        (t.rounded === !0 ? " q-field--rounded" : "") +
        (t.square === !0 ? " q-field--square" : "") +
        (x.value === !0 ? " q-field--float" : "") +
        (W.value === !0 ? " q-field--labeled" : "") +
        (t.dense === !0 ? " q-field--dense" : "") +
        (t.itemAligned === !0 ? " q-field--item-aligned q-item-type" : "") +
        (e.isDark.value === !0 ? " q-field--dark" : "") +
        (e.getControl === void 0 ? " q-field--auto-height" : "") +
        (e.focused.value === !0 ? " q-field--focused" : "") +
        (f.value === !0 ? " q-field--error" : "") +
        (f.value === !0 || e.focused.value === !0
          ? " q-field--highlighted"
          : "") +
        (t.hideBottomSpace !== !0 && M.value === !0
          ? " q-field--with-bottom"
          : "") +
        (t.disable === !0
          ? " q-field--disabled"
          : t.readonly === !0
          ? " q-field--readonly"
          : "")
    ),
    V = I(
      () =>
        "q-field__control relative-position row no-wrap" +
        (t.bgColor !== void 0 ? ` bg-${t.bgColor}` : "") +
        (f.value === !0
          ? " text-negative"
          : typeof t.standout == "string" &&
            t.standout.length !== 0 &&
            e.focused.value === !0
          ? ` ${t.standout}`
          : t.color !== void 0
          ? ` text-${t.color}`
          : "")
    ),
    W = I(() => t.labelSlot === !0 || t.label !== void 0),
    Y = I(
      () =>
        "q-field__label no-pointer-events absolute ellipsis" +
        (t.labelColor !== void 0 && f.value !== !0
          ? ` text-${t.labelColor}`
          : "")
    ),
    L = I(() => ({
      id: e.targetUid.value,
      editable: e.editable.value,
      focused: e.focused.value,
      floatingLabel: x.value,
      modelValue: t.modelValue,
      emitValue: e.emitValue,
    })),
    $ = I(() => {
      const y = { for: e.targetUid.value };
      return (
        t.disable === !0
          ? (y["aria-disabled"] = "true")
          : t.readonly === !0 && (y["aria-readonly"] = "true"),
        y
      );
    });
  ve(
    () => t.for,
    (y) => {
      e.targetUid.value = Ir(y);
    }
  );
  function U() {
    const y = document.activeElement;
    let z = e.targetRef !== void 0 && e.targetRef.value;
    z &&
      (y === null || y.id !== e.targetUid.value) &&
      (z.hasAttribute("tabindex") === !0 || (z = z.querySelector("[tabindex]")),
      z && z !== y && z.focus({ preventScroll: !0 }));
  }
  function q() {
    js(U);
  }
  function p() {
    Oc(U);
    const y = document.activeElement;
    y !== null && e.rootRef.value.contains(y) && y.blur();
  }
  function b(y) {
    l !== null && (clearTimeout(l), (l = null)),
      e.editable.value === !0 &&
        e.focused.value === !1 &&
        ((e.focused.value = !0), n("focus", y));
  }
  function _(y, z) {
    l !== null && clearTimeout(l),
      (l = setTimeout(() => {
        (l = null),
          !(
            document.hasFocus() === !0 &&
            (e.hasPopupOpen === !0 ||
              e.controlRef === void 0 ||
              e.controlRef.value === null ||
              e.controlRef.value.contains(document.activeElement) !== !1)
          ) &&
            (e.focused.value === !0 && ((e.focused.value = !1), n("blur", y)),
            z !== void 0 && z());
      }));
  }
  function P(y) {
    _t(y),
      s.platform.is.mobile !== !0
        ? (
            (e.targetRef !== void 0 && e.targetRef.value) ||
            e.rootRef.value
          ).focus()
        : e.rootRef.value.contains(document.activeElement) === !0 &&
          document.activeElement.blur(),
      t.type === "file" && (e.inputRef.value.value = null),
      n("update:modelValue", null),
      n("clear", t.modelValue),
      Ze(() => {
        h(), s.platform.is.mobile !== !0 && (a.value = !1);
      });
  }
  function m() {
    const y = [];
    return (
      r.prepend !== void 0 &&
        y.push(
          H(
            "div",
            {
              class:
                "q-field__prepend q-field__marginal row no-wrap items-center",
              key: "prepend",
              onClick: Ot,
            },
            r.prepend()
          )
        ),
      y.push(
        H(
          "div",
          {
            class:
              "q-field__control-container col relative-position row no-wrap q-anchor--skip",
          },
          N()
        )
      ),
      f.value === !0 &&
        t.noErrorIcon === !1 &&
        y.push(
          j("error", [
            H(On, { name: s.iconSet.field.error, color: "negative" }),
          ])
        ),
      t.loading === !0 || e.innerLoading.value === !0
        ? y.push(
            j(
              "inner-loading-append",
              r.loading !== void 0 ? r.loading() : [H(io, { color: t.color })]
            )
          )
        : t.clearable === !0 &&
          e.hasValue.value === !0 &&
          e.editable.value === !0 &&
          y.push(
            j("inner-clearable-append", [
              H(On, {
                class: "q-field__focusable-action",
                tag: "button",
                name: t.clearIcon || s.iconSet.field.clear,
                tabindex: 0,
                type: "button",
                "aria-hidden": null,
                role: null,
                onClick: P,
              }),
            ])
          ),
      r.append !== void 0 &&
        y.push(
          H(
            "div",
            {
              class:
                "q-field__append q-field__marginal row no-wrap items-center",
              key: "append",
              onClick: Ot,
            },
            r.append()
          )
        ),
      e.getInnerAppend !== void 0 &&
        y.push(j("inner-append", e.getInnerAppend())),
      e.getControlChild !== void 0 && y.push(e.getControlChild()),
      y
    );
  }
  function N() {
    const y = [];
    return (
      t.prefix !== void 0 &&
        t.prefix !== null &&
        y.push(
          H(
            "div",
            { class: "q-field__prefix no-pointer-events row items-center" },
            t.prefix
          )
        ),
      e.getShadowControl !== void 0 &&
        e.hasShadow.value === !0 &&
        y.push(e.getShadowControl()),
      e.getControl !== void 0
        ? y.push(e.getControl())
        : r.rawControl !== void 0
        ? y.push(r.rawControl())
        : r.control !== void 0 &&
          y.push(
            H(
              "div",
              {
                ref: e.targetRef,
                class: "q-field__native row",
                tabindex: -1,
                ...e.splitAttrs.attributes.value,
                "data-autofocus": t.autofocus === !0 || void 0,
              },
              r.control(L.value)
            )
          ),
      W.value === !0 &&
        y.push(H("div", { class: Y.value }, Ye(r.label, t.label))),
      t.suffix !== void 0 &&
        t.suffix !== null &&
        y.push(
          H(
            "div",
            { class: "q-field__suffix no-pointer-events row items-center" },
            t.suffix
          )
        ),
      y.concat(Ye(r.default))
    );
  }
  function w() {
    let y, z;
    f.value === !0
      ? g.value !== null
        ? ((y = [H("div", { role: "alert" }, g.value)]),
          (z = `q--slot-error-${g.value}`))
        : ((y = Ye(r.error)), (z = "q--slot-error"))
      : (t.hideHint !== !0 || e.focused.value === !0) &&
        (t.hint !== void 0
          ? ((y = [H("div", t.hint)]), (z = `q--slot-hint-${t.hint}`))
          : ((y = Ye(r.hint)), (z = "q--slot-hint")));
    const _e = t.counter === !0 || r.counter !== void 0;
    if (t.hideBottomSpace === !0 && _e === !1 && y === void 0) return;
    const ne = H("div", { key: z, class: "q-field__messages col" }, y);
    return H(
      "div",
      {
        class:
          "q-field__bottom row items-start q-field__bottom--" +
          (t.hideBottomSpace !== !0 ? "animated" : "stale"),
        onClick: Ot,
      },
      [
        t.hideBottomSpace === !0
          ? ne
          : H(un, { name: "q-transition--field-message" }, () => ne),
        _e === !0
          ? H(
              "div",
              { class: "q-field__counter" },
              r.counter !== void 0 ? r.counter() : e.computedCounter.value
            )
          : null,
      ]
    );
  }
  function j(y, z) {
    return z === null
      ? null
      : H(
          "div",
          {
            key: y,
            class:
              "q-field__append q-field__marginal row no-wrap items-center q-anchor--skip",
          },
          z
        );
  }
  let K = !1;
  return (
    rs(() => {
      K = !0;
    }),
    ns(() => {
      K === !0 && t.autofocus === !0 && i.focus();
    }),
    an(() => {
      dt.value === !0 && t.for === void 0 && (e.targetUid.value = Ir()),
        t.autofocus === !0 && i.focus();
    }),
    ht(() => {
      l !== null && clearTimeout(l);
    }),
    Object.assign(i, { focus: q, blur: p }),
    function () {
      const z =
        e.getControl === void 0 && r.control === void 0
          ? {
              ...e.splitAttrs.attributes.value,
              "data-autofocus": t.autofocus === !0 || void 0,
              ...$.value,
            }
          : $.value;
      return H(
        "label",
        { ref: e.rootRef, class: [F.value, o.class], style: o.style, ...z },
        [
          r.before !== void 0
            ? H(
                "div",
                {
                  class:
                    "q-field__before q-field__marginal row no-wrap items-center",
                  onClick: Ot,
                },
                r.before()
              )
            : null,
          H(
            "div",
            { class: "q-field__inner relative-position col self-stretch" },
            [
              H(
                "div",
                {
                  ref: e.controlRef,
                  class: V.value,
                  tabindex: -1,
                  ...e.controlEvents,
                },
                m()
              ),
              M.value === !0 ? w() : null,
            ]
          ),
          r.after !== void 0
            ? H(
                "div",
                {
                  class:
                    "q-field__after q-field__marginal row no-wrap items-center",
                  onClick: Ot,
                },
                r.after()
              )
            : null,
        ]
      );
    }
  );
}
const hi = {
    date: "####/##/##",
    datetime: "####/##/## ##:##",
    time: "##:##",
    fulltime: "##:##:##",
    phone: "(###) ### - ####",
    card: "#### #### #### ####",
  },
  qn = {
    "#": { pattern: "[\\d]", negate: "[^\\d]" },
    S: { pattern: "[a-zA-Z]", negate: "[^a-zA-Z]" },
    N: { pattern: "[0-9a-zA-Z]", negate: "[^0-9a-zA-Z]" },
    A: {
      pattern: "[a-zA-Z]",
      negate: "[^a-zA-Z]",
      transform: (e) => e.toLocaleUpperCase(),
    },
    a: {
      pattern: "[a-zA-Z]",
      negate: "[^a-zA-Z]",
      transform: (e) => e.toLocaleLowerCase(),
    },
    X: {
      pattern: "[0-9a-zA-Z]",
      negate: "[^0-9a-zA-Z]",
      transform: (e) => e.toLocaleUpperCase(),
    },
    x: {
      pattern: "[0-9a-zA-Z]",
      negate: "[^0-9a-zA-Z]",
      transform: (e) => e.toLocaleLowerCase(),
    },
  },
  Hs = Object.keys(qn);
Hs.forEach((e) => {
  qn[e].regex = new RegExp(qn[e].pattern);
});
const $c = new RegExp(
    "\\\\([^.*+?^${}()|([\\]])|([.*+?^${}()|[\\]])|([" + Hs.join("") + "])|(.)",
    "g"
  ),
  gi = /[.*+?^${}()|[\]\\]/g,
  ge = String.fromCharCode(1),
  Nc = {
    mask: String,
    reverseFillMask: Boolean,
    fillMask: [Boolean, String],
    unmaskedValue: Boolean,
  };
function jc(e, t, n, r) {
  let o, i, s, l, a, c;
  const f = ce(null),
    g = ce(x());
  function h() {
    return (
      e.autogrow === !0 ||
      ["textarea", "text", "search", "url", "tel", "password"].includes(e.type)
    );
  }
  ve(() => e.type + e.autogrow, A),
    ve(
      () => e.mask,
      (b) => {
        if (b !== void 0) F(g.value, !0);
        else {
          const _ = q(g.value);
          A(), e.modelValue !== _ && t("update:modelValue", _);
        }
      }
    ),
    ve(
      () => e.fillMask + e.reverseFillMask,
      () => {
        f.value === !0 && F(g.value, !0);
      }
    ),
    ve(
      () => e.unmaskedValue,
      () => {
        f.value === !0 && F(g.value);
      }
    );
  function x() {
    if ((A(), f.value === !0)) {
      const b = $(q(e.modelValue));
      return e.fillMask !== !1 ? p(b) : b;
    }
    return e.modelValue;
  }
  function M(b) {
    if (b < o.length) return o.slice(-b);
    let _ = "",
      P = o;
    const m = P.indexOf(ge);
    if (m > -1) {
      for (let N = b - P.length; N > 0; N--) _ += ge;
      P = P.slice(0, m) + _ + P.slice(m);
    }
    return P;
  }
  function A() {
    if (
      ((f.value = e.mask !== void 0 && e.mask.length !== 0 && h()),
      f.value === !1)
    ) {
      (l = void 0), (o = ""), (i = "");
      return;
    }
    const b = hi[e.mask] === void 0 ? e.mask : hi[e.mask],
      _ =
        typeof e.fillMask == "string" && e.fillMask.length !== 0
          ? e.fillMask.slice(0, 1)
          : "_",
      P = _.replace(gi, "\\$&"),
      m = [],
      N = [],
      w = [];
    let j = e.reverseFillMask === !0,
      K = "",
      y = "";
    b.replace($c, (ie, E, le, Ie, Me) => {
      if (Ie !== void 0) {
        const ae = qn[Ie];
        w.push(ae),
          (y = ae.negate),
          j === !0 &&
            (N.push(
              "(?:" +
                y +
                "+)?(" +
                ae.pattern +
                "+)?(?:" +
                y +
                "+)?(" +
                ae.pattern +
                "+)?"
            ),
            (j = !1)),
          N.push("(?:" + y + "+)?(" + ae.pattern + ")?");
      } else if (le !== void 0)
        (K = "\\" + (le === "\\" ? "" : le)),
          w.push(le),
          m.push("([^" + K + "]+)?" + K + "?");
      else {
        const ae = E !== void 0 ? E : Me;
        (K = ae === "\\" ? "\\\\\\\\" : ae.replace(gi, "\\\\$&")),
          w.push(ae),
          m.push("([^" + K + "]+)?" + K + "?");
      }
    });
    const z = new RegExp(
        "^" +
          m.join("") +
          "(" +
          (K === "" ? "." : "[^" + K + "]") +
          "+)?" +
          (K === "" ? "" : "[" + K + "]*") +
          "$"
      ),
      _e = N.length - 1,
      ne = N.map((ie, E) =>
        E === 0 && e.reverseFillMask === !0
          ? new RegExp("^" + P + "*" + ie)
          : E === _e
          ? new RegExp(
              "^" +
                ie +
                "(" +
                (y === "" ? "." : y) +
                "+)?" +
                (e.reverseFillMask === !0 ? "$" : P + "*")
            )
          : new RegExp("^" + ie)
      );
    (s = w),
      (l = (ie) => {
        const E = z.exec(
          e.reverseFillMask === !0 ? ie : ie.slice(0, w.length + 1)
        );
        E !== null && (ie = E.slice(1).join(""));
        const le = [],
          Ie = ne.length;
        for (let Me = 0, ae = ie; Me < Ie; Me++) {
          const Le = ne[Me].exec(ae);
          if (Le === null) break;
          (ae = ae.slice(Le.shift().length)), le.push(...Le);
        }
        return le.length !== 0 ? le.join("") : ie;
      }),
      (o = w.map((ie) => (typeof ie == "string" ? ie : ge)).join("")),
      (i = o.split(ge).join(_));
  }
  function F(b, _, P) {
    const m = r.value,
      N = m.selectionEnd,
      w = m.value.length - N,
      j = q(b);
    _ === !0 && A();
    const K = $(j),
      y = e.fillMask !== !1 ? p(K) : K,
      z = g.value !== y;
    m.value !== y && (m.value = y),
      z === !0 && (g.value = y),
      document.activeElement === m &&
        Ze(() => {
          if (y === i) {
            const ne = e.reverseFillMask === !0 ? i.length : 0;
            m.setSelectionRange(ne, ne, "forward");
            return;
          }
          if (P === "insertFromPaste" && e.reverseFillMask !== !0) {
            const ne = m.selectionEnd;
            let ie = N - 1;
            for (let E = a; E <= ie && E < ne; E++) o[E] !== ge && ie++;
            W.right(m, ie);
            return;
          }
          if (
            ["deleteContentBackward", "deleteContentForward"].indexOf(P) > -1
          ) {
            const ne =
              e.reverseFillMask === !0
                ? N === 0
                  ? y.length > K.length
                    ? 1
                    : 0
                  : Math.max(
                      0,
                      y.length - (y === i ? 0 : Math.min(K.length, w) + 1)
                    ) + 1
                : N;
            m.setSelectionRange(ne, ne, "forward");
            return;
          }
          if (e.reverseFillMask === !0)
            if (z === !0) {
              const ne = Math.max(
                0,
                y.length - (y === i ? 0 : Math.min(K.length, w + 1))
              );
              ne === 1 && N === 1
                ? m.setSelectionRange(ne, ne, "forward")
                : W.rightReverse(m, ne);
            } else {
              const ne = y.length - w;
              m.setSelectionRange(ne, ne, "backward");
            }
          else if (z === !0) {
            const ne = Math.max(0, o.indexOf(ge), Math.min(K.length, N) - 1);
            W.right(m, ne);
          } else {
            const ne = N - 1;
            W.right(m, ne);
          }
        });
    const _e = e.unmaskedValue === !0 ? q(y) : y;
    String(e.modelValue) !== _e && n(_e, !0);
  }
  function V(b, _, P) {
    const m = $(q(b.value));
    (_ = Math.max(0, o.indexOf(ge), Math.min(m.length, _))),
      (a = _),
      b.setSelectionRange(_, P, "forward");
  }
  const W = {
    left(b, _) {
      const P = o.slice(_ - 1).indexOf(ge) === -1;
      let m = Math.max(0, _ - 1);
      for (; m >= 0; m--)
        if (o[m] === ge) {
          (_ = m), P === !0 && _++;
          break;
        }
      if (m < 0 && o[_] !== void 0 && o[_] !== ge) return W.right(b, 0);
      _ >= 0 && b.setSelectionRange(_, _, "backward");
    },
    right(b, _) {
      const P = b.value.length;
      let m = Math.min(P, _ + 1);
      for (; m <= P; m++)
        if (o[m] === ge) {
          _ = m;
          break;
        } else o[m - 1] === ge && (_ = m);
      if (m > P && o[_ - 1] !== void 0 && o[_ - 1] !== ge) return W.left(b, P);
      b.setSelectionRange(_, _, "forward");
    },
    leftReverse(b, _) {
      const P = M(b.value.length);
      let m = Math.max(0, _ - 1);
      for (; m >= 0; m--)
        if (P[m - 1] === ge) {
          _ = m;
          break;
        } else if (P[m] === ge && ((_ = m), m === 0)) break;
      if (m < 0 && P[_] !== void 0 && P[_] !== ge) return W.rightReverse(b, 0);
      _ >= 0 && b.setSelectionRange(_, _, "backward");
    },
    rightReverse(b, _) {
      const P = b.value.length,
        m = M(P),
        N = m.slice(0, _ + 1).indexOf(ge) === -1;
      let w = Math.min(P, _ + 1);
      for (; w <= P; w++)
        if (m[w - 1] === ge) {
          (_ = w), _ > 0 && N === !0 && _--;
          break;
        }
      if (w > P && m[_ - 1] !== void 0 && m[_ - 1] !== ge)
        return W.leftReverse(b, P);
      b.setSelectionRange(_, _, "forward");
    },
  };
  function Y(b) {
    t("click", b), (c = void 0);
  }
  function L(b) {
    if ((t("keydown", b), Rs(b) === !0)) return;
    const _ = r.value,
      P = _.selectionStart,
      m = _.selectionEnd;
    if ((b.shiftKey || (c = void 0), b.keyCode === 37 || b.keyCode === 39)) {
      b.shiftKey &&
        c === void 0 &&
        (c = _.selectionDirection === "forward" ? P : m);
      const N =
        W[
          (b.keyCode === 39 ? "right" : "left") +
            (e.reverseFillMask === !0 ? "Reverse" : "")
        ];
      if ((b.preventDefault(), N(_, c === P ? m : P), b.shiftKey)) {
        const w = _.selectionStart;
        _.setSelectionRange(Math.min(c, w), Math.max(c, w), "forward");
      }
    } else
      b.keyCode === 8 && e.reverseFillMask !== !0 && P === m
        ? (W.left(_, P), _.setSelectionRange(_.selectionStart, m, "backward"))
        : b.keyCode === 46 &&
          e.reverseFillMask === !0 &&
          P === m &&
          (W.rightReverse(_, m),
          _.setSelectionRange(P, _.selectionEnd, "forward"));
  }
  function $(b) {
    if (b == null || b === "") return "";
    if (e.reverseFillMask === !0) return U(b);
    const _ = s;
    let P = 0,
      m = "";
    for (let N = 0; N < _.length; N++) {
      const w = b[P],
        j = _[N];
      if (typeof j == "string") (m += j), w === j && P++;
      else if (w !== void 0 && j.regex.test(w))
        (m += j.transform !== void 0 ? j.transform(w) : w), P++;
      else return m;
    }
    return m;
  }
  function U(b) {
    const _ = s,
      P = o.indexOf(ge);
    let m = b.length - 1,
      N = "";
    for (let w = _.length - 1; w >= 0 && m > -1; w--) {
      const j = _[w];
      let K = b[m];
      if (typeof j == "string") (N = j + N), K === j && m--;
      else if (K !== void 0 && j.regex.test(K))
        do
          (N = (j.transform !== void 0 ? j.transform(K) : K) + N),
            m--,
            (K = b[m]);
        while (P === w && K !== void 0 && j.regex.test(K));
      else return N;
    }
    return N;
  }
  function q(b) {
    return typeof b != "string" || l === void 0
      ? typeof b == "number"
        ? l("" + b)
        : b
      : l(b);
  }
  function p(b) {
    return i.length - b.length <= 0
      ? b
      : e.reverseFillMask === !0 && b.length !== 0
      ? i.slice(0, -b.length) + b
      : b + i.slice(b.length);
  }
  return {
    innerValue: g,
    hasMask: f,
    moveCursorForPaste: V,
    updateMaskValue: F,
    onMaskedKeydown: L,
    onMaskedClick: Y,
  };
}
const Hc = { name: String };
function zc(e) {
  return I(() => e.name || e.for);
}
function Dc(e, t) {
  function n() {
    const r = e.modelValue;
    try {
      const o =
        "DataTransfer" in window
          ? new DataTransfer()
          : "ClipboardEvent" in window
          ? new ClipboardEvent("").clipboardData
          : void 0;
      return (
        Object(r) === r &&
          ("length" in r ? Array.from(r) : [r]).forEach((i) => {
            o.items.add(i);
          }),
        { files: o.files }
      );
    } catch {
      return { files: void 0 };
    }
  }
  return I(
    t === !0
      ? () => {
          if (e.type === "file") return n();
        }
      : n
  );
}
const Vc =
    /[\u3000-\u303f\u3040-\u309f\u30a0-\u30ff\uff00-\uff9f\u4e00-\u9faf\u3400-\u4dbf]/,
  Uc =
    /[\u4e00-\u9fff\u3400-\u4dbf\u{20000}-\u{2a6df}\u{2a700}-\u{2b73f}\u{2b740}-\u{2b81f}\u{2b820}-\u{2ceaf}\uf900-\ufaff\u3300-\u33ff\ufe30-\ufe4f\uf900-\ufaff\u{2f800}-\u{2fa1f}]/u,
  Kc = /[\u3131-\u314e\u314f-\u3163\uac00-\ud7a3]/,
  Wc = /[a-z0-9_ -]$/i;
function Qc(e) {
  return function (n) {
    if (n.type === "compositionend" || n.type === "change") {
      if (n.target.qComposing !== !0) return;
      (n.target.qComposing = !1), e(n);
    } else
      n.type === "compositionupdate" &&
        n.target.qComposing !== !0 &&
        typeof n.data == "string" &&
        (Ae.is.firefox === !0
          ? Wc.test(n.data) === !1
          : Vc.test(n.data) === !0 ||
            Uc.test(n.data) === !0 ||
            Kc.test(n.data) === !0) === !0 &&
        (n.target.qComposing = !0);
  };
}
const Jc = gt({
  name: "QInput",
  inheritAttrs: !1,
  props: {
    ...qc,
    ...Nc,
    ...Hc,
    modelValue: { required: !1 },
    shadowText: String,
    type: { type: String, default: "text" },
    debounce: [String, Number],
    autogrow: Boolean,
    inputClass: [Array, String, Object],
    inputStyle: [Array, String, Object],
  },
  emits: [...Ic, "paste", "change", "keydown", "click", "animationend"],
  setup(e, { emit: t, attrs: n }) {
    const { proxy: r } = ze(),
      { $q: o } = r,
      i = {};
    let s = NaN,
      l,
      a,
      c = null,
      f;
    const g = ce(null),
      h = zc(e),
      {
        innerValue: x,
        hasMask: M,
        moveCursorForPaste: A,
        updateMaskValue: F,
        onMaskedKeydown: V,
        onMaskedClick: W,
      } = jc(e, t, K, g),
      Y = Dc(e, !0),
      L = I(() => Lr(x.value)),
      $ = Qc(w),
      U = Lc(),
      q = I(() => e.type === "textarea" || e.autogrow === !0),
      p = I(
        () =>
          q.value === !0 ||
          ["text", "search", "url", "tel", "password"].includes(e.type)
      ),
      b = I(() => {
        const E = {
          ...U.splitAttrs.listeners.value,
          onInput: w,
          onPaste: N,
          onChange: z,
          onBlur: _e,
          onFocus: An,
        };
        return (
          (E.onCompositionstart =
            E.onCompositionupdate =
            E.onCompositionend =
              $),
          M.value === !0 && ((E.onKeydown = V), (E.onClick = W)),
          e.autogrow === !0 && (E.onAnimationend = j),
          E
        );
      }),
      _ = I(() => {
        const E = {
          tabindex: 0,
          "data-autofocus": e.autofocus === !0 || void 0,
          rows: e.type === "textarea" ? 6 : void 0,
          "aria-label": e.label,
          name: h.value,
          ...U.splitAttrs.attributes.value,
          id: U.targetUid.value,
          maxlength: e.maxlength,
          disabled: e.disable === !0,
          readonly: e.readonly === !0,
        };
        return (
          q.value === !1 && (E.type = e.type),
          e.autogrow === !0 && (E.rows = 1),
          E
        );
      });
    ve(
      () => e.type,
      () => {
        g.value && (g.value.value = e.modelValue);
      }
    ),
      ve(
        () => e.modelValue,
        (E) => {
          if (M.value === !0) {
            if (a === !0 && ((a = !1), String(E) === s)) return;
            F(E);
          } else
            x.value !== E &&
              ((x.value = E),
              e.type === "number" &&
                i.hasOwnProperty("value") === !0 &&
                (l === !0 ? (l = !1) : delete i.value));
          e.autogrow === !0 && Ze(y);
        }
      ),
      ve(
        () => e.autogrow,
        (E) => {
          E === !0
            ? Ze(y)
            : g.value !== null && n.rows > 0 && (g.value.style.height = "auto");
        }
      ),
      ve(
        () => e.dense,
        () => {
          e.autogrow === !0 && Ze(y);
        }
      );
    function P() {
      js(() => {
        const E = document.activeElement;
        g.value !== null &&
          g.value !== E &&
          (E === null || E.id !== U.targetUid.value) &&
          g.value.focus({ preventScroll: !0 });
      });
    }
    function m() {
      g.value !== null && g.value.select();
    }
    function N(E) {
      if (M.value === !0 && e.reverseFillMask !== !0) {
        const le = E.target;
        A(le, le.selectionStart, le.selectionEnd);
      }
      t("paste", E);
    }
    function w(E) {
      if (!E || !E.target) return;
      if (e.type === "file") {
        t("update:modelValue", E.target.files);
        return;
      }
      const le = E.target.value;
      if (E.target.qComposing === !0) {
        i.value = le;
        return;
      }
      if (M.value === !0) F(le, !1, E.inputType);
      else if ((K(le), p.value === !0 && E.target === document.activeElement)) {
        const { selectionStart: Ie, selectionEnd: Me } = E.target;
        Ie !== void 0 &&
          Me !== void 0 &&
          Ze(() => {
            E.target === document.activeElement &&
              le.indexOf(E.target.value) === 0 &&
              E.target.setSelectionRange(Ie, Me);
          });
      }
      e.autogrow === !0 && y();
    }
    function j(E) {
      t("animationend", E), y();
    }
    function K(E, le) {
      (f = () => {
        (c = null),
          e.type !== "number" &&
            i.hasOwnProperty("value") === !0 &&
            delete i.value,
          e.modelValue !== E &&
            s !== E &&
            ((s = E),
            le === !0 && (a = !0),
            t("update:modelValue", E),
            Ze(() => {
              s === E && (s = NaN);
            })),
          (f = void 0);
      }),
        e.type === "number" && ((l = !0), (i.value = E)),
        e.debounce !== void 0
          ? (c !== null && clearTimeout(c),
            (i.value = E),
            (c = setTimeout(f, e.debounce)))
          : f();
    }
    function y() {
      requestAnimationFrame(() => {
        const E = g.value;
        if (E !== null) {
          const le = E.parentNode.style,
            { scrollTop: Ie } = E,
            { overflowY: Me, maxHeight: ae } =
              o.platform.is.firefox === !0 ? {} : window.getComputedStyle(E),
            Le = Me !== void 0 && Me !== "scroll";
          Le === !0 && (E.style.overflowY = "hidden"),
            (le.marginBottom = E.scrollHeight - 1 + "px"),
            (E.style.height = "1px"),
            (E.style.height = E.scrollHeight + "px"),
            Le === !0 &&
              (E.style.overflowY =
                parseInt(ae, 10) < E.scrollHeight ? "auto" : "hidden"),
            (le.marginBottom = ""),
            (E.scrollTop = Ie);
        }
      });
    }
    function z(E) {
      $(E),
        c !== null && (clearTimeout(c), (c = null)),
        f !== void 0 && f(),
        t("change", E.target.value);
    }
    function _e(E) {
      E !== void 0 && An(E),
        c !== null && (clearTimeout(c), (c = null)),
        f !== void 0 && f(),
        (l = !1),
        (a = !1),
        delete i.value,
        e.type !== "file" &&
          setTimeout(() => {
            g.value !== null &&
              (g.value.value = x.value !== void 0 ? x.value : "");
          });
    }
    function ne() {
      return i.hasOwnProperty("value") === !0
        ? i.value
        : x.value !== void 0
        ? x.value
        : "";
    }
    ht(() => {
      _e();
    }),
      an(() => {
        e.autogrow === !0 && y();
      }),
      Object.assign(U, {
        innerValue: x,
        fieldClass: I(
          () =>
            `q-${q.value === !0 ? "textarea" : "input"}` +
            (e.autogrow === !0 ? " q-textarea--autogrow" : "")
        ),
        hasShadow: I(
          () =>
            e.type !== "file" &&
            typeof e.shadowText == "string" &&
            e.shadowText.length !== 0
        ),
        inputRef: g,
        emitValue: K,
        hasValue: L,
        floatingLabel: I(
          () =>
            (L.value === !0 &&
              (e.type !== "number" || isNaN(x.value) === !1)) ||
            Lr(e.displayValue)
        ),
        getControl: () =>
          H(q.value === !0 ? "textarea" : "input", {
            ref: g,
            class: ["q-field__native q-placeholder", e.inputClass],
            style: e.inputStyle,
            ..._.value,
            ...b.value,
            ...(e.type !== "file" ? { value: ne() } : Y.value),
          }),
        getShadowControl: () =>
          H(
            "div",
            {
              class:
                "q-field__native q-field__shadow absolute-bottom no-pointer-events" +
                (q.value === !0 ? "" : " text-no-wrap"),
            },
            [H("span", { class: "invisible" }, ne()), H("span", e.shadowText)]
          ),
      });
    const ie = Bc(U);
    return (
      Object.assign(r, {
        focus: P,
        select: m,
        getNativeElement: () => g.value,
      }),
      cn(r, "nativeEl", () => g.value),
      ie
    );
  },
});
function Zc(e, t) {
  const n = e.style;
  for (const r in t) n[r] = t[r];
}
function Yc(e, t = 250) {
  let n = !1,
    r;
  return function () {
    return (
      n === !1 &&
        ((n = !0),
        setTimeout(() => {
          n = !1;
        }, t),
        (r = e.apply(this, arguments))),
      r
    );
  };
}
function mi(e, t, n, r) {
  n.modifiers.stop === !0 && An(e);
  const o = n.modifiers.color;
  let i = n.modifiers.center;
  i = i === !0 || r === !0;
  const s = document.createElement("span"),
    l = document.createElement("span"),
    a = Nu(e),
    { left: c, top: f, width: g, height: h } = t.getBoundingClientRect(),
    x = Math.sqrt(g * g + h * h),
    M = x / 2,
    A = `${(g - x) / 2}px`,
    F = i ? A : `${a.left - c - M}px`,
    V = `${(h - x) / 2}px`,
    W = i ? V : `${a.top - f - M}px`;
  (l.className = "q-ripple__inner"),
    Zc(l, {
      height: `${x}px`,
      width: `${x}px`,
      transform: `translate3d(${F},${W},0) scale3d(.2,.2,1)`,
      opacity: 0,
    }),
    (s.className = `q-ripple${o ? " text-" + o : ""}`),
    s.setAttribute("dir", "ltr"),
    s.appendChild(l),
    t.appendChild(s);
  const Y = () => {
    s.remove(), clearTimeout(L);
  };
  n.abort.push(Y);
  let L = setTimeout(() => {
    l.classList.add("q-ripple__inner--enter"),
      (l.style.transform = `translate3d(${A},${V},0) scale3d(1,1,1)`),
      (l.style.opacity = 0.2),
      (L = setTimeout(() => {
        l.classList.remove("q-ripple__inner--enter"),
          l.classList.add("q-ripple__inner--leave"),
          (l.style.opacity = 0),
          (L = setTimeout(() => {
            s.remove(), n.abort.splice(n.abort.indexOf(Y), 1);
          }, 275));
      }, 250));
  }, 50);
}
function pi(e, { modifiers: t, value: n, arg: r }) {
  const o = Object.assign({}, e.cfg.ripple, t, n);
  e.modifiers = {
    early: o.early === !0,
    stop: o.stop === !0,
    center: o.center === !0,
    color: o.color || r,
    keyCodes: [].concat(o.keyCodes || 13),
  };
}
const Xc = cc({
    name: "ripple",
    beforeMount(e, t) {
      const n = t.instance.$.appContext.config.globalProperties.$q.config || {};
      if (n.ripple === !1) return;
      const r = {
        cfg: n,
        enabled: t.value !== !1,
        modifiers: {},
        abort: [],
        start(o) {
          r.enabled === !0 &&
            o.qSkipRipple !== !0 &&
            o.type === (r.modifiers.early === !0 ? "pointerdown" : "click") &&
            mi(o, e, r, o.qKeyEvent === !0);
        },
        keystart: Yc((o) => {
          r.enabled === !0 &&
            o.qSkipRipple !== !0 &&
            Fr(o, r.modifiers.keyCodes) === !0 &&
            o.type === `key${r.modifiers.early === !0 ? "down" : "up"}` &&
            mi(o, e, r, !0);
        }, 300),
      };
      pi(r, t),
        (e.__qripple = r),
        ju(r, "main", [
          [e, "pointerdown", "start", "passive"],
          [e, "click", "start", "passive"],
          [e, "keydown", "keystart", "passive"],
          [e, "keyup", "keystart", "passive"],
        ]);
    },
    updated(e, t) {
      if (t.oldValue !== t.value) {
        const n = e.__qripple;
        n !== void 0 &&
          ((n.enabled = t.value !== !1),
          n.enabled === !0 && Object(t.value) === t.value && pi(n, t));
      }
    },
    beforeUnmount(e) {
      const t = e.__qripple;
      t !== void 0 &&
        (t.abort.forEach((n) => {
          n();
        }),
        Hu(t, "main"),
        delete e._qripple);
    },
  }),
  zs = {
    left: "start",
    center: "center",
    right: "end",
    between: "between",
    around: "around",
    evenly: "evenly",
    stretch: "stretch",
  },
  Gc = Object.keys(zs),
  Ds = { align: { type: String, validator: (e) => Gc.includes(e) } };
function Vs(e) {
  return I(() => {
    const t =
      e.align === void 0 ? (e.vertical === !0 ? "stretch" : "left") : e.align;
    return `${e.vertical === !0 ? "items" : "justify"}-${zs[t]}`;
  });
}
function ef(e) {
  return e.appContext.config.globalProperties.$router !== void 0;
}
function vi(e) {
  return e ? (e.aliasOf ? e.aliasOf.path : e.path) : "";
}
function bi(e, t) {
  return (e.aliasOf || e) === (t.aliasOf || t);
}
function tf(e, t) {
  for (const n in t) {
    const r = t[n],
      o = e[n];
    if (typeof r == "string") {
      if (r !== o) return !1;
    } else if (
      Array.isArray(o) === !1 ||
      o.length !== r.length ||
      r.some((i, s) => i !== o[s])
    )
      return !1;
  }
  return !0;
}
function _i(e, t) {
  return Array.isArray(t) === !0
    ? e.length === t.length && e.every((n, r) => n === t[r])
    : e.length === 1 && e[0] === t;
}
function nf(e, t) {
  return Array.isArray(e) === !0
    ? _i(e, t)
    : Array.isArray(t) === !0
    ? _i(t, e)
    : e === t;
}
function rf(e, t) {
  if (Object.keys(e).length !== Object.keys(t).length) return !1;
  for (const n in e) if (nf(e[n], t[n]) === !1) return !1;
  return !0;
}
const of = {
  to: [String, Object],
  replace: Boolean,
  exact: Boolean,
  activeClass: { type: String, default: "q-router-link--active" },
  exactActiveClass: { type: String, default: "q-router-link--exact-active" },
  href: String,
  target: String,
  disable: Boolean,
};
function sf({ fallbackTag: e, useDisableForRouterLinkProps: t = !0 } = {}) {
  const n = ze(),
    { props: r, proxy: o, emit: i } = n,
    s = ef(n),
    l = I(() => r.disable !== !0 && r.href !== void 0),
    a = I(
      t === !0
        ? () =>
            s === !0 &&
            r.disable !== !0 &&
            l.value !== !0 &&
            r.to !== void 0 &&
            r.to !== null &&
            r.to !== ""
        : () =>
            s === !0 &&
            l.value !== !0 &&
            r.to !== void 0 &&
            r.to !== null &&
            r.to !== ""
    ),
    c = I(() => (a.value === !0 ? W(r.to) : null)),
    f = I(() => c.value !== null),
    g = I(() => l.value === !0 || f.value === !0),
    h = I(() => (r.type === "a" || g.value === !0 ? "a" : r.tag || e || "div")),
    x = I(() =>
      l.value === !0
        ? { href: r.href, target: r.target }
        : f.value === !0
        ? { href: c.value.href, target: r.target }
        : {}
    ),
    M = I(() => {
      if (f.value === !1) return -1;
      const { matched: $ } = c.value,
        { length: U } = $,
        q = $[U - 1];
      if (q === void 0) return -1;
      const p = o.$route.matched;
      if (p.length === 0) return -1;
      const b = p.findIndex(bi.bind(null, q));
      if (b > -1) return b;
      const _ = vi($[U - 2]);
      return U > 1 && vi(q) === _ && p[p.length - 1].path !== _
        ? p.findIndex(bi.bind(null, $[U - 2]))
        : b;
    }),
    A = I(
      () =>
        f.value === !0 && M.value !== -1 && tf(o.$route.params, c.value.params)
    ),
    F = I(
      () =>
        A.value === !0 &&
        M.value === o.$route.matched.length - 1 &&
        rf(o.$route.params, c.value.params)
    ),
    V = I(() =>
      f.value === !0
        ? F.value === !0
          ? ` ${r.exactActiveClass} ${r.activeClass}`
          : r.exact === !0
          ? ""
          : A.value === !0
          ? ` ${r.activeClass}`
          : ""
        : ""
    );
  function W($) {
    try {
      return o.$router.resolve($);
    } catch {}
    return null;
  }
  function Y(
    $,
    { returnRouterError: U, to: q = r.to, replace: p = r.replace } = {}
  ) {
    if (r.disable === !0) return $.preventDefault(), Promise.resolve(!1);
    if (
      $.metaKey ||
      $.altKey ||
      $.ctrlKey ||
      $.shiftKey ||
      ($.button !== void 0 && $.button !== 0) ||
      r.target === "_blank"
    )
      return Promise.resolve(!1);
    $.preventDefault();
    const b = o.$router[p === !0 ? "replace" : "push"](q);
    return U === !0 ? b : b.then(() => {}).catch(() => {});
  }
  function L($) {
    if (f.value === !0) {
      const U = (q) => Y($, q);
      i("click", $, U), $.defaultPrevented !== !0 && U();
    } else i("click", $);
  }
  return {
    hasRouterLink: f,
    hasHrefLink: l,
    hasLink: g,
    linkTag: h,
    resolvedLink: c,
    linkIsActive: A,
    linkIsExactActive: F,
    linkClass: V,
    linkAttrs: x,
    getLink: W,
    navigateToRouterLink: Y,
    navigateOnClick: L,
  };
}
const yi = { none: 0, xs: 4, sm: 8, md: 16, lg: 24, xl: 32 },
  lf = { xs: 8, sm: 10, md: 14, lg: 20, xl: 24 },
  af = ["button", "submit", "reset"],
  uf = /[^\s]\/[^\s]/,
  cf = ["flat", "outline", "push", "unelevated"],
  ff = (e, t) =>
    e.flat === !0
      ? "flat"
      : e.outline === !0
      ? "outline"
      : e.push === !0
      ? "push"
      : e.unelevated === !0
      ? "unelevated"
      : t,
  df = {
    ...Os,
    ...of,
    type: { type: String, default: "button" },
    label: [Number, String],
    icon: String,
    iconRight: String,
    ...cf.reduce((e, t) => (e[t] = Boolean) && e, {}),
    square: Boolean,
    round: Boolean,
    rounded: Boolean,
    glossy: Boolean,
    size: String,
    fab: Boolean,
    fabMini: Boolean,
    padding: String,
    color: String,
    textColor: String,
    noCaps: Boolean,
    noWrap: Boolean,
    dense: Boolean,
    tabindex: [Number, String],
    ripple: { type: [Boolean, Object], default: !0 },
    align: { ...Ds.align, default: "center" },
    stack: Boolean,
    stretch: Boolean,
    loading: { type: Boolean, default: null },
    disable: Boolean,
  };
function hf(e) {
  const t = qs(e, lf),
    n = Vs(e),
    {
      hasRouterLink: r,
      hasLink: o,
      linkTag: i,
      linkAttrs: s,
      navigateOnClick: l,
    } = sf({ fallbackTag: "button" }),
    a = I(() => {
      const F = e.fab === !1 && e.fabMini === !1 ? t.value : {};
      return e.padding !== void 0
        ? Object.assign({}, F, {
            padding: e.padding
              .split(/\s+/)
              .map((V) => (V in yi ? yi[V] + "px" : V))
              .join(" "),
            minWidth: "0",
            minHeight: "0",
          })
        : F;
    }),
    c = I(() => e.rounded === !0 || e.fab === !0 || e.fabMini === !0),
    f = I(() => e.disable !== !0 && e.loading !== !0),
    g = I(() => (f.value === !0 ? e.tabindex || 0 : -1)),
    h = I(() => ff(e, "standard")),
    x = I(() => {
      const F = { tabindex: g.value };
      return (
        o.value === !0
          ? Object.assign(F, s.value)
          : af.includes(e.type) === !0 && (F.type = e.type),
        i.value === "a"
          ? (e.disable === !0
              ? (F["aria-disabled"] = "true")
              : F.href === void 0 && (F.role = "button"),
            r.value !== !0 && uf.test(e.type) === !0 && (F.type = e.type))
          : e.disable === !0 &&
            ((F.disabled = ""), (F["aria-disabled"] = "true")),
        e.loading === !0 &&
          e.percentage !== void 0 &&
          Object.assign(F, {
            role: "progressbar",
            "aria-valuemin": 0,
            "aria-valuemax": 100,
            "aria-valuenow": e.percentage,
          }),
        F
      );
    }),
    M = I(() => {
      let F;
      e.color !== void 0
        ? e.flat === !0 || e.outline === !0
          ? (F = `text-${e.textColor || e.color}`)
          : (F = `bg-${e.color} text-${e.textColor || "white"}`)
        : e.textColor && (F = `text-${e.textColor}`);
      const V =
        e.round === !0
          ? "round"
          : `rectangle${
              c.value === !0
                ? " q-btn--rounded"
                : e.square === !0
                ? " q-btn--square"
                : ""
            }`;
      return (
        `q-btn--${h.value} q-btn--${V}` +
        (F !== void 0 ? " " + F : "") +
        (f.value === !0
          ? " q-btn--actionable q-focusable q-hoverable"
          : e.disable === !0
          ? " disabled"
          : "") +
        (e.fab === !0
          ? " q-btn--fab"
          : e.fabMini === !0
          ? " q-btn--fab-mini"
          : "") +
        (e.noCaps === !0 ? " q-btn--no-uppercase" : "") +
        (e.dense === !0 ? " q-btn--dense" : "") +
        (e.stretch === !0 ? " no-border-radius self-stretch" : "") +
        (e.glossy === !0 ? " glossy" : "") +
        (e.square ? " q-btn--square" : "")
      );
    }),
    A = I(
      () =>
        n.value +
        (e.stack === !0 ? " column" : " row") +
        (e.noWrap === !0 ? " no-wrap text-no-wrap" : "") +
        (e.loading === !0 ? " q-btn__content--hidden" : "")
    );
  return {
    classes: M,
    style: a,
    innerClasses: A,
    attributes: x,
    hasLink: o,
    linkTag: i,
    navigateOnClick: l,
    isActionable: f,
  };
}
const { passiveCapture: Oe } = fn;
let Rt = null,
  At = null,
  Ft = null;
const wi = gt({
    name: "QBtn",
    props: {
      ...df,
      percentage: Number,
      darkPercentage: Boolean,
      onTouchstart: [Function, Array],
    },
    emits: ["click", "keydown", "mousedown", "keyup"],
    setup(e, { slots: t, emit: n }) {
      const { proxy: r } = ze(),
        {
          classes: o,
          style: i,
          innerClasses: s,
          attributes: l,
          hasLink: a,
          linkTag: c,
          navigateOnClick: f,
          isActionable: g,
        } = hf(e),
        h = ce(null),
        x = ce(null);
      let M = null,
        A,
        F = null;
      const V = I(
          () => e.label !== void 0 && e.label !== null && e.label !== ""
        ),
        W = I(() =>
          e.disable === !0 || e.ripple === !1
            ? !1
            : {
                keyCodes: a.value === !0 ? [13, 32] : [13],
                ...(e.ripple === !0 ? {} : e.ripple),
              }
        ),
        Y = I(() => ({ center: e.round })),
        L = I(() => {
          const w = Math.max(0, Math.min(100, e.percentage));
          return w > 0
            ? {
                transition: "transform 0.6s",
                transform: `translateX(${w - 100}%)`,
              }
            : {};
        }),
        $ = I(() => {
          if (e.loading === !0)
            return {
              onMousedown: N,
              onTouchstart: N,
              onClick: N,
              onKeydown: N,
              onKeyup: N,
            };
          if (g.value === !0) {
            const w = { onClick: q, onKeydown: p, onMousedown: _ };
            if (r.$q.platform.has.touch === !0) {
              const j = e.onTouchstart !== void 0 ? "" : "Passive";
              w[`onTouchstart${j}`] = b;
            }
            return w;
          }
          return { onClick: _t };
        }),
        U = I(() => ({
          ref: h,
          class: "q-btn q-btn-item non-selectable no-outline " + o.value,
          style: i.value,
          ...l.value,
          ...$.value,
        }));
      function q(w) {
        if (h.value !== null) {
          if (w !== void 0) {
            if (w.defaultPrevented === !0) return;
            const j = document.activeElement;
            if (
              e.type === "submit" &&
              j !== document.body &&
              h.value.contains(j) === !1 &&
              j.contains(h.value) === !1
            ) {
              h.value.focus();
              const K = () => {
                document.removeEventListener("keydown", _t, !0),
                  document.removeEventListener("keyup", K, Oe),
                  h.value !== null &&
                    h.value.removeEventListener("blur", K, Oe);
              };
              document.addEventListener("keydown", _t, !0),
                document.addEventListener("keyup", K, Oe),
                h.value.addEventListener("blur", K, Oe);
            }
          }
          f(w);
        }
      }
      function p(w) {
        h.value !== null &&
          (n("keydown", w),
          Fr(w, [13, 32]) === !0 &&
            At !== h.value &&
            (At !== null && m(),
            w.defaultPrevented !== !0 &&
              (h.value.focus(),
              (At = h.value),
              h.value.classList.add("q-btn--active"),
              document.addEventListener("keyup", P, !0),
              h.value.addEventListener("blur", P, Oe)),
            _t(w)));
      }
      function b(w) {
        h.value !== null &&
          (n("touchstart", w),
          w.defaultPrevented !== !0 &&
            (Rt !== h.value &&
              (Rt !== null && m(),
              (Rt = h.value),
              (M = w.target),
              M.addEventListener("touchcancel", P, Oe),
              M.addEventListener("touchend", P, Oe)),
            (A = !0),
            F !== null && clearTimeout(F),
            (F = setTimeout(() => {
              (F = null), (A = !1);
            }, 200))));
      }
      function _(w) {
        h.value !== null &&
          ((w.qSkipRipple = A === !0),
          n("mousedown", w),
          w.defaultPrevented !== !0 &&
            Ft !== h.value &&
            (Ft !== null && m(),
            (Ft = h.value),
            h.value.classList.add("q-btn--active"),
            document.addEventListener("mouseup", P, Oe)));
      }
      function P(w) {
        if (
          h.value !== null &&
          !(
            w !== void 0 &&
            w.type === "blur" &&
            document.activeElement === h.value
          )
        ) {
          if (w !== void 0 && w.type === "keyup") {
            if (At === h.value && Fr(w, [13, 32]) === !0) {
              const j = new MouseEvent("click", w);
              (j.qKeyEvent = !0),
                w.defaultPrevented === !0 && Ot(j),
                w.cancelBubble === !0 && An(j),
                h.value.dispatchEvent(j),
                _t(w),
                (w.qKeyEvent = !0);
            }
            n("keyup", w);
          }
          m();
        }
      }
      function m(w) {
        const j = x.value;
        w !== !0 &&
          (Rt === h.value || Ft === h.value) &&
          j !== null &&
          j !== document.activeElement &&
          (j.setAttribute("tabindex", -1), j.focus()),
          Rt === h.value &&
            (M !== null &&
              (M.removeEventListener("touchcancel", P, Oe),
              M.removeEventListener("touchend", P, Oe)),
            (Rt = M = null)),
          Ft === h.value &&
            (document.removeEventListener("mouseup", P, Oe), (Ft = null)),
          At === h.value &&
            (document.removeEventListener("keyup", P, !0),
            h.value !== null && h.value.removeEventListener("blur", P, Oe),
            (At = null)),
          h.value !== null && h.value.classList.remove("q-btn--active");
      }
      function N(w) {
        _t(w), (w.qSkipRipple = !0);
      }
      return (
        ht(() => {
          m(!0);
        }),
        Object.assign(r, { click: q }),
        () => {
          let w = [];
          e.icon !== void 0 &&
            w.push(
              H(On, {
                name: e.icon,
                left: e.stack === !1 && V.value === !0,
                role: "img",
                "aria-hidden": "true",
              })
            ),
            V.value === !0 && w.push(H("span", { class: "block" }, [e.label])),
            (w = Zt(t.default, w)),
            e.iconRight !== void 0 &&
              e.round === !1 &&
              w.push(
                H(On, {
                  name: e.iconRight,
                  right: e.stack === !1 && V.value === !0,
                  role: "img",
                  "aria-hidden": "true",
                })
              );
          const j = [H("span", { class: "q-focus-helper", ref: x })];
          return (
            e.loading === !0 &&
              e.percentage !== void 0 &&
              j.push(
                H(
                  "span",
                  {
                    class:
                      "q-btn__progress absolute-full overflow-hidden" +
                      (e.darkPercentage === !0 ? " q-btn__progress--dark" : ""),
                  },
                  [
                    H("span", {
                      class: "q-btn__progress-indicator fit block",
                      style: L.value,
                    }),
                  ]
                )
              ),
            j.push(
              H(
                "span",
                {
                  class:
                    "q-btn__content text-center col items-center q-anchor--skip " +
                    s.value,
                },
                w
              )
            ),
            e.loading !== null &&
              j.push(
                H(un, { name: "q-transition--fade" }, () =>
                  e.loading === !0
                    ? [
                        H(
                          "span",
                          {
                            key: "loading",
                            class: "absolute-full flex flex-center",
                          },
                          t.loading !== void 0 ? t.loading() : [H(io)]
                        ),
                      ]
                    : null
                )
              ),
            Pn(H(c.value, U.value, j), [[Xc, W.value, void 0, Y.value]])
          );
        }
      );
    },
  }),
  gf = gt({
    name: "QCardActions",
    props: { ...Ds, vertical: Boolean },
    setup(e, { slots: t }) {
      const n = Vs(e),
        r = I(
          () =>
            `q-card__actions ${n.value} q-card__actions--${
              e.vertical === !0 ? "vert column" : "horiz row"
            }`
        );
      return () => H("div", { class: r.value }, Ye(t.default));
    },
  }),
  mf = gt({
    name: "QCard",
    props: {
      ...$s,
      tag: { type: String, default: "div" },
      square: Boolean,
      flat: Boolean,
      bordered: Boolean,
    },
    setup(e, { slots: t }) {
      const {
          proxy: { $q: n },
        } = ze(),
        r = Ns(e, n),
        o = I(
          () =>
            "q-card" +
            (r.value === !0 ? " q-card--dark q-dark" : "") +
            (e.bordered === !0 ? " q-card--bordered" : "") +
            (e.square === !0 ? " q-card--square no-border-radius" : "") +
            (e.flat === !0 ? " q-card--flat no-shadow" : "")
        );
      return () => H(e.tag, { class: o.value }, Ye(t.default));
    },
  });
const pf = {
    components: {},
    setup() {
      return { store: oo() };
    },
    data() {
      return {
        showing: !1,
        loadImage: !1,
        content: "",
        errorMessage: "Invalid image URL provided. Please try again.",
        error: !1,
      };
    },
    computed: {},
    methods: {
      cancel: function () {
        (this.showing = !1), this.store.SendMessage("exit", {});
      },
      saveSettings: async function () {
        this.loadImage = !0;
        const e = await this.imageValidation(this.content);
        if (!e) {
          (this.loadImage = !1),
            (this.error = !0),
            (this.content = ""),
            setTimeout(() => {
              this.error = !1;
            }, 2500);
          return;
        }
        (this.showing = !1),
          (this.loadImage = !1),
          this.store.SendMessage("savePoster", e);
      },
      imageValidation: function (e) {
        return new Promise((t) => {
          if (!e.startsWith("https")) return t(!1);
          const n = new Image();
          (n.crossOrigin = "Anonymous"),
            (n.onload = () => {
              t({ width: n.naturalWidth, height: n.naturalHeight, url: e });
            }),
            (n.onerror = () => {
              t(!1);
            }),
            (n.src = e);
        });
      },
    },
    mounted() {
      this.eventBus.on("openEditor", () => {
        this.showing = !0;
      });
    },
    unmounted() {
      this.eventBus.off("openEditor");
    },
  },
  vf = (e) => (Yl("data-v-f51ff58e"), (e = e()), Xl(), e),
  bf = vf(() => Wn("div", { class: "text-h6 text-center" }, "Image URL", -1));
function _f(e, t, n, r, o, i) {
  return Pn(
    (to(),
    vs(
      mf,
      {
        class: "q-pa-xs q-ma-xs",
        id: "editor",
        dark: "",
        dense: "",
        bordered: "",
        type: "url",
      },
      {
        default: Qt(() => [
          me(oi, null, { default: Qt(() => [bf]), _: 1 }),
          me(oi, null, {
            default: Qt(() => [
              me(
                Jc,
                {
                  modelValue: o.content,
                  "onUpdate:modelValue":
                    t[0] || (t[0] = (s) => (o.content = s)),
                  label: "URL",
                  dark: "",
                  dense: "",
                },
                null,
                8,
                ["modelValue"]
              ),
              Pn(
                Wn(
                  "span",
                  { class: "text-negative text-caption text-center" },
                  il(o.errorMessage),
                  513
                ),
                [[Pr, o.error]]
              ),
            ]),
            _: 1,
          }),
          me(
            gf,
            { align: "center" },
            {
              default: Qt(() => [
                me(
                  wi,
                  {
                    label: "Cancel",
                    color: "red",
                    icon: "fa-solid fa-xmark",
                    onClick: i.cancel,
                  },
                  null,
                  8,
                  ["onClick"]
                ),
                me(
                  wi,
                  {
                    label: "Save",
                    color: "green",
                    "icon-right": "fa-solid fa-save",
                    onClick: i.saveSettings,
                    loading: o.loadImage,
                  },
                  null,
                  8,
                  ["onClick", "loading"]
                ),
              ]),
              _: 1,
            }
          ),
        ]),
        _: 1,
      },
      512
    )),
    [[Pr, o.showing]]
  );
}
const yf = so(pf, [
  ["render", _f],
  ["__scopeId", "data-v-f51ff58e"],
]);
const wf = {
    name: "App",
    components: { Poster: vc, Editor: yf },
    setup() {
      return { store: oo() };
    },
    methods: {
      eventHandler: function (e) {
        this.eventBus.emit(e.data.action, e.data);
      },
    },
    mounted() {
      window.addEventListener("message", this.eventHandler),
        this.store.SendMessageAsync("loaded", {}).then((e) => {
          this.store.resourcename = e.resName;
        });
    },
    unmounted() {
      window.removeEventListener("message", this.eventHandler);
    },
  },
  xf = { id: "app" };
function Cf(e, t, n, r, o, i) {
  const s = Co("Editor"),
    l = Co("Poster");
  return to(), $a("div", xf, [me(s), me(l)]);
}
const kf = so(wf, [["render", Cf]]),
  Sf = lc(),
  Xn = Su(kf);
Xn.config.globalProperties.eventBus = Sf;
Xn.use(ic, {
  plugins: {},
  iconSet: sc,
  config: {
    brand: { primary: "#673AB7", secondary: "#1e1e1ef9", accent: "#EBEBEB17" },
  },
});
Xn.use(Pu());
Xn.mount("#app");
