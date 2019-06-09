(** Some monadic toys *)

module type MONAD =
sig
  type 'a t
  val return : 'a -> 'a t
  val (>>=) : 'a t -> ('a -> 'b t) -> 'b t
end

module type STATE =
sig
  type state
  include MONAD
  val get : state t
  val put : state -> unit t
  val run_state : 'a t -> init:state -> state * 'a
end

module State (S : sig type t end)
  : STATE with type state = S.t = struct
  type state = S.t
  type 'a t = state -> state * 'a
  let return v s = (s, v)
  let (>>=) m k s = let s', a = m s in k a s'
  let get s = (s, s)
  let put s' _ = (s', ())
  let run_state m ~init = m init
end

module IntState = State (struct type t = int end)

let fresh_name : string IntState.t =
  let open IntState in
  get         >>= fun i ->
  put (i + 1) >>= fun () ->
  return (Printf.sprintf "x%d" i)

let show_state s = print_endline (snd s)

let main () =
  let open IntState in
  show_state (run_state fresh_name 0);;

main ()
