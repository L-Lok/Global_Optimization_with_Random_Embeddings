% ------------------------------------------------------------- %
% Hartmann6_function_ada(yy,Q,A,D,d,dim,p,bounds)
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
function [y] = Hartmann6_function_ada(yy,Q,A,D,d,dim,p,bounds)

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

alpha = [1.0, 1.2, 3.0, 3.2]';
A = [10, 3, 17, 3.5, 1.7, 8;
     0.05, 10, 17, 0.1, 8, 14;
     3, 3.5, 1.7, 10, 17, 8;
     17, 8, 0.05, 10, 0.1, 14];
P = 10^(-4) * [1312, 1696, 5569, 124, 8283, 5886;
               2329, 4135, 8307, 3736, 1004, 9991;
               2348, 1451, 3522, 2883, 3047, 6650;
               4047, 8828, 8732, 5743, 1091, 381];

outer = 0;
for i = 1:4
	inner = 0;
	for j = 1:6
		inner = inner + A(i,j)*(z{j}-P(i,j))^2;
	end
	new = alpha(i) * exp(-inner);
	outer = outer + new;
end

y = -outer;

end


