{
type token = 
    SEMICOLON
  | RPARENT
  | RETURN
  | RBRACE
  | LPARENT
  | LBRACE
  | INT_LITERAL of (int)
  | INT_KEYWORD
  | IDENTIFIER of (string)
  | EOF

let string_of_token = function
    SEMICOLON -> ";"
  | RPARENT -> ")"
  | LPARENT -> "("
  | RETURN -> "return"
  | RBRACE -> "}"
  | LBRACE -> "{"
  | INT_LITERAL(i) -> Printf.sprintf "%d" i
  | INT_KEYWORD -> "int"
  | IDENTIFIER(s) -> s
  | EOF -> "EOF"

module L = Lexing 
module B = Buffer

let position lexbuf =
  let p = lexbuf.L.lex_curr_p in
  Printf.sprintf "%s:%d:%d" 
    p.L.pos_fname p.L.pos_lnum (p.L.pos_cnum - p.L.pos_bol)

exception Error of string
let error lexbuf fmt = 
  Printf.kprintf (fun msg -> 
      raise (Error ((position lexbuf)^" "^msg))) fmt
}

let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']

    rule token = parse
          | ' '+ { token lexbuf }
          | '\n' { Lexing.new_line lexbuf; token lexbuf }
          | digit+ { INT_LITERAL(Lexing.lexeme lexbuf |> int_of_string) }
          | alpha(alpha | digit)* { IDENTIFIER(Lexing.lexeme lexbuf) }
          | '(' { LPARENT }
          | ')' { RPARENT }
          | '{' { LBRACE }
          | '}' { RBRACE }
          | ';' { SEMICOLON }
          | "return" { RETURN }
          | eof { EOF }
          | _ { error lexbuf "UNKNOWN CHAR" }


              {
                let lex input = 
                  let lexbuf = Lexing.from_string input in
                  let rec aux = function
                      EOF -> [EOF]
                    | tok -> tok::(aux (token lexbuf))
                  in aux (token lexbuf)
              }
