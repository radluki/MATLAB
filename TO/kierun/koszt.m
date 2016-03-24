function [q,x]=koszt(x,z,d)

% KOSZT wylicza wska�nik jako�ci dla wektora zmiennych
% decyzyjnych x+z*d.
global zad
if nargin==2, x=x+z;
elseif nargin==3, x=x+z*d;
end
% q=x(1)*exp(x(1))+1.54*x(1)*exp(-x(1))-3.5*exp(x(1))-5.38*exp(-x(1))+9.7;
% q=q*q;
%if nargin == 2
    len = size(x,2)/2;
if len*2>1 % dwie zmienne
    x1 = x(:,1:len);
    x2 = x(:,len+1:end);
    %q = x1.^2 + x2.^2;
    q = x1.^2 + x1.*x2 +0.5*x2.^2 -2*x2 -3*x1 +2.5;
elseif ((len*2==1) && ( zad == 3 ))
    global a_wsp;
    q = polyval(a_wsp,x).^2;
   %q = x.^2
elseif zad == 5
    global a b
    q = max([a*x'; b*x'])';
elseif zad==4
    q = abs(x-5).^1.6;
end
%end