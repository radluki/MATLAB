function [q,x]=koszt(x,z,d)

% KOSZT wylicza wska�nik jako�ci dla wektora zmiennych
% decyzyjnych x+z*d.

if nargin==2, x=x+z;
elseif nargin==3, x=x+z*d;
end
if iscell(x)
    x1 = x{1};
    x2 = x{2};
else
    x1 = x(1);
    x2 = x(2);
end
global zad
global a
if zad == 1 || zad == 3
    q = x1.^2 + a*x2.^2;
elseif zad == 2 || zad == 4
    q = 6*x1.^2 + 6*x1.*x2 + x2.^2 + 4.5*(exp(x1) - x1 -1) + 1.5*(exp(x2) - x2 -1);
elseif zad == 5
    q = 100*(x2-x1.^2).^2 + (1-x1).^2;
elseif zad == 6
    global dane
    fun1 = @(a,w,fi,x) exp(-a*x)*sin(w*x + fi);
    fun2 = @(a,w,fi) -a*exp(-a*x)*sin(w*x + fi) + w*exp(-a*x)*cos(w*x +fi);
end