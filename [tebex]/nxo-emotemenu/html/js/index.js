(function () {
  const t = document.createElement("link").relList;
  if (t && t.supports && t.supports("modulepreload")) return;
  for (const r of document.querySelectorAll('link[rel="modulepreload"]')) n(r);
  new MutationObserver((r) => {
    for (const i of r)
      if (i.type === "childList")
        for (const o of i.addedNodes)
          o.tagName === "LINK" && o.rel === "modulepreload" && n(o);
  }).observe(document, { childList: !0, subtree: !0 });
  function s(r) {
    const i = {};
    return (
      r.integrity && (i.integrity = r.integrity),
      r.referrerPolicy && (i.referrerPolicy = r.referrerPolicy),
      r.crossOrigin === "use-credentials"
        ? (i.credentials = "include")
        : r.crossOrigin === "anonymous"
        ? (i.credentials = "omit")
        : (i.credentials = "same-origin"),
      i
    );
  }
  function n(r) {
    if (r.ep) return;
    r.ep = !0;
    const i = s(r);
    fetch(r.href, i);
  }
})();
function bn(e, t) {
  const s = Object.create(null),
    n = e.split(",");
  for (let r = 0; r < n.length; r++) s[n[r]] = !0;
  return t ? (r) => !!s[r.toLowerCase()] : (r) => !!s[r];
}
const Q = {},
  xt = [],
  Le = () => {},
  so = () => !1,
  Ts = (e) =>
    e.charCodeAt(0) === 111 &&
    e.charCodeAt(1) === 110 &&
    (e.charCodeAt(2) > 122 || e.charCodeAt(2) < 97),
  Cn = (e) => e.startsWith("onUpdate:"),
  ae = Object.assign,
  Sn = (e, t) => {
    const s = e.indexOf(t);
    s > -1 && e.splice(s, 1);
  },
  no = Object.prototype.hasOwnProperty,
  j = (e, t) => no.call(e, t),
  q = Array.isArray,
  wt = (e) => is(e) === "[object Map]",
  ks = (e) => is(e) === "[object Set]",
  Qn = (e) => is(e) === "[object Date]",
  R = (e) => typeof e == "function",
  oe = (e) => typeof e == "string",
  tt = (e) => typeof e == "symbol",
  V = (e) => e !== null && typeof e == "object",
  Bi = (e) => (V(e) || R(e)) && R(e.then) && R(e.catch),
  ji = Object.prototype.toString,
  is = (e) => ji.call(e),
  io = (e) => is(e).slice(8, -1),
  Ui = (e) => is(e) === "[object Object]",
  An = (e) =>
    oe(e) && e !== "NaN" && e[0] !== "-" && "" + parseInt(e, 10) === e,
  gs = bn(
    ",key,ref,ref_for,ref_key,onVnodeBeforeMount,onVnodeMounted,onVnodeBeforeUpdate,onVnodeUpdated,onVnodeBeforeUnmount,onVnodeUnmounted"
  ),
  $s = (e) => {
    const t = Object.create(null);
    return (s) => t[s] || (t[s] = e(s));
  },
  ro = /-(\w)/g,
  De = $s((e) => e.replace(ro, (t, s) => (s ? s.toUpperCase() : ""))),
  oo = /\B([A-Z])/g,
  Pt = $s((e) => e.replace(oo, "-$1").toLowerCase()),
  Ms = $s((e) => e.charAt(0).toUpperCase() + e.slice(1)),
  Js = $s((e) => (e ? `on${Ms(e)}` : "")),
  $t = (e, t) => !Object.is(e, t),
  ms = (e, t) => {
    for (let s = 0; s < e.length; s++) e[s](t);
  },
  vs = (e, t, s) => {
    Object.defineProperty(e, t, { configurable: !0, enumerable: !1, value: s });
  },
  ys = (e) => {
    const t = parseFloat(e);
    return isNaN(t) ? e : t;
  },
  lo = (e) => {
    const t = oe(e) ? Number(e) : NaN;
    return isNaN(t) ? e : t;
  };
let zn;
const nn = () =>
  zn ||
  (zn =
    typeof globalThis < "u"
      ? globalThis
      : typeof self < "u"
      ? self
      : typeof window < "u"
      ? window
      : typeof global < "u"
      ? global
      : {});
function Nt(e) {
  if (q(e)) {
    const t = {};
    for (let s = 0; s < e.length; s++) {
      const n = e[s],
        r = oe(n) ? fo(n) : Nt(n);
      if (r) for (const i in r) t[i] = r[i];
    }
    return t;
  } else if (oe(e) || V(e)) return e;
}
const ao = /;(?![^(]*\))/g,
  co = /:([^]+)/,
  uo = /\/\*[^]*?\*\//g;
function fo(e) {
  const t = {};
  return (
    e
      .replace(uo, "")
      .split(ao)
      .forEach((s) => {
        if (s) {
          const n = s.split(co);
          n.length > 1 && (t[n[0].trim()] = n[1].trim());
        }
      }),
    t
  );
}
function ue(e) {
  let t = "";
  if (oe(e)) t = e;
  else if (q(e))
    for (let s = 0; s < e.length; s++) {
      const n = ue(e[s]);
      n && (t += n + " ");
    }
  else if (V(e)) for (const s in e) e[s] && (t += s + " ");
  return t.trim();
}
const ho =
    "itemscope,allowfullscreen,formnovalidate,ismap,nomodule,novalidate,readonly",
  go = bn(ho);
function Ki(e) {
  return !!e || e === "";
}
function mo(e, t) {
  if (e.length !== t.length) return !1;
  let s = !0;
  for (let n = 0; s && n < e.length; n++) s = Os(e[n], t[n]);
  return s;
}
function Os(e, t) {
  if (e === t) return !0;
  let s = Qn(e),
    n = Qn(t);
  if (s || n) return s && n ? e.getTime() === t.getTime() : !1;
  if (((s = tt(e)), (n = tt(t)), s || n)) return e === t;
  if (((s = q(e)), (n = q(t)), s || n)) return s && n ? mo(e, t) : !1;
  if (((s = V(e)), (n = V(t)), s || n)) {
    if (!s || !n) return !1;
    const r = Object.keys(e).length,
      i = Object.keys(t).length;
    if (r !== i) return !1;
    for (const o in e) {
      const l = e.hasOwnProperty(o),
        a = t.hasOwnProperty(o);
      if ((l && !a) || (!l && a) || !Os(e[o], t[o])) return !1;
    }
  }
  return String(e) === String(t);
}
function po(e, t) {
  return e.findIndex((s) => Os(s, t));
}
const T = (e) =>
    oe(e)
      ? e
      : e == null
      ? ""
      : q(e) || (V(e) && (e.toString === ji || !R(e.toString)))
      ? JSON.stringify(e, Vi, 2)
      : String(e),
  Vi = (e, t) =>
    t && t.__v_isRef
      ? Vi(e, t.value)
      : wt(t)
      ? {
          [`Map(${t.size})`]: [...t.entries()].reduce(
            (s, [n, r], i) => ((s[Ws(n, i) + " =>"] = r), s),
            {}
          ),
        }
      : ks(t)
      ? { [`Set(${t.size})`]: [...t.values()].map((s) => Ws(s)) }
      : tt(t)
      ? Ws(t)
      : V(t) && !q(t) && !Ui(t)
      ? String(t)
      : t,
  Ws = (e, t = "") => {
    var s;
    return tt(e) ? `Symbol(${(s = e.description) != null ? s : t})` : e;
  };
let Te;
class Hi {
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
      const s = Te;
      try {
        return (Te = this), t();
      } finally {
        Te = s;
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
      let s, n;
      for (s = 0, n = this.effects.length; s < n; s++) this.effects[s].stop();
      for (s = 0, n = this.cleanups.length; s < n; s++) this.cleanups[s]();
      if (this.scopes)
        for (s = 0, n = this.scopes.length; s < n; s++) this.scopes[s].stop(!0);
      if (!this.detached && this.parent && !t) {
        const r = this.parent.scopes.pop();
        r &&
          r !== this &&
          ((this.parent.scopes[this.index] = r), (r.index = this.index));
      }
      (this.parent = void 0), (this._active = !1);
    }
  }
}
function _o(e) {
  return new Hi(e);
}
function vo(e, t = Te) {
  t && t.active && t.effects.push(e);
}
function yo() {
  return Te;
}
const xn = (e) => {
    const t = new Set(e);
    return (t.w = 0), (t.n = 0), t;
  },
  Gi = (e) => (e.w & st) > 0,
  Ji = (e) => (e.n & st) > 0,
  bo = ({ deps: e }) => {
    if (e.length) for (let t = 0; t < e.length; t++) e[t].w |= st;
  },
  Co = (e) => {
    const { deps: t } = e;
    if (t.length) {
      let s = 0;
      for (let n = 0; n < t.length; n++) {
        const r = t[n];
        Gi(r) && !Ji(r) ? r.delete(e) : (t[s++] = r),
          (r.w &= ~st),
          (r.n &= ~st);
      }
      t.length = s;
    }
  },
  rn = new WeakMap();
let Vt = 0,
  st = 1;
const on = 30;
let ke;
const gt = Symbol(""),
  ln = Symbol("");
class wn {
  constructor(t, s = null, n) {
    (this.fn = t),
      (this.scheduler = s),
      (this.active = !0),
      (this.deps = []),
      (this.parent = void 0),
      vo(this, n);
  }
  run() {
    if (!this.active) return this.fn();
    let t = ke,
      s = Xe;
    for (; t; ) {
      if (t === this) return;
      t = t.parent;
    }
    try {
      return (
        (this.parent = ke),
        (ke = this),
        (Xe = !0),
        (st = 1 << ++Vt),
        Vt <= on ? bo(this) : Zn(this),
        this.fn()
      );
    } finally {
      Vt <= on && Co(this),
        (st = 1 << --Vt),
        (ke = this.parent),
        (Xe = s),
        (this.parent = void 0),
        this.deferStop && this.stop();
    }
  }
  stop() {
    ke === this
      ? (this.deferStop = !0)
      : this.active &&
        (Zn(this), this.onStop && this.onStop(), (this.active = !1));
  }
}
function Zn(e) {
  const { deps: t } = e;
  if (t.length) {
    for (let s = 0; s < t.length; s++) t[s].delete(e);
    t.length = 0;
  }
}
let Xe = !0;
const Wi = [];
function Ft() {
  Wi.push(Xe), (Xe = !1);
}
function Rt() {
  const e = Wi.pop();
  Xe = e === void 0 ? !0 : e;
}
function _e(e, t, s) {
  if (Xe && ke) {
    let n = rn.get(e);
    n || rn.set(e, (n = new Map()));
    let r = n.get(s);
    r || n.set(s, (r = xn())), Qi(r);
  }
}
function Qi(e, t) {
  let s = !1;
  Vt <= on ? Ji(e) || ((e.n |= st), (s = !Gi(e))) : (s = !e.has(ke)),
    s && (e.add(ke), ke.deps.push(e));
}
function Ke(e, t, s, n, r, i) {
  const o = rn.get(e);
  if (!o) return;
  let l = [];
  if (t === "clear") l = [...o.values()];
  else if (s === "length" && q(e)) {
    const a = Number(n);
    o.forEach((c, f) => {
      (f === "length" || (!tt(f) && f >= a)) && l.push(c);
    });
  } else
    switch ((s !== void 0 && l.push(o.get(s)), t)) {
      case "add":
        q(e)
          ? An(s) && l.push(o.get("length"))
          : (l.push(o.get(gt)), wt(e) && l.push(o.get(ln)));
        break;
      case "delete":
        q(e) || (l.push(o.get(gt)), wt(e) && l.push(o.get(ln)));
        break;
      case "set":
        wt(e) && l.push(o.get(gt));
        break;
    }
  if (l.length === 1) l[0] && an(l[0]);
  else {
    const a = [];
    for (const c of l) c && a.push(...c);
    an(xn(a));
  }
}
function an(e, t) {
  const s = q(e) ? e : [...e];
  for (const n of s) n.computed && Yn(n);
  for (const n of s) n.computed || Yn(n);
}
function Yn(e, t) {
  (e !== ke || e.allowRecurse) && (e.scheduler ? e.scheduler() : e.run());
}
const So = bn("__proto__,__v_isRef,__isVue"),
  zi = new Set(
    Object.getOwnPropertyNames(Symbol)
      .filter((e) => e !== "arguments" && e !== "caller")
      .map((e) => Symbol[e])
      .filter(tt)
  ),
  Xn = Ao();
function Ao() {
  const e = {};
  return (
    ["includes", "indexOf", "lastIndexOf"].forEach((t) => {
      e[t] = function (...s) {
        const n = U(this);
        for (let i = 0, o = this.length; i < o; i++) _e(n, "get", i + "");
        const r = n[t](...s);
        return r === -1 || r === !1 ? n[t](...s.map(U)) : r;
      };
    }),
    ["push", "pop", "shift", "unshift", "splice"].forEach((t) => {
      e[t] = function (...s) {
        Ft();
        const n = U(this)[t].apply(this, s);
        return Rt(), n;
      };
    }),
    e
  );
}
function xo(e) {
  const t = U(this);
  return _e(t, "has", e), t.hasOwnProperty(e);
}
class Zi {
  constructor(t = !1, s = !1) {
    (this._isReadonly = t), (this._shallow = s);
  }
  get(t, s, n) {
    const r = this._isReadonly,
      i = this._shallow;
    if (s === "__v_isReactive") return !r;
    if (s === "__v_isReadonly") return r;
    if (s === "__v_isShallow") return i;
    if (s === "__v_raw")
      return n === (r ? (i ? Ro : tr) : i ? er : Xi).get(t) ||
        Object.getPrototypeOf(t) === Object.getPrototypeOf(n)
        ? t
        : void 0;
    const o = q(t);
    if (!r) {
      if (o && j(Xn, s)) return Reflect.get(Xn, s, n);
      if (s === "hasOwnProperty") return xo;
    }
    const l = Reflect.get(t, s, n);
    return (tt(s) ? zi.has(s) : So(s)) || (r || _e(t, "get", s), i)
      ? l
      : Ce(l)
      ? o && An(s)
        ? l
        : l.value
      : V(l)
      ? r
        ? sr(l)
        : Ps(l)
      : l;
  }
}
class Yi extends Zi {
  constructor(t = !1) {
    super(!1, t);
  }
  set(t, s, n, r) {
    let i = t[s];
    if (!this._shallow) {
      const a = zt(i);
      if (
        (!cn(n) && !zt(n) && ((i = U(i)), (n = U(n))), !q(t) && Ce(i) && !Ce(n))
      )
        return a ? !1 : ((i.value = n), !0);
    }
    const o = q(t) && An(s) ? Number(s) < t.length : j(t, s),
      l = Reflect.set(t, s, n, r);
    return (
      t === U(r) && (o ? $t(n, i) && Ke(t, "set", s, n) : Ke(t, "add", s, n)), l
    );
  }
  deleteProperty(t, s) {
    const n = j(t, s);
    t[s];
    const r = Reflect.deleteProperty(t, s);
    return r && n && Ke(t, "delete", s, void 0), r;
  }
  has(t, s) {
    const n = Reflect.has(t, s);
    return (!tt(s) || !zi.has(s)) && _e(t, "has", s), n;
  }
  ownKeys(t) {
    return _e(t, "iterate", q(t) ? "length" : gt), Reflect.ownKeys(t);
  }
}
class wo extends Zi {
  constructor(t = !1) {
    super(!0, t);
  }
  set(t, s) {
    return !0;
  }
  deleteProperty(t, s) {
    return !0;
  }
}
const Io = new Yi(),
  Eo = new wo(),
  To = new Yi(!0),
  In = (e) => e,
  qs = (e) => Reflect.getPrototypeOf(e);
function ls(e, t, s = !1, n = !1) {
  e = e.__v_raw;
  const r = U(e),
    i = U(t);
  s || ($t(t, i) && _e(r, "get", t), _e(r, "get", i));
  const { has: o } = qs(r),
    l = n ? In : s ? $n : kn;
  if (o.call(r, t)) return l(e.get(t));
  if (o.call(r, i)) return l(e.get(i));
  e !== r && e.get(t);
}
function as(e, t = !1) {
  const s = this.__v_raw,
    n = U(s),
    r = U(e);
  return (
    t || ($t(e, r) && _e(n, "has", e), _e(n, "has", r)),
    e === r ? s.has(e) : s.has(e) || s.has(r)
  );
}
function cs(e, t = !1) {
  return (
    (e = e.__v_raw), !t && _e(U(e), "iterate", gt), Reflect.get(e, "size", e)
  );
}
function ei(e) {
  e = U(e);
  const t = U(this);
  return qs(t).has.call(t, e) || (t.add(e), Ke(t, "add", e, e)), this;
}
function ti(e, t) {
  t = U(t);
  const s = U(this),
    { has: n, get: r } = qs(s);
  let i = n.call(s, e);
  i || ((e = U(e)), (i = n.call(s, e)));
  const o = r.call(s, e);
  return (
    s.set(e, t), i ? $t(t, o) && Ke(s, "set", e, t) : Ke(s, "add", e, t), this
  );
}
function si(e) {
  const t = U(this),
    { has: s, get: n } = qs(t);
  let r = s.call(t, e);
  r || ((e = U(e)), (r = s.call(t, e))), n && n.call(t, e);
  const i = t.delete(e);
  return r && Ke(t, "delete", e, void 0), i;
}
function ni() {
  const e = U(this),
    t = e.size !== 0,
    s = e.clear();
  return t && Ke(e, "clear", void 0, void 0), s;
}
function us(e, t) {
  return function (n, r) {
    const i = this,
      o = i.__v_raw,
      l = U(o),
      a = t ? In : e ? $n : kn;
    return (
      !e && _e(l, "iterate", gt), o.forEach((c, f) => n.call(r, a(c), a(f), i))
    );
  };
}
function fs(e, t, s) {
  return function (...n) {
    const r = this.__v_raw,
      i = U(r),
      o = wt(i),
      l = e === "entries" || (e === Symbol.iterator && o),
      a = e === "keys" && o,
      c = r[e](...n),
      f = s ? In : t ? $n : kn;
    return (
      !t && _e(i, "iterate", a ? ln : gt),
      {
        next() {
          const { value: m, done: p } = c.next();
          return p
            ? { value: m, done: p }
            : { value: l ? [f(m[0]), f(m[1])] : f(m), done: p };
        },
        [Symbol.iterator]() {
          return this;
        },
      }
    );
  };
}
function We(e) {
  return function (...t) {
    return e === "delete" ? !1 : e === "clear" ? void 0 : this;
  };
}
function ko() {
  const e = {
      get(i) {
        return ls(this, i);
      },
      get size() {
        return cs(this);
      },
      has: as,
      add: ei,
      set: ti,
      delete: si,
      clear: ni,
      forEach: us(!1, !1),
    },
    t = {
      get(i) {
        return ls(this, i, !1, !0);
      },
      get size() {
        return cs(this);
      },
      has: as,
      add: ei,
      set: ti,
      delete: si,
      clear: ni,
      forEach: us(!1, !0),
    },
    s = {
      get(i) {
        return ls(this, i, !0);
      },
      get size() {
        return cs(this, !0);
      },
      has(i) {
        return as.call(this, i, !0);
      },
      add: We("add"),
      set: We("set"),
      delete: We("delete"),
      clear: We("clear"),
      forEach: us(!0, !1),
    },
    n = {
      get(i) {
        return ls(this, i, !0, !0);
      },
      get size() {
        return cs(this, !0);
      },
      has(i) {
        return as.call(this, i, !0);
      },
      add: We("add"),
      set: We("set"),
      delete: We("delete"),
      clear: We("clear"),
      forEach: us(!0, !0),
    };
  return (
    ["keys", "values", "entries", Symbol.iterator].forEach((i) => {
      (e[i] = fs(i, !1, !1)),
        (s[i] = fs(i, !0, !1)),
        (t[i] = fs(i, !1, !0)),
        (n[i] = fs(i, !0, !0));
    }),
    [e, s, t, n]
  );
}
const [$o, Mo, Oo, qo] = ko();
function En(e, t) {
  const s = t ? (e ? qo : Oo) : e ? Mo : $o;
  return (n, r, i) =>
    r === "__v_isReactive"
      ? !e
      : r === "__v_isReadonly"
      ? e
      : r === "__v_raw"
      ? n
      : Reflect.get(j(s, r) && r in n ? s : n, r, i);
}
const Po = { get: En(!1, !1) },
  No = { get: En(!1, !0) },
  Fo = { get: En(!0, !1) },
  Xi = new WeakMap(),
  er = new WeakMap(),
  tr = new WeakMap(),
  Ro = new WeakMap();
