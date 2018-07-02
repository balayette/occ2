let test_compiler  = [
  "info exists", `Quick, (fun () -> Alcotest.(check string) "strings" "occ2" Compiler.info)
]

let test_parser = [
  "info exists", `Quick, (fun () -> Alcotest.(check string) "strings" "parser" Parser.info)
]

let () =
    Alcotest.run "everything" [
        "lexer tests", Lexer_tests.tests;
        "parser tests", test_parser;
        "compiler tests", test_compiler;
]
