function a = Compute_Agr(m)
% agr: This function computes the observer % agreement.
% Input m must be a 2 X 2 matrix.

if ( (size(m,1) ~= 2) || (size(m,2) ~= 2))
    return;
end

n = sum(sum(m));
a = (m(1,1) + m(2,2)) / n;

end