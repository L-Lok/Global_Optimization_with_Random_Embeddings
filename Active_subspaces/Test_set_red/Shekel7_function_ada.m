% ------------------------------------------------------------- %
% Shekel7_function_ada(yy,Q,A,D,d,dim,p,bounds)
%
% input:  yy     = optimal solution of reduced problem
%         Q      = orthogonal matrix for rotating the function  
%         A      = reduced matrix A
%         D      = dimension of the domain of the function
%         d      = dimension of the reduced problem
%         dim    = dimension of the effective subspace
%         p      = additional parameter p
%         bounds = bounds of the search domain of the function
% output: y      = output of the function
% ------------------------------------------------------------- %
function [y] = Shekel7_function_ada(yy,Q,A,D,d,dim,p,bounds)

y = cell(d,1);
for i = 1:d
   y{i} = yy(i);
end
 
x = cell(D,1);
for i = 1:D
    sum = 0;
    for j = 1 : d
       sum = sum + A(i,j)*y{j};
    end
    x{i} = sum + p(i);
end

z = cell(D,1);
 
for i = 1:dim
    sum1 = 0;
     
    for j = 1:D
        sum1 = sum1 + Q(j,i).*x{j};
    end
    z{i} = sum1; 
end

for i = 1:dim
    z{i} = ((bounds(i,2)-bounds(i,1)).*z{i}+(bounds(i,2)+bounds(i,1)))/2;
end

b = 0.1 * [1, 2, 2, 4, 4, 6, 3, 7, 5, 5]';
C = [4, 1, 8, 6, 3, 2, 5, 8, 6, 7;
     4, 1, 8, 6, 7, 9, 5, 1, 2, 3.6;
     4, 1, 8, 6, 3, 2, 3, 8, 6, 7;
     4, 1, 8, 6, 7, 9, 3, 1, 2, 3.6];

outer = 0;
for i = 1:7
    inner = 0;
	for j = 1:4
		inner = inner + (z{j}-C(j,i))^2;
	end
	outer = outer + 1/(inner+b(i));
end

y = -outer;

end


