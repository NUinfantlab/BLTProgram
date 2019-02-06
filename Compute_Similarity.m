function s = Compute_Similarity(timeOn1, timeOn2)
% sim: This function computes the observer % similarity.
% Input m must be a 2 X 2 matrix.
if ( (timeOn1 == 0) || (timeOn2 == 0))
    s = 0;
else
    if (timeOn1 > timeOn2)
        s = timeOn2 / timeOn1;
    else
        s = timeOn1 / timeOn2;
    end
end

end