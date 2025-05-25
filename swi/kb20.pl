factorial(0, 1).                 % Caso base: el factorial de 0 es 1
factorial(N, Result) :-
    N > 0,                     % N debe ser mayor que 0
    N1 is N - 1,               % Calcula N-1
    factorial(N1, Result1),    % Llama recursivamente para factorial(N-1)
    Result is N * Result1.     % Multiplica N por el resultado de factorial(N-1)