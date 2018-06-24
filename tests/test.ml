let test_compiler = [
    "info exists", `Quick, (fun () -> Alcotest.(check string) "strings" "occ2" Compiler.info)
]

let test_lexer = [
    "info exists", `Quick, (fun () -> Alcotest.(check string) "strings" "lexer" Lexer.info)
]

let test_parser = [
    "info exists", `Quick, (fun () -> Alcotest.(check string) "strings" "parser" Parser.info)
]

let () =
    Alcotest.run "everything" [
        "lexer", test_lexer;
        "parser", test_parser;
        "compiler", test_compiler;
    ] 
