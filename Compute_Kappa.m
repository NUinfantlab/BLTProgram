function k = Compute_Kappa(m)
% KAPPA: This function computes the Cohen's kappa coefficient.
% Input m must be a 2 X 2 matrix.

if ( (size(m,1) ~= 2) || (size(m,2) ~= 2))
    k=0;
    return;
end

n = sum(sum(m));
P0 = ( m(1,1) + m(2,2) ) / n;
Pc = ( ((m(1,1) + m(2,1)) * (m(1,1) + m(1,2)) ) + ((m(1,2) + m(2,2)) * (m(2,1) + m(2,2)) ) ) / (n*n);
k = (P0 - Pc) / (1 - Pc);

end