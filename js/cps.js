// Tail-recursive factorial
const tail_fact = (n, a) =>
  n == 0 ? a : tail_fact(n - 1, n * a)

const fact = n =>
  tail_fact(n, 1)

// After CPS translation
const cps_tail_fact = (n, a, cc) =>
  n == 0 ? cc(a) : cps_tail_fact(n - 1, n * a, cc)

const cps_fact = (n, cc) =>
  cps_tail_fact(n, 1, cc)

const log = x => console.log(x)

const main = () => {
  log(fact(4))
  cps_fact(4, log)
}

main()
