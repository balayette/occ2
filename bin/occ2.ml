let () = 
    print_string (String.concat "\n" [
        Compiler.info;
        Lexer.info;
        Parser.info
    ]);     
    print_string "\nSetup complete!\n";
