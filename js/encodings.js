const Print =
  x => console.log(`${x}`)

Print('---')

const Id = x => x

const Unit = Id

const Const =
  x => _ => x

const B = {
  True: Const,
  False: _ => y => y,
  // Use the `Unit` to prevent being stuck at the `p`, due to eager evaluation.
  IfThenElse: p => a => b => p(a)(b)(Unit),
  show: b => b('True')('False')
}

const CN = {
  type: 'church',
  Z: _ => x => x,
  Suc: n => f => x => f(n(f)(x)),
  IsZ: n => n(_ => B.False)(B.True),
  Add: m => n => m(CN.Suc)(n),
  Pred: n => f => x => n(g => h => h(g(f)))(_ => x)(u => u),
  show: n => n(x => x + 1)(0)
}

Print(`Numerals: ${CN.type}`)
Print(CN.show(CN.Z))
Print(CN.show(CN.Suc(CN.Z)))
Print(B.show(CN.IsZ(CN.Z)))
Print(B.show(CN.IsZ(CN.Suc(CN.Z))))
Print(CN.show(CN.Add(CN.Suc(CN.Z))(CN.Suc(CN.Z))))
Print(CN.show(CN.Pred(CN.Suc(CN.Z))))
Print('---')

const SN = {
  type: 'scott',
  Z: _ => x => x,
  Suc: n => f => _ => f(n),
  IsZ: n => n(_ => B.False)(B.True),
  // The 'fold' operation for N, or the recursor.
  Rec: n => f => x => n(pred => SN.Suc(SN.Rec(pred)(f)(x)))(x),
  Add: m => n => SN.Rec(m)(SN.Suc)(n),
  Pred: n => n(Id)(n),
  show: n => n(x => SN.show(x) + 1)(0)
}

Print(`Numerals: ${SN.type}`)
Print(SN.show(SN.Z))
Print(SN.show(SN.Suc(SN.Z)))
Print(B.show(SN.IsZ(SN.Z)))
Print(B.show(SN.IsZ(SN.Suc(SN.Z))))
Print(SN.show(SN.Add(SN.Suc(SN.Z))(SN.Suc(SN.Z))))
Print(SN.show(SN.Pred(SN.Suc(SN.Z))))
Print('---')

Print('Booleans:')
Print(B.show(B.True))
Print(B.show(B.False))
Print(CN.show(B.IfThenElse(B.True)(_ => CN.Z)(_ => CN.Suc(CN.Z))))
Print(CN.show(B.IfThenElse(B.False)(_ => CN.Z)(_ => CN.Suc(CN.Z))))
Print('---')

const Pair =
  x => y => f => f(x)(y)

const Fst =
  p => p(B.True)

const Snd =
  p => p(B.False)

Print('Pair:')
Print(CN.show(Fst(Pair(CN.Z)(CN.Suc(CN.Z)))))
Print(CN.show(Snd(Pair(CN.Z)(CN.Suc(CN.Z)))))
Print('---')

const Left =
  x => f => _ => f(x)

const Right =
  y => _ => g => g(y)

const CaseOf = Id

Print('Sum:')
Print(CN.show(CaseOf(Left(CN.Z))(_ => CN.Z)(_ => CN.Suc(CN.Z))))
Print(CN.show(CaseOf(Right(CN.Z))(_ => CN.Z)(_ => CN.Suc(CN.Z))))
Print('---')

// This is not the Y combinator, but a Z combinator.  It's impossible to have
// one in such a non-lazy language.
const Fix =
  f => (x => f(y => x(x)(y)))(x => f(y => x(x)(y)))

Print('Fix:')
Print(CN.show(
  Fix(f => n =>
    B.IfThenElse(
      CN.IsZ(n)
    )(
      _ => CN.Z
    )(
      _ => CN.Add(f(CN.Pred(n)))(n)
    )
  )(
    CN.Suc(CN.Suc(CN.Suc(CN.Z)))
  )
))
Print('---')
