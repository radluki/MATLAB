function [q,x]=koszt(x,z,d)

% KOSZT wylicza wska�nik jako�ci dla wektora zmiennych
% decyzyjnych x+z*d.

if nargin==2, x=x+z;
elseif nargin==3, x=x+z*d;
end

if iscell(x)
    x1 = x{1};
    x2 = x{2};
    n = 2;
else
    x1 = x(1);
    x2 = x(2);
    n = length(x(:,1));
end

if n==4
e1=x(1)-1;
e2=x(2)-1;
e3=x(3)-1;
e4=x(4)-1;
q=100*(x(1)^2-x(2))^2+e1^2+90*(x(3)^3-x(4))^2;
q=q+e3^2+10.1*(e2^2+e4^2)+19.8*e2*e4;
%q=100*(x(2)-x(1)^2)^2+(1-x(1)^2)^2;
q = e1.^2+e2.^2+e3.^2+e4.^2;
elseif n==2
    %Dolina bananowa
    %q = 100*(x1-x2.^2).^2+(1-x1).^2;
   %q = 7*abs(x1-5).^2.3 +2*x1.*x2+ 1*abs(x2-3).^2.2;
  %zadanie z kolokwium
   q = 10*(x1+x2-5).^2 + (x1-x2).^2;
end