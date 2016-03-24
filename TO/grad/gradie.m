function g=gradie(x)

% GRADIE Wyznacza analitycznie gradient funkcji kosztu w punkcie X.


 x1 = x(1);
 x2 = x(2);
global zad
global a
global rodz_grad
if rodz_grad == 1
    if zad == 1 || zad == 3
        g = [2*x1; 2*a*x2];
    elseif zad == 2 || zad == 4
        g = [12*x1 + 6*x2 + 4.5*(exp(x1)-1); 6*x1 + 2*x2 + 1.5*(exp(x2)-1)];
    elseif zad == 5
        g = [200*(x2-x1.^2)*(-2*x1) - 2*(1-x1); 200*(x2-x1.^2)];
    end
else
    dx = 1e-5;
    g = [ (koszt([x1+dx x2])-koszt([x1, x2]))/dx; (koszt([x1 x2+dx])-koszt([x1, x2]))/dx]
end