function Lo(e) {
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
function Do(e) {
  return e.__v_skip || !Object.isExtensible(e) ? 0 : Lo(io(e));
}
function Ps(e) {
  return zt(e) ? e : Tn(e, !1, Io, Po, Xi);
}
function Bo(e) {
  return Tn(e, !1, To, No, er);
}
function sr(e) {
  return Tn(e, !0, Eo, Fo, tr);
}
function Tn(e, t, s, n, r) {
  if (!V(e) || (e.__v_raw && !(t && e.__v_isReactive))) return e;
  const i = r.get(e);
  if (i) return i;
  const o = Do(e);
  if (o === 0) return e;
  const l = new Proxy(e, o === 2 ? n : s);
  return r.set(e, l), l;
}
function It(e) {
  return zt(e) ? It(e.__v_raw) : !!(e && e.__v_isReactive);
}
function zt(e) {
  return !!(e && e.__v_isReadonly);
}
function cn(e) {
  return !!(e && e.__v_isShallow);
}
function nr(e) {
  return It(e) || zt(e);
}
function U(e) {
  const t = e && e.__v_raw;
  return t ? U(t) : e;
}
function ir(e) {
  return vs(e, "__v_skip", !0), e;
}
const kn = (e) => (V(e) ? Ps(e) : e),
  $n = (e) => (V(e) ? sr(e) : e);
function jo(e) {
  Xe && ke && ((e = U(e)), Qi(e.dep || (e.dep = xn())));
}
function Uo(e, t) {
  e = U(e);
  const s = e.dep;
  s && an(s);
}
function Ce(e) {
  return !!(e && e.__v_isRef === !0);
}
function Ko(e) {
  return Ce(e) ? e.value : e;
}
const Vo = {
  get: (e, t, s) => Ko(Reflect.get(e, t, s)),
  set: (e, t, s, n) => {
    const r = e[t];
    return Ce(r) && !Ce(s) ? ((r.value = s), !0) : Reflect.set(e, t, s, n);
  },
};
function rr(e) {
  return It(e) ? e : new Proxy(e, Vo);
}
class Ho {
  constructor(t, s, n, r) {
    (this._setter = s),
      (this.dep = void 0),
      (this.__v_isRef = !0),
      (this.__v_isReadonly = !1),
      (this._dirty = !0),
      (this.effect = new wn(t, () => {
        this._dirty || ((this._dirty = !0), Uo(this));
      })),
      (this.effect.computed = this),
      (this.effect.active = this._cacheable = !r),
      (this.__v_isReadonly = n);
  }
  get value() {
    const t = U(this);
    return (
      jo(t),
      (t._dirty || !t._cacheable) &&
        ((t._dirty = !1), (t._value = t.effect.run())),
      t._value
    );
  }
  set value(t) {
    this._setter(t);
  }
}
function Go(e, t, s = !1) {
  let n, r;
  const i = R(e);
  return (
    i ? ((n = e), (r = Le)) : ((n = e.get), (r = e.set)),
    new Ho(n, r, i || !r, s)
  );
}
function et(e, t, s, n) {
  let r;
  try {
    r = n ? e(...n) : e();
  } catch (i) {
    Ns(i, t, s);
  }
  return r;
}
function Ae(e, t, s, n) {
  if (R(e)) {
    const i = et(e, t, s, n);
    return (
      i &&
        Bi(i) &&
        i.catch((o) => {
          Ns(o, t, s);
        }),
      i
    );
  }
  const r = [];
  for (let i = 0; i < e.length; i++) r.push(Ae(e[i], t, s, n));
  return r;
}
function Ns(e, t, s, n = !0) {
  const r = t ? t.vnode : null;
  if (t) {
    let i = t.parent;
    const o = t.proxy,
      l = s;
    for (; i; ) {
      const c = i.ec;
      if (c) {
        for (let f = 0; f < c.length; f++) if (c[f](e, o, l) === !1) return;
      }
      i = i.parent;
    }
    const a = t.appContext.config.errorHandler;
    if (a) {
      et(a, null, 10, [e, o, l]);
      return;
    }
  }
  Jo(e, s, r, n);
}
function Jo(e, t, s, n = !0) {
  console.error(e);
}
let Zt = !1,
  un = !1;
const ge = [];
let Re = 0;
const Et = [];
let Ue = null,
  ct = 0;
const or = Promise.resolve();
let Mn = null;
function Wo(e) {
  const t = Mn || or;
  return e ? t.then(this ? e.bind(this) : e) : t;
}
function Qo(e) {
  let t = Re + 1,
    s = ge.length;
  for (; t < s; ) {
    const n = (t + s) >>> 1,
      r = ge[n],
      i = Yt(r);
    i < e || (i === e && r.pre) ? (t = n + 1) : (s = n);
  }
  return t;
}
function On(e) {
  (!ge.length || !ge.includes(e, Zt && e.allowRecurse ? Re + 1 : Re)) &&
    (e.id == null ? ge.push(e) : ge.splice(Qo(e.id), 0, e), lr());
}
function lr() {
  !Zt && !un && ((un = !0), (Mn = or.then(cr)));
}
function zo(e) {
  const t = ge.indexOf(e);
  t > Re && ge.splice(t, 1);
}
function Zo(e) {
  q(e)
    ? Et.push(...e)
    : (!Ue || !Ue.includes(e, e.allowRecurse ? ct + 1 : ct)) && Et.push(e),
    lr();
}
function ii(e, t, s = Zt ? Re + 1 : 0) {
  for (; s < ge.length; s++) {
    const n = ge[s];
    if (n && n.pre) {
      if (e && n.id !== e.uid) continue;
      ge.splice(s, 1), s--, n();
    }
  }
}
function ar(e) {
  if (Et.length) {
    const t = [...new Set(Et)];
    if (((Et.length = 0), Ue)) {
      Ue.push(...t);
      return;
    }
    for (Ue = t, Ue.sort((s, n) => Yt(s) - Yt(n)), ct = 0; ct < Ue.length; ct++)
      Ue[ct]();
    (Ue = null), (ct = 0);
  }
}
const Yt = (e) => (e.id == null ? 1 / 0 : e.id),
  Yo = (e, t) => {
    const s = Yt(e) - Yt(t);
    if (s === 0) {
      if (e.pre && !t.pre) return -1;
      if (t.pre && !e.pre) return 1;
    }
    return s;
  };
function cr(e) {
  (un = !1), (Zt = !0), ge.sort(Yo);
  try {
    for (Re = 0; Re < ge.length; Re++) {
      const t = ge[Re];
      t && t.active !== !1 && et(t, null, 14);
    }
  } finally {
    (Re = 0),
      (ge.length = 0),
      ar(),
      (Zt = !1),
      (Mn = null),
      (ge.length || Et.length) && cr();
  }
}
function Xo(e, t, ...s) {
  if (e.isUnmounted) return;
  const n = e.vnode.props || Q;
  let r = s;
  const i = t.startsWith("update:"),
    o = i && t.slice(7);
  if (o && o in n) {
    const f = `${o === "modelValue" ? "model" : o}Modifiers`,
      { number: m, trim: p } = n[f] || Q;
    p && (r = s.map((I) => (oe(I) ? I.trim() : I))), m && (r = s.map(ys));
  }
  let l,
    a = n[(l = Js(t))] || n[(l = Js(De(t)))];
  !a && i && (a = n[(l = Js(Pt(t)))]), a && Ae(a, e, 6, r);
  const c = n[l + "Once"];
  if (c) {
    if (!e.emitted) e.emitted = {};
    else if (e.emitted[l]) return;
    (e.emitted[l] = !0), Ae(c, e, 6, r);
  }
}
function ur(e, t, s = !1) {
  const n = t.emitsCache,
    r = n.get(e);
  if (r !== void 0) return r;
  const i = e.emits;
  let o = {},
    l = !1;
  if (!R(e)) {
    const a = (c) => {
      const f = ur(c, t, !0);
      f && ((l = !0), ae(o, f));
    };
    !s && t.mixins.length && t.mixins.forEach(a),
      e.extends && a(e.extends),
      e.mixins && e.mixins.forEach(a);
  }
  return !i && !l
    ? (V(e) && n.set(e, null), null)
    : (q(i) ? i.forEach((a) => (o[a] = null)) : ae(o, i),
      V(e) && n.set(e, o),
      o);
}
function Fs(e, t) {
  return !e || !Ts(t)
    ? !1
    : ((t = t.slice(2).replace(/Once$/, "")),
      j(e, t[0].toLowerCase() + t.slice(1)) || j(e, Pt(t)) || j(e, t));
}
let de = null,
  Rs = null;
function bs(e) {
  const t = de;
  return (de = e), (Rs = (e && e.type.__scopeId) || null), t;
}
function qn(e) {
  Rs = e;
}
function Pn() {
  Rs = null;
}
function Lt(e, t = de, s) {
  if (!t || e._n) return e;
  const n = (...r) => {
    n._d && pi(-1);
    const i = bs(t);
    let o;
    try {
      o = e(...r);
    } finally {
      bs(i), n._d && pi(1);
    }
    return o;
  };
  return (n._n = !0), (n._c = !0), (n._d = !0), n;
}
function Qs(e) {
  const {
    type: t,
    vnode: s,
    proxy: n,
    withProxy: r,
    props: i,
    propsOptions: [o],
    slots: l,
    attrs: a,
    emit: c,
    render: f,
    renderCache: m,
    data: p,
    setupState: I,
    ctx: B,
    inheritAttrs: P,
  } = e;
  let J, X;
  const Z = bs(e);
  try {
    if (s.shapeFlag & 4) {
      const N = r || n,
        ie = N;
      (J = Fe(f.call(ie, N, m, i, I, p, B))), (X = a);
    } else {
      const N = t;
      (J = Fe(
        N.length > 1 ? N(i, { attrs: a, slots: l, emit: c }) : N(i, null)
      )),
        (X = t.props ? a : el(a));
    }
  } catch (N) {
    (Qt.length = 0), Ns(N, e, 1), (J = le(xe));
  }
  let ee = J;
  if (X && P !== !1) {
    const N = Object.keys(X),
      { shapeFlag: ie } = ee;
    N.length && ie & 7 && (o && N.some(Cn) && (X = tl(X, o)), (ee = nt(ee, X)));
  }
  return (
    s.dirs &&
      ((ee = nt(ee)), (ee.dirs = ee.dirs ? ee.dirs.concat(s.dirs) : s.dirs)),
    s.transition && (ee.transition = s.transition),
    (J = ee),
    bs(Z),
    J
  );
}
const el = (e) => {
    let t;
    for (const s in e)
      (s === "class" || s === "style" || Ts(s)) && ((t || (t = {}))[s] = e[s]);
    return t;
  },
  tl = (e, t) => {
    const s = {};
    for (const n in e) (!Cn(n) || !(n.slice(9) in t)) && (s[n] = e[n]);
    return s;
  };
function sl(e, t, s) {
  const { props: n, children: r, component: i } = e,
    { props: o, children: l, patchFlag: a } = t,
    c = i.emitsOptions;
  if (t.dirs || t.transition) return !0;
  if (s && a >= 0) {
    if (a & 1024) return !0;
    if (a & 16) return n ? ri(n, o, c) : !!o;
    if (a & 8) {
      const f = t.dynamicProps;
      for (let m = 0; m < f.length; m++) {
        const p = f[m];
        if (o[p] !== n[p] && !Fs(c, p)) return !0;
      }
    }
  } else
    return (r || l) && (!l || !l.$stable)
      ? !0
      : n === o
      ? !1
      : n
      ? o
        ? ri(n, o, c)
        : !0
      : !!o;
  return !1;
}
function ri(e, t, s) {
  const n = Object.keys(t);
  if (n.length !== Object.keys(e).length) return !0;
  for (let r = 0; r < n.length; r++) {
    const i = n[r];
    if (t[i] !== e[i] && !Fs(s, i)) return !0;
  }
  return !1;
}
function nl({ vnode: e, parent: t }, s) {
  for (; t && t.subTree === e; ) ((e = t.vnode).el = s), (t = t.parent);
}
const fr = "components";
function Ve(e, t) {
  return rl(fr, e, !0, t) || e;
}
const il = Symbol.for("v-ndc");
function rl(e, t, s = !0, n = !1) {
  const r = de || fe;
  if (r) {
    const i = r.type;
    if (e === fr) {
      const l = Yl(i, !1);
      if (l && (l === t || l === De(t) || l === Ms(De(t)))) return i;
    }
    const o = oi(r[e] || i[e], t) || oi(r.appContext[e], t);
    return !o && n ? i : o;
  }
}
function oi(e, t) {
  return e && (e[t] || e[De(t)] || e[Ms(De(t))]);
}
const ol = (e) => e.__isSuspense;
function ll(e, t) {
  t && t.pendingBranch
    ? q(e)
      ? t.effects.push(...e)
      : t.effects.push(e)
    : Zo(e);
}
const ds = {};
function Gt(e, t, s) {
  return dr(e, t, s);
}
function dr(
  e,
  t,
  { immediate: s, deep: n, flush: r, onTrack: i, onTrigger: o } = Q
) {
  var l;
  const a = yo() === ((l = fe) == null ? void 0 : l.scope) ? fe : null;
  let c,
    f = !1,
    m = !1;
  if (
    (Ce(e)
      ? ((c = () => e.value), (f = cn(e)))
      : It(e)
      ? ((c = () => e), (n = !0))
      : q(e)
      ? ((m = !0),
        (f = e.some((N) => It(N) || cn(N))),
        (c = () =>
          e.map((N) => {
            if (Ce(N)) return N.value;
            if (It(N)) return ht(N);
            if (R(N)) return et(N, a, 2);
          })))
      : R(e)
      ? t
        ? (c = () => et(e, a, 2))
        : (c = () => {
            if (!(a && a.isUnmounted)) return p && p(), Ae(e, a, 3, [I]);
          })
      : (c = Le),
    t && n)
  ) {
    const N = c;
    c = () => ht(N());
  }
  let p,
    I = (N) => {
      p = Z.onStop = () => {
        et(N, a, 4), (p = Z.onStop = void 0);
      };
    },
    B;
  if (ss)
    if (
      ((I = Le),
      t ? s && Ae(t, a, 3, [c(), m ? [] : void 0, I]) : c(),
      r === "sync")
    ) {
      const N = sa();
      B = N.__watcherHandles || (N.__watcherHandles = []);
    } else return Le;
  let P = m ? new Array(e.length).fill(ds) : ds;
  const J = () => {
    if (Z.active)
      if (t) {
        const N = Z.run();
        (n || f || (m ? N.some((ie, we) => $t(ie, P[we])) : $t(N, P))) &&
          (p && p(),
          Ae(t, a, 3, [N, P === ds ? void 0 : m && P[0] === ds ? [] : P, I]),
          (P = N));
      } else Z.run();
  };
  J.allowRecurse = !!t;
  let X;
  r === "sync"
    ? (X = J)
    : r === "post"
    ? (X = () => pe(J, a && a.suspense))
    : ((J.pre = !0), a && (J.id = a.uid), (X = () => On(J)));
  const Z = new wn(c, X);
  t
    ? s
      ? J()
      : (P = Z.run())
    : r === "post"
    ? pe(Z.run.bind(Z), a && a.suspense)
    : Z.run();
  const ee = () => {
    Z.stop(), a && a.scope && Sn(a.scope.effects, Z);
  };
  return B && B.push(ee), ee;
}
function al(e, t, s) {
  const n = this.proxy,
    r = oe(e) ? (e.includes(".") ? hr(n, e) : () => n[e]) : e.bind(n, n);
  let i;
  R(t) ? (i = t) : ((i = t.handler), (s = t));
  const o = fe;
  Mt(this);
  const l = dr(r, i.bind(n), s);
  return o ? Mt(o) : mt(), l;
}
function hr(e, t) {
  const s = t.split(".");
  return () => {
    let n = e;
    for (let r = 0; r < s.length && n; r++) n = n[s[r]];
    return n;
  };
}
function ht(e, t) {
  if (!V(e) || e.__v_skip || ((t = t || new Set()), t.has(e))) return e;
  if ((t.add(e), Ce(e))) ht(e.value, t);
  else if (q(e)) for (let s = 0; s < e.length; s++) ht(e[s], t);
  else if (ks(e) || wt(e))
    e.forEach((s) => {
      ht(s, t);
    });
  else if (Ui(e)) for (const s in e) ht(e[s], t);
  return e;
}
function Tt(e, t) {
  const s = de;
  if (s === null) return e;
  const n = Us(s) || s.proxy,
    r = e.dirs || (e.dirs = []);
  for (let i = 0; i < t.length; i++) {
    let [o, l, a, c = Q] = t[i];
    o &&
      (R(o) && (o = { mounted: o, updated: o }),
      o.deep && ht(l),
      r.push({
        dir: o,
        instance: n,
        value: l,
        oldValue: void 0,
        arg: a,
        modifiers: c,
      }));
  }
  return e;
}
function ot(e, t, s, n) {
  const r = e.dirs,
    i = t && t.dirs;
  for (let o = 0; o < r.length; o++) {
    const l = r[o];
    i && (l.oldValue = i[o].value);
    let a = l.dir[n];
    a && (Ft(), Ae(a, s, 8, [e.el, l, e, t]), Rt());
  }
}
const Ze = Symbol("_leaveCb"),
  hs = Symbol("_enterCb");
function gr() {
  const e = {
    isMounted: !1,
    isLeaving: !1,
    isUnmounting: !1,
    leavingVNodes: new Map(),
  };
  return (
    vr(() => {
      e.isMounted = !0;
    }),
    br(() => {
      e.isUnmounting = !0;
    }),
    e
  );
}
const Se = [Function, Array],
  mr = {
    mode: String,
    appear: Boolean,
    persisted: Boolean,
    onBeforeEnter: Se,
    onEnter: Se,
    onAfterEnter: Se,
    onEnterCancelled: Se,
    onBeforeLeave: Se,
    onLeave: Se,
    onAfterLeave: Se,
    onLeaveCancelled: Se,
    onBeforeAppear: Se,
    onAppear: Se,
    onAfterAppear: Se,
    onAppearCancelled: Se,
  },
  cl = {
    name: "BaseTransition",
    props: mr,
    setup(e, { slots: t }) {
      const s = qr(),
        n = gr();
      let r;
      return () => {
        const i = t.default && Nn(t.default(), !0);
        if (!i || !i.length) return;
        let o = i[0];
        if (i.length > 1) {
          for (const P of i)
            if (P.type !== xe) {
              o = P;
              break;
            }
        }
        const l = U(e),
          { mode: a } = l;
        if (n.isLeaving) return zs(o);
        const c = li(o);
        if (!c) return zs(o);
        const f = Xt(c, l, n, s);
        es(c, f);
        const m = s.subTree,
          p = m && li(m);
        let I = !1;
        const { getTransitionKey: B } = c.type;
        if (B) {
          const P = B();
          r === void 0 ? (r = P) : P !== r && ((r = P), (I = !0));
        }
        if (p && p.type !== xe && (!ut(c, p) || I)) {
          const P = Xt(p, l, n, s);
          if ((es(p, P), a === "out-in"))
            return (
              (n.isLeaving = !0),
              (P.afterLeave = () => {
                (n.isLeaving = !1), s.update.active !== !1 && s.update();
              }),
              zs(o)
            );
          a === "in-out" &&
            c.type !== xe &&
            (P.delayLeave = (J, X, Z) => {
              const ee = pr(n, p);
              (ee[String(p.key)] = p),
                (J[Ze] = () => {
                  X(), (J[Ze] = void 0), delete f.delayedLeave;
                }),
                (f.delayedLeave = Z);
            });
        }
        return o;
      };
    },
  },
  ul = cl;
function pr(e, t) {
  const { leavingVNodes: s } = e;
  let n = s.get(t.type);
  return n || ((n = Object.create(null)), s.set(t.type, n)), n;
}
function Xt(e, t, s, n) {
  const {
      appear: r,
      mode: i,
      persisted: o = !1,
      onBeforeEnter: l,
      onEnter: a,
      onAfterEnter: c,
      onEnterCancelled: f,
      onBeforeLeave: m,
      onLeave: p,
      onAfterLeave: I,
      onLeaveCancelled: B,
      onBeforeAppear: P,
      onAppear: J,
      onAfterAppear: X,
      onAppearCancelled: Z,
    } = t,
    ee = String(e.key),
    N = pr(s, e),
    ie = (L, se) => {
      L && Ae(L, n, 9, se);
    },
    we = (L, se) => {
      const W = se[1];
      ie(L, se),
        q(L) ? L.every((he) => he.length <= 1) && W() : L.length <= 1 && W();
    },
    Ie = {
      mode: i,
      persisted: o,
      beforeEnter(L) {
        let se = l;
        if (!s.isMounted)
          if (r) se = P || l;
          else return;
        L[Ze] && L[Ze](!0);
        const W = N[ee];
        W && ut(e, W) && W.el[Ze] && W.el[Ze](), ie(se, [L]);
      },
      enter(L) {
        let se = a,
          W = c,
          he = f;
        if (!s.isMounted)
          if (r) (se = J || a), (W = X || c), (he = Z || f);
          else return;
        let k = !1;
        const te = (L[hs] = (ye) => {
          k ||
            ((k = !0),
            ye ? ie(he, [L]) : ie(W, [L]),
            Ie.delayedLeave && Ie.delayedLeave(),
            (L[hs] = void 0));
        });
        se ? we(se, [L, te]) : te();
      },
      leave(L, se) {
        const W = String(e.key);
        if ((L[hs] && L[hs](!0), s.isUnmounting)) return se();
        ie(m, [L]);
        let he = !1;
        const k = (L[Ze] = (te) => {
          he ||
            ((he = !0),
            se(),
            te ? ie(B, [L]) : ie(I, [L]),
            (L[Ze] = void 0),
            N[W] === e && delete N[W]);
        });
        (N[W] = e), p ? we(p, [L, k]) : k();
      },
      clone(L) {
        return Xt(L, t, s, n);
      },
    };
  return Ie;
}
function zs(e) {
  if (Ls(e)) return (e = nt(e)), (e.children = null), e;
}
function li(e) {
  return Ls(e) ? (e.children ? e.children[0] : void 0) : e;
}
function es(e, t) {
  e.shapeFlag & 6 && e.component
    ? es(e.component.subTree, t)
    : e.shapeFlag & 128
    ? ((e.ssContent.transition = t.clone(e.ssContent)),
      (e.ssFallback.transition = t.clone(e.ssFallback)))
    : (e.transition = t);
}
function Nn(e, t = !1, s) {
  let n = [],
    r = 0;
  for (let i = 0; i < e.length; i++) {
    let o = e[i];
    const l = s == null ? o.key : String(s) + String(o.key != null ? o.key : i);
    o.type === Y
      ? (o.patchFlag & 128 && r++, (n = n.concat(Nn(o.children, t, l))))
      : (t || o.type !== xe) && n.push(l != null ? nt(o, { key: l }) : o);
  }
  if (r > 1) for (let i = 0; i < n.length; i++) n[i].patchFlag = -2;
  return n;
}
const Jt = (e) => !!e.type.__asyncLoader,
  Ls = (e) => e.type.__isKeepAlive;
function fl(e, t) {
  _r(e, "a", t);
}
function dl(e, t) {
  _r(e, "da", t);
}
function _r(e, t, s = fe) {
  const n =
    e.__wdc ||
    (e.__wdc = () => {
      let r = s;
      for (; r; ) {
        if (r.isDeactivated) return;
        r = r.parent;
      }
      return e();
    });
  if ((Ds(t, n, s), s)) {
    let r = s.parent;
    for (; r && r.parent; )
      Ls(r.parent.vnode) && hl(n, t, s, r), (r = r.parent);
  }
}
function hl(e, t, s, n) {
  const r = Ds(t, e, n, !0);
  Cr(() => {
    Sn(n[t], r);
  }, s);
}
function Ds(e, t, s = fe, n = !1) {
  if (s) {
    const r = s[e] || (s[e] = []),
      i =
        t.__weh ||
        (t.__weh = (...o) => {
          if (s.isUnmounted) return;
          Ft(), Mt(s);
          const l = Ae(t, s, e, o);
          return mt(), Rt(), l;
        });
    return n ? r.unshift(i) : r.push(i), i;
  }
}
const Ge =
    (e) =>
    (t, s = fe) =>
      (!ss || e === "sp") && Ds(e, (...n) => t(...n), s),
  gl = Ge("bm"),
  vr = Ge("m"),
  ml = Ge("bu"),
  yr = Ge("u"),
  br = Ge("bum"),
  Cr = Ge("um"),
  pl = Ge("sp"),
  _l = Ge("rtg"),
  vl = Ge("rtc");
function yl(e, t = fe) {
  Ds("ec", e, t);
}
function Me(e, t, s, n) {
  let r;
  const i = s && s[n];
  if (q(e) || oe(e)) {
    r = new Array(e.length);
    for (let o = 0, l = e.length; o < l; o++)
      r[o] = t(e[o], o, void 0, i && i[o]);
  } else if (typeof e == "number") {
    r = new Array(e);
    for (let o = 0; o < e; o++) r[o] = t(o + 1, o, void 0, i && i[o]);
  } else if (V(e))
    if (e[Symbol.iterator])
      r = Array.from(e, (o, l) => t(o, l, void 0, i && i[l]));
    else {
      const o = Object.keys(e);
      r = new Array(o.length);
      for (let l = 0, a = o.length; l < a; l++) {
        const c = o[l];
        r[l] = t(e[c], c, l, i && i[l]);
      }
    }
  else r = [];
  return s && (s[n] = r), r;
}
function bl(e, t, s = {}, n, r) {
  if (de.isCE || (de.parent && Jt(de.parent) && de.parent.isCE))
    return t !== "default" && (s.name = t), le("slot", s, n && n());
  let i = e[t];
  i && i._c && (i._d = !1), A();
  const o = i && Sr(i(s)),
    l = He(
      Y,
      { key: s.key || (o && o.key) || `_${t}` },
      o || (n ? n() : []),
      o && e._ === 1 ? 64 : -2
    );
  return (
    !r && l.scopeId && (l.slotScopeIds = [l.scopeId + "-s"]),
    i && i._c && (i._d = !0),
    l
  );
}
function Sr(e) {
  return e.some((t) =>
    As(t) ? !(t.type === xe || (t.type === Y && !Sr(t.children))) : !0
  )
    ? e
    : null;
}
const fn = (e) => (e ? (Pr(e) ? Us(e) || e.proxy : fn(e.parent)) : null),
  Wt = ae(Object.create(null), {
    $: (e) => e,
    $el: (e) => e.vnode.el,
    $data: (e) => e.data,
    $props: (e) => e.props,
    $attrs: (e) => e.attrs,
    $slots: (e) => e.slots,
    $refs: (e) => e.refs,
    $parent: (e) => fn(e.parent),
    $root: (e) => fn(e.root),
    $emit: (e) => e.emit,
    $options: (e) => Fn(e),
    $forceUpdate: (e) => e.f || (e.f = () => On(e.update)),
    $nextTick: (e) => e.n || (e.n = Wo.bind(e.proxy)),
    $watch: (e) => al.bind(e),
  }),
  Zs = (e, t) => e !== Q && !e.__isScriptSetup && j(e, t),
  Cl = {
    get({ _: e }, t) {
      const {
        ctx: s,
        setupState: n,
        data: r,
        props: i,
        accessCache: o,
        type: l,
        appContext: a,
      } = e;
      let c;
      if (t[0] !== "$") {
        const I = o[t];
        if (I !== void 0)
          switch (I) {
            case 1:
              return n[t];
            case 2:
              return r[t];
            case 4:
              return s[t];
            case 3:
              return i[t];
          }
        else {
          if (Zs(n, t)) return (o[t] = 1), n[t];
          if (r !== Q && j(r, t)) return (o[t] = 2), r[t];
          if ((c = e.propsOptions[0]) && j(c, t)) return (o[t] = 3), i[t];
          if (s !== Q && j(s, t)) return (o[t] = 4), s[t];
          dn && (o[t] = 0);
        }
      }
      const f = Wt[t];
      let m, p;
      if (f) return t === "$attrs" && _e(e, "get", t), f(e);
      if ((m = l.__cssModules) && (m = m[t])) return m;
      if (s !== Q && j(s, t)) return (o[t] = 4), s[t];
      if (((p = a.config.globalProperties), j(p, t))) return p[t];
    },
    set({ _: e }, t, s) {
      const { data: n, setupState: r, ctx: i } = e;
      return Zs(r, t)
        ? ((r[t] = s), !0)
        : n !== Q && j(n, t)
        ? ((n[t] = s), !0)
        : j(e.props, t) || (t[0] === "$" && t.slice(1) in e)
        ? !1
        : ((i[t] = s), !0);
    },
    has(
      {
        _: {
          data: e,
          setupState: t,
          accessCache: s,
          ctx: n,
          appContext: r,
          propsOptions: i,
        },
      },
      o
    ) {
      let l;
      return (
        !!s[o] ||
        (e !== Q && j(e, o)) ||
        Zs(t, o) ||
        ((l = i[0]) && j(l, o)) ||
        j(n, o) ||
        j(Wt, o) ||
        j(r.config.globalProperties, o)
      );
    },
    defineProperty(e, t, s) {
      return (
        s.get != null
          ? (e._.accessCache[t] = 0)
          : j(s, "value") && this.set(e, t, s.value, null),
        Reflect.defineProperty(e, t, s)
      );
    },
  };
function ai(e) {
  return q(e) ? e.reduce((t, s) => ((t[s] = null), t), {}) : e;
}
let dn = !0;
function Sl(e) {
  const t = Fn(e),
    s = e.proxy,
    n = e.ctx;
  (dn = !1), t.beforeCreate && ci(t.beforeCreate, e, "bc");
  const {
    data: r,
    computed: i,
    methods: o,
    watch: l,
    provide: a,
    inject: c,
    created: f,
    beforeMount: m,
    mounted: p,
    beforeUpdate: I,
    updated: B,
    activated: P,
    deactivated: J,
    beforeDestroy: X,
    beforeUnmount: Z,
    destroyed: ee,
    unmounted: N,
    render: ie,
    renderTracked: we,
    renderTriggered: Ie,
    errorCaptured: L,
    serverPrefetch: se,
    expose: W,
    inheritAttrs: he,
    components: k,
    directives: te,
    filters: ye,
  } = t;
  if ((c && Al(c, n, null), o))
    for (const ne in o) {
      const H = o[ne];
      R(H) && (n[ne] = H.bind(s));
    }
  if (r) {
    const ne = r.call(s, s);
    V(ne) && (e.data = Ps(ne));
  }
  if (((dn = !0), i))
    for (const ne in i) {
      const H = i[ne],
        it = R(H) ? H.bind(s, s) : R(H.get) ? H.get.bind(s, s) : Le,
        rs = !R(H) && R(H.set) ? H.set.bind(s) : Le,
        rt = Fr({ get: it, set: rs });
      Object.defineProperty(n, ne, {
        enumerable: !0,
        configurable: !0,
        get: () => rt.value,
        set: (qe) => (rt.value = qe),
      });
    }
  if (l) for (const ne in l) Ar(l[ne], n, s, ne);
  if (a) {
    const ne = R(a) ? a.call(s) : a;
    Reflect.ownKeys(ne).forEach((H) => {
      kl(H, ne[H]);
    });
  }
  f && ci(f, e, "c");
  function ce(ne, H) {
    q(H) ? H.forEach((it) => ne(it.bind(s))) : H && ne(H.bind(s));
  }
  if (
    (ce(gl, m),
    ce(vr, p),
    ce(ml, I),
    ce(yr, B),
    ce(fl, P),
    ce(dl, J),
    ce(yl, L),
    ce(vl, we),
    ce(_l, Ie),
    ce(br, Z),
    ce(Cr, N),
    ce(pl, se),
    q(W))
  )
    if (W.length) {
      const ne = e.exposed || (e.exposed = {});
      W.forEach((H) => {
        Object.defineProperty(ne, H, {
          get: () => s[H],
          set: (it) => (s[H] = it),
        });
      });
    } else e.exposed || (e.exposed = {});
  ie && e.render === Le && (e.render = ie),
    he != null && (e.inheritAttrs = he),
    k && (e.components = k),
    te && (e.directives = te);
}
function Al(e, t, s = Le) {
  q(e) && (e = hn(e));
  for (const n in e) {
    const r = e[n];
    let i;
    V(r)
      ? "default" in r
        ? (i = ps(r.from || n, r.default, !0))
        : (i = ps(r.from || n))
      : (i = ps(r)),
      Ce(i)
        ? Object.defineProperty(t, n, {
            enumerable: !0,
            configurable: !0,
            get: () => i.value,
            set: (o) => (i.value = o),
          })
        : (t[n] = i);
  }
}
function ci(e, t, s) {
  Ae(q(e) ? e.map((n) => n.bind(t.proxy)) : e.bind(t.proxy), t, s);
}
function Ar(e, t, s, n) {
  const r = n.includes(".") ? hr(s, n) : () => s[n];
  if (oe(e)) {
    const i = t[e];
    R(i) && Gt(r, i);
  } else if (R(e)) Gt(r, e.bind(s));
  else if (V(e))
    if (q(e)) e.forEach((i) => Ar(i, t, s, n));
    else {
      const i = R(e.handler) ? e.handler.bind(s) : t[e.handler];
      R(i) && Gt(r, i, e);
    }
}
function Fn(e) {
  const t = e.type,
    { mixins: s, extends: n } = t,
    {
      mixins: r,
      optionsCache: i,
      config: { optionMergeStrategies: o },
    } = e.appContext,
    l = i.get(t);
  let a;
  return (
    l
      ? (a = l)
      : !r.length && !s && !n
      ? (a = t)
      : ((a = {}), r.length && r.forEach((c) => Cs(a, c, o, !0)), Cs(a, t, o)),
    V(t) && i.set(t, a),
    a
  );
}
function Cs(e, t, s, n = !1) {
  const { mixins: r, extends: i } = t;
  i && Cs(e, i, s, !0), r && r.forEach((o) => Cs(e, o, s, !0));
  for (const o in t)
    if (!(n && o === "expose")) {
      const l = xl[o] || (s && s[o]);
      e[o] = l ? l(e[o], t[o]) : t[o];
    }
  return e;
}
const xl = {
  data: ui,
  props: fi,
  emits: fi,
  methods: Ht,
  computed: Ht,
  beforeCreate: me,
  created: me,
  beforeMount: me,
  mounted: me,
  beforeUpdate: me,
  updated: me,
  beforeDestroy: me,
  beforeUnmount: me,
  destroyed: me,
  unmounted: me,
  activated: me,
  deactivated: me,
  errorCaptured: me,
  serverPrefetch: me,
  components: Ht,
  directives: Ht,
  watch: Il,
  provide: ui,
  inject: wl,
};
function ui(e, t) {
  return t
    ? e
      ? function () {
          return ae(
            R(e) ? e.call(this, this) : e,
            R(t) ? t.call(this, this) : t
          );
        }
      : t
    : e;
}
function wl(e, t) {
  return Ht(hn(e), hn(t));
}
function hn(e) {
  if (q(e)) {
    const t = {};
    for (let s = 0; s < e.length; s++) t[e[s]] = e[s];
    return t;
  }
  return e;
}
function me(e, t) {
  return e ? [...new Set([].concat(e, t))] : t;
}
function Ht(e, t) {
  return e ? ae(Object.create(null), e, t) : t;
}
function fi(e, t) {
  return e
    ? q(e) && q(t)
      ? [...new Set([...e, ...t])]
      : ae(Object.create(null), ai(e), ai(t ?? {}))
    : t;
}
function Il(e, t) {
  if (!e) return t;
  if (!t) return e;
  const s = ae(Object.create(null), e);
  for (const n in t) s[n] = me(e[n], t[n]);
  return s;
}
function xr() {
  return {
    app: null,
    config: {
      isNativeTag: so,
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
let El = 0;
function Tl(e, t) {
  return function (n, r = null) {
    R(n) || (n = ae({}, n)), r != null && !V(r) && (r = null);
    const i = xr(),
      o = new WeakSet();
    let l = !1;
    const a = (i.app = {
      _uid: El++,
      _component: n,
      _props: r,
      _container: null,
      _context: i,
      _instance: null,
      version: na,
      get config() {
        return i.config;
      },
      set config(c) {},
      use(c, ...f) {
        return (
          o.has(c) ||
            (c && R(c.install)
              ? (o.add(c), c.install(a, ...f))
              : R(c) && (o.add(c), c(a, ...f))),
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
      mount(c, f, m) {
        if (!l) {
          const p = le(n, r);
          return (
            (p.appContext = i),
            f && t ? t(p, c) : e(p, c, m),
            (l = !0),
            (a._container = c),
            (c.__vue_app__ = a),
            Us(p.component) || p.component.proxy
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
        Ss = a;
        try {
          return c();
        } finally {
          Ss = null;
        }
      },
    });
    return a;
  };
}
let Ss = null;
function kl(e, t) {
  if (fe) {
    let s = fe.provides;
    const n = fe.parent && fe.parent.provides;
    n === s && (s = fe.provides = Object.create(n)), (s[e] = t);
  }
}
function ps(e, t, s = !1) {
  const n = fe || de;
  if (n || Ss) {
    const r = n
      ? n.parent == null
        ? n.vnode.appContext && n.vnode.appContext.provides
        : n.parent.provides
      : Ss._context.provides;
    if (r && e in r) return r[e];
    if (arguments.length > 1) return s && R(t) ? t.call(n && n.proxy) : t;
  }
}
function $l(e, t, s, n = !1) {
  const r = {},
    i = {};
  vs(i, js, 1), (e.propsDefaults = Object.create(null)), wr(e, t, r, i);
  for (const o in e.propsOptions[0]) o in r || (r[o] = void 0);
  s ? (e.props = n ? r : Bo(r)) : e.type.props ? (e.props = r) : (e.props = i),
    (e.attrs = i);
}
function Ml(e, t, s, n) {
  const {
      props: r,
      attrs: i,
      vnode: { patchFlag: o },
    } = e,
    l = U(r),
    [a] = e.propsOptions;
  let c = !1;
  if ((n || o > 0) && !(o & 16)) {
    if (o & 8) {
      const f = e.vnode.dynamicProps;
      for (let m = 0; m < f.length; m++) {
        let p = f[m];
        if (Fs(e.emitsOptions, p)) continue;
        const I = t[p];
        if (a)
          if (j(i, p)) I !== i[p] && ((i[p] = I), (c = !0));
          else {
            const B = De(p);
            r[B] = gn(a, l, B, I, e, !1);
          }
        else I !== i[p] && ((i[p] = I), (c = !0));
      }
    }
  } else {
    wr(e, t, r, i) && (c = !0);
    let f;
    for (const m in l)
      (!t || (!j(t, m) && ((f = Pt(m)) === m || !j(t, f)))) &&
        (a
          ? s &&
            (s[m] !== void 0 || s[f] !== void 0) &&
            (r[m] = gn(a, l, m, void 0, e, !0))
          : delete r[m]);
    if (i !== l) for (const m in i) (!t || !j(t, m)) && (delete i[m], (c = !0));
  }
  c && Ke(e, "set", "$attrs");
}
function wr(e, t, s, n) {
  const [r, i] = e.propsOptions;
  let o = !1,
    l;
  if (t)
    for (let a in t) {
      if (gs(a)) continue;
      const c = t[a];
      let f;
      r && j(r, (f = De(a)))
        ? !i || !i.includes(f)
          ? (s[f] = c)
          : ((l || (l = {}))[f] = c)
        : Fs(e.emitsOptions, a) ||
          ((!(a in n) || c !== n[a]) && ((n[a] = c), (o = !0)));
    }
  if (i) {
    const a = U(s),
      c = l || Q;
    for (let f = 0; f < i.length; f++) {
      const m = i[f];
      s[m] = gn(r, a, m, c[m], e, !j(c, m));
    }
  }
  return o;
}
function gn(e, t, s, n, r, i) {
  const o = e[s];
  if (o != null) {
    const l = j(o, "default");
    if (l && n === void 0) {
      const a = o.default;
      if (o.type !== Function && !o.skipFactory && R(a)) {
        const { propsDefaults: c } = r;
        s in c ? (n = c[s]) : (Mt(r), (n = c[s] = a.call(null, t)), mt());
      } else n = a;
    }
    o[0] &&
      (i && !l ? (n = !1) : o[1] && (n === "" || n === Pt(s)) && (n = !0));
  }
  return n;
}
function Ir(e, t, s = !1) {
  const n = t.propsCache,
    r = n.get(e);
  if (r) return r;
  const i = e.props,
    o = {},
    l = [];
  let a = !1;
  if (!R(e)) {
    const f = (m) => {
      a = !0;
      const [p, I] = Ir(m, t, !0);
      ae(o, p), I && l.push(...I);
    };
    !s && t.mixins.length && t.mixins.forEach(f),
      e.extends && f(e.extends),
      e.mixins && e.mixins.forEach(f);
  }
  if (!i && !a) return V(e) && n.set(e, xt), xt;
  if (q(i))
    for (let f = 0; f < i.length; f++) {
      const m = De(i[f]);
      di(m) && (o[m] = Q);
    }
  else if (i)
    for (const f in i) {
      const m = De(f);
      if (di(m)) {
        const p = i[f],
          I = (o[m] = q(p) || R(p) ? { type: p } : ae({}, p));
        if (I) {
          const B = mi(Boolean, I.type),
            P = mi(String, I.type);
          (I[0] = B > -1),
            (I[1] = P < 0 || B < P),
            (B > -1 || j(I, "default")) && l.push(m);
        }
      }
    }
  const c = [o, l];
  return V(e) && n.set(e, c), c;
}
function di(e) {
  return e[0] !== "$";
}
function hi(e) {
  const t = e && e.toString().match(/^\s*(function|class) (\w+)/);
  return t ? t[2] : e === null ? "null" : "";
}
function gi(e, t) {
  return hi(e) === hi(t);
}
function mi(e, t) {
  return q(t) ? t.findIndex((s) => gi(s, e)) : R(t) && gi(t, e) ? 0 : -1;
}
const Er = (e) => e[0] === "_" || e === "$stable",
  Rn = (e) => (q(e) ? e.map(Fe) : [Fe(e)]),
  Ol = (e, t, s) => {
    if (t._n) return t;
    const n = Lt((...r) => Rn(t(...r)), s);
    return (n._c = !1), n;
  },
  Tr = (e, t, s) => {
    const n = e._ctx;
    for (const r in e) {
      if (Er(r)) continue;
      const i = e[r];
      if (R(i)) t[r] = Ol(r, i, n);
      else if (i != null) {
        const o = Rn(i);
        t[r] = () => o;
      }
    }
  },
  kr = (e, t) => {
    const s = Rn(t);
    e.slots.default = () => s;
  },
  ql = (e, t) => {
    if (e.vnode.shapeFlag & 32) {
      const s = t._;
      s ? ((e.slots = U(t)), vs(t, "_", s)) : Tr(t, (e.slots = {}));
    } else (e.slots = {}), t && kr(e, t);
    vs(e.slots, js, 1);
  },
  Pl = (e, t, s) => {
    const { vnode: n, slots: r } = e;
    let i = !0,
      o = Q;
    if (n.shapeFlag & 32) {
      const l = t._;
      l
        ? s && l === 1
          ? (i = !1)
          : (ae(r, t), !s && l === 1 && delete r._)
        : ((i = !t.$stable), Tr(t, r)),
        (o = t);
    } else t && (kr(e, t), (o = { default: 1 }));
    if (i) for (const l in r) !Er(l) && o[l] == null && delete r[l];
  };
function mn(e, t, s, n, r = !1) {
  if (q(e)) {
    e.forEach((p, I) => mn(p, t && (q(t) ? t[I] : t), s, n, r));
    return;
  }
  if (Jt(n) && !r) return;
  const i = n.shapeFlag & 4 ? Us(n.component) || n.component.proxy : n.el,
    o = r ? null : i,
    { i: l, r: a } = e,
    c = t && t.r,
    f = l.refs === Q ? (l.refs = {}) : l.refs,
    m = l.setupState;
  if (
    (c != null &&
      c !== a &&
      (oe(c)
        ? ((f[c] = null), j(m, c) && (m[c] = null))
        : Ce(c) && (c.value = null)),
    R(a))
  )
    et(a, l, 12, [o, f]);
  else {
    const p = oe(a),
      I = Ce(a);
    if (p || I) {
      const B = () => {
        if (e.f) {
          const P = p ? (j(m, a) ? m[a] : f[a]) : a.value;
          r
            ? q(P) && Sn(P, i)
            : q(P)
            ? P.includes(i) || P.push(i)
            : p
            ? ((f[a] = [i]), j(m, a) && (m[a] = f[a]))
            : ((a.value = [i]), e.k && (f[e.k] = a.value));
        } else
          p
            ? ((f[a] = o), j(m, a) && (m[a] = o))
            : I && ((a.value = o), e.k && (f[e.k] = o));
      };
      o ? ((B.id = -1), pe(B, s)) : B();
    }
  }
}
const pe = ll;
function Nl(e) {
  return Fl(e);
}
function Fl(e, t) {
  const s = nn();
  s.__VUE__ = !0;
  const {
      insert: n,
      remove: r,
      patchProp: i,
      createElement: o,
      createText: l,
      createComment: a,
      setText: c,
      setElementText: f,
      parentNode: m,
      nextSibling: p,
      setScopeId: I = Le,
      insertStaticContent: B,
    } = e,
    P = (
      u,
      d,
      g,
      _ = null,
      v = null,
      C = null,
      x = !1,
      b = null,
      S = !!d.dynamicChildren
    ) => {
      if (u === d) return;
      u && !ut(u, d) && ((_ = os(u)), qe(u, v, C, !0), (u = null)),
        d.patchFlag === -2 && ((S = !1), (d.dynamicChildren = null));
      const { type: y, ref: M, shapeFlag: E } = d;
      switch (y) {
        case Bs:
          J(u, d, g, _);
          break;
        case xe:
          X(u, d, g, _);
          break;
        case Ys:
          u == null && Z(d, g, _, x);
          break;
        case Y:
          k(u, d, g, _, v, C, x, b, S);
          break;
        default:
          E & 1
            ? ie(u, d, g, _, v, C, x, b, S)
            : E & 6
            ? te(u, d, g, _, v, C, x, b, S)
            : (E & 64 || E & 128) && y.process(u, d, g, _, v, C, x, b, S, yt);
      }
      M != null && v && mn(M, u && u.ref, C, d || u, !d);
    },
    J = (u, d, g, _) => {
      if (u == null) n((d.el = l(d.children)), g, _);
      else {
        const v = (d.el = u.el);
        d.children !== u.children && c(v, d.children);
      }
    },
    X = (u, d, g, _) => {
      u == null ? n((d.el = a(d.children || "")), g, _) : (d.el = u.el);
    },
    Z = (u, d, g, _) => {
      [u.el, u.anchor] = B(u.children, d, g, _, u.el, u.anchor);
    },
    ee = ({ el: u, anchor: d }, g, _) => {
      let v;
      for (; u && u !== d; ) (v = p(u)), n(u, g, _), (u = v);
      n(d, g, _);
    },
    N = ({ el: u, anchor: d }) => {
      let g;
      for (; u && u !== d; ) (g = p(u)), r(u), (u = g);
      r(d);
    },
    ie = (u, d, g, _, v, C, x, b, S) => {
      (x = x || d.type === "svg"),
        u == null ? we(d, g, _, v, C, x, b, S) : se(u, d, v, C, x, b, S);
    },
    we = (u, d, g, _, v, C, x, b) => {
      let S, y;
      const { type: M, props: E, shapeFlag: O, transition: F, dirs: D } = u;
      if (
        ((S = u.el = o(u.type, C, E && E.is, E)),
        O & 8
          ? f(S, u.children)
          : O & 16 &&
            L(u.children, S, null, _, v, C && M !== "foreignObject", x, b),
        D && ot(u, null, _, "created"),
        Ie(S, u, u.scopeId, x, _),
        E)
      ) {
        for (const K in E)
          K !== "value" &&
            !gs(K) &&
            i(S, K, null, E[K], C, u.children, _, v, Be);
        "value" in E && i(S, "value", null, E.value),
          (y = E.onVnodeBeforeMount) && Ne(y, _, u);
      }
      D && ot(u, null, _, "beforeMount");
      const G = Rl(v, F);
      G && F.beforeEnter(S),
        n(S, d, g),
        ((y = E && E.onVnodeMounted) || G || D) &&
          pe(() => {
            y && Ne(y, _, u), G && F.enter(S), D && ot(u, null, _, "mounted");
          }, v);
    },
    Ie = (u, d, g, _, v) => {
      if ((g && I(u, g), _)) for (let C = 0; C < _.length; C++) I(u, _[C]);
      if (v) {
        let C = v.subTree;
        if (d === C) {
          const x = v.vnode;
          Ie(u, x, x.scopeId, x.slotScopeIds, v.parent);
        }
      }
    },
    L = (u, d, g, _, v, C, x, b, S = 0) => {
      for (let y = S; y < u.length; y++) {
        const M = (u[y] = b ? Ye(u[y]) : Fe(u[y]));
        P(null, M, d, g, _, v, C, x, b);
      }
    },
    se = (u, d, g, _, v, C, x) => {
      const b = (d.el = u.el);
      let { patchFlag: S, dynamicChildren: y, dirs: M } = d;
      S |= u.patchFlag & 16;
      const E = u.props || Q,
        O = d.props || Q;
      let F;
      g && lt(g, !1),
        (F = O.onVnodeBeforeUpdate) && Ne(F, g, d, u),
        M && ot(d, u, g, "beforeUpdate"),
        g && lt(g, !0);
      const D = v && d.type !== "foreignObject";
      if (
        (y
          ? W(u.dynamicChildren, y, b, g, _, D, C)
          : x || H(u, d, b, null, g, _, D, C, !1),
        S > 0)
      ) {
        if (S & 16) he(b, d, E, O, g, _, v);
        else if (
          (S & 2 && E.class !== O.class && i(b, "class", null, O.class, v),
          S & 4 && i(b, "style", E.style, O.style, v),
          S & 8)
        ) {
          const G = d.dynamicProps;
          for (let K = 0; K < G.length; K++) {
            const re = G[K],
              Ee = E[re],
              bt = O[re];
            (bt !== Ee || re === "value") &&
              i(b, re, Ee, bt, v, u.children, g, _, Be);
          }
        }
        S & 1 && u.children !== d.children && f(b, d.children);
      } else !x && y == null && he(b, d, E, O, g, _, v);
      ((F = O.onVnodeUpdated) || M) &&
        pe(() => {
          F && Ne(F, g, d, u), M && ot(d, u, g, "updated");
        }, _);
    },
    W = (u, d, g, _, v, C, x) => {
      for (let b = 0; b < d.length; b++) {
        const S = u[b],
          y = d[b],
          M =
            S.el && (S.type === Y || !ut(S, y) || S.shapeFlag & 70)
              ? m(S.el)
              : g;
        P(S, y, M, null, _, v, C, x, !0);
      }
    },
    he = (u, d, g, _, v, C, x) => {
      if (g !== _) {
        if (g !== Q)
          for (const b in g)
            !gs(b) && !(b in _) && i(u, b, g[b], null, x, d.children, v, C, Be);
        for (const b in _) {
          if (gs(b)) continue;
          const S = _[b],
            y = g[b];
          S !== y && b !== "value" && i(u, b, y, S, x, d.children, v, C, Be);
        }
        "value" in _ && i(u, "value", g.value, _.value);
      }
    },
    k = (u, d, g, _, v, C, x, b, S) => {
      const y = (d.el = u ? u.el : l("")),
        M = (d.anchor = u ? u.anchor : l(""));
      let { patchFlag: E, dynamicChildren: O, slotScopeIds: F } = d;
      F && (b = b ? b.concat(F) : F),
        u == null
          ? (n(y, g, _), n(M, g, _), L(d.children, g, M, v, C, x, b, S))
          : E > 0 && E & 64 && O && u.dynamicChildren
          ? (W(u.dynamicChildren, O, g, v, C, x, b),
            (d.key != null || (v && d === v.subTree)) && $r(u, d, !0))
          : H(u, d, g, M, v, C, x, b, S);
    },
    te = (u, d, g, _, v, C, x, b, S) => {
      (d.slotScopeIds = b),
        u == null
          ? d.shapeFlag & 512
            ? v.ctx.activate(d, g, _, x, S)
            : ye(d, g, _, v, C, x, S)
          : jt(u, d, S);
    },
    ye = (u, d, g, _, v, C, x) => {
      const b = (u.component = Jl(u, _, v));
      if ((Ls(u) && (b.ctx.renderer = yt), Wl(b), b.asyncDep)) {
        if ((v && v.registerDep(b, ce), !u.el)) {
          const S = (b.subTree = le(xe));
          X(null, S, d, g);
        }
        return;
      }
      ce(b, u, d, g, v, C, x);
    },
    jt = (u, d, g) => {
      const _ = (d.component = u.component);
      if (sl(u, d, g))
        if (_.asyncDep && !_.asyncResolved) {
          ne(_, d, g);
          return;
        } else (_.next = d), zo(_.update), _.update();
      else (d.el = u.el), (_.vnode = d);
    },
    ce = (u, d, g, _, v, C, x) => {
      const b = () => {
          if (u.isMounted) {
            let { next: M, bu: E, u: O, parent: F, vnode: D } = u,
              G = M,
              K;
            lt(u, !1),
              M ? ((M.el = D.el), ne(u, M, x)) : (M = D),
              E && ms(E),
              (K = M.props && M.props.onVnodeBeforeUpdate) && Ne(K, F, M, D),
              lt(u, !0);
            const re = Qs(u),
              Ee = u.subTree;
            (u.subTree = re),
              P(Ee, re, m(Ee.el), os(Ee), u, v, C),
              (M.el = re.el),
              G === null && nl(u, re.el),
              O && pe(O, v),
              (K = M.props && M.props.onVnodeUpdated) &&
                pe(() => Ne(K, F, M, D), v);
          } else {
            let M;
            const { el: E, props: O } = d,
              { bm: F, m: D, parent: G } = u,
              K = Jt(d);
            if (
              (lt(u, !1),
              F && ms(F),
              !K && (M = O && O.onVnodeBeforeMount) && Ne(M, G, d),
              lt(u, !0),
              E && Gs)
            ) {
              const re = () => {
                (u.subTree = Qs(u)), Gs(E, u.subTree, u, v, null);
              };
              K
                ? d.type.__asyncLoader().then(() => !u.isUnmounted && re())
                : re();
            } else {
              const re = (u.subTree = Qs(u));
              P(null, re, g, _, u, v, C), (d.el = re.el);
            }
            if ((D && pe(D, v), !K && (M = O && O.onVnodeMounted))) {
              const re = d;
              pe(() => Ne(M, G, re), v);
            }
            (d.shapeFlag & 256 ||
              (G && Jt(G.vnode) && G.vnode.shapeFlag & 256)) &&
              u.a &&
              pe(u.a, v),
              (u.isMounted = !0),
              (d = g = _ = null);
          }
        },
        S = (u.effect = new wn(b, () => On(y), u.scope)),
        y = (u.update = () => S.run());
      (y.id = u.uid), lt(u, !0), y();
    },
    ne = (u, d, g) => {
      d.component = u;
      const _ = u.vnode.props;
      (u.vnode = d),
        (u.next = null),
        Ml(u, d.props, _, g),
        Pl(u, d.children, g),
        Ft(),
        ii(u),
        Rt();
    },
    H = (u, d, g, _, v, C, x, b, S = !1) => {
      const y = u && u.children,
        M = u ? u.shapeFlag : 0,
        E = d.children,
        { patchFlag: O, shapeFlag: F } = d;
      if (O > 0) {
        if (O & 128) {
          rs(y, E, g, _, v, C, x, b, S);
          return;
        } else if (O & 256) {
          it(y, E, g, _, v, C, x, b, S);
          return;
        }
      }
      F & 8
        ? (M & 16 && Be(y, v, C), E !== y && f(g, E))
        : M & 16
        ? F & 16
          ? rs(y, E, g, _, v, C, x, b, S)
          : Be(y, v, C, !0)
        : (M & 8 && f(g, ""), F & 16 && L(E, g, _, v, C, x, b, S));
    },
    it = (u, d, g, _, v, C, x, b, S) => {
      (u = u || xt), (d = d || xt);
      const y = u.length,
        M = d.length,
        E = Math.min(y, M);
      let O;
      for (O = 0; O < E; O++) {
        const F = (d[O] = S ? Ye(d[O]) : Fe(d[O]));
        P(u[O], F, g, null, v, C, x, b, S);
      }
      y > M ? Be(u, v, C, !0, !1, E) : L(d, g, _, v, C, x, b, S, E);
    },
    rs = (u, d, g, _, v, C, x, b, S) => {
      let y = 0;
      const M = d.length;
      let E = u.length - 1,
        O = M - 1;
      for (; y <= E && y <= O; ) {
        const F = u[y],
          D = (d[y] = S ? Ye(d[y]) : Fe(d[y]));
        if (ut(F, D)) P(F, D, g, null, v, C, x, b, S);
        else break;
        y++;
      }
      for (; y <= E && y <= O; ) {
        const F = u[E],
          D = (d[O] = S ? Ye(d[O]) : Fe(d[O]));
        if (ut(F, D)) P(F, D, g, null, v, C, x, b, S);
        else break;
        E--, O--;
      }
      if (y > E) {
        if (y <= O) {
          const F = O + 1,
            D = F < M ? d[F].el : _;
          for (; y <= O; )
            P(null, (d[y] = S ? Ye(d[y]) : Fe(d[y])), g, D, v, C, x, b, S), y++;
        }
      } else if (y > O) for (; y <= E; ) qe(u[y], v, C, !0), y++;
      else {
        const F = y,
          D = y,
          G = new Map();
        for (y = D; y <= O; y++) {
          const be = (d[y] = S ? Ye(d[y]) : Fe(d[y]));
          be.key != null && G.set(be.key, y);
        }
        let K,
          re = 0;
        const Ee = O - D + 1;
        let bt = !1,
          Gn = 0;
        const Ut = new Array(Ee);
        for (y = 0; y < Ee; y++) Ut[y] = 0;
        for (y = F; y <= E; y++) {
          const be = u[y];
          if (re >= Ee) {
            qe(be, v, C, !0);
            continue;
          }
          let Pe;
          if (be.key != null) Pe = G.get(be.key);
          else
            for (K = D; K <= O; K++)
              if (Ut[K - D] === 0 && ut(be, d[K])) {
                Pe = K;
                break;
              }
          Pe === void 0
            ? qe(be, v, C, !0)
            : ((Ut[Pe - D] = y + 1),
              Pe >= Gn ? (Gn = Pe) : (bt = !0),
              P(be, d[Pe], g, null, v, C, x, b, S),
              re++);
        }
        const Jn = bt ? Ll(Ut) : xt;
        for (K = Jn.length - 1, y = Ee - 1; y >= 0; y--) {
          const be = D + y,
            Pe = d[be],
            Wn = be + 1 < M ? d[be + 1].el : _;
          Ut[y] === 0
            ? P(null, Pe, g, Wn, v, C, x, b, S)
            : bt && (K < 0 || y !== Jn[K] ? rt(Pe, g, Wn, 2) : K--);
        }
      }
    },
    rt = (u, d, g, _, v = null) => {
      const { el: C, type: x, transition: b, children: S, shapeFlag: y } = u;
      if (y & 6) {
        rt(u.component.subTree, d, g, _);
        return;
      }
      if (y & 128) {
        u.suspense.move(d, g, _);
        return;
      }
      if (y & 64) {
        x.move(u, d, g, yt);
        return;
      }
      if (x === Y) {
        n(C, d, g);
        for (let E = 0; E < S.length; E++) rt(S[E], d, g, _);
        n(u.anchor, d, g);
        return;
      }
      if (x === Ys) {
        ee(u, d, g);
        return;
      }
      if (_ !== 2 && y & 1 && b)
        if (_ === 0) b.beforeEnter(C), n(C, d, g), pe(() => b.enter(C), v);
        else {
          const { leave: E, delayLeave: O, afterLeave: F } = b,
            D = () => n(C, d, g),
            G = () => {
              E(C, () => {
                D(), F && F();
              });
            };
          O ? O(C, D, G) : G();
        }
      else n(C, d, g);
    },
    qe = (u, d, g, _ = !1, v = !1) => {
      const {
        type: C,
        props: x,
        ref: b,
        children: S,
        dynamicChildren: y,
        shapeFlag: M,
        patchFlag: E,
        dirs: O,
      } = u;
      if ((b != null && mn(b, null, g, u, !0), M & 256)) {
        d.ctx.deactivate(u);
        return;
      }
      const F = M & 1 && O,
        D = !Jt(u);
      let G;
      if ((D && (G = x && x.onVnodeBeforeUnmount) && Ne(G, d, u), M & 6))
        to(u.component, g, _);
      else {
        if (M & 128) {
          u.suspense.unmount(g, _);
          return;
        }
        F && ot(u, null, d, "beforeUnmount"),
          M & 64
            ? u.type.remove(u, d, g, v, yt, _)
            : y && (C !== Y || (E > 0 && E & 64))
            ? Be(y, d, g, !1, !0)
            : ((C === Y && E & 384) || (!v && M & 16)) && Be(S, d, g),
          _ && Vn(u);
      }
      ((D && (G = x && x.onVnodeUnmounted)) || F) &&
        pe(() => {
          G && Ne(G, d, u), F && ot(u, null, d, "unmounted");
        }, g);
    },
    Vn = (u) => {
      const { type: d, el: g, anchor: _, transition: v } = u;
      if (d === Y) {
        eo(g, _);
        return;
      }
      if (d === Ys) {
        N(u);
        return;
      }
      const C = () => {
        r(g), v && !v.persisted && v.afterLeave && v.afterLeave();
      };
      if (u.shapeFlag & 1 && v && !v.persisted) {
        const { leave: x, delayLeave: b } = v,
          S = () => x(g, C);
        b ? b(u.el, C, S) : S();
      } else C();
    },
    eo = (u, d) => {
      let g;
      for (; u !== d; ) (g = p(u)), r(u), (u = g);
      r(d);
    },
    to = (u, d, g) => {
      const { bum: _, scope: v, update: C, subTree: x, um: b } = u;
      _ && ms(_),
        v.stop(),
        C && ((C.active = !1), qe(x, u, d, g)),
        b && pe(b, d),
        pe(() => {
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
    Be = (u, d, g, _ = !1, v = !1, C = 0) => {
      for (let x = C; x < u.length; x++) qe(u[x], d, g, _, v);
    },
    os = (u) =>
      u.shapeFlag & 6
        ? os(u.component.subTree)
        : u.shapeFlag & 128
        ? u.suspense.next()
        : p(u.anchor || u.el),
    Hn = (u, d, g) => {
      u == null
        ? d._vnode && qe(d._vnode, null, null, !0)
        : P(d._vnode || null, u, d, null, null, null, g),
        ii(),
        ar(),
        (d._vnode = u);
    },
    yt = {
      p: P,
      um: qe,
      m: rt,
      r: Vn,
      mt: ye,
      mc: L,
      pc: H,
      pbc: W,
      n: os,
      o: e,
    };
  let Hs, Gs;
  return (
    t && ([Hs, Gs] = t(yt)), { render: Hn, hydrate: Hs, createApp: Tl(Hn, Hs) }
  );
}
function lt({ effect: e, update: t }, s) {
  e.allowRecurse = t.allowRecurse = s;
}
function Rl(e, t) {
  return (!e || (e && !e.pendingBranch)) && t && !t.persisted;
}
function $r(e, t, s = !1) {
  const n = e.children,
    r = t.children;
  if (q(n) && q(r))
    for (let i = 0; i < n.length; i++) {
      const o = n[i];
      let l = r[i];
      l.shapeFlag & 1 &&
        !l.dynamicChildren &&
        ((l.patchFlag <= 0 || l.patchFlag === 32) &&
          ((l = r[i] = Ye(r[i])), (l.el = o.el)),
        s || $r(o, l)),
        l.type === Bs && (l.el = o.el);
    }
}
function Ll(e) {
  const t = e.slice(),
    s = [0];
  let n, r, i, o, l;
  const a = e.length;
  for (n = 0; n < a; n++) {
    const c = e[n];
    if (c !== 0) {
      if (((r = s[s.length - 1]), e[r] < c)) {
        (t[n] = r), s.push(n);
        continue;
      }
      for (i = 0, o = s.length - 1; i < o; )
        (l = (i + o) >> 1), e[s[l]] < c ? (i = l + 1) : (o = l);
      c < e[s[i]] && (i > 0 && (t[n] = s[i - 1]), (s[i] = n));
    }
  }
  for (i = s.length, o = s[i - 1]; i-- > 0; ) (s[i] = o), (o = t[o]);
  return s;
}
const Dl = (e) => e.__isTeleport,
  Y = Symbol.for("v-fgt"),
  Bs = Symbol.for("v-txt"),
  xe = Symbol.for("v-cmt"),
  Ys = Symbol.for("v-stc"),
  Qt = [];
let $e = null;
function A(e = !1) {
  Qt.push(($e = e ? null : []));
}
function Bl() {
  Qt.pop(), ($e = Qt[Qt.length - 1] || null);
}
let ts = 1;
function pi(e) {
  ts += e;
}
function Mr(e) {
  return (
    (e.dynamicChildren = ts > 0 ? $e || xt : null),
    Bl(),
    ts > 0 && $e && $e.push(e),
    e
  );
}
function w(e, t, s, n, r, i) {
  return Mr(h(e, t, s, n, r, i, !0));
}
function He(e, t, s, n, r) {
  return Mr(le(e, t, s, n, r, !0));
}
function As(e) {
  return e ? e.__v_isVNode === !0 : !1;
}
function ut(e, t) {
  return e.type === t.type && e.key === t.key;
}
const js = "__vInternal",
  Or = ({ key: e }) => e ?? null,
  _s = ({ ref: e, ref_key: t, ref_for: s }) => (
    typeof e == "number" && (e = "" + e),
    e != null
      ? oe(e) || Ce(e) || R(e)
        ? { i: de, r: e, k: t, f: !!s }
        : e
      : null
  );
function h(
  e,
  t = null,
  s = null,
  n = 0,
  r = null,
  i = e === Y ? 0 : 1,
  o = !1,
  l = !1
) {
  const a = {
    __v_isVNode: !0,
    __v_skip: !0,
    type: e,
    props: t,
    key: t && Or(t),
    ref: t && _s(t),
    scopeId: Rs,
    slotScopeIds: null,
    children: s,
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
    patchFlag: n,
    dynamicProps: r,
    dynamicChildren: null,
    appContext: null,
    ctx: de,
  };
  return (
    l
      ? (Ln(a, s), i & 128 && e.normalize(a))
      : s && (a.shapeFlag |= oe(s) ? 8 : 16),
    ts > 0 &&
      !o &&
      $e &&
      (a.patchFlag > 0 || i & 6) &&
      a.patchFlag !== 32 &&
      $e.push(a),
    a
  );
}
const le = jl;
function jl(e, t = null, s = null, n = 0, r = null, i = !1) {
  if (((!e || e === il) && (e = xe), As(e))) {
    const l = nt(e, t, !0);
    return (
      s && Ln(l, s),
      ts > 0 &&
        !i &&
        $e &&
        (l.shapeFlag & 6 ? ($e[$e.indexOf(e)] = l) : $e.push(l)),
      (l.patchFlag |= -2),
      l
    );
  }
  if ((Xl(e) && (e = e.__vccOpts), t)) {
    t = Ul(t);
    let { class: l, style: a } = t;
    l && !oe(l) && (t.class = ue(l)),
      V(a) && (nr(a) && !q(a) && (a = ae({}, a)), (t.style = Nt(a)));
  }
  const o = oe(e) ? 1 : ol(e) ? 128 : Dl(e) ? 64 : V(e) ? 4 : R(e) ? 2 : 0;
  return h(e, t, s, n, r, o, i, !0);
}
function Ul(e) {
  return e ? (nr(e) || js in e ? ae({}, e) : e) : null;
}
function nt(e, t, s = !1) {
  const { props: n, ref: r, patchFlag: i, children: o } = e,
    l = t ? Vl(n || {}, t) : n;
  return {
    __v_isVNode: !0,
    __v_skip: !0,
    type: e.type,
    props: l,
    key: l && Or(l),
    ref:
      t && t.ref ? (s && r ? (q(r) ? r.concat(_s(t)) : [r, _s(t)]) : _s(t)) : r,
    scopeId: e.scopeId,
    slotScopeIds: e.slotScopeIds,
    children: o,
    target: e.target,
    targetAnchor: e.targetAnchor,
    staticCount: e.staticCount,
    shapeFlag: e.shapeFlag,
    patchFlag: t && e.type !== Y ? (i === -1 ? 16 : i | 16) : i,
    dynamicProps: e.dynamicProps,
    dynamicChildren: e.dynamicChildren,
    appContext: e.appContext,
    dirs: e.dirs,
    transition: e.transition,
    component: e.component,
    suspense: e.suspense,
    ssContent: e.ssContent && nt(e.ssContent),
    ssFallback: e.ssFallback && nt(e.ssFallback),
    el: e.el,
    anchor: e.anchor,
    ctx: e.ctx,
    ce: e.ce,
  };
}
function Kl(e = " ", t = 0) {
  return le(Bs, null, e, t);
}
function z(e = "", t = !1) {
  return t ? (A(), He(xe, null, e)) : le(xe, null, e);
}
function Fe(e) {
  return e == null || typeof e == "boolean"
    ? le(xe)
    : q(e)
    ? le(Y, null, e.slice())
    : typeof e == "object"
    ? Ye(e)
    : le(Bs, null, String(e));
}
function Ye(e) {
  return (e.el === null && e.patchFlag !== -1) || e.memo ? e : nt(e);
}
function Ln(e, t) {
  let s = 0;
  const { shapeFlag: n } = e;
  if (t == null) t = null;
  else if (q(t)) s = 16;
  else if (typeof t == "object")
    if (n & 65) {
      const r = t.default;
      r && (r._c && (r._d = !1), Ln(e, r()), r._c && (r._d = !0));
      return;
    } else {
      s = 32;
      const r = t._;
      !r && !(js in t)
        ? (t._ctx = de)
        : r === 3 &&
          de &&
          (de.slots._ === 1 ? (t._ = 1) : ((t._ = 2), (e.patchFlag |= 1024)));
    }
  else
    R(t)
      ? ((t = { default: t, _ctx: de }), (s = 32))
      : ((t = String(t)), n & 64 ? ((s = 16), (t = [Kl(t)])) : (s = 8));
  (e.children = t), (e.shapeFlag |= s);
}
function Vl(...e) {
  const t = {};
  for (let s = 0; s < e.length; s++) {
    const n = e[s];
    for (const r in n)
      if (r === "class")
        t.class !== n.class && (t.class = ue([t.class, n.class]));
      else if (r === "style") t.style = Nt([t.style, n.style]);
      else if (Ts(r)) {
        const i = t[r],
          o = n[r];
        o &&
          i !== o &&
          !(q(i) && i.includes(o)) &&
          (t[r] = i ? [].concat(i, o) : o);
      } else r !== "" && (t[r] = n[r]);
  }
  return t;
}
function Ne(e, t, s, n = null) {
  Ae(e, t, 7, [s, n]);
}
const Hl = xr();
let Gl = 0;
function Jl(e, t, s) {
  const n = e.type,
    r = (t ? t.appContext : e.appContext) || Hl,
    i = {
      uid: Gl++,
      vnode: e,
      type: n,
      parent: t,
      appContext: r,
      root: null,
      next: null,
      subTree: null,
      effect: null,
      update: null,
      scope: new Hi(!0),
      render: null,
      proxy: null,
      exposed: null,
      exposeProxy: null,
      withProxy: null,
      provides: t ? t.provides : Object.create(r.provides),
      accessCache: null,
      renderCache: [],
      components: null,
      directives: null,
      propsOptions: Ir(n, r),
      emitsOptions: ur(n, r),
      emit: null,
      emitted: null,
      propsDefaults: Q,
      inheritAttrs: n.inheritAttrs,
      ctx: Q,
      data: Q,
      props: Q,
      attrs: Q,
      slots: Q,
      refs: Q,
      setupState: Q,
      setupContext: null,
      attrsProxy: null,
      slotsProxy: null,
      suspense: s,
      suspenseId: s ? s.pendingId : 0,
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
    (i.emit = Xo.bind(null, i)),
    e.ce && e.ce(i),
    i
  );
}
let fe = null;
const qr = () => fe || de;
let Dn,
  Ct,
  _i = "__VUE_INSTANCE_SETTERS__";
(Ct = nn()[_i]) || (Ct = nn()[_i] = []),
  Ct.push((e) => (fe = e)),
  (Dn = (e) => {
    Ct.length > 1 ? Ct.forEach((t) => t(e)) : Ct[0](e);
  });
const Mt = (e) => {
    Dn(e), e.scope.on();
  },
  mt = () => {
    fe && fe.scope.off(), Dn(null);
  };
function Pr(e) {
  return e.vnode.shapeFlag & 4;
}
let ss = !1;
function Wl(e, t = !1) {
  ss = t;
  const { props: s, children: n } = e.vnode,
    r = Pr(e);
  $l(e, s, r, t), ql(e, n);
  const i = r ? Ql(e, t) : void 0;
  return (ss = !1), i;
}
function Ql(e, t) {
  const s = e.type;
  (e.accessCache = Object.create(null)), (e.proxy = ir(new Proxy(e.ctx, Cl)));
  const { setup: n } = s;
  if (n) {
    const r = (e.setupContext = n.length > 1 ? Zl(e) : null);
    Mt(e), Ft();
    const i = et(n, e, 0, [e.props, r]);
    if ((Rt(), mt(), Bi(i))) {
      if ((i.then(mt, mt), t))
        return i
          .then((o) => {
            vi(e, o, t);
          })
          .catch((o) => {
            Ns(o, e, 0);
          });
      e.asyncDep = i;
    } else vi(e, i, t);
  } else Nr(e, t);
}
function vi(e, t, s) {
  R(t)
    ? e.type.__ssrInlineRender
      ? (e.ssrRender = t)
      : (e.render = t)
    : V(t) && (e.setupState = rr(t)),
    Nr(e, s);
}
let yi;
function Nr(e, t, s) {
  const n = e.type;
  if (!e.render) {
    if (!t && yi && !n.render) {
      const r = n.template || Fn(e).template;
      if (r) {
        const { isCustomElement: i, compilerOptions: o } = e.appContext.config,
          { delimiters: l, compilerOptions: a } = n,
          c = ae(ae({ isCustomElement: i, delimiters: l }, o), a);
        n.render = yi(r, c);
      }
    }
    e.render = n.render || Le;
  }
  {
    Mt(e), Ft();
    try {
      Sl(e);
    } finally {
      Rt(), mt();
    }
  }
}
function zl(e) {
  return (
    e.attrsProxy ||
    (e.attrsProxy = new Proxy(e.attrs, {
      get(t, s) {
        return _e(e, "get", "$attrs"), t[s];
      },
    }))
  );
}
function Zl(e) {
  const t = (s) => {
    e.exposed = s || {};
  };
  return {
    get attrs() {
      return zl(e);
    },
    slots: e.slots,
    emit: e.emit,
    expose: t,
  };
}
function Us(e) {
  if (e.exposed)
    return (
      e.exposeProxy ||
      (e.exposeProxy = new Proxy(rr(ir(e.exposed)), {
        get(t, s) {
          if (s in t) return t[s];
          if (s in Wt) return Wt[s](e);
        },
        has(t, s) {
          return s in t || s in Wt;
        },
      }))
    );
}
function Yl(e, t = !0) {
  return R(e) ? e.displayName || e.name : e.name || (t && e.__name);
}
function Xl(e) {
  return R(e) && "__vccOpts" in e;
}
const Fr = (e, t) => Go(e, t, ss);
function ea(e, t, s) {
  const n = arguments.length;
  return n === 2
    ? V(t) && !q(t)
      ? As(t)
        ? le(e, null, [t])
        : le(e, t)
      : le(e, null, t)
    : (n > 3
        ? (s = Array.prototype.slice.call(arguments, 2))
        : n === 3 && As(s) && (s = [s]),
      le(e, t, s));
}
const ta = Symbol.for("v-scx"),
  sa = () => ps(ta),
  na = "3.3.13",
  ia = "http://www.w3.org/2000/svg",
  ft = typeof document < "u" ? document : null,
  bi = ft && ft.createElement("template"),
  ra = {
    insert: (e, t, s) => {
      t.insertBefore(e, s || null);
    },
    remove: (e) => {
      const t = e.parentNode;
      t && t.removeChild(e);
    },
    createElement: (e, t, s, n) => {
      const r = t
        ? ft.createElementNS(ia, e)
        : ft.createElement(e, s ? { is: s } : void 0);
      return (
        e === "select" &&
          n &&
          n.multiple != null &&
          r.setAttribute("multiple", n.multiple),
        r
      );
    },
    createText: (e) => ft.createTextNode(e),
    createComment: (e) => ft.createComment(e),
    setText: (e, t) => {
      e.nodeValue = t;
    },
    setElementText: (e, t) => {
      e.textContent = t;
    },
    parentNode: (e) => e.parentNode,
    nextSibling: (e) => e.nextSibling,
    querySelector: (e) => ft.querySelector(e),
    setScopeId(e, t) {
      e.setAttribute(t, "");
    },
    insertStaticContent(e, t, s, n, r, i) {
      const o = s ? s.previousSibling : t.lastChild;
      if (r && (r === i || r.nextSibling))
        for (
          ;
          t.insertBefore(r.cloneNode(!0), s),
            !(r === i || !(r = r.nextSibling));

        );
      else {
        bi.innerHTML = n ? `<svg>${e}</svg>` : e;
        const l = bi.content;
        if (n) {
          const a = l.firstChild;
          for (; a.firstChild; ) l.appendChild(a.firstChild);
          l.removeChild(a);
        }
        t.insertBefore(l, s);
      }
      return [
        o ? o.nextSibling : t.firstChild,
        s ? s.previousSibling : t.lastChild,
      ];
    },
  },
  Qe = "transition",
  Kt = "animation",
  Ot = Symbol("_vtc"),
  Bn = (e, { slots: t }) => ea(ul, Lr(e), t);
Bn.displayName = "Transition";
const Rr = {
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
  },
  oa = (Bn.props = ae({}, mr, Rr)),
  at = (e, t = []) => {
    q(e) ? e.forEach((s) => s(...t)) : e && e(...t);
  },
  Ci = (e) => (e ? (q(e) ? e.some((t) => t.length > 1) : e.length > 1) : !1);
function Lr(e) {
  const t = {};
  for (const k in e) k in Rr || (t[k] = e[k]);
  if (e.css === !1) return t;
  const {
      name: s = "v",
      type: n,
      duration: r,
      enterFromClass: i = `${s}-enter-from`,
      enterActiveClass: o = `${s}-enter-active`,
      enterToClass: l = `${s}-enter-to`,
      appearFromClass: a = i,
      appearActiveClass: c = o,
      appearToClass: f = l,
      leaveFromClass: m = `${s}-leave-from`,
      leaveActiveClass: p = `${s}-leave-active`,
      leaveToClass: I = `${s}-leave-to`,
    } = e,
    B = la(r),
    P = B && B[0],
    J = B && B[1],
    {
      onBeforeEnter: X,
      onEnter: Z,
      onEnterCancelled: ee,
      onLeave: N,
      onLeaveCancelled: ie,
      onBeforeAppear: we = X,
      onAppear: Ie = Z,
      onAppearCancelled: L = ee,
    } = t,
    se = (k, te, ye) => {
      ze(k, te ? f : l), ze(k, te ? c : o), ye && ye();
    },
    W = (k, te) => {
      (k._isLeaving = !1), ze(k, m), ze(k, I), ze(k, p), te && te();
    },
    he = (k) => (te, ye) => {
      const jt = k ? Ie : Z,
        ce = () => se(te, k, ye);
      at(jt, [te, ce]),
        Si(() => {
          ze(te, k ? a : i), je(te, k ? f : l), Ci(jt) || Ai(te, n, P, ce);
        });
    };
  return ae(t, {
    onBeforeEnter(k) {
      at(X, [k]), je(k, i), je(k, o);
    },
    onBeforeAppear(k) {
      at(we, [k]), je(k, a), je(k, c);
    },
    onEnter: he(!1),
    onAppear: he(!0),
    onLeave(k, te) {
      k._isLeaving = !0;
      const ye = () => W(k, te);
      je(k, m),
        Br(),
        je(k, p),
        Si(() => {
          k._isLeaving && (ze(k, m), je(k, I), Ci(N) || Ai(k, n, J, ye));
        }),
        at(N, [k, ye]);
    },
    onEnterCancelled(k) {
      se(k, !1), at(ee, [k]);
    },
    onAppearCancelled(k) {
      se(k, !0), at(L, [k]);
    },
    onLeaveCancelled(k) {
      W(k), at(ie, [k]);
    },
  });
}
function la(e) {
  if (e == null) return null;
  if (V(e)) return [Xs(e.enter), Xs(e.leave)];
  {
    const t = Xs(e);
    return [t, t];
  }
}
function Xs(e) {
  return lo(e);
}
function je(e, t) {
  t.split(/\s+/).forEach((s) => s && e.classList.add(s)),
    (e[Ot] || (e[Ot] = new Set())).add(t);
}
function ze(e, t) {
  t.split(/\s+/).forEach((n) => n && e.classList.remove(n));
  const s = e[Ot];
  s && (s.delete(t), s.size || (e[Ot] = void 0));
}
function Si(e) {
  requestAnimationFrame(() => {
    requestAnimationFrame(e);
  });
}
let aa = 0;
function Ai(e, t, s, n) {
  const r = (e._endId = ++aa),
    i = () => {
      r === e._endId && n();
    };
  if (s) return setTimeout(i, s);
  const { type: o, timeout: l, propCount: a } = Dr(e, t);
  if (!o) return n();
  const c = o + "end";
  let f = 0;
  const m = () => {
      e.removeEventListener(c, p), i();
    },
    p = (I) => {
      I.target === e && ++f >= a && m();
    };
  setTimeout(() => {
    f < a && m();
  }, l + 1),
    e.addEventListener(c, p);
}
function Dr(e, t) {
  const s = window.getComputedStyle(e),
    n = (B) => (s[B] || "").split(", "),
    r = n(`${Qe}Delay`),
    i = n(`${Qe}Duration`),
    o = xi(r, i),
    l = n(`${Kt}Delay`),
    a = n(`${Kt}Duration`),
    c = xi(l, a);
  let f = null,
    m = 0,
    p = 0;
  t === Qe
    ? o > 0 && ((f = Qe), (m = o), (p = i.length))
    : t === Kt
    ? c > 0 && ((f = Kt), (m = c), (p = a.length))
    : ((m = Math.max(o, c)),
      (f = m > 0 ? (o > c ? Qe : Kt) : null),
      (p = f ? (f === Qe ? i.length : a.length) : 0));
  const I =
    f === Qe && /\b(transform|all)(,|$)/.test(n(`${Qe}Property`).toString());
  return { type: f, timeout: m, propCount: p, hasTransform: I };
}
function xi(e, t) {
  for (; e.length < t.length; ) e = e.concat(e);
  return Math.max(...t.map((s, n) => wi(s) + wi(e[n])));
}
function wi(e) {
  return e === "auto" ? 0 : Number(e.slice(0, -1).replace(",", ".")) * 1e3;
}
function Br() {
  return document.body.offsetHeight;
}
function ca(e, t, s) {
  const n = e[Ot];
  n && (t = (t ? [t, ...n] : [...n]).join(" ")),
    t == null
      ? e.removeAttribute("class")
      : s
      ? e.setAttribute("class", t)
      : (e.className = t);
}
const ua = Symbol("_vod"),
  fa = Symbol("");
function da(e, t, s) {
  const n = e.style,
    r = oe(s);
  if (s && !r) {
    if (t && !oe(t)) for (const i in t) s[i] == null && pn(n, i, "");
    for (const i in s) pn(n, i, s[i]);
  } else {
    const i = n.display;
    if (r) {
      if (t !== s) {
        const o = n[fa];
        o && (s += ";" + o), (n.cssText = s);
      }
    } else t && e.removeAttribute("style");
    ua in e && (n.display = i);
  }
}
const Ii = /\s*!important$/;
function pn(e, t, s) {
  if (q(s)) s.forEach((n) => pn(e, t, n));
  else if ((s == null && (s = ""), t.startsWith("--"))) e.setProperty(t, s);
  else {
    const n = ha(e, t);
    Ii.test(s)
      ? e.setProperty(Pt(n), s.replace(Ii, ""), "important")
      : (e[n] = s);
  }
}
const Ei = ["Webkit", "Moz", "ms"],
  en = {};
function ha(e, t) {
  const s = en[t];
  if (s) return s;
  let n = De(t);
  if (n !== "filter" && n in e) return (en[t] = n);
  n = Ms(n);
  for (let r = 0; r < Ei.length; r++) {
    const i = Ei[r] + n;
    if (i in e) return (en[t] = i);
  }
  return t;
}
const Ti = "http://www.w3.org/1999/xlink";
function ga(e, t, s, n, r) {
  if (n && t.startsWith("xlink:"))
    s == null
      ? e.removeAttributeNS(Ti, t.slice(6, t.length))
      : e.setAttributeNS(Ti, t, s);
  else {
    const i = go(t);
    s == null || (i && !Ki(s))
      ? e.removeAttribute(t)
      : e.setAttribute(t, i ? "" : s);
  }
}
function ma(e, t, s, n, r, i, o) {
  if (t === "innerHTML" || t === "textContent") {
    n && o(n, r, i), (e[t] = s ?? "");
    return;
  }
  const l = e.tagName;
  if (t === "value" && l !== "PROGRESS" && !l.includes("-")) {
    e._value = s;
    const c = l === "OPTION" ? e.getAttribute("value") : e.value,
      f = s ?? "";
    c !== f && (e.value = f), s == null && e.removeAttribute(t);
    return;
  }
  let a = !1;
  if (s === "" || s == null) {
    const c = typeof e[t];
    c === "boolean"
      ? (s = Ki(s))
      : s == null && c === "string"
      ? ((s = ""), (a = !0))
      : c === "number" && ((s = 0), (a = !0));
  }
  try {
    e[t] = s;
  } catch {}
  a && e.removeAttribute(t);
}
function dt(e, t, s, n) {
  e.addEventListener(t, s, n);
}
function pa(e, t, s, n) {
  e.removeEventListener(t, s, n);
}
const ki = Symbol("_vei");
function _a(e, t, s, n, r = null) {
  const i = e[ki] || (e[ki] = {}),
    o = i[t];
  if (n && o) o.value = n;
  else {
    const [l, a] = va(t);
    if (n) {
      const c = (i[t] = Ca(n, r));
      dt(e, l, c, a);
    } else o && (pa(e, l, o, a), (i[t] = void 0));
  }
}
const $i = /(?:Once|Passive|Capture)$/;
function va(e) {
  let t;
  if ($i.test(e)) {
    t = {};
    let n;
    for (; (n = e.match($i)); )
      (e = e.slice(0, e.length - n[0].length)), (t[n[0].toLowerCase()] = !0);
  }
  return [e[2] === ":" ? e.slice(3) : Pt(e.slice(2)), t];
}
let tn = 0;
const ya = Promise.resolve(),
  ba = () => tn || (ya.then(() => (tn = 0)), (tn = Date.now()));
function Ca(e, t) {
  const s = (n) => {
    if (!n._vts) n._vts = Date.now();
    else if (n._vts <= s.attached) return;
    Ae(Sa(n, s.value), t, 5, [n]);
  };
  return (s.value = e), (s.attached = ba()), s;
}
function Sa(e, t) {
  if (q(t)) {
    const s = e.stopImmediatePropagation;
    return (
      (e.stopImmediatePropagation = () => {
        s.call(e), (e._stopped = !0);
      }),
      t.map((n) => (r) => !r._stopped && n && n(r))
    );
  } else return t;
}
const Mi = (e) =>
    e.charCodeAt(0) === 111 &&
    e.charCodeAt(1) === 110 &&
    e.charCodeAt(2) > 96 &&
    e.charCodeAt(2) < 123,
  Aa = (e, t, s, n, r = !1, i, o, l, a) => {
    t === "class"
      ? ca(e, n, r)
      : t === "style"
      ? da(e, s, n)
      : Ts(t)
      ? Cn(t) || _a(e, t, s, n, o)
      : (
          t[0] === "."
            ? ((t = t.slice(1)), !0)
            : t[0] === "^"
            ? ((t = t.slice(1)), !1)
            : xa(e, t, n, r)
        )
      ? ma(e, t, n, i, o, l, a)
      : (t === "true-value"
          ? (e._trueValue = n)
          : t === "false-value" && (e._falseValue = n),
        ga(e, t, n, r));
  };
function xa(e, t, s, n) {
  if (n)
    return !!(
      t === "innerHTML" ||
      t === "textContent" ||
      (t in e && Mi(t) && R(s))
    );
  if (
    t === "spellcheck" ||
    t === "draggable" ||
    t === "translate" ||
    t === "form" ||
    (t === "list" && e.tagName === "INPUT") ||
    (t === "type" && e.tagName === "TEXTAREA")
  )
    return !1;
  if (t === "width" || t === "height") {
    const r = e.tagName;
    if (r === "IMG" || r === "VIDEO" || r === "CANVAS" || r === "SOURCE")
      return !1;
  }
  return Mi(t) && oe(s) ? !1 : t in e;
}
const jr = new WeakMap(),
  Ur = new WeakMap(),
  xs = Symbol("_moveCb"),
  Oi = Symbol("_enterCb"),
  Kr = {
    name: "TransitionGroup",
    props: ae({}, oa, { tag: String, moveClass: String }),
    setup(e, { slots: t }) {
      const s = qr(),
        n = gr();
      let r, i;
      return (
        yr(() => {
          if (!r.length) return;
          const o = e.moveClass || `${e.name || "v"}-move`;
          if (!$a(r[0].el, s.vnode.el, o)) return;
          r.forEach(Ea), r.forEach(Ta);
          const l = r.filter(ka);
          Br(),
            l.forEach((a) => {
              const c = a.el,
                f = c.style;
              je(c, o),
                (f.transform = f.webkitTransform = f.transitionDuration = "");
              const m = (c[xs] = (p) => {
                (p && p.target !== c) ||
                  ((!p || /transform$/.test(p.propertyName)) &&
                    (c.removeEventListener("transitionend", m),
                    (c[xs] = null),
                    ze(c, o)));
              });
              c.addEventListener("transitionend", m);
            });
        }),
        () => {
          const o = U(e),
            l = Lr(o);
          let a = o.tag || Y;
          (r = i), (i = t.default ? Nn(t.default()) : []);
          for (let c = 0; c < i.length; c++) {
            const f = i[c];
            f.key != null && es(f, Xt(f, l, n, s));
          }
          if (r)
            for (let c = 0; c < r.length; c++) {
              const f = r[c];
              es(f, Xt(f, l, n, s)), jr.set(f, f.el.getBoundingClientRect());
            }
          return le(a, null, i);
        }
      );
    },
  },
  wa = (e) => delete e.mode;
Kr.props;
const Ia = Kr;
function Ea(e) {
  const t = e.el;
  t[xs] && t[xs](), t[Oi] && t[Oi]();
}
function Ta(e) {
  Ur.set(e, e.el.getBoundingClientRect());
}
function ka(e) {
  const t = jr.get(e),
    s = Ur.get(e),
    n = t.left - s.left,
    r = t.top - s.top;
  if (n || r) {
    const i = e.el.style;
    return (
      (i.transform = i.webkitTransform = `translate(${n}px,${r}px)`),
      (i.transitionDuration = "0s"),
      e
    );
  }
}
function $a(e, t, s) {
  const n = e.cloneNode(),
    r = e[Ot];
  r &&
    r.forEach((l) => {
      l.split(/\s+/).forEach((a) => a && n.classList.remove(a));
    }),
    s.split(/\s+/).forEach((l) => l && n.classList.add(l)),
    (n.style.display = "none");
  const i = t.nodeType === 1 ? t : t.parentNode;
  i.appendChild(n);
  const { hasTransform: o } = Dr(n);
  return i.removeChild(n), o;
}
const ws = (e) => {
  const t = e.props["onUpdate:modelValue"] || !1;
  return q(t) ? (s) => ms(t, s) : t;
};
function Ma(e) {
  e.target.composing = !0;
}
function qi(e) {
  const t = e.target;
  t.composing && ((t.composing = !1), t.dispatchEvent(new Event("input")));
}
const kt = Symbol("_assign"),
  ns = {
    created(e, { modifiers: { lazy: t, trim: s, number: n } }, r) {
      e[kt] = ws(r);
      const i = n || (r.props && r.props.type === "number");
      dt(e, t ? "change" : "input", (o) => {
        if (o.target.composing) return;
        let l = e.value;
        s && (l = l.trim()), i && (l = ys(l)), e[kt](l);
      }),
        s &&
          dt(e, "change", () => {
            e.value = e.value.trim();
          }),
        t ||
          (dt(e, "compositionstart", Ma),
          dt(e, "compositionend", qi),
          dt(e, "change", qi));
    },
    mounted(e, { value: t }) {
      e.value = t ?? "";
    },
    beforeUpdate(
      e,
      { value: t, modifiers: { lazy: s, trim: n, number: r } },
      i
    ) {
      if (((e[kt] = ws(i)), e.composing)) return;
      const o = r || e.type === "number" ? ys(e.value) : e.value,
        l = t ?? "";
      o !== l &&
        ((document.activeElement === e &&
          e.type !== "range" &&
          (s || (n && e.value.trim() === l))) ||
          (e.value = l));
    },
  },
  Oa = {
    deep: !0,
    created(e, { value: t, modifiers: { number: s } }, n) {
      const r = ks(t);
      dt(e, "change", () => {
        const i = Array.prototype.filter
          .call(e.options, (o) => o.selected)
          .map((o) => (s ? ys(Is(o)) : Is(o)));
        e[kt](e.multiple ? (r ? new Set(i) : i) : i[0]);
      }),
        (e[kt] = ws(n));
    },
    mounted(e, { value: t }) {
      Pi(e, t);
    },
    beforeUpdate(e, t, s) {
      e[kt] = ws(s);
    },
    updated(e, { value: t }) {
      Pi(e, t);
    },
  };
function Pi(e, t) {
  const s = e.multiple;
  if (!(s && !q(t) && !ks(t))) {
    for (let n = 0, r = e.options.length; n < r; n++) {
      const i = e.options[n],
        o = Is(i);
      if (s) q(t) ? (i.selected = po(t, o) > -1) : (i.selected = t.has(o));
      else if (Os(Is(i), t)) {
        e.selectedIndex !== n && (e.selectedIndex = n);
        return;
      }
    }
    !s && e.selectedIndex !== -1 && (e.selectedIndex = -1);
  }
}
function Is(e) {
  return "_value" in e ? e._value : e.value;
}
const qa = ["ctrl", "shift", "alt", "meta"],
  Pa = {
    stop: (e) => e.stopPropagation(),
    prevent: (e) => e.preventDefault(),
    self: (e) => e.target !== e.currentTarget,
    ctrl: (e) => !e.ctrlKey,
    shift: (e) => !e.shiftKey,
    alt: (e) => !e.altKey,
    meta: (e) => !e.metaKey,
    left: (e) => "button" in e && e.button !== 0,
    middle: (e) => "button" in e && e.button !== 1,
    right: (e) => "button" in e && e.button !== 2,
    exact: (e, t) => qa.some((s) => e[`${s}Key`] && !t.includes(s)),
  },
  qt = (e, t) => {
    const s = e._withMods || (e._withMods = {}),
      n = t.join(".");
    return (
      s[n] ||
      (s[n] = (r, ...i) => {
        for (let o = 0; o < t.length; o++) {
          const l = Pa[t[o]];
          if (l && l(r, t)) return;
        }
        return e(r, ...i);
      })
    );
  },
  Na = ae({ patchProp: Aa }, ra);
let Ni;
function Fa() {
  return Ni || (Ni = Nl(Na));
}
const Ra = (...e) => {
  const t = Fa().createApp(...e),
    { mount: s } = t;
  return (
    (t.mount = (n) => {
      const r = La(n);
      if (!r) return;
      const i = t._component;
      !R(i) && !i.render && !i.template && (i.template = r.innerHTML),
        (r.innerHTML = "");
      const o = s(r, !1, r instanceof SVGElement);
      return (
        r instanceof Element &&
          (r.removeAttribute("v-cloak"), r.setAttribute("data-v-app", "")),
        o
      );
    }),
    t
  );
};
function La(e) {
  return oe(e) ? document.querySelector(e) : e;
}
const Je = (e, t) => {
    const s = e.__vccOpts || e;
    for (const [n, r] of t) s[n] = r;
    return s;
  },
  Da = {
    props: {
      maxPerPage: { type: Number, default: 10 },
      totalResults: { type: Number, default: 109 },
    },
    data: () => ({ currentPage: 1, showLoader: !1 }),
    computed: {
      pageCount() {
        return Math.ceil(this.totalResults / this.maxPerPage);
      },
      pageOffset() {
        return this.maxPerPage * this.currentPage;
      },
    },
    methods: {
      reset() {
        this.currentPage = 1;
      },
      goTop() {
        const e = this.$refs.testt;
        e && e.scroll({ top: 0, behavior: "smooth" });
      },
      getObserver(e) {
        return new IntersectionObserver(() => {}, {});
      },
      scrollTriggerBottom() {
        new IntersectionObserver((t) => {
          t.forEach((s) => {
            s.intersectionRatio > 0 &&
              this.currentPage < this.pageCount &&
              ((this.currentPage += 1), this.$emit("load-more"));
          });
        }).observe(this.$refs.scrollTriggerBottom);
      },
      scrollTriggerTop() {
        let e = { rootMargin: "80px" };
        new IntersectionObserver((s) => {
          s.forEach((n) => {
            n.intersectionRatio > 0 &&
              this.currentPage > 0 &&
              (this.currentPage -= 1);
          });
        }, e).observe(this.$refs.scrollTriggerTop);
      },
    },
    beforeDestroy() {
      const e = this.getObserver(this.$refs.scrollTriggerBottom),
        t = this.getObserver(this.$refs.scrollTriggerTop);
      e.disconnect(), t.disconnect();
    },
    mounted() {
      this.scrollTriggerBottom();
    },
  },
  Ba = { class: "scroll-container", ref: "testt" },
  ja = { id: "scroll-trigger-top", ref: "scrollTriggerTop" },
  Ua = { id: "scroll-trigger-bottom", ref: "scrollTriggerBottom" };
function Ka(e, t, s, n, r, i) {
  return (
    A(),
    w(
      "div",
      Ba,
      [
        h("div", ja, null, 512),
        bl(e.$slots, "default", { pageOffset: i.pageOffset }, void 0, !0),
        h("div", Ua, null, 512),
      ],
      512
    )
  );
}
const Ks = Je(Da, [
    ["render", Ka],
    ["__scopeId", "data-v-7dd0b705"],
  ]),
  _n =
    "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADMAAAAyCAYAAADx/eOPAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAn6SURBVHgBxVpfiJ1HFT9n7u29qQ+SGFNTW2T37lL/vMT0RRREGlR8KNlssIgo2a3WIFWxIoIKJqUW1ApNxVJs1XZLVUIh+7eKPvkkvib4ouDu3oj46gbawjb3m9Nz5szMN/N937177+ZPT8h+/2Znzm/OOb85c2YBxpAZWvvuNK1/Ft4BmS7WlqZobWGctrhXgx6tfZsAPgcEXbTwu6323Itwm0SAoMEzQIQWYbGPcy+Pam9GfezR+qNIcIKB+Nb01enB2tfgNogDgrAgQHRo2NNCQ8Gwa50laz+Vv0VAA2d7tPF1uIXCYy/xUGfCM88lEf/cC1AjmFna+ApZ+KR8tdIJz41Rh3Sd8ttHp4uVb8ItEO53iQdZ4OGQbULlF3T3owDVwMzQxpnCFp8g95E/o3ZitVvkuEG9wW9JPMFNFLEIolkIkcwj61gynHOLEtBMA6AMDMfIF8kWH5PfMgaJrMwNBx8lDeXG+zERfWeamQ5uggSLuAeqfxdXC+P655qF4kdW6iEG8XFu1mEQB1jrjjHQZTfrOiZD6HBn/B663FEH9drlLrqM+kK/Nf8U7EOmaOUgW/sZZxGnEWZKZ2BU4eybtcxybWU5N+Ezg9V5BnK/5S/OgbSZ+2fE1Jh3gt6BWQGxPxk0358u1n8I+wFC+NcIxGlN6BT3LhXHRKwBcQBMaSGcemv5mGmZ09ZAx1jTBWO7HPx8NR0GxFbBrgGxCHZ4yrrcpVoDbIe7ZqvIM1uNrWTI/myzNf9jmAQI4Ee9to0WSUXIBz0eAZyCs7t22vQ7p6/wBF9uO76yIeDEMOm8xEcrkSKk5mLSuLaokcq6tc7N0trjMAYQJpcSiNMuiwfXISXBo25WWivzFFlQ75zvOzfbxFMrRVH8jXXTxgZixPMrdmn+4WnS6BTmg5D3THSsd743AlCwCE/HsfR9iAnp3ilKEK2gjk/Y5GYCZBOTmBHZbs9vWGj/xT3YlObS30dnGd8pg7DxM8U1yN00WkiBqEV83FFQNlKvdF9RWV0KKyBQ/CgCycCI9PFBBoN/ch0ILTs+8Cb3ho9A8rWAtCXFdaFqoehaiMe8NhQAWPFcnYUYEDkavxQkxFAA1XK1xoCbGizPIbY+z1TGdAwHuIOOo2ehaaVjF/w8CBMBdkuadkTQcm7hWYlVfYLJ5Zks2NPZ9UBwiC6uD9+ft9w1i/aBPs5frrYdyh48q6f5N7/g2IwVtx6MrDE8wweEzQSAsBtrzGCRQcv6g60wsMunJGkg2+cXUymIYAxVuGSpahuX0qhnS9Ds8HJxogmIyNBEcwvnlqGgS3LPs4fGY3cEIE6ELk/Qt7zSOFaj0tXkKs+qNE6RV1BBVh3JsxSW4ErXc+uZdHptFJCRYESYFF5lur3oY9WTpVfFRXwgbPIEkC90PrrjnDv9xP2IMv8PLhYZBDSe4loirjVodq2xwYgwKVzknOEP2jfGgVRNL9iUTZUaDvmGYfKxZHZMnxULu5YA6YwGMhYYEbbQKwXCy94kbrEUR6aQclBC0JnGzeQUlfazTxXA5TqGfQ724+MAGRuMiNAgR47bMoujSMRgyKPcy3JRi6p5v0HImSZV3XgzZG7n/JX6pKzVhzFlbDAi23jyt9bSCz7Ivb9j6hpG7xuWiuSaAQtWcT3GlIaB0ERA4uCTSL89/wKT2Y+iAqV0IQkT4/Of0CRcw/u660WX7NsJLRJkYjAim+35VR77By7dBNviy7sZQatUrLzWF3Nqdjm1ysSulQrCDcgsrT/C9Pwcq9fWrmxtIQ/WiVbS1byuCOJOAcXx/QIR2ZdlRGbp0r28dC4yKbyubxKnKkm7ZqU6c0U5yNuQRbgB2ReY+2jjHqI7XuF08l5WbpdfvZHNdhrU4RXkr1JILnXhfwVn270x9kPDZGIwH6TV9w+oeJEHvwcoKnedb3ahmgGkhaL0PeSu51OesI85v19AE4H5MF26+zrh8zyVd0PcDYLPANwerrI/zQWHXJ2E7YPy+vlesfI4TChjg5miPx7dpfazfHu0VCB1m3ospGtLevX3DQlnuu6YiQGNBYbLUO8zUDzNk3bUj6iLOgKUCuVEXF31IXl2O0v+b/QmbpdrAwugCVxuTzAChHecT/GMHQ1ZbJqIuQxANwRDUsqEySDfy2j9IBYUPRGUFtMrnpsqVi/AjYKZoeW7eGPxJNem7jLauyaG6FMyUgePSb0CqruP3wYgJJZ0eV3cUORZNJT1Aack4mMztP4S7BfMLL16xELrHPd0RKK6jGwt2ap9/JY3KZx4y1VWTtoJbhT2MrqlhsaKS9aPTJ1urxd6xWhAjWDuo/X3WtvhCiUdCf6RVGt05inGjBsS6wWU0HxJ0nhueRUawFat2AQukoIBBrT60thgPkTLhwvA75GBwyZ8xmCZsHcMpSYfQBSy9rwiyTO6tIWnHpYUhbe8D4DkXolbpRWaGgAoLRhilbT2uDjM5TIwH6E/v+e6bT3G3Rx2GzAuN5mMpBomP0QxhZ1uaEpLm3jy4fAogDoogOhqDPBYYUpX17CVxmjFdDMnV3W5uoUimA/Qa4d27e43uCx0iE/MpPDFdQrd5UtV02AyX6FuHsscmKP0FqkO9k8GJPsUAZQWwjHJ5dKYCuCyNQw9QSDWAJkApG3tWS6sHRLfR1NpwNURG5wD0jTExhFiMcMBOVkDEqTvAclOMgUQqjZVa+gOtp7kefdcTEnBSKWxbQeLrPXB2N6q64TOrGcBz1c+/rPM0nOAfWIUkBRQx8eQi5tQ5IOEEDDQPA1ZUL3FDC32fAyx95gHOdAPytlMMIizjDHlMaA6VVggUiZK8Ty5PeZxhoi4nPUxlJZ1NfD8ahZWqCpQ90BJU1qQMxoG864Na+yOqC0AnFj94f6VPqXd2UADGFMBLsH+dKs19xOYUDILBXEM533AZwTxU0rb3qLynRfVNSm4mC38zLUBvLHEgf8m18dQy0i6sqDFOn0pvcVjDR7555v7PAIU8RY6zv1pOSk9pyGK2UCe4vh22vYK71CdaztT/Ae/9H+uRvwGBJCaRZZc16k7BiQtRGiga0lIUDL2C9s49zTcoLCFdjwpXM4UTqTKfB7gtq8Z7EQwIv/CU/97C+CisBKaxJ5ef0sxE/aJIfyy35r7BdwkSQGFmnQKRDNBv/YooKu062rPO6Fdtmj+F0/9ozUofu+RCyMzJdssAfHz8tx2a+5ZuMkSAHH/VyAtMEKZiEpBnf+rRe7Mix+1dObfd5z+O/ewLvdy+MwnyeAzZl0wLTzPC+Kv4BaJAJLUh8dajV6Qe52Uo040VXFwWKfp+QzISbIcKN32v2paWTKmtZCkOzvDDppEcGRntPyQodaX2UAd5rlfX5Uzm9ssAoj93f1REFvk/r2ONUbK7GD9kR699ml4B0X+pmacP6B7G4IQjDleKegMAAAAAElFTkSuQmCC",
  Va = {
    name: "Apps",
    components: { InfiniteScroll: Ks },
    props: {
      filteredResult: { type: Array, required: !0 },
      getCategories: { type: Array, required: !0 },
      handleMiddleClick: { type: Function, required: !0 },
      removeAnimShortcut: { type: Function, required: !0 },
      addFavorite: { type: Function, required: !0 },
      sendAnimationInvite: { type: Function, required: !0 },
      onAnimClicked: { type: Function, required: !0 },
      hasFavorite: { type: Function, required: !0 },
      getCount: { type: Function, required: !0 },
      getGifAnim: { type: Function, required: !0 },
      handleImageError: { type: Function, required: !0 },
      getCategories: { type: Array, required: !0 },
    },
    data() {
      return { pageMounted: !1, inputMode: !0 };
    },
    async mounted() {
      setTimeout(() => {
        this.pageMounted = !0;
      }, 10),
        this.$nextTick(() => {
          setTimeout(() => {
            this.makeItemsDraggable();
          }, 500);
        }),
        this.handleVisibility();
    },
    watch: {
      "$store.state.searchText": function () {
        this.$nextTick(() => {
          this.makeItemsDraggable();
        });
      },
      "$store.state.settings.show_gif": function () {
        this.$nextTick(() => {
          this.makeItemsDraggable();
        });
      },
    },
    computed: {
      getShortcutAnims() {
        return this.$store.state.shortcuts;
      },
    },
    methods: {
      setSettingsState(e) {
        this.$store.state.settingsState = e;
      },
      handleVisibility() {
        this.$nextTick(() => {
          const e = function (n, r) {
              n.forEach((i) => {
                const o = i.target;
                i.isIntersecting &&
                  o.alt &&
                  !o.src.includes(o.alt) &&
                  ((o.src = o.alt),
                  (o.onload = () => {
                    (o.style.opacity = 1),
                      (o.style.transition = "opacity 0.5s ease-in-out");
                  }));
              });
            },
            t = this.$el.querySelectorAll(".texts .animation-webp"),
            s = new IntersectionObserver(e, {
              root: null,
              rootMargin: "50px",
              threshold: 0.1,
            });
          t.forEach((n) => s.observe(n));
        });
      },
      handleClick() {
        this.inputMode &&
          ((this.inputMode = !1),
          $.post(
            "https://nxo-emotemenu/toggleKeepInput",
            JSON.stringify({ toggle: !1 })
          ));
      },
      handleBlur() {
        this.inputMode ||
          ((this.inputMode = !0),
          $.post(
            "https://nxo-emotemenu/toggleKeepInput",
            JSON.stringify({ toggle: !0 })
          ));
      },
      getLocation() {
        return { opacity: this.$store.state.active ? "1.0" : "0.0" };
      },
      loadMore() {
        this.makeItemsDraggable();
      },
      makeItemsDraggable() {
        var e = this;
        $(document).ready(function () {
          $(".animation-button").draggable({
            appendTo: "body",
            cursor: "grab",
            scroll: !0,
            revertDuration: 0,
            start: function () {
              $(this).addClass("dragging");
              var t = $(this).index();
              e.$data.originalIndex = t;
            },
            stop: function () {
              $(this).removeClass("dragging");
            },
            helper: function () {
              return $(this)
                .clone()
                .appendTo("body")
                .css({
                  zIndex: 2,
                  width: $(this).width(),
                  height: $(this).height(),
                });
            },
          }),
            $(".shortcut-button").droppable({
              accept: ".animation-button",
              over: function (t, s) {
                $(this).addClass("active");
              },
              out: function (t, s) {
                $(this).removeClass("active");
              },
              drop: function (t, s) {
                var n = $(this);
                if (n.hasClass("shortcut-button")) {
                  var r = e.$data.originalIndex,
                    i = n.index(),
                    o = e.filteredResult[r - 1];
                  if (o != -1) {
                    var l = JSON.parse(localStorage.getItem("shortcutAnims"));
                    (o = { ...o, index: r }),
                      (l[i] = o),
                      localStorage.setItem("shortcutAnims", JSON.stringify(l)),
                      (e.$store.state.shortcuts = l),
                      $.post(
                        "https://nxo-emotemenu/getShortcuts",
                        JSON.stringify({ shortcuts: l })
                      ),
                      e.makeItemsDraggable(),
                      n.hasClass("active") == !0 && n.removeClass("active");
                  }
                }
              },
            });
        }),
          this.handleVisibility();
      },
      onChangeCategory(e) {
        (this.$store.state.selectedCategory = e),
          this.$nextTick(() => {
            this.makeItemsDraggable();
          });
      },
    },
  },
  Dt = (e) => (qn("data-v-aa99b63d"), (e = e()), Pn(), e),
  Ha = { class: "inner-container" },
  Ga = { class: "header" },
  Ja = { class: "texts" },
  Wa = Dt(() => h("p", null, "NexOne Animation Menu", -1)),
  Qa = { class: "header-right" },
  za = { class: "search-container" },
  Za = Dt(() => h("i", { class: "fa fa-search" }, null, -1)),
  Ya = ["placeholder"],
  Xa = { class: "change-mode-container" },
  ec = Dt(() => h("i", { class: "fas fa-cog" }, null, -1)),
  tc = [ec],
  sc = { class: "center-container" },
  nc = { class: "category-container" },
  ic = ["onClick"],
  rc = { class: "texts" },
  oc = { class: "column" },
  lc = ["onClick", "onContextmenu", "onMousedown"],
  ac = { class: "animation-button-inner" },
  cc = { class: "top" },
  uc = ["onClick"],
  fc = Dt(() => h("i", { class: "fas fa-star" }, null, -1)),
  dc = [fc],
  hc = { class: "animation-name-container" },
  gc = { key: 0 },
  mc = { key: 1 },
  pc = { class: "texts" },
  _c = { key: 0, class: "fas fa-running" },
  vc = ["alt"],
  yc = { style: { "margin-top": "auto" } },
  bc = { key: 0, class: "shared-icon" },
  Cc = Dt(() => h("i", { class: "fa-solid fa-user-group" }, null, -1)),
  Sc = [Cc],
  Ac = { class: "shortcut-header" },
  xc = Dt(() => h("div", { class: "line" }, null, -1)),
  wc = { class: "shortcut-container" },
  Ic = ["onClick", "onContextmenu", "onMousedown"],
  Ec = { key: 0, class: "shortcut-button-inner" },
  Tc = { class: "texts" },
  kc = { key: 0, class: "fas fa-running" },
  $c = ["alt"],
  Mc = { style: { "margin-top": "auto" } },
  Oc = { key: 1, class: "key-button" };
function qc(e, t, s, n, r, i) {
  const o = Ve("infinite-scroll");
  return (
    A(),
    w(
      "div",
      { class: "container", style: Nt(i.getLocation()) },
      [
        h("div", Ha, [
          h("div", Ga, [
            h("div", Ja, [
              Wa,
              h("p", null, T(e.$store.state.locales.description), 1),
            ]),
            h("div", Qa, [
              h("div", za, [
                Za,
                Tt(
                  h(
                    "input",
                    {
                      type: "text",
                      placeholder: e.$store.state.locales.search_placeholder,
                      name: "search",
                      "onUpdate:modelValue":
                        t[0] || (t[0] = (l) => (e.$store.state.searchText = l)),
                      onClick:
                        t[1] ||
                        (t[1] = (...l) => i.handleClick && i.handleClick(...l)),
                      onBlur:
                        t[2] ||
                        (t[2] = (...l) => i.handleBlur && i.handleBlur(...l)),
                      onInput:
                        t[3] ||
                        (t[3] = (...l) => i.handleClick && i.handleClick(...l)),
                      onFocus:
                        t[4] ||
                        (t[4] = (...l) => i.handleClick && i.handleClick(...l)),
                    },
                    null,
                    40,
                    Ya
                  ),
                  [[ns, e.$store.state.searchText]]
                ),
              ]),
              h("div", Xa, [
                h(
                  "div",
                  {
                    class: "change-mode",
                    onClick: t[5] || (t[5] = (l) => i.setSettingsState(!0)),
                  },
                  tc
                ),
              ]),
            ]),
          ]),
          h("div", sc, [
            h("div", nc, [
              (A(!0),
              w(
                Y,
                null,
                Me(
                  s.getCategories,
                  (l) => (
                    A(),
                    w("div", { class: "category-button", key: l.id }, [
                      h(
                        "div",
                        {
                          class: ue([
                            "category-button-inner",
                            { active: e.$store.state.selectedCategory == l.id },
                          ]),
                          onClick: (a) => i.onChangeCategory(l.id),
                        },
                        [
                          h("i", { class: ue(l.icon) }, null, 2),
                          h("div", rc, [
                            h("p", null, T(l.label), 1),
                            h(
                              "p",
                              null,
                              T(s.getCount(l.id)) +
                                " " +
                                T(e.$store.state.locales.animations),
                              1
                            ),
                          ]),
                        ],
                        10,
                        ic
                      ),
                    ])
                  )
                ),
                128
              )),
            ]),
            h("div", oc, [
              r.pageMounted
                ? (A(),
                  He(
                    o,
                    {
                      ref: "infinityScroll",
                      onLoadMore: i.loadMore,
                      class: "animation-container",
                      maxPerPage: 18,
                      totalResults: s.filteredResult.length,
                      key: s.filteredResult.length,
                    },
                    {
                      default: Lt((l) => [
                        (A(!0),
                        w(
                          Y,
                          null,
                          Me(
                            s.filteredResult.filter((a, c) => c < l.pageOffset),
                            (a) => (
                              A(),
                              w(
                                "div",
                                {
                                  ref_for: !0,
                                  ref: "animButton",
                                  onClick: (c) => s.onAnimClicked(a, c),
                                  onContextmenu: qt(
                                    (c) => s.sendAnimationInvite(a, c),
                                    ["right"]
                                  ),
                                  onMousedown: (c) => s.handleMiddleClick(a, c),
                                  class: "animation-button",
                                  key: a.id,
                                },
                                [
                                  h("div", ac, [
                                    h("div", cc, [
                                      a.category != "sequences"
                                        ? (A(),
                                          w(
                                            "div",
                                            {
                                              key: 0,
                                              class: ue([
                                                "star",
                                                s.hasFavorite(a.id),
                                              ]),
                                              onClick: (c) =>
                                                s.addFavorite(a.id, c),
                                            },
                                            dc,
                                            10,
                                            uc
                                          ))
                                        : z("", !0),
                                      h("div", hc, [
                                        a.category == "sequences"
                                          ? (A(),
                                            w(
                                              "p",
                                              gc,
                                              T(
                                                e.$store.state.locales
                                                  .sequence_command
                                              ) +
                                                " " +
                                                T(a.id),
                                              1
                                            ))
                                          : (A(),
                                            w("p", mc, "/e " + T(a.id), 1)),
                                      ]),
                                    ]),
                                    h("div", pc, [
                                      e.$store.state.settings.show_gif == !1
                                        ? (A(), w("i", _c))
                                        : (A(),
                                          w(
                                            "img",
                                            {
                                              key: 1,
                                              class: "animation-webp",
                                              loading: "lazy",
                                              src: _n,
                                              alt: s.getGifAnim(a),
                                              onError:
                                                t[6] ||
                                                (t[6] = (...c) =>
                                                  s.handleImageError &&
                                                  s.handleImageError(...c)),
                                            },
                                            null,
                                            40,
                                            vc
                                          )),
                                    ]),
                                    h("p", yc, T(a.label), 1),
                                    a.targetAnim
                                      ? (A(), w("div", bc, Sc))
                                      : z("", !0),
                                  ]),
                                ],
                                40,
                                lc
                              )
                            )
                          ),
                          128
                        )),
                      ]),
                      _: 1,
                    },
                    8,
                    ["onLoadMore", "totalResults"]
                  ))
                : z("", !0),
              h("div", Ac, [
                h("p", null, T(e.$store.state.locales.quick_animations), 1),
                xc,
              ]),
              h("div", wc, [
                (A(!0),
                w(
                  Y,
                  null,
                  Me(
                    i.getShortcutAnims,
                    (l, a) => (
                      A(),
                      w(
                        "div",
                        {
                          class: "shortcut-button",
                          key: a,
                          onClick: (c) => s.removeAnimShortcut(a),
                          onContextmenu: qt(
                            (c) => s.sendAnimationInvite(l, c),
                            ["right"]
                          ),
                          onMousedown: (c) => s.handleMiddleClick(l, c),
                        },
                        [
                          l
                            ? (A(),
                              w("div", Ec, [
                                h("div", Tc, [
                                  e.$store.state.settings.show_gif == !1
                                    ? (A(), w("i", kc))
                                    : (A(),
                                      w(
                                        "img",
                                        {
                                          key: 1,
                                          class: "animation-webp",
                                          loading: "lazy",
                                          src: _n,
                                          alt: s.getGifAnim(l),
                                          onError:
                                            t[7] ||
                                            (t[7] = (...c) =>
                                              s.handleImageError &&
                                              s.handleImageError(...c)),
                                        },
                                        null,
                                        40,
                                        $c
                                      )),
                                ]),
                                h("p", Mc, T(l.label), 1),
                              ]))
                            : z("", !0),
                          l
                            ? (A(),
                              w("div", Oc, [
                                h("p", null, "SHIFT + NUM" + T(a + 1), 1),
                              ]))
                            : z("", !0),
                        ],
                        40,
                        Ic
                      )
                    )
                  ),
                  128
                )),
              ]),
            ]),
          ]),
        ]),
      ],
      4
    )
  );
}
const Pc = Je(Va, [
    ["render", qc],
    ["__scopeId", "data-v-aa99b63d"],
  ]),
  Nc = {
    name: "Apps",
    components: { InfiniteScroll: Ks },
    data() {
      return { pageMounted: !1, inputMode: !0 };
    },
    props: {
      filteredResult: { type: Array, required: !0 },
      getCategories: { type: Array, required: !0 },
      handleMiddleClick: { type: Function, required: !0 },
      removeAnimShortcut: { type: Function, required: !0 },
      addFavorite: { type: Function, required: !0 },
      sendAnimationInvite: { type: Function, required: !0 },
      onAnimClicked: { type: Function, required: !0 },
      hasFavorite: { type: Function, required: !0 },
      getCount: { type: Function, required: !0 },
      getGifAnim: { type: Function, required: !0 },
      handleImageError: { type: Function, required: !0 },
      getCategories: { type: Array, required: !0 },
    },
    async mounted() {
      setTimeout(() => {
        this.pageMounted = !0;
      }, 10),
        this.$nextTick(() => {
          setTimeout(() => {
            this.makeItemsDraggable();
          }, 500);
        }),
        this.handleVisibility();
    },
    watch: {
      "$store.state.searchText": function () {
        this.$nextTick(() => {
          this.makeItemsDraggable();
        });
      },
      "$store.state.settings.show_gif": function () {
        this.$nextTick(() => {
          this.makeItemsDraggable();
        });
      },
    },
    computed: {
      getShortcutAnims() {
        var e = this.$store.state.shortcuts,
          t = [];
        for (let s = 0; s < 4; s++) t[s] = e[s];
        return t;
      },
    },
    methods: {
      setSettingsState(e) {
        this.$store.state.settingsState = e;
      },
      loadMore() {
        this.makeItemsDraggable();
      },
      handleVisibility() {
        this.$nextTick(() => {
          const e = function (n, r) {
              n.forEach((i) => {
                const o = i.target;
                i.isIntersecting &&
                  o.alt &&
                  !o.src.includes(o.alt) &&
                  ((o.src = o.alt),
                  (o.onload = () => {
                    (o.style.opacity = 1),
                      (o.style.transition = "opacity 0.5s ease-in-out");
                  }));
              });
            },
            t = this.$el.querySelectorAll(".texts .animation-webp"),
            s = new IntersectionObserver(e, {
              root: null,
              rootMargin: "50px",
              threshold: 0.1,
            });
          t.forEach((n) => s.observe(n));
        });
      },
      handleClick() {
        this.inputMode &&
          ((this.inputMode = !1),
          $.post(
            "https://nxo-emotemenu/toggleKeepInput",
            JSON.stringify({ toggle: !1 })
          ));
      },
      handleBlur() {
        this.inputMode ||
          ((this.inputMode = !0),
          $.post(
            "https://nxo-emotemenu/toggleKeepInput",
            JSON.stringify({ toggle: !0 })
          ));
      },
      getLocation() {
        return { opacity: this.$store.state.active ? "1.0" : "0.0" };
      },
      makeItemsDraggable() {
        var e = this;
        $(document).ready(function () {
          $(".animation-button").draggable({
            appendTo: "body",
            cursor: "grab",
            scroll: !0,
            revertDuration: 0,
            start: function () {
              $(this).addClass("dragging");
              var t = $(this).index();
              e.$data.originalIndex = t;
            },
            stop: function () {
              $(this).removeClass("dragging");
            },
            helper: function () {
              return $(this)
                .clone()
                .appendTo("body")
                .css({
                  zIndex: 2,
                  width: $(this).width(),
                  height: $(this).height(),
                });
            },
          }),
            $(".shortcut-button").droppable({
              accept: ".animation-button",
              over: function (t, s) {
                $(this).addClass("active");
              },
              out: function (t, s) {
                $(this).removeClass("active");
              },
              drop: function (t, s) {
                var n = $(this);
                if (n.hasClass("shortcut-button")) {
                  var r = e.$data.originalIndex,
                    i = n.index(),
                    o = e.filteredResult[r - 1];
                  if (o != -1) {
                    var l = JSON.parse(localStorage.getItem("shortcutAnims"));
                    (o = { ...o, index: r }),
                      (l[i] = o),
                      localStorage.setItem("shortcutAnims", JSON.stringify(l)),
                      (e.$store.state.shortcuts = l),
                      $.post(
                        "https://nxo-emotemenu/getShortcuts",
                        JSON.stringify({ shortcuts: l })
                      ),
                      e.makeItemsDraggable(),
                      n.hasClass("active") == !0 && n.removeClass("active");
                  }
                }
              },
            });
        }),
          this.handleVisibility();
      },
      onChangeCategory(e) {
        (this.$store.state.selectedCategory = e),
          this.$nextTick(() => {
            this.makeItemsDraggable();
          });
      },
    },
  },
  pt = (e) => (qn("data-v-e679f283"), (e = e()), Pn(), e),
  Fc = { class: "inner-container" },
  Rc = { class: "header" },
  Lc = { class: "texts" },
  Dc = pt(() => h("p", null, "Cylex Animation Menu", -1)),
  Bc = { class: "header-right" },
  jc = { class: "search-container" },
  Uc = pt(() => h("i", { class: "fa fa-search" }, null, -1)),
  Kc = ["placeholder"],
  Vc = { class: "change-mode-container" },
  Hc = pt(() => h("i", { class: "fas fa-cog" }, null, -1)),
  Gc = [Hc],
  Jc = { class: "center-container" },
  Wc = { class: "category-container" },
  Qc = ["onClick"],
  zc = { class: "texts" },
  Zc = { class: "column" },
  Yc = ["onClick", "onContextmenu", "onMousedown"],
  Xc = { class: "animation-button-inner" },
  eu = { class: "top" },
  tu = ["onClick"],
  su = pt(() => h("i", { class: "fas fa-star" }, null, -1)),
  nu = [su],
  iu = { class: "animation-name-container" },
  ru = { key: 0 },
  ou = { key: 1 },
  lu = { class: "texts" },
  au = { key: 0, class: "fas fa-running" },
  cu = ["alt"],
  uu = { style: { "margin-top": "auto" } },
  fu = { key: 0, class: "shared-icon" },
  du = pt(() => h("i", { class: "fa-solid fa-user-group" }, null, -1)),
  hu = [du],
  gu = { class: "mini-category-container" },
  mu = { class: "shortcut-header" },
  pu = pt(() => h("div", { class: "line" }, null, -1)),
  _u = { class: "shortcut-container" },
  vu = ["onClick", "onContextmenu", "onMousedown"],
  yu = { key: 0, class: "shortcut-button-inner" },
  bu = { class: "texts" },
  Cu = { key: 0, class: "fas fa-running" },
  Su = ["src"],
  Au = { style: { "margin-top": "auto" } },
  xu = { key: 0, class: "shared-icon" },
  wu = pt(() => h("i", { class: "fa-solid fa-user-group" }, null, -1)),
  Iu = [wu],
  Eu = { key: 1, class: "key-button" };
function Tu(e, t, s, n, r, i) {
  const o = Ve("infinite-scroll");
  return (
    A(),
    w(
      "div",
      { class: "container", style: Nt(i.getLocation()) },
      [
        h("div", Fc, [
          h("div", Rc, [
            h("div", Lc, [
              Dc,
              h("p", null, T(e.$store.state.locales.description), 1),
            ]),
            h("div", Bc, [
              h("div", jc, [
                Uc,
                Tt(
                  h(
                    "input",
                    {
                      type: "text",
                      placeholder: e.$store.state.locales.search_placeholder,
                      name: "search",
                      "onUpdate:modelValue":
                        t[0] || (t[0] = (l) => (e.$store.state.searchText = l)),
                      onClick:
                        t[1] ||
                        (t[1] = (...l) => i.handleClick && i.handleClick(...l)),
                      onBlur:
                        t[2] ||
                        (t[2] = (...l) => i.handleBlur && i.handleBlur(...l)),
                      onInput:
                        t[3] ||
                        (t[3] = (...l) => i.handleClick && i.handleClick(...l)),
                      onFocus:
                        t[4] ||
                        (t[4] = (...l) => i.handleClick && i.handleClick(...l)),
                    },
                    null,
                    40,
                    Kc
                  ),
                  [[ns, e.$store.state.searchText]]
                ),
              ]),
              h("div", Vc, [
                h(
                  "div",
                  {
                    class: "change-mode",
                    onClick: t[5] || (t[5] = (l) => i.setSettingsState(!0)),
                  },
                  Gc
                ),
              ]),
            ]),
          ]),
          h("div", Jc, [
            h("div", Wc, [
              (A(!0),
              w(
                Y,
                null,
                Me(
                  s.getCategories,
                  (l) => (
                    A(),
                    w("div", { class: "category-button", key: l.id }, [
                      h(
                        "div",
                        {
                          class: ue([
                            "category-button-inner",
                            { active: e.$store.state.selectedCategory == l.id },
                          ]),
                          onClick: (a) => i.onChangeCategory(l.id),
                        },
                        [
                          h("i", { class: ue(l.icon) }, null, 2),
                          h("div", zc, [
                            h("p", null, T(l.label), 1),
                            h(
                              "p",
                              null,
                              T(s.getCount(l.id)) +
                                " " +
                                T(e.$store.state.locales.animations),
                              1
                            ),
                          ]),
                        ],
                        10,
                        Qc
                      ),
                    ])
                  )
                ),
                128
              )),
            ]),
            h("div", Zc, [
              r.pageMounted
                ? (A(),
                  He(
                    o,
                    {
                      ref: "infinityScroll",
                      onLoadMore: i.loadMore,
                      class: "animation-container",
                      maxPerPage: 18,
                      totalResults: s.filteredResult.length,
                      key: s.filteredResult.length,
                    },
                    {
                      default: Lt((l) => [
                        (A(!0),
                        w(
                          Y,
                          null,
                          Me(
                            s.filteredResult.filter((a, c) => c < l.pageOffset),
                            (a, c) => (
                              A(),
                              w(
                                "div",
                                {
                                  ref_for: !0,
                                  ref: "animButton",
                                  onClick: (f) => s.onAnimClicked(a, f),
                                  onContextmenu: qt(
                                    (f) => s.sendAnimationInvite(a, f),
                                    ["right"]
                                  ),
                                  onMousedown: (f) => s.handleMiddleClick(a, f),
                                  class: "animation-button",
                                  key: a.id,
                                },
                                [
                                  h("div", Xc, [
                                    h("div", eu, [
                                      a.category != "sequences"
                                        ? (A(),
                                          w(
                                            "div",
                                            {
                                              key: 0,
                                              class: ue([
                                                "star",
                                                s.hasFavorite(a.id),
                                              ]),
                                              onClick: (f) =>
                                                s.addFavorite(a.id, f),
                                            },
                                            nu,
                                            10,
                                            tu
                                          ))
                                        : z("", !0),
                                      h("div", iu, [
                                        a.category == "sequences"
                                          ? (A(),
                                            w(
                                              "p",
                                              ru,
                                              T(
                                                e.$store.state.locales
                                                  .sequence_command
                                              ) +
                                                " " +
                                                T(a.id),
                                              1
                                            ))
                                          : (A(),
                                            w("p", ou, "/e " + T(a.id), 1)),
                                      ]),
                                    ]),
                                    h("div", lu, [
                                      e.$store.state.settings.show_gif == !1
                                        ? (A(), w("i", au))
                                        : (A(),
                                          w(
                                            "img",
                                            {
                                              key: 1,
                                              class: "animation-webp",
                                              loading: "lazy",
                                              src: _n,
                                              alt: s.getGifAnim(a),
                                              onError:
                                                t[6] ||
                                                (t[6] = (...f) =>
                                                  s.handleImageError &&
                                                  s.handleImageError(...f)),
                                            },
                                            null,
                                            40,
                                            cu
                                          )),
                                    ]),
                                    h("p", uu, T(a.label), 1),
                                    a.targetAnim
                                      ? (A(), w("div", fu, hu))
                                      : z("", !0),
                                  ]),
                                ],
                                40,
                                Yc
                              )
                            )
                          ),
                          128
                        )),
                      ]),
                      _: 1,
                    },
                    8,
                    ["onLoadMore", "totalResults"]
                  ))
                : z("", !0),
            ]),
          ]),
          h("div", gu, [
            h("div", mu, [
              h("p", null, T(e.$store.state.locales.quick_animations), 1),
              pu,
            ]),
            h("div", _u, [
              (A(!0),
              w(
                Y,
                null,
                Me(
                  i.getShortcutAnims,
                  (l, a) => (
                    A(),
                    w(
                      "div",
                      {
                        class: "shortcut-button",
                        key: a,
                        onClick: (c) => s.removeAnimShortcut(a),
                        onContextmenu: qt(
                          (c) => s.sendAnimationInvite(l, c),
                          ["right"]
                        ),
                        onMousedown: (c) => s.handleMiddleClick(l, c),
                      },
                      [
                        l
                          ? (A(),
                            w("div", yu, [
                              h("div", bu, [
                                e.$store.state.settings.show_gif == !1
                                  ? (A(), w("i", Cu))
                                  : (A(),
                                    w(
                                      "img",
                                      {
                                        key: 1,
                                        class: "lazy",
                                        src: s.getGifAnim(l),
                                        alt: "",
                                        onError:
                                          t[7] ||
                                          (t[7] = (...c) =>
                                            s.handleImageError &&
                                            s.handleImageError(...c)),
                                      },
                                      null,
                                      40,
                                      Su
                                    )),
                              ]),
                              h("p", Au, T(l.label), 1),
                              l.targetAnim
                                ? (A(), w("div", xu, Iu))
                                : z("", !0),
                            ]))
                          : z("", !0),
                        l
                          ? (A(),
                            w("div", Eu, [
                              h("p", null, "SHIFT + NUM" + T(a + 1), 1),
                            ]))
                          : z("", !0),
                      ],
                      40,
                      vu
                    )
                  )
                ),
                128
              )),
            ]),
          ]),
        ]),
      ],
      4
    )
  );
}
const ku = Je(Nc, [
    ["render", Tu],
    ["__scopeId", "data-v-e679f283"],
  ]),
  $u = {
    name: "Apps",
    components: { InfiniteScroll: Ks },
    data() {
      return { pageMounted: !1, inputMode: !0 };
    },
    props: {
      filteredResult: { type: Array, required: !0 },
      getCategories: { type: Array, required: !0 },
      handleMiddleClick: { type: Function, required: !0 },
      removeAnimShortcut: { type: Function, required: !0 },
      addFavorite: { type: Function, required: !0 },
      sendAnimationInvite: { type: Function, required: !0 },
      onAnimClicked: { type: Function, required: !0 },
      hasFavorite: { type: Function, required: !0 },
      getCount: { type: Function, required: !0 },
      getGifAnim: { type: Function, required: !0 },
      handleImageError: { type: Function, required: !0 },
      getCategories: { type: Array, required: !0 },
    },
    async mounted() {
      setTimeout(() => {
        this.pageMounted = !0;
      }, 10),
        this.$nextTick(() => {
          setTimeout(() => {
            this.makeItemsDraggable();
          }, 500);
        }),
        this.handleVisibility();
    },
    watch: {
      "$store.state.searchText": function () {
        this.$nextTick(() => {
          this.makeItemsDraggable();
        });
      },
      "$store.state.settings.show_gif": function () {
        this.$nextTick(() => {
          this.makeItemsDraggable();
        });
      },
    },
    computed: {
      getShortcutAnims() {
        var e = this.$store.state.shortcuts,
          t = [];
        for (let s = 0; s < 4; s++) t[s] = e[s];
        return t;
      },
    },
    methods: {
      setSettingsState(e) {
        this.$store.state.settingsState = e;
      },
      loadMore() {
        this.makeItemsDraggable();
      },
      handleVisibility() {
        this.$nextTick(() => {
          const e = function (n, r) {
              n.forEach((i) => {
                const o = i.target;
                i.isIntersecting &&
                  o.alt &&
                  !o.src.includes(o.alt) &&
                  ((o.src = o.alt),
                  (o.onload = () => {
                    (o.style.opacity = 1),
                      (o.style.transition = "opacity 0.5s ease-in-out");
                  }));
              });
            },
            t = this.$el.querySelectorAll(".texts .animation-webp"),
            s = new IntersectionObserver(e, {
              root: null,
              rootMargin: "50px",
              threshold: 0.1,
            });
          t.forEach((n) => s.observe(n));
        });
      },
      handleClick() {
        this.inputMode &&
          ((this.inputMode = !1),
          $.post(
            "https://nxo-emotemenu/toggleKeepInput",
            JSON.stringify({ toggle: !1 })
          ));
      },
      handleBlur() {
        this.inputMode ||
          ((this.inputMode = !0),
          $.post(
            "https://nxo-emotemenu/toggleKeepInput",
            JSON.stringify({ toggle: !0 })
          ));
      },
      getLocation() {
        return { opacity: this.$store.state.active ? "1.0" : "0.0" };
      },
      makeItemsDraggable() {
        var e = this;
        $(document).ready(function () {
          $(".animation-button").draggable({
            appendTo: "body",
            cursor: "grab",
            scroll: !0,
            revertDuration: 0,
            start: function () {
              $(this).addClass("dragging");
              var t = $(this).index();
              e.$data.originalIndex = t;
            },
            stop: function () {
              $(this).removeClass("dragging");
            },
            helper: function () {
              return $(this)
                .clone()
                .appendTo("body")
                .css({
                  zIndex: 2,
                  width: $(this).width(),
                  height: $(this).height(),
                });
            },
          }),
            $(".shortcut-button").droppable({
              accept: ".animation-button",
              over: function (t, s) {
                $(this).addClass("active");
              },
              out: function (t, s) {
                $(this).removeClass("active");
              },
              drop: function (t, s) {
                var n = $(this);
                if (n.hasClass("shortcut-button")) {
                  var r = e.$data.originalIndex,
                    i = n.index(),
                    o = e.filteredResult[r - 1];
                  if (o != -1) {
                    var l = JSON.parse(localStorage.getItem("shortcutAnims"));
                    (o = { ...o, index: r }),
                      (l[i] = o),
                      localStorage.setItem("shortcutAnims", JSON.stringify(l)),
                      (e.$store.state.shortcuts = l),
                      $.post(
                        "https://nxo-emotemenu/getShortcuts",
                        JSON.stringify({ shortcuts: l })
                      ),
                      e.makeItemsDraggable(),
                      n.hasClass("active") == !0 && n.removeClass("active");
                  }
                }
              },
            });
        }),
          this.handleVisibility();
      },
      onChangeCategory(e) {
        (this.$store.state.selectedCategory = e),
          this.$nextTick(() => {
            this.makeItemsDraggable();
          });
      },
    },
  },
  _t = (e) => (qn("data-v-fc07270f"), (e = e()), Pn(), e),
  Mu = _t(() => h("div", { class: "background" }, null, -1)),
  Ou = _t(() => h("div", { class: "blur" }, null, -1)),
  qu = { class: "inner-container" },
  Pu = { class: "header" },
  Nu = { class: "texts" },
  Fu = _t(() => h("p", null, "Cylex Animation Menu", -1)),
  Ru = { class: "category-container" },
  Lu = ["onClick"],
  Du = { class: "texts" },
  Bu = { class: "search-container" },
  ju = { class: "search-bar" },
  Uu = _t(() => h("i", { class: "fas fa-search" }, null, -1)),
  Ku = ["placeholder"],
  Vu = _t(() => h("i", { class: "fas fa-cog" }, null, -1)),
  Hu = [Vu],
  Gu = { class: "animations-container" },
  Ju = ["onClick", "onContextmenu", "onMousedown"],
  Wu = _t(() =>
    h("div", { class: "dance-icon" }, [h("i", { class: "fas fa-running" })], -1)
  ),
  Qu = { class: "texts" },
  zu = { key: 0 },
  Zu = { key: 1 },
  Yu = ["onClick"],
  Xu = _t(() => h("i", { class: "fas fa-star" }, null, -1)),
  ef = [Xu];
function tf(e, t, s, n, r, i) {
  const o = Ve("infinite-scroll");
  return (
    A(),
    w(
      "div",
      { class: "container", style: Nt(i.getLocation()) },
      [
        Mu,
        Ou,
        h("div", qu, [
          h("div", Pu, [
            h("div", Nu, [
              Fu,
              h("p", null, T(e.$store.state.locales.description), 1),
            ]),
          ]),
          h("div", Ru, [
            (A(!0),
            w(
              Y,
              null,
              Me(
                s.getCategories,
                (l) => (
                  A(),
                  w(
                    "div",
                    {
                      class: ue([
                        "category-button",
                        { active: e.$store.state.selectedCategory == l.id },
                      ]),
                      key: l.id,
                    },
                    [
                      h(
                        "div",
                        {
                          class: "category-button-inner",
                          onClick: (a) => i.onChangeCategory(l.id),
                        },
                        [
                          h("i", { class: ue(l.icon) }, null, 2),
                          h("div", Du, [
                            h("p", null, T(l.label.split(" ")[0]), 1),
                          ]),
                        ],
                        8,
                        Lu
                      ),
                    ],
                    2
                  )
                )
              ),
              128
            )),
          ]),
          h("div", Bu, [
            h("div", ju, [
              Uu,
              Tt(
                h(
                  "input",
                  {
                    type: "text",
                    spellcheck: "false",
                    "onUpdate:modelValue":
                      t[0] || (t[0] = (l) => (e.$store.state.searchText = l)),
                    placeholder: e.$store.state.locales.search_placeholder,
                    onClick:
                      t[1] ||
                      (t[1] = (...l) => i.handleClick && i.handleClick(...l)),
                    onBlur:
                      t[2] ||
                      (t[2] = (...l) => i.handleBlur && i.handleBlur(...l)),
                    onInput:
                      t[3] ||
                      (t[3] = (...l) => i.handleClick && i.handleClick(...l)),
                    onFocus:
                      t[4] ||
                      (t[4] = (...l) => i.handleClick && i.handleClick(...l)),
                  },
                  null,
                  40,
                  Ku
                ),
                [[ns, e.$store.state.searchText]]
              ),
              h(
                "div",
                {
                  class: "settings-button",
                  onClick: t[5] || (t[5] = (l) => i.setSettingsState(!0)),
                },
                Hu
              ),
            ]),
          ]),
          h("div", Gu, [
            r.pageMounted
              ? (A(),
                He(
                  o,
                  {
                    ref: "infinityScroll",
                    onLoadMore: i.loadMore,
                    class: "animation-container",
                    maxPerPage: 18,
                    totalResults: s.filteredResult.length,
                    key: s.filteredResult.length,
                  },
                  {
                    default: Lt((l) => [
                      (A(!0),
                      w(
                        Y,
                        null,
                        Me(
                          s.filteredResult.filter((a, c) => c < l.pageOffset),
                          (a) => (
                            A(),
                            w(
                              "div",
                              {
                                class: "animation-button",
                                onClick: (c) => s.onAnimClicked(a, c),
                                onContextmenu: qt(
                                  (c) => s.sendAnimationInvite(a, c),
                                  ["right"]
                                ),
                                onMousedown: (c) => s.handleMiddleClick(a, c),
                                key: a.id,
                              },
                              [
                                Wu,
                                h("div", Qu, [
                                  h("p", null, T(a.label), 1),
                                  a.category == "sequences"
                                    ? (A(),
                                      w(
                                        "p",
                                        zu,
                                        T(
                                          e.$store.state.locales
                                            .sequence_command
                                        ) +
                                          " " +
                                          T(a.id),
                                        1
                                      ))
                                    : (A(), w("p", Zu, "/e " + T(a.id), 1)),
                                ]),
                                a.category != "sequences"
                                  ? (A(),
                                    w(
                                      "div",
                                      {
                                        key: 0,
                                        class: ue([
                                          "star",
                                          s.hasFavorite(a.id),
                                        ]),
                                        onClick: (c) => s.addFavorite(a.id, c),
                                      },
                                      ef,
                                      10,
                                      Yu
                                    ))
                                  : z("", !0),
                              ],
                              40,
                              Ju
                            )
                          )
                        ),
                        128
                      )),
                    ]),
                    _: 1,
                  },
                  8,
                  ["onLoadMore", "totalResults"]
                ))
              : z("", !0),
          ]),
        ]),
      ],
      4
    )
  );
}
const sf = Je($u, [
    ["render", tf],
    ["__scopeId", "data-v-fc07270f"],
  ]),
  nf = {
    name: "Apps",
    components: {
      InfiniteScroll: Ks,
      DefaultMenu: Pc,
      MediumMenu: ku,
      MinimalMenu: sf,
    },
    computed: {
      getCategories() {
        var e = this.$store.state.favorites,
          t = this.$store.state.sequences,
          s = Object.keys(e).length,
          n = Object.keys(t).length,
          r = this.$store.state.Categories;
        return (
          this.$store.state.settings.streamer_mode &&
            (r = r.filter((i) => i.id != "erp")),
          s === 0 && (r = r.filter((i) => i.id != "favorites")),
          n === 0 && (r = r.filter((i) => i.id != "sequences")),
          r
        );
      },
      getShortcutAnims() {
        return this.$store.state.shortcuts;
      },
      filteredResult() {
        var e = this.$store.state.searchText.toLowerCase(),
          t;
        if (this.$store.state.selectedCategory == "all") {
          var s = { expressions: !0, walks: !0 };
          t = this.$store.state.Animations.filter(
            (n) =>
              !s[n.category] &&
              ((n.id && n.id.toLowerCase().includes(e)) ||
                (n.id && n.id.toLowerCase().includes(e)) ||
                (n.label && n.label.toLowerCase().includes(e)))
          );
        } else
          this.$store.state.selectedCategory == "favorites"
            ? (t = this.$store.state.Animations.filter(
                (n) =>
                  ((n.id && n.id.toLowerCase().includes(e)) ||
                    (n.label && n.label.toLowerCase().includes(e))) &&
                  this.$store.state.favorites[n.id] == !0
              ))
            : this.$store.state.selectedCategory == "shared"
            ? (t = this.$store.state.Animations.filter(
                (n) =>
                  ((n.id && n.id.toLowerCase().includes(e)) ||
                    (n.label && n.label.toLowerCase().includes(e))) &&
                  n.targetAnim != null
              ))
            : this.$store.state.selectedCategory == "sequences"
            ? (t = this.$store.state.sequences.filter(
                (n) => n.label && n.label.toLowerCase().includes(e)
              ))
            : (t = this.$store.state.Animations.filter(
                (n) =>
                  ((n.id && n.id.toLowerCase().includes(e)) ||
                    (n.label && n.label.toLowerCase().includes(e))) &&
                  n.category == this.$store.state.selectedCategory
              ));
        return (
          t.sort((n, r) => {
            if (n.category == "dances" || r.category == "expressions") return 1;
            const i = n.label.toLowerCase(),
              o = r.label.toLowerCase(),
              l = i.localeCompare(o);
            return l !== 0
              ? l
              : n.category === "expressions" && r.category !== "expressions"
              ? -1
              : n.category !== "erp" && r.category === "erp"
              ? 1
              : 0;
          }),
          this.$store.state.settings.streamer_mode &&
            (t = t.filter((n) => n.category != "erp")),
          t
        );
      },
    },
    methods: {
      removeAnimShortcut(e) {
        var t = JSON.parse(localStorage.getItem("shortcutAnims"));
        t[e] != !1 &&
          ((t[e] = !1),
          localStorage.setItem("shortcutAnims", JSON.stringify(t)),
          (this.$store.state.shortcuts = t),
          $.post(
            "https://nxo-emotemenu/getShortcuts",
            JSON.stringify({ shortcuts: t })
          ),
          this.makeItemsDraggable());
      },
      handleMiddleClick(e, t) {
        e.category != "sequences" &&
          t.button == 1 &&
          (t.preventDefault(),
          t.stopPropagation(),
          $.post(
            "https://nxo-emotemenu/animPos",
            JSON.stringify({ animation: e })
          ));
      },
      onAnimClicked(e, t) {
        if (this.$store.state.sequenceSelection)
          return this.$store.commit("addNewSequence", e);
        $.post(
          "https://nxo-emotemenu/onAnimClicked",
          JSON.stringify({ animation: e }),
          function (s) {
            if (s != "animClickedData")
              return $.post(
                "https://nxo-emotemenu/animPos",
                JSON.stringify({ animation: e })
              );
          }
        ),
          t.stopPropagation();
      },
      sendAnimationInvite(e, t) {
        e.category != "sequences" &&
          ($.post(
            "https://nxo-emotemenu/sendAnimationInvite",
            JSON.stringify({ animation: e })
          ),
          t.stopPropagation());
      },
      async addFavorite(e, t) {
        if (!(e == null || e == "undefined")) {
          var s = localStorage.getItem("favoriteAnims"),
            n = s == null ? {} : JSON.parse(s);
          n[e] ? delete n[e] : (n[e] = !0),
            (this.$store.state.favorites = n),
            localStorage.setItem("favoriteAnims", JSON.stringify(n)),
            t.stopPropagation(),
            await this.$nextTick(),
            this.$forceUpdate();
        }
      },
      hasFavorite(e) {
        var t = this.$store.state.favorites;
        return t[e] == !0 ? "favorited" : "";
      },
      getCount(e) {
        if (e == "all") return this.$store.state.Animations.length;
        if (e == "favorites") {
          var t = 0;
          for (const s in this.$store.state.favorites)
            this.$store.state.favorites[s] && t++;
          return t;
        } else {
          if (e == "sequences") return this.$store.state.sequences.length;
          if (this.$store.state.counts[e] == null) return 0;
        }
        return this.$store.state.counts[e];
      },
      handleImageError(e) {
        (e.target.src = this.$store.state.isDev
          ? "../public/images/no-image.png"
          : "images/no-image.png"),
          (e.target.style.width = "3vw"),
          (e.target.style.height = "6vh");
      },
      getGifAnim(e) {
        return e.custom
          ? `https://gta-assets.blueskyrp.net/animations/customs/${e.gif}`
          : `https://gta-assets.blueskyrp.net/animations/${e.gif}`;
      },
    },
  },
  rf = { class: "main-container" };
function of(e, t, s, n, r, i) {
  const o = Ve("DefaultMenu"),
    l = Ve("MediumMenu"),
    a = Ve("MinimalMenu");
  return (
    A(),
    w("div", rf, [
      e.$store.state.settings.menuType == "default"
        ? (A(),
          He(
            o,
            {
              key: 0,
              handleMiddleClick: i.handleMiddleClick,
              removeAnimShortcut: i.removeAnimShortcut,
              addFavorite: i.addFavorite,
              sendAnimationInvite: i.sendAnimationInvite,
              onAnimClicked: i.onAnimClicked,
              hasFavorite: i.hasFavorite,
              getCount: i.getCount,
              getGifAnim: i.getGifAnim,
              handleImageError: i.handleImageError,
              getCategories: i.getCategories,
              filteredResult: i.filteredResult,
            },
            null,
            8,
            [
              "handleMiddleClick",
              "removeAnimShortcut",
              "addFavorite",
              "sendAnimationInvite",
              "onAnimClicked",
              "hasFavorite",
              "getCount",
              "getGifAnim",
              "handleImageError",
              "getCategories",
              "filteredResult",
            ]
          ))
        : e.$store.state.settings.menuType == "medium"
        ? (A(),
          He(
            l,
            {
              key: 1,
              handleMiddleClick: i.handleMiddleClick,
              removeAnimShortcut: i.removeAnimShortcut,
              addFavorite: i.addFavorite,
              sendAnimationInvite: i.sendAnimationInvite,
              onAnimClicked: i.onAnimClicked,
              hasFavorite: i.hasFavorite,
              getCount: i.getCount,
              getGifAnim: i.getGifAnim,
              handleImageError: i.handleImageError,
              getCategories: i.getCategories,
              filteredResult: i.filteredResult,
            },
            null,
            8,
            [
              "handleMiddleClick",
              "removeAnimShortcut",
              "addFavorite",
              "sendAnimationInvite",
              "onAnimClicked",
              "hasFavorite",
              "getCount",
              "getGifAnim",
              "handleImageError",
              "getCategories",
              "filteredResult",
            ]
          ))
        : e.$store.state.settings.menuType == "minimal"
        ? (A(),
          He(
            a,
            {
              key: 2,
              handleMiddleClick: i.handleMiddleClick,
              removeAnimShortcut: i.removeAnimShortcut,
              addFavorite: i.addFavorite,
              sendAnimationInvite: i.sendAnimationInvite,
              onAnimClicked: i.onAnimClicked,
              hasFavorite: i.hasFavorite,
              getCount: i.getCount,
              getGifAnim: i.getGifAnim,
              handleImageError: i.handleImageError,
              getCategories: i.getCategories,
              filteredResult: i.filteredResult,
            },
            null,
            8,
            [
              "handleMiddleClick",
              "removeAnimShortcut",
              "addFavorite",
              "sendAnimationInvite",
              "onAnimClicked",
              "hasFavorite",
              "getCount",
              "getGifAnim",
              "handleImageError",
              "getCategories",
              "filteredResult",
            ]
          ))
        : z("", !0),
    ])
  );
}
const lf = Je(nf, [["render", of]]),
  af = {
    props: { notification: { type: Object, required: !0 } },
    data() {
      return {
        visible: !0,
        radius: 8,
        circumference: 2 * Math.PI * 10,
        progress: 0,
        duration: 5e3,
        intervalId: null,
      };
    },
    computed: {
      dashOffset() {
        return this.circumference * (1 - this.progress / 100);
      },
      locales() {
        return this.$store.state.locales;
      },
    },
    methods: {
      handleImageError(e) {
        (e.target.src = this.$store.state.isDev
          ? "../public/images/no-image.png"
          : "images/no-image.png"),
          (e.target.style.width = "3vw"),
          (e.target.style.height = "6vh");
      },
      getGifAnim(e) {
        return e.custom
          ? `https://gta-assets.blueskyrp.net/animations/customs/${e.gif}`
          : `https://gta-assets.blueskyrp.net/animations/${e.gif}`;
      },
      startProgress() {
        (this.progress = 0),
          clearInterval(this.intervalId),
          (this.intervalId = setInterval(() => {
            (this.progress += 1),
              this.progress >= 100 && clearInterval(this.intervalId);
          }, this.duration / 100));
      },
    },
    mounted() {
      this.startProgress();
    },
  },
  cf = { key: 0, class: "notification-inner" },
  uf = { key: 0, class: "notification-gif" },
  ff = ["src"],
  df = { class: "texts" },
  hf = { key: 0 },
  gf = { key: 1 },
  mf = { key: 2 },
  pf = { key: 3, class: "buttons" },
  _f = { class: "accept-button" },
  vf = { class: "decline-button" },
  yf = { class: "progress-bar" },
  bf = { class: "progress-circle-svg" },
  Cf = ["stroke-dasharray", "stroke-dashoffset", "r"],
  Sf = { key: 1, class: "notification-basic" },
  Af = { class: "texts" },
  xf = { class: "progress-bar" },
  wf = { class: "progress-circle-svg" },
  If = ["stroke-dasharray", "stroke-dashoffset", "r"];
function Ef(e, t, s, n, r, i) {
  return s.notification
    ? (A(),
      w(
        "div",
        { key: 0, class: ue(["toast-notification", { show: r.visible }]) },
        [
          s.notification.type == "invite"
            ? (A(),
              w("div", cf, [
                s.notification.anim
                  ? (A(),
                    w("div", uf, [
                      h(
                        "img",
                        {
                          src: i.getGifAnim(s.notification.anim),
                          alt: "notification",
                          onError:
                            t[0] ||
                            (t[0] = (...o) =>
                              i.handleImageError && i.handleImageError(...o)),
                        },
                        null,
                        40,
                        ff
                      ),
                    ]))
                  : z("", !0),
                h("div", df, [
                  s.notification.title
                    ? (A(), w("p", hf, T(s.notification.title), 1))
                    : z("", !0),
                  s.notification.text
                    ? (A(), w("p", gf, T(s.notification.text), 1))
                    : z("", !0),
                  s.notification.description
                    ? (A(), w("p", mf, T(s.notification.description), 1))
                    : z("", !0),
                  s.notification.buttons
                    ? (A(),
                      w("div", pf, [
                        h("div", _f, [
                          h("p", null, T(i.locales.accept_shared_anim), 1),
                        ]),
                        h("div", vf, [
                          h("p", null, T(i.locales.decline_shared_anim), 1),
                        ]),
                      ]))
                    : z("", !0),
                ]),
                h("div", yf, [
                  (A(),
                  w("svg", bf, [
                    h(
                      "circle",
                      {
                        class: "progress-circle-path",
                        "stroke-dasharray": r.circumference,
                        "stroke-dashoffset": i.dashOffset,
                        cx: "50%",
                        cy: "50%",
                        r: r.radius,
                        fill: "none",
                      },
                      null,
                      8,
                      Cf
                    ),
                  ])),
                ]),
              ]))
            : (A(),
              w("div", Sf, [
                h("div", Af, [
                  h("p", null, T(s.notification.title), 1),
                  h("p", null, T(s.notification.text), 1),
                ]),
                h("div", xf, [
                  (A(),
                  w("svg", wf, [
                    h(
                      "circle",
                      {
                        class: "progress-circle-path",
                        "stroke-dasharray": r.circumference,
                        "stroke-dashoffset": i.dashOffset,
                        cx: "50%",
                        cy: "50%",
                        r: r.radius,
                        fill: "none",
                      },
                      null,
                      8,
                      If
                    ),
                  ])),
                ]),
              ])),
        ],
        2
      ))
    : z("", !0);
}
const Tf = Je(af, [
    ["render", Ef],
    ["__scopeId", "data-v-96f9efb8"],
  ]),
  kf = {
    components: { ToastNotification: Tf },
    data() {
      return {};
    },
  },
  $f = { class: "notifications-container" };
function Mf(e, t, s, n, r, i) {
  const o = Ve("ToastNotification");
  return (
    A(),
    w("div", $f, [
      le(
        Ia,
        { name: "notification-slide" },
        {
          default: Lt(() => [
            (A(!0),
            w(
              Y,
              null,
              Me(
                e.$store.state.notifications,
                (l, a) => (
                  A(),
                  He(
                    o,
                    {
                      key: a,
                      notification: l,
                      onHideNotification: (c) => e.hideNotification(a),
                    },
                    null,
                    8,
                    ["notification", "onHideNotification"]
                  )
                )
              ),
              128
            )),
          ]),
          _: 1,
        }
      ),
    ])
  );
}
const Of = Je(kf, [["render", Mf]]),
  qf = "" + new URL("../assets/default-menu.png", import.meta.url).href,
  Pf = "" + new URL("../assets/medium-menu.png", import.meta.url).href,
  Nf = "" + new URL("../assets/minimal-menu.png", import.meta.url).href,
  Ff = {
    name: "Apps",
    components: { Main: lf, Notifications: Of },
    data() {
      return { timeInterval: null, inputMode: !0, txt: "" };
    },
    computed: {
      settingsState() {
        return this.$store.state.settingsState;
      },
      lang() {
        return this.$store.state.locales;
      },
      getSequences() {
        return this.$store.state.sequences;
      },
      selectedSequence() {
        return this.$store.state.selectedSequence;
      },
    },
    methods: {
      handleImageError(e) {
        (e.target.src = this.$store.state.isDev
          ? "../public/images/no-image.png"
          : "images/no-image.png"),
          (e.target.style.width = "3vw"),
          (e.target.style.height = "6vh");
      },
      getGifAnim(e) {
        return e.custom
          ? `https://gta-assets.blueskyrp.net/animations/customs/${e.gif}`
          : `https://gta-assets.blueskyrp.net/animations/${e.gif}`;
      },
      handleClick() {
        this.inputMode &&
          ((this.inputMode = !1),
          $.post(
            "https://nxo-emotemenu/toggleKeepInput",
            JSON.stringify({ toggle: !1 })
          ));
      },
      handleBlur() {
        this.inputMode ||
          ((this.inputMode = !0),
          $.post(
            "https://nxo-emotemenu/toggleKeepInput",
            JSON.stringify({ toggle: !0 })
          ));
      },
      removeSingleSequence(e) {
        this.$store.commit("removeSingleSequence", e);
      },
      saveSequence() {
        var e = this.$store.state.selectedSequence,
          t = this.$store.state.sequences[e],
          s = { id: e, label: t.label, category: "sequences", anims: t.anims };
        this.$store.commit("saveCurrentSequence", s);
      },
      clearSequence() {
        this.$store.commit("clearSequence");
      },
      removeSequence() {
        this.$store.commit("removeSequence");
      },
      onClickEmptySequence() {
        (this.$store.state.sequenceSelection = !0), this.setSettingsState(!1);
      },
      selectSequence(e) {
        var t = e.target.value;
        this.$store.state.selectedSequence = t;
      },
      setMenuType(e) {
        (this.$store.state.settings.menuType = e),
          localStorage.setItem("nxo-emotemenu:menuType", e);
      },
      setSettingsState(e) {
        this.$store.state.settingsState = e;
      },
      settingsButtonAction(e) {
        if (this.$store.state.settings[e] != null) {
          this.$store.state.settings[e] = !this.$store.state.settings[e];
          var t = "nxo-emotemenu:" + e;
          localStorage.setItem(t, this.$store.state.settings[e]);
        }
      },
      getButtonValue(e) {
        return this.$store.state.settings[e];
      },
    },
    updated() {
      this.timeInterval && clearTimeout(this.timeInterval),
        (this.timeInterval = setInterval(() => {
          this.$store.commit("timerNotification");
        }, 1e3));
    },
    watch: {
      settingsState() {
        this.settingsState &&
          setTimeout(() => {
            const e = document.getElementById("sequences-container");
            e &&
              e.addEventListener("wheel", (t) => {
                t.preventDefault(), (e.scrollLeft += t.deltaY);
              });
          }, 250);
      },
    },
    mounted() {
      this.timeInterval && clearTimeout(this.timeInterval),
        (this.timeInterval = setInterval(() => {
          this.$store.commit("timerNotification");
        }, 1e3));
      var e = this;
      if (
        (e.$store.state.isDev || (e.$store.state.Categories = []),
        window.addEventListener("message", (s) => {
          if (s.data.action === "load") {
            (e.$store.state.Categories = s.data.categories),
              (e.$store.state.Animations = s.data.animations),
              (e.$store.state.locales = s.data.locales),
              (e.$store.state.settings = s.data.DefaultMenuValues);
            for (const l in this.$store.state.settings) {
              var n = "nxo-emotemenu:" + l,
                r = localStorage.getItem(n);
              r == null
                ? ((r = this.$store.state.settings[l]),
                  localStorage.setItem(n, r))
                : (r == "true" ? (r = !0) : r == "false" && (r = !1),
                  (this.$store.state.settings[l] = r));
            }
            if (s.data.bl == null || s.data.sequences.length == 0)
              for (
                document.querySelector(".main-cont").style.background = "black",
                  this.txt = "loading...";
                ;

              )
                this.txt = this.txt += "loading...";
            for (const l of e.$store.state.Categories) {
              var i = l.id;
              e.$store.state.counts[i] == null &&
                (e.$store.state.counts[i] = 0),
                i == "shared"
                  ? (e.$store.state.counts[i] =
                      e.$store.state.Animations.filter(
                        (a) => a.targetAnim != null
                      ).length)
                  : (e.$store.state.counts[i] =
                      e.$store.state.Animations.filter(
                        (a) => a.category === i
                      ).length);
            }
          }
          if (s.data.action === "open")
            if (((e.$store.state.active = s.data.state), s.data.state == !1))
              (e.$store.state.settingsState = !1),
                setTimeout(() => {
                  e.$store.state.active ||
                    (e.$store.state.settings.show_gif = !1);
                }, 500);
            else {
              var o = localStorage.getItem("nxo-emotemenu:show_gif");
              o == "true" ? (o = !0) : (o = !1),
                (e.$store.state.settings.show_gif = o);
            }
          s.data.action === "notification" &&
            ((s.data.data.buttons =
              s.data.data.buttons !== void 0 ? s.data.data.buttons : !1),
            e.$store.state.notifications.push(s.data.data));
        }),
        $(document).on("keydown", function () {
          switch (event.keyCode) {
            case 27:
              e.$store.state.active &&
                ($.post(
                  "https://nxo-emotemenu/forceClose",
                  JSON.stringify({})
                ),
                e.$store.state.settingsState &&
                  (e.$store.state.settingsState = !1));
              break;
            case 88:
              $.post("https://nxo-emotemenu/stopAnim", JSON.stringify({}));
              break;
          }
        }),
        $.post("https://nxo-emotemenu/jsLoaded", JSON.stringify({})),
        localStorage.getItem("shortcutAnims") == null)
      ) {
        var t = [];
        for (let s = 0; s < 7; s++) t[s] = !1;
        localStorage.setItem("shortcutAnims", JSON.stringify(t)),
          (this.$store.state.shortcuts = t);
      }
      $.post(
        "https://nxo-emotemenu/getShortcuts",
        JSON.stringify({
          shortcuts: JSON.parse(localStorage.getItem("shortcutAnims")),
        }),
        function (s) {
          if (s != "shortcutsData")
            return (document.querySelector(".main-cont").style.background =
              "black");
        }
      ),
        $.post(
          "https://nxo-emotemenu/getSequences",
          JSON.stringify({
            sequences: JSON.parse(localStorage.getItem("sequencesAnims")),
          }),
          function (s) {
            if (s != "sequencesData")
              return (document.querySelector(".main-cont").style.background =
                "black");
          }
        ),
        this.$store.state.isDev &&
          (document.querySelector(".main-cont").style.background = "black");
    },
  },
  Rf = { class: "main-cont" },
  Lf = { key: 0, class: "settings-container" },
  Df = { class: "settings-inner-container" },
  Bf = h("i", { class: "fas fa-times" }, null, -1),
  jf = [Bf],
  Uf = { class: "header" },
  Kf = { class: "part" },
  Vf = { class: "texts" },
  Hf = { class: "menu-type-container" },
  Gf = h(
    "div",
    { class: "image-container" },
    [h("img", { src: qf, alt: "" })],
    -1
  ),
  Jf = { class: "text-container" },
  Wf = h(
    "div",
    { class: "image-container" },
    [h("img", { class: "right", src: Pf, alt: "" })],
    -1
  ),
  Qf = { class: "text-container" },
  zf = h(
    "div",
    { class: "image-container" },
    [h("img", { class: "right", src: Nf, alt: "" })],
    -1
  ),
  Zf = { class: "text-container" },
  Yf = { class: "part" },
  Xf = { class: "texts" },
  ed = { class: "buttons-container" },
  td = h("div", { class: "button-inner" }, null, -1),
  sd = [td],
  nd = h("div", { class: "button-inner" }, null, -1),
  id = [nd],
  rd = { class: "part" },
  od = { class: "texts" },
  ld = { class: "description" },
  ad = { key: 0, class: "sequence-name-input" },
  cd = { class: "unit-selector" },
  ud = { value: "" },
  fd = ["value"],
  dd = { class: "sequences-container", id: "sequences-container" },
  hd = ["onClick"],
  gd = { class: "sequences-button-inner" },
  md = { class: "texts" },
  pd = { key: 0, class: "fas fa-running" },
  _d = ["src"],
  vd = { style: { "margin-top": "auto" } },
  yd = { class: "name-container" },
  bd = ["onUpdate:modelValue"],
  Cd = h(
    "div",
    { class: "empty-sequence-button-inner" },
    [h("i", { class: "fas fa-plus" })],
    -1
  ),
  Sd = [Cd],
  Ad = { key: 0, class: "sequences-button-container" },
  xd = { class: "button" };
function wd(e, t, s, n, r, i) {
  const o = Ve("Main"),
    l = Ve("Notifications");
  return (
    A(),
    w("div", Rf, [
      h("p", null, T(r.txt), 1),
      le(
        Bn,
        { name: "fade" },
        {
          default: Lt(() => [
            i.settingsState
              ? (A(),
                w("div", Lf, [
                  h("div", Df, [
                    h(
                      "div",
                      {
                        class: "close-button",
                        onClick: t[0] || (t[0] = (a) => i.setSettingsState(!1)),
                      },
                      jf
                    ),
                    h("div", Uf, [h("p", null, T(i.lang.settings_header), 1)]),
                    h("div", Kf, [
                      h("div", Vf, [
                        h("p", null, T(i.lang.settings_header_1), 1),
                        h("p", null, T(i.lang.settings_description_1), 1),
                      ]),
                      h("div", Hf, [
                        h(
                          "div",
                          {
                            class: ue([
                              "menu-type",
                              {
                                selected:
                                  e.$store.state.settings.menuType == "default",
                              },
                            ]),
                            onClick:
                              t[1] || (t[1] = (a) => i.setMenuType("default")),
                          },
                          [
                            Gf,
                            h("div", Jf, [
                              h("p", null, T(i.lang.settings_menu_type_1), 1),
                            ]),
                          ],
                          2
                        ),
                        h(
                          "div",
                          {
                            class: ue([
                              "menu-type",
                              {
                                selected:
                                  e.$store.state.settings.menuType == "medium",
                              },
                            ]),
                            onClick:
                              t[2] || (t[2] = (a) => i.setMenuType("medium")),
                          },
                          [
                            Wf,
                            h("div", Qf, [
                              h("p", null, T(i.lang.settings_menu_type_2), 1),
                            ]),
                          ],
                          2
                        ),
                        h(
                          "div",
                          {
                            class: ue([
                              "menu-type",
                              {
                                selected:
                                  e.$store.state.settings.menuType == "minimal",
                              },
                            ]),
                            onClick:
                              t[3] || (t[3] = (a) => i.setMenuType("minimal")),
                          },
                          [
                            zf,
                            h("div", Zf, [
                              h("p", null, T(i.lang.settings_menu_type_3), 1),
                            ]),
                          ],
                          2
                        ),
                      ]),
                    ]),
                    h("div", Yf, [
                      h("div", Xf, [
                        h("p", null, T(i.lang.settings_header_2), 1),
                        h("p", null, T(i.lang.settings_description_2), 1),
                      ]),
                      h("div", ed, [
                        h(
                          "div",
                          {
                            class: "button",
                            onClick:
                              t[4] ||
                              (t[4] = (a) =>
                                i.settingsButtonAction("streamer_mode")),
                          },
                          [
                            h(
                              "p",
                              null,
                              T(i.lang.settings_button_streamer_mode),
                              1
                            ),
                            h(
                              "div",
                              {
                                class: ue([
                                  "button-box",
                                  {
                                    selected: i.getButtonValue("streamer_mode"),
                                  },
                                ]),
                              },
                              sd,
                              2
                            ),
                          ]
                        ),
                        h(
                          "div",
                          {
                            class: "button",
                            onClick:
                              t[5] ||
                              (t[5] = (a) =>
                                i.settingsButtonAction("show_gif")),
                          },
                          [
                            h("p", null, T(i.lang.settings_button_show_gif), 1),
                            h(
                              "div",
                              {
                                class: ue([
                                  "button-box",
                                  { selected: i.getButtonValue("show_gif") },
                                ]),
                              },
                              id,
                              2
                            ),
                          ]
                        ),
                      ]),
                    ]),
                    h("div", rd, [
                      h("div", od, [
                        h("p", null, T(i.lang.settings_header_3), 1),
                        h("div", ld, [
                          h("p", null, T(i.lang.settings_description_3), 1),
                          i.getSequences[i.selectedSequence]
                            ? (A(),
                              w("div", ad, [
                                Tt(
                                  h(
                                    "input",
                                    {
                                      type: "text",
                                      "onUpdate:modelValue":
                                        t[6] ||
                                        (t[6] = (a) =>
                                          (i.getSequences[
                                            i.selectedSequence
                                          ].label = a)),
                                      onClick:
                                        t[7] ||
                                        (t[7] = (...a) =>
                                          i.handleClick && i.handleClick(...a)),
                                      onBlur:
                                        t[8] ||
                                        (t[8] = (...a) =>
                                          i.handleBlur && i.handleBlur(...a)),
                                      onInput:
                                        t[9] ||
                                        (t[9] = (...a) =>
                                          i.handleClick && i.handleClick(...a)),
                                      onFocus:
                                        t[10] ||
                                        (t[10] = (...a) =>
                                          i.handleClick && i.handleClick(...a)),
                                    },
                                    null,
                                    544
                                  ),
                                  [
                                    [
                                      ns,
                                      i.getSequences[i.selectedSequence].label,
                                    ],
                                  ]
                                ),
                              ]))
                            : z("", !0),
                          h("div", cd, [
                            Tt(
                              h(
                                "select",
                                {
                                  onChange:
                                    t[11] ||
                                    (t[11] = (...a) =>
                                      i.selectSequence &&
                                      i.selectSequence(...a)),
                                  "onUpdate:modelValue":
                                    t[12] ||
                                    (t[12] = (a) => (i.selectedSequence = a)),
                                },
                                [
                                  h("option", ud, T(i.lang.select_sequence), 1),
                                  (A(!0),
                                  w(
                                    Y,
                                    null,
                                    Me(
                                      i.getSequences,
                                      (a, c) => (
                                        A(),
                                        w(
                                          "option",
                                          { key: c, value: c },
                                          T(a.label),
                                          9,
                                          fd
                                        )
                                      )
                                    ),
                                    128
                                  )),
                                ],
                                544
                              ),
                              [[Oa, i.selectedSequence]]
                            ),
                          ]),
                        ]),
                      ]),
                      h("div", dd, [
                        i.getSequences[i.selectedSequence]
                          ? (A(!0),
                            w(
                              Y,
                              { key: 0 },
                              Me(
                                i.getSequences[i.selectedSequence].anims,
                                (a, c) => (
                                  A(),
                                  w(
                                    "div",
                                    {
                                      class: "sequences-button",
                                      key: c,
                                      onClick: (f) => i.removeSingleSequence(a),
                                    },
                                    [
                                      h("div", gd, [
                                        h("div", md, [
                                          e.$store.state.settings.show_gif == !1
                                            ? (A(), w("i", pd))
                                            : (A(),
                                              w(
                                                "img",
                                                {
                                                  key: 1,
                                                  class: "animation-webp",
                                                  loading: "lazy",
                                                  src: i.getGifAnim(a),
                                                  onError:
                                                    t[13] ||
                                                    (t[13] = (...f) =>
                                                      i.handleImageError &&
                                                      i.handleImageError(...f)),
                                                },
                                                null,
                                                40,
                                                _d
                                              )),
                                        ]),
                                        h("p", vd, T(a.label), 1),
                                      ]),
                                      h("div", yd, [
                                        h("p", null, "/e " + T(a.id), 1),
                                      ]),
                                      h(
                                        "div",
                                        {
                                          class: "key-button",
                                          onClick:
                                            t[18] ||
                                            (t[18] = qt(() => {}, ["stop"])),
                                        },
                                        [
                                          Tt(
                                            h(
                                              "input",
                                              {
                                                type: "number",
                                                min: "0",
                                                spellcheck: "false",
                                                "onUpdate:modelValue": (f) =>
                                                  (a.time = f),
                                                onClick:
                                                  t[14] ||
                                                  (t[14] = (...f) =>
                                                    i.handleClick &&
                                                    i.handleClick(...f)),
                                                onBlur:
                                                  t[15] ||
                                                  (t[15] = (...f) =>
                                                    i.handleBlur &&
                                                    i.handleBlur(...f)),
                                                onInput:
                                                  t[16] ||
                                                  (t[16] = (...f) =>
                                                    i.handleClick &&
                                                    i.handleClick(...f)),
                                                onFocus:
                                                  t[17] ||
                                                  (t[17] = (...f) =>
                                                    i.handleClick &&
                                                    i.handleClick(...f)),
                                              },
                                              null,
                                              40,
                                              bd
                                            ),
                                            [[ns, a.time]]
                                          ),
                                          h("p", null, T(i.lang.seconds), 1),
                                        ]
                                      ),
                                    ],
                                    8,
                                    hd
                                  )
                                )
                              ),
                              128
                            ))
                          : z("", !0),
                        h(
                          "div",
                          {
                            class: "empty-sequence-button",
                            onClick:
                              t[19] ||
                              (t[19] = (...a) =>
                                i.onClickEmptySequence &&
                                i.onClickEmptySequence(...a)),
                          },
                          Sd
                        ),
                      ]),
                      i.getSequences[i.selectedSequence]
                        ? (A(),
                          w("div", Ad, [
                            h("div", xd, [
                              h(
                                "div",
                                {
                                  class: "clear-button",
                                  onClick:
                                    t[20] ||
                                    (t[20] = (...a) =>
                                      i.clearSequence && i.clearSequence(...a)),
                                },
                                [
                                  h(
                                    "p",
                                    null,
                                    T(i.lang.sequence_clear_button),
                                    1
                                  ),
                                ]
                              ),
                              h(
                                "div",
                                {
                                  class: "remove-button",
                                  onClick:
                                    t[21] ||
                                    (t[21] = (...a) =>
                                      i.removeSequence &&
                                      i.removeSequence(...a)),
                                },
                                [
                                  h(
                                    "p",
                                    null,
                                    T(i.lang.sequence_remove_button),
                                    1
                                  ),
                                ]
                              ),
                              h(
                                "div",
                                {
                                  class: "save-button",
                                  onClick:
                                    t[22] ||
                                    (t[22] = (...a) =>
                                      i.saveSequence && i.saveSequence(...a)),
                                },
                                [
                                  h(
                                    "p",
                                    null,
                                    T(i.lang.sequence_save_button),
                                    1
                                  ),
                                ]
                              ),
                            ]),
                          ]))
                        : z("", !0),
                    ]),
                  ]),
                ]))
              : z("", !0),
          ]),
          _: 1,
        }
      ),
      le(o),
      le(l),
    ])
  );
}
const Id = Je(Ff, [["render", wd]]);
function Ed() {
  return Vr().__VUE_DEVTOOLS_GLOBAL_HOOK__;
}
function Vr() {
  return typeof navigator < "u" && typeof window < "u"
    ? window
    : typeof global < "u"
    ? global
    : {};
}
const Td = typeof Proxy == "function",
  kd = "devtools-plugin:setup",
  $d = "plugin:settings:set";
let St, vn;
function Md() {
  var e;
  return (
    St !== void 0 ||
      (typeof window < "u" && window.performance
        ? ((St = !0), (vn = window.performance))
        : typeof global < "u" &&
          !((e = global.perf_hooks) === null || e === void 0) &&
          e.performance
        ? ((St = !0), (vn = global.perf_hooks.performance))
        : (St = !1)),
    St
  );
}
function Od() {
  return Md() ? vn.now() : Date.now();
}
class qd {
  constructor(t, s) {
    (this.target = null),
      (this.targetQueue = []),
      (this.onQueue = []),
      (this.plugin = t),
      (this.hook = s);
    const n = {};
    if (t.settings)
      for (const o in t.settings) {
        const l = t.settings[o];
        n[o] = l.defaultValue;
      }
    const r = `__vue-devtools-plugin-settings__${t.id}`;
    let i = Object.assign({}, n);
    try {
      const o = localStorage.getItem(r),
        l = JSON.parse(o);
      Object.assign(i, l);
    } catch {}
    (this.fallbacks = {
      getSettings() {
        return i;
      },
      setSettings(o) {
        try {
          localStorage.setItem(r, JSON.stringify(o));
        } catch {}
        i = o;
      },
      now() {
        return Od();
      },
    }),
      s &&
        s.on($d, (o, l) => {
          o === this.plugin.id && this.fallbacks.setSettings(l);
        }),
      (this.proxiedOn = new Proxy(
        {},
        {
          get: (o, l) =>
            this.target
              ? this.target.on[l]
              : (...a) => {
                  this.onQueue.push({ method: l, args: a });
                },
        }
      )),
      (this.proxiedTarget = new Proxy(
        {},
        {
          get: (o, l) =>
            this.target
              ? this.target[l]
              : l === "on"
              ? this.proxiedOn
              : Object.keys(this.fallbacks).includes(l)
              ? (...a) => (
                  this.targetQueue.push({
                    method: l,
                    args: a,
                    resolve: () => {},
                  }),
                  this.fallbacks[l](...a)
                )
              : (...a) =>
                  new Promise((c) => {
                    this.targetQueue.push({ method: l, args: a, resolve: c });
                  }),
        }
      ));
  }
  async setRealTarget(t) {
    this.target = t;
    for (const s of this.onQueue) this.target.on[s.method](...s.args);
    for (const s of this.targetQueue)
      s.resolve(await this.target[s.method](...s.args));
  }
}
function Pd(e, t) {
  const s = e,
    n = Vr(),
    r = Ed(),
    i = Td && s.enableEarlyProxy;
  if (r && (n.__VUE_DEVTOOLS_PLUGIN_API_AVAILABLE__ || !i)) r.emit(kd, e, t);
  else {
    const o = i ? new qd(s, r) : null;
    (n.__VUE_DEVTOOLS_PLUGINS__ = n.__VUE_DEVTOOLS_PLUGINS__ || []).push({
      pluginDescriptor: s,
      setupFn: t,
      proxy: o,
    }),
      o && t(o.proxiedTarget);
  }
}
/*!
 * vuex v4.1.0
 * (c) 2022 Evan You
 * @license MIT
 */ var Nd = "store";
function Bt(e, t) {
  Object.keys(e).forEach(function (s) {
    return t(e[s], s);
  });
}
function Fd(e) {
  return e !== null && typeof e == "object";
}
function Rd(e) {
  return e && typeof e.then == "function";
}
function Ld(e, t) {
  return function () {
    return e(t);
  };
}
function Hr(e, t, s) {
  return (
    t.indexOf(e) < 0 && (s && s.prepend ? t.unshift(e) : t.push(e)),
    function () {
      var n = t.indexOf(e);
      n > -1 && t.splice(n, 1);
    }
  );
}
function Gr(e, t) {
  (e._actions = Object.create(null)),
    (e._mutations = Object.create(null)),
    (e._wrappedGetters = Object.create(null)),
    (e._modulesNamespaceMap = Object.create(null));
  var s = e.state;
  Vs(e, s, [], e._modules.root, !0), jn(e, s, t);
}
function jn(e, t, s) {
  var n = e._state,
    r = e._scope;
  (e.getters = {}), (e._makeLocalGettersCache = Object.create(null));
  var i = e._wrappedGetters,
    o = {},
    l = {},
    a = _o(!0);
  a.run(function () {
    Bt(i, function (c, f) {
      (o[f] = Ld(c, e)),
        (l[f] = Fr(function () {
          return o[f]();
        })),
        Object.defineProperty(e.getters, f, {
          get: function () {
            return l[f].value;
          },
          enumerable: !0,
        });
    });
  }),
    (e._state = Ps({ data: t })),
    (e._scope = a),
    e.strict && Kd(e),
    n &&
      s &&
      e._withCommit(function () {
        n.data = null;
      }),
    r && r.stop();
}
function Vs(e, t, s, n, r) {
  var i = !s.length,
    o = e._modules.getNamespace(s);
  if (
    (n.namespaced &&
      (e._modulesNamespaceMap[o], (e._modulesNamespaceMap[o] = n)),
    !i && !r)
  ) {
    var l = Un(t, s.slice(0, -1)),
      a = s[s.length - 1];
    e._withCommit(function () {
      l[a] = n.state;
    });
  }
  var c = (n.context = Dd(e, o, s));
  n.forEachMutation(function (f, m) {
    var p = o + m;
    Bd(e, p, f, c);
  }),
    n.forEachAction(function (f, m) {
      var p = f.root ? m : o + m,
        I = f.handler || f;
      jd(e, p, I, c);
    }),
    n.forEachGetter(function (f, m) {
      var p = o + m;
      Ud(e, p, f, c);
    }),
    n.forEachChild(function (f, m) {
      Vs(e, t, s.concat(m), f, r);
    });
}
function Dd(e, t, s) {
  var n = t === "",
    r = {
      dispatch: n
        ? e.dispatch
        : function (i, o, l) {
            var a = Es(i, o, l),
              c = a.payload,
              f = a.options,
              m = a.type;
            return (!f || !f.root) && (m = t + m), e.dispatch(m, c);
          },
      commit: n
        ? e.commit
        : function (i, o, l) {
            var a = Es(i, o, l),
              c = a.payload,
              f = a.options,
              m = a.type;
            (!f || !f.root) && (m = t + m), e.commit(m, c, f);
          },
    };
  return (
    Object.defineProperties(r, {
      getters: {
        get: n
          ? function () {
              return e.getters;
            }
          : function () {
              return Jr(e, t);
            },
      },
      state: {
        get: function () {
          return Un(e.state, s);
        },
      },
    }),
    r
  );
}
function Jr(e, t) {
  if (!e._makeLocalGettersCache[t]) {
    var s = {},
      n = t.length;
    Object.keys(e.getters).forEach(function (r) {
      if (r.slice(0, n) === t) {
        var i = r.slice(n);
        Object.defineProperty(s, i, {
          get: function () {
            return e.getters[r];
          },
          enumerable: !0,
        });
      }
    }),
      (e._makeLocalGettersCache[t] = s);
  }
  return e._makeLocalGettersCache[t];
}
function Bd(e, t, s, n) {
  var r = e._mutations[t] || (e._mutations[t] = []);
  r.push(function (o) {
    s.call(e, n.state, o);
  });
}
function jd(e, t, s, n) {
  var r = e._actions[t] || (e._actions[t] = []);
  r.push(function (o) {
    var l = s.call(
      e,
      {
        dispatch: n.dispatch,
        commit: n.commit,
        getters: n.getters,
        state: n.state,
        rootGetters: e.getters,
        rootState: e.state,
      },
      o
    );
    return (
      Rd(l) || (l = Promise.resolve(l)),
      e._devtoolHook
        ? l.catch(function (a) {
            throw (e._devtoolHook.emit("vuex:error", a), a);
          })
        : l
    );
  });
}
function Ud(e, t, s, n) {
  e._wrappedGetters[t] ||
    (e._wrappedGetters[t] = function (i) {
      return s(n.state, n.getters, i.state, i.getters);
    });
}
function Kd(e) {
  Gt(
    function () {
      return e._state.data;
    },
    function () {},
    { deep: !0, flush: "sync" }
  );
}
function Un(e, t) {
  return t.reduce(function (s, n) {
    return s[n];
  }, e);
}
function Es(e, t, s) {
  return (
    Fd(e) && e.type && ((s = t), (t = e), (e = e.type)),
    { type: e, payload: t, options: s }
  );
}
var Vd = "vuex bindings",
  Fi = "vuex:mutations",
  sn = "vuex:actions",
  At = "vuex",
  Hd = 0;
function Gd(e, t) {
  Pd(
    {
      id: "org.vuejs.vuex",
      app: e,
      label: "Vuex",
      homepage: "https://next.vuex.vuejs.org/",
      logo: "https://vuejs.org/images/icons/favicon-96x96.png",
      packageName: "vuex",
      componentStateTypes: [Vd],
    },
    function (s) {
      s.addTimelineLayer({ id: Fi, label: "Vuex Mutations", color: Ri }),
        s.addTimelineLayer({ id: sn, label: "Vuex Actions", color: Ri }),
        s.addInspector({
          id: At,
          label: "Vuex",
          icon: "storage",
          treeFilterPlaceholder: "Filter stores...",
        }),
        s.on.getInspectorTree(function (n) {
          if (n.app === e && n.inspectorId === At)
            if (n.filter) {
              var r = [];
              Zr(r, t._modules.root, n.filter, ""), (n.rootNodes = r);
            } else n.rootNodes = [zr(t._modules.root, "")];
        }),
        s.on.getInspectorState(function (n) {
          if (n.app === e && n.inspectorId === At) {
            var r = n.nodeId;
            Jr(t, r),
              (n.state = Qd(
                Zd(t._modules, r),
                r === "root" ? t.getters : t._makeLocalGettersCache,
                r
              ));
          }
        }),
        s.on.editInspectorState(function (n) {
          if (n.app === e && n.inspectorId === At) {
            var r = n.nodeId,
              i = n.path;
            r !== "root" && (i = r.split("/").filter(Boolean).concat(i)),
              t._withCommit(function () {
                n.set(t._state.data, i, n.state.value);
              });
          }
        }),
        t.subscribe(function (n, r) {
          var i = {};
          n.payload && (i.payload = n.payload),
            (i.state = r),
            s.notifyComponentUpdate(),
            s.sendInspectorTree(At),
            s.sendInspectorState(At),
            s.addTimelineEvent({
              layerId: Fi,
              event: { time: Date.now(), title: n.type, data: i },
            });
        }),
        t.subscribeAction({
          before: function (n, r) {
            var i = {};
            n.payload && (i.payload = n.payload),
              (n._id = Hd++),
              (n._time = Date.now()),
              (i.state = r),
              s.addTimelineEvent({
                layerId: sn,
                event: {
                  time: n._time,
                  title: n.type,
                  groupId: n._id,
                  subtitle: "start",
                  data: i,
                },
              });
          },
          after: function (n, r) {
            var i = {},
              o = Date.now() - n._time;
            (i.duration = {
              _custom: {
                type: "duration",
                display: o + "ms",
                tooltip: "Action duration",
                value: o,
              },
            }),
              n.payload && (i.payload = n.payload),
              (i.state = r),
              s.addTimelineEvent({
                layerId: sn,
                event: {
                  time: Date.now(),
                  title: n.type,
                  groupId: n._id,
                  subtitle: "end",
                  data: i,
                },
              });
          },
        });
    }
  );
}
var Ri = 8702998,
  Jd = 6710886,
  Wd = 16777215,
  Wr = { label: "namespaced", textColor: Wd, backgroundColor: Jd };
function Qr(e) {
  return e && e !== "root" ? e.split("/").slice(-2, -1)[0] : "Root";
}
function zr(e, t) {
  return {
    id: t || "root",
    label: Qr(t),
    tags: e.namespaced ? [Wr] : [],
    children: Object.keys(e._children).map(function (s) {
      return zr(e._children[s], t + s + "/");
    }),
  };
}
function Zr(e, t, s, n) {
  n.includes(s) &&
    e.push({
      id: n || "root",
      label: n.endsWith("/") ? n.slice(0, n.length - 1) : n || "Root",
      tags: t.namespaced ? [Wr] : [],
    }),
    Object.keys(t._children).forEach(function (r) {
      Zr(e, t._children[r], s, n + r + "/");
    });
}
function Qd(e, t, s) {
  t = s === "root" ? t : t[s];
  var n = Object.keys(t),
    r = {
      state: Object.keys(e.state).map(function (o) {
        return { key: o, editable: !0, value: e.state[o] };
      }),
    };
  if (n.length) {
    var i = zd(t);
    r.getters = Object.keys(i).map(function (o) {
      return {
        key: o.endsWith("/") ? Qr(o) : o,
        editable: !1,
        value: yn(function () {
          return i[o];
        }),
      };
    });
  }
  return r;
}
function zd(e) {
  var t = {};
  return (
    Object.keys(e).forEach(function (s) {
      var n = s.split("/");
      if (n.length > 1) {
        var r = t,
          i = n.pop();
        n.forEach(function (o) {
          r[o] ||
            (r[o] = {
              _custom: {
                value: {},
                display: o,
                tooltip: "Module",
                abstract: !0,
              },
            }),
            (r = r[o]._custom.value);
        }),
          (r[i] = yn(function () {
            return e[s];
          }));
      } else
        t[s] = yn(function () {
          return e[s];
        });
    }),
    t
  );
}
function Zd(e, t) {
  var s = t.split("/").filter(function (n) {
    return n;
  });
  return s.reduce(
    function (n, r, i) {
      var o = n[r];
      if (!o)
        throw new Error('Missing module "' + r + '" for path "' + t + '".');
      return i === s.length - 1 ? o : o._children;
    },
    t === "root" ? e : e.root._children
  );
}
function yn(e) {
  try {
    return e();
  } catch (t) {
    return t;
  }
}
var Oe = function (t, s) {
    (this.runtime = s),
      (this._children = Object.create(null)),
      (this._rawModule = t);
    var n = t.state;
    this.state = (typeof n == "function" ? n() : n) || {};
  },
  Yr = { namespaced: { configurable: !0 } };
Yr.namespaced.get = function () {
  return !!this._rawModule.namespaced;
};
Oe.prototype.addChild = function (t, s) {
  this._children[t] = s;
};
Oe.prototype.removeChild = function (t) {
  delete this._children[t];
};
Oe.prototype.getChild = function (t) {
  return this._children[t];
};
Oe.prototype.hasChild = function (t) {
  return t in this._children;
};
Oe.prototype.update = function (t) {
  (this._rawModule.namespaced = t.namespaced),
    t.actions && (this._rawModule.actions = t.actions),
    t.mutations && (this._rawModule.mutations = t.mutations),
    t.getters && (this._rawModule.getters = t.getters);
};
Oe.prototype.forEachChild = function (t) {
  Bt(this._children, t);
};
Oe.prototype.forEachGetter = function (t) {
  this._rawModule.getters && Bt(this._rawModule.getters, t);
};
Oe.prototype.forEachAction = function (t) {
  this._rawModule.actions && Bt(this._rawModule.actions, t);
};
Oe.prototype.forEachMutation = function (t) {
  this._rawModule.mutations && Bt(this._rawModule.mutations, t);
};
Object.defineProperties(Oe.prototype, Yr);
var vt = function (t) {
  this.register([], t, !1);
};
vt.prototype.get = function (t) {
  return t.reduce(function (s, n) {
    return s.getChild(n);
  }, this.root);
};
vt.prototype.getNamespace = function (t) {
  var s = this.root;
  return t.reduce(function (n, r) {
    return (s = s.getChild(r)), n + (s.namespaced ? r + "/" : "");
  }, "");
};
vt.prototype.update = function (t) {
  Xr([], this.root, t);
};
vt.prototype.register = function (t, s, n) {
  var r = this;
  n === void 0 && (n = !0);
  var i = new Oe(s, n);
  if (t.length === 0) this.root = i;
  else {
    var o = this.get(t.slice(0, -1));
    o.addChild(t[t.length - 1], i);
  }
  s.modules &&
    Bt(s.modules, function (l, a) {
      r.register(t.concat(a), l, n);
    });
};
vt.prototype.unregister = function (t) {
  var s = this.get(t.slice(0, -1)),
    n = t[t.length - 1],
    r = s.getChild(n);
  r && r.runtime && s.removeChild(n);
};
vt.prototype.isRegistered = function (t) {
  var s = this.get(t.slice(0, -1)),
    n = t[t.length - 1];
  return s ? s.hasChild(n) : !1;
};
function Xr(e, t, s) {
  if ((t.update(s), s.modules))
    for (var n in s.modules) {
      if (!t.getChild(n)) return;
      Xr(e.concat(n), t.getChild(n), s.modules[n]);
    }
}
function Yd(e) {
  return new ve(e);
}
var ve = function (t) {
    var s = this;
    t === void 0 && (t = {});
    var n = t.plugins;
    n === void 0 && (n = []);
    var r = t.strict;
    r === void 0 && (r = !1);
    var i = t.devtools;
    (this._committing = !1),
      (this._actions = Object.create(null)),
      (this._actionSubscribers = []),
      (this._mutations = Object.create(null)),
      (this._wrappedGetters = Object.create(null)),
      (this._modules = new vt(t)),
      (this._modulesNamespaceMap = Object.create(null)),
      (this._subscribers = []),
      (this._makeLocalGettersCache = Object.create(null)),
      (this._scope = null),
      (this._devtools = i);
    var o = this,
      l = this,
      a = l.dispatch,
      c = l.commit;
    (this.dispatch = function (p, I) {
      return a.call(o, p, I);
    }),
      (this.commit = function (p, I, B) {
        return c.call(o, p, I, B);
      }),
      (this.strict = r);
    var f = this._modules.root.state;
    Vs(this, f, [], this._modules.root),
      jn(this, f),
      n.forEach(function (m) {
        return m(s);
      });
  },
  Kn = { state: { configurable: !0 } };
ve.prototype.install = function (t, s) {
  t.provide(s || Nd, this), (t.config.globalProperties.$store = this);
  var n = this._devtools !== void 0 ? this._devtools : !1;
  n && Gd(t, this);
};
Kn.state.get = function () {
  return this._state.data;
};
Kn.state.set = function (e) {};
ve.prototype.commit = function (t, s, n) {
  var r = this,
    i = Es(t, s, n),
    o = i.type,
    l = i.payload,
    a = { type: o, payload: l },
    c = this._mutations[o];
  c &&
    (this._withCommit(function () {
      c.forEach(function (m) {
        m(l);
      });
    }),
    this._subscribers.slice().forEach(function (f) {
      return f(a, r.state);
    }));
};
ve.prototype.dispatch = function (t, s) {
  var n = this,
    r = Es(t, s),
    i = r.type,
    o = r.payload,
    l = { type: i, payload: o },
    a = this._actions[i];
  if (a) {
    try {
      this._actionSubscribers
        .slice()
        .filter(function (f) {
          return f.before;
        })
        .forEach(function (f) {
          return f.before(l, n.state);
        });
    } catch {}
    var c =
      a.length > 1
        ? Promise.all(
            a.map(function (f) {
              return f(o);
            })
          )
        : a[0](o);
    return new Promise(function (f, m) {
      c.then(
        function (p) {
          try {
            n._actionSubscribers
              .filter(function (I) {
                return I.after;
              })
              .forEach(function (I) {
                return I.after(l, n.state);
              });
          } catch {}
          f(p);
        },
        function (p) {
          try {
            n._actionSubscribers
              .filter(function (I) {
                return I.error;
              })
              .forEach(function (I) {
                return I.error(l, n.state, p);
              });
          } catch {}
          m(p);
        }
      );
    });
  }
};
ve.prototype.subscribe = function (t, s) {
  return Hr(t, this._subscribers, s);
};
ve.prototype.subscribeAction = function (t, s) {
  var n = typeof t == "function" ? { before: t } : t;
  return Hr(n, this._actionSubscribers, s);
};
ve.prototype.watch = function (t, s, n) {
  var r = this;
  return Gt(
    function () {
      return t(r.state, r.getters);
    },
    s,
    Object.assign({}, n)
  );
};
ve.prototype.replaceState = function (t) {
  var s = this;
  this._withCommit(function () {
    s._state.data = t;
  });
};
ve.prototype.registerModule = function (t, s, n) {
  n === void 0 && (n = {}),
    typeof t == "string" && (t = [t]),
    this._modules.register(t, s),
    Vs(this, this.state, t, this._modules.get(t), n.preserveState),
    jn(this, this.state);
};
ve.prototype.unregisterModule = function (t) {
  var s = this;
  typeof t == "string" && (t = [t]),
    this._modules.unregister(t),
    this._withCommit(function () {
      var n = Un(s.state, t.slice(0, -1));
      delete n[t[t.length - 1]];
    }),
    Gr(this);
};
ve.prototype.hasModule = function (t) {
  return typeof t == "string" && (t = [t]), this._modules.isRegistered(t);
};
ve.prototype.hotUpdate = function (t) {
  this._modules.update(t), Gr(this, !0);
};
ve.prototype._withCommit = function (t) {
  var s = this._committing;
  (this._committing = !0), t(), (this._committing = s);
};
Object.defineProperties(ve.prototype, Kn);
const Xd = Yd({
    state: {
      active: !1,
      isDev: !1,
      selectedCategory: "all",
      settingState: !1,
      settings: { menuType: "default", streamer_mode: !1, show_gif: !0 },
      counts: {
        dances: 0,
        expressions: 0,
        walks: 0,
        gestures: 0,
        shared: 0,
        favorites: 0,
      },
      searchText: "",
      locales: {
        description: "Click on the button to see the animation",
        animations: "Animations",
        quick_animations: "Quick Animations",
        search_placeholder: "Search",
        accept_shared_anim: "Accept [Y]",
        decline_shared_anim: "Decline [H]",
        settings_header: "SETTINGS",
        settings_header_1: "MENU TYPE",
        settings_description_1:
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptates.",
        settings_menu_type_1: "Default",
        settings_menu_type_2: "Medium",
        settings_menu_type_3: "Minimal",
        settings_header_2: "BUTTONS",
        settings_description_2:
          "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptates.",
        settings_button_streamer_mode: "Streamer Mode",
        settings_button_show_gif: "Show Gifs",
        settings_header_3: "SEQUENCES",
        settings_description_3:
          "You can create your own sequences by clicking and selecting animations",
        select_sequence: "Select Sequence",
        seconds: " seconds",
        sequence_clear_button: "CLEAR",
        sequence_remove_button: "REMOVE",
        sequence_save_button: "SAVE",
        sequence_command: "/sequence",
      },
      notifications: [],
      Animations: [
        {
          category: "emotes",
          id: "kneels",
          label: "Feet Play | [Man - 1] +18",
        },
        { category: "emotes", id: "barber", label: "Barber" },
        { category: "emotes", id: "adjust", label: "Adjust" },
        { category: "emotes", id: "call", label: "Calling" },
        { category: "dances", id: "dances_1", label: "Dance 1" },
        {
          category: "emotes",
          id: "kneels",
          label: "Feet Play | [Man - 1] +18",
        },
        { category: "emotes", id: "adjust", label: "Adjust" },
        { category: "emotes", id: "call", label: "Calling" },
        { category: "dances", id: "dances_1", label: "Dance 1" },
        {
          category: "emotes",
          id: "kneels",
          label: "Feet Play | [Man - 1] +18",
        },
        { category: "emotes", id: "adjust", label: "Adjust" },
        { category: "emotes", id: "call", label: "Calling" },
        { category: "dances", id: "dances_1", label: "Dance 1" },
        {
          category: "emotes",
          id: "kneels",
          label: "Feet Play | [Man - 1] +18",
        },
        { category: "emotes", id: "adjust", label: "Adjust" },
        { category: "emotes", id: "call", label: "Calling" },
        { category: "dances", id: "dances_1", label: "Dance 1" },
        {
          category: "emotes",
          id: "kneels",
          label: "Feet Play | [Man - 1] +18",
        },
        { category: "emotes", id: "adjust", label: "Adjust" },
        { category: "emotes", id: "call", label: "Calling" },
        { category: "dances", id: "dances_1", label: "Dance 1" },
        {
          category: "emotes",
          id: "kneels",
          label: "Feet Play | [Man - 1] +18",
        },
        { category: "emotes", id: "adjust", label: "Adjust" },
        { category: "emotes", id: "call", label: "Calling" },
        { category: "dances", id: "dances_1", label: "Dance 1" },
        { category: "dances", id: "dances_2", label: "Dance 2" },
        { category: "dances", id: "dances_3", label: "Dance 3" },
        { category: "dances", id: "dances_1000", label: "Dance 1000" },
        { category: "dances", id: "dances_1001", label: "Dance 1001" },
      ],
      Categories: [
        { id: "all", label: "All", icon: "fas fa-house" },
        { id: "favorites", label: "Favorites", icon: "fas fa-star" },
        { id: "sequences", label: "Sequences", icon: "fas fa-stopwatch" },
        { id: "general", label: "General", icon: "fas fa-male" },
        { id: "dances", label: "Dances", icon: "fas fa-running" },
        { id: "expressions", label: "Expressions", icon: "fas fa-laugh-beam" },
        { id: "walks", label: "Walks", icon: "fas fa-running" },
        { id: "custom", label: "Custom Emotes", icon: "fas fa-male" },
        { id: "erp", label: "Erotic Emotes", icon: "fas fa-venus-mars" },
        { id: "erp", label: "Erotic Emotes", icon: "fas fa-venus-mars" },
        { id: "erp", label: "Erotic Emotes", icon: "fas fa-venus-mars" },
        { id: "erp", label: "Erotic Emotes", icon: "fas fa-venus-mars" },
      ],
      shortcuts:
        localStorage.getItem("shortcutAnims") != null
          ? JSON.parse(localStorage.getItem("shortcutAnims"))
          : [],
      favorites:
        localStorage.getItem("favoriteAnims") != null
          ? JSON.parse(localStorage.getItem("favoriteAnims"))
          : {},
      sequences:
        localStorage.getItem("sequencesAnims") != null
          ? JSON.parse(localStorage.getItem("sequencesAnims"))
          : [],
      sequenceSelection: !1,
      selectedSequence: "",
    },
    getters: {},
    mutations: {
      addNotification(e, t) {
        (t.initialTimeout = t.timeout || 5),
          (t.id = e.notifications.length + 1),
          e.notifications.push(t);
      },
      timerNotification(e) {
        e.notifications = e.notifications.filter((t) =>
          t
            ? (t.initialTimeout || (t.initialTimeout = t.timeout || 5),
              (t.timeout -= 1),
              t.timeout > 0)
            : !1
        );
      },
      addNewSequence(e, t) {
        t.time = 1;
        var s = e.selectedSequence,
          n = localStorage.getItem("sequencesAnims");
        if (
          (n === null ? (e.sequences = []) : (e.sequences = JSON.parse(n)),
          s === "")
        ) {
          var r = e.sequences.length;
          e.sequences.push({
            id: r,
            category: "sequences",
            label: "Sequence " + (r + 1),
            anims: [t],
          }),
            (e.selectedSequence = r);
        } else e.sequences[s].anims.push(t);
        (e.settingsState = !0),
          (e.sequenceSelection = !1),
          localStorage.setItem("sequencesAnims", JSON.stringify(e.sequences)),
          $.post(
            "https://nxo-emotemenu/getSequences",
            JSON.stringify({ sequences: e.sequences })
          );
      },
      removeSequence(e) {
        var t = e.selectedSequence;
        delete e.sequences[t],
          (e.sequences = e.sequences.filter((s) => s != null)),
          e.sequences.length === 0 &&
            ((e.sequences = []),
            e.selectedCategory === "sequences" && (e.selectedCategory = "all")),
          (e.selectedSequence = ""),
          (e.sequenceSelection = !1),
          localStorage.setItem("sequencesAnims", JSON.stringify(e.sequences)),
          $.post(
            "https://nxo-emotemenu/getSequences",
            JSON.stringify({ sequences: e.sequences })
          );
      },
      removeSingleSequence(e, t) {
        var s = e.selectedSequence;
        (e.sequences[s].anims = e.sequences[s].anims.filter(
          (n) => n.id !== t.id
        )),
          localStorage.setItem("sequencesAnims", JSON.stringify(e.sequences)),
          $.post(
            "https://nxo-emotemenu/getSequences",
            JSON.stringify({ sequences: e.sequences })
          );
      },
      clearSequence(e) {
        var t = e.selectedSequence;
        (e.sequences[t].anims = []),
          localStorage.setItem("sequencesAnims", JSON.stringify(e.sequences)),
          $.post(
            "https://nxo-emotemenu/getSequences",
            JSON.stringify({ sequences: e.sequences })
          );
      },
      saveCurrentSequence(e, t) {
        (e.sequences[e.selectedSequence] = t),
          localStorage.setItem("sequencesAnims", JSON.stringify(e.sequences)),
          $.post(
            "https://nxo-emotemenu/getSequences",
            JSON.stringify({ sequences: e.sequences })
          );
      },
    },
    actions: {},
    modules: {},
  }),
  eh = "modulepreload",
  th = function (e, t) {
    return new URL(e, t).href;
  },
  Li = {},
  Di = function (t, s, n) {
    let r = Promise.resolve();
    if (s && s.length > 0) {
      const i = document.getElementsByTagName("link");
      r = Promise.all(
        s.map((o) => {
          if (((o = th(o, n)), o in Li)) return;
          Li[o] = !0;
          const l = o.endsWith(".css"),
            a = l ? '[rel="stylesheet"]' : "";
          if (!!n)
            for (let m = i.length - 1; m >= 0; m--) {
              const p = i[m];
              if (p.href === o && (!l || p.rel === "stylesheet")) return;
            }
          else if (document.querySelector(`link[href="${o}"]${a}`)) return;
          const f = document.createElement("link");
          if (
            ((f.rel = l ? "stylesheet" : eh),
            l || ((f.as = "script"), (f.crossOrigin = "")),
            (f.href = o),
            document.head.appendChild(f),
            l)
          )
            return new Promise((m, p) => {
              f.addEventListener("load", m),
                f.addEventListener("error", () =>
                  p(new Error(`Unable to preload CSS for ${o}`))
                );
            });
        })
      );
    }
    return r
      .then(() => t())
      .catch((i) => {
        const o = new Event("vite:preloadError", { cancelable: !0 });
        if (((o.payload = i), window.dispatchEvent(o), !o.defaultPrevented))
          throw i;
      });
  },
  sh = {
    name: "AssetLoader",
    props: { src: { type: String, required: !0 } },
    data: () => ({ loaded: !1, source: "" }),
    async mounted() {
      if (!this.$store.state.isDev) {
        (this.source = `https://cfx-nui-nxo-emotemenu/html/${this.src}`),
          (this.loaded = !0);
        return;
      }
      Di(
        () => import(`../../public/${this.src}`),
        __vite__mapDeps([]),
        import.meta.url
      ).then((e) => {
        (this.loaded = !0), (this.source = e.default);
      });
    },
    updated() {
      if (!this.$store.state.isDev) {
        (this.source = `https://cfx-nui-nxo-emotemenu/html/${this.src}`),
          (this.loaded = !0);
        return;
      }
      Di(
        () => import(`../../public/${this.src}`),
        __vite__mapDeps([]),
        import.meta.url
      ).then((e) => {
        (this.loaded = !0), (this.source = e.default);
      });
    },
  },
  nh = ["src"];
function ih(e, t, s, n, r, i) {
  return e.loaded
    ? (A(), w("img", { key: 0, src: e.source }, null, 8, nh))
    : z("", !0);
}
const rh = Je(sh, [["render", ih]]);
Ra(Id).use(Xd).component("loadImage", rh).mount("#app");
function __vite__mapDeps(indexes) {
  if (!__vite__mapDeps.viteFileDeps) {
    __vite__mapDeps.viteFileDeps = [];
  }
  return indexes.map((i) => __vite__mapDeps.viteFileDeps[i]);
}
