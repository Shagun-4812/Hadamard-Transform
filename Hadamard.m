% Example usage:
xn = [1; 0; 1; 0; 0; 1; 1; 0];
Xk = Hadamard_transform(xn);
disp(Xk);

function Xk = Hadamard_transform(xn)
    % Input:
    % xn: Input vector of length 2^m (where m is a non-negative integer)
    
    % Compute the size of the input vector
    N = length(xn);
    
    % Check if N is a power of 2
    if log2(N) ~= round(log2(N))
        error('Input vector length must be a power of 2.');
    end
    
    % Initialize the Hadamard matrix
    Hm = hadamard_matrix(N);
    
    % Compute the Hadamard transform
    Xk = Hm * xn(:);  % Ensure xn is a column vector
    
    % Output:
    % Xk: Transformed vector
end

function Hm = hadamard_matrix(N)
    % Input:
    % N: Size of the Hadamard matrix (must be a power of 2)
    
    % Check if N is a power of 2
    if log2(N) ~= round(log2(N))
        error('Input size must be a power of 2.');
    end
    
    % Initialize Hadamard matrix of size N
    Hm = hadamard_recursive(N);
    
    % Normalize the Hadamard matrix
    Hm = Hm / sqrt(N);
end

function Hm = hadamard_recursive(N)
    % Recursive construction of Hadamard matrix
    
    % Base case
    if N == 1
        Hm = 1;
    else
        % Recursive construction
        Hm_prev = hadamard_recursive(N/2);
        Hm = [Hm_prev, Hm_prev; Hm_prev, -Hm_prev];
    end
end
