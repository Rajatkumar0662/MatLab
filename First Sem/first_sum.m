% This script uses 'n' as a number
% Finds sum from 1 to n

function [  ] = first_sum(n)
sum=0;
for i=1:n
    sum=sum+i;
end
fprintf('sum is %d\n',sum);

end

