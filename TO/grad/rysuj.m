function rysuj(punkty)
    xmin =min(punkty(1,:));
    ymin = min(punkty(2,:));
    xmax =max(punkty(1,:));
    ymax = max(punkty(2,:));
    ddxx = 1
    xmin = xmin - ddxx;
    ymin = ymin - ddxx;
    xmax = xmax + ddxx;
    ymax = ymax + ddxx;
    xx1 = linspace(xmin,xmax,300);
    yy1 = linspace(ymin,ymax,300);
    [X,Y] = meshgrid(xx1,yy1);
    fun = @(x1,x2)  koszt({x1 x2});
    Z = fun(X,Y);
    
    figure(1)
    contour(X,Y,Z,300);
    hold on
    plot(punkty(1,:),punkty(2,:))
    for i = 1 : length(punkty(1,:));
        text(punkty(1,i),punkty(2,i),num2str(i));
    end
    hold off
    figure(2)
    mesh(X,Y,Z)
    figure(3)
    norma = sqrt(sum((punkty-repmat(punkty(:,end),1,size(punkty,2))).^2));
    plot(norma,'o-')
    title('Dystans do punktu końcowego')
    x0 = punkty(:,end)
    %fprintf('xopt = (%d,%d)\n',x0(1),x0(2))