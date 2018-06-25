let test_compiler = [
  "info exists", `Quick, (fun () -> Alcotest.(check string) "strings" "occ2" Compiler.info)
]

let lex_string input expected_output = 
    Alcotest.(check (list string)) 
        (Printf.sprintf "checking %s" input) 
        expected_output
        (Lexer.lex input |> List.map Lexer.string_of_token) 

let simple_lex_string input = lex_string input [input; "EOF"]

let test_single_token_lexer = [
  "parses (", `Quick, (fun () -> simple_lex_string "(");
  "parses )", `Quick, (fun () -> simple_lex_string ")");
  "parses {", `Quick, (fun () -> simple_lex_string "{");
  "parses }", `Quick, (fun () -> simple_lex_string "}");
  "parses ;", `Quick, (fun () -> simple_lex_string ";");
  "parses return", `Quick, (fun () -> simple_lex_string "return");
  "parses identifier", `Quick, (fun () -> simple_lex_string "abcde12");
  "parses int literal", `Quick, (fun () -> simple_lex_string "12233");
  "parses int keyword", `Quick, (fun () -> simple_lex_string "int");
  "parses EOF", `Quick, (fun () -> lex_string "" ["EOF"]);
]

let test_parser = [
  "info exists", `Quick, (fun () -> Alcotest.(check string) "strings" "parser" Parser.info)
]

let () =
  Alcotest.run "everything" [
    "single token lexer", test_single_token_lexer;
    "parser", test_parser;
    "compiler", test_compiler;
  ] 
