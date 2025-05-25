fibonacci(0, 0).                 % Caso base: Fibonacci de 0 es 0
fibonacci(1, 1).                 % Caso base: Fibonacci de 1 es 1
fibonacci(N, Result) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, Result1),      % Llama recursivamente para F(N-1)
    fibonacci(N2, Result2),      % Llama recursivamente para F(N-2)
    Result is Result1 + Result2. % Suma los resultados