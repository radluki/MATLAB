function rysuj(fun,x1,y1,x0,d,x_min,y_min,mode)
%% RYSUJ - kreśli wykresy funkcji dwuch zmiennych
% fun funkcja w formacie np. fun = @(x1,x2) koszt([x1 x2]);
% x1, y1 cellki zawierające współrzędne wszystkich punktów wygenerowanych
% podczas szukania na kierunku
% x0 - celka zawierająca punkty początkowe poszukiwań na k.
% d - wektory poszukiwań
% x_min, y_min minima na kierunku
% mode - [ a b c] , a - łączyć wszystkie punkty na kierunku,
% czy tylko optymalne  b - czy umieścić na contour wszystkie punkty
% c - dodatkowe poziomice (liczba)
if iscell(x0)
    x1c = x1;
    y1c = y1;
    x0c =x0;
    dc = d;
    x_minc = x_min;
    y_minc = y_min;
end
l_iter = length(x0);
x1cw = [x1c{:}];
xmin = min(x1cw);
xmax = max(x1cw);
y1cw = [y1c{:}];
ymin = min(y1cw);
ymax = max(y1cw);
xx = linspace(xmin,xmax,300);
yy = linspace(ymin,ymax,300);
[X,Y] = meshgrid(xx,yy);
Z = fun(X,Y);
zz = fun(xx,yy);

figure(1)
mesh(X,Y,Z)
hold on
xlabel('x')
ylabel('y')
zlabel('z')

figure(2)
hold on
x00 = x0{1};
contour(X,Y,Z,[fun(x00(1),x00(2)),0],'b')
plot(x00(1),x00(2),'xb')
x11 = x_min{1};
plot([x00(1), x11(1) ],[x00(2), x11(2)])


for ig = 1:l_iter
    x1=x1c{ig};
    y1 = y1c{ig};
    x0 = x0c{ig};
    d = dc{ig};
    x_min = x_minc{ig};
    y_min = y_minc{ig};
    if 1
       figure(3)
       hold on
       zl = fun(x1,y1);
       ti = (x1 -x0(1))/d(1);
       tp = min(ti); tk = max(ti);
       plot(ti, zl,'og');
       t_min = (x_min-x0);
       t_min = t_min(1)./d(1);
       plot(t_min, y_min,'*r');
      % hold off
       xlabel('t')
       ylabel('z')
        t = linspace(tp,tk,100);
       xline = x0(1)+t.*d(1);
       yline = x0(2)+t.*d(2);
       z1 = fun(xline, yline);
       plot(t,z1)
    end

    
    figure(1)
    %plot3(xx,yy,zz)
    plot3(x1,y1,fun(x1,y1),'xg')% punkty na prostej
    plot3(x_min(1),x_min(2),fun(x_min(1),x_min(2)),'*r')
    % hold off

    figure(2)
    if length(mode)>2
        contour(X,Y,Z,mode(3));
    end
    if mode(1)==1
        contour(X,Y,Z,[y_min;0],'b')%fun(x1,y1)
        plot(x1,y1,'g')
    else
        contour(X,Y,Z,[y_min;0],'b');
        if ig>1
            x_min_old = x_minc{ig-1};
            XXX = [x_min_old;x_min];
            plot(XXX(:,1),XXX(:,2),'r')
        end
    end
    hold on
    if mode(2) == 1
        plot(x1,y1,'og')
    end
    
    plot(x_min(1),x_min(2),'*r')
    % hold off
    xlabel('x')
    ylabel('y')
end