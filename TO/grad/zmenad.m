% ZMENAD Zawiera nast�puj�ce metody zmiennej metryki: 
%        - Davidona - Fletchera - Powella (par=0)
%        - Wolfe'a - Broydena - Davidona  (par=1)
%        - Broydena - Fletchera - Goldfarba - Shanno (par=2)
%        - Pearsona 1 (par=3)
%        - Pearsona 2 (par=4)
%        - McCormicka (par=5).
% Oznaczenia: maxit - maksymalna liczba iteracji g�rnego poziomu
%             x0 - aktualne przybli�enie rozwi�zania optymalnego
%             e0 - metoda si� zatrzymuje, gdy kwadrat normy gradientu
%                  n2 spadnie poni�ej e0
%             g - gradient
%             d - kierunek poszukiwania
%             v - aproksymacja odwrotno�ci hesjanu
%             czod - cz�sto�� odnowy.

maxit=100;
x0=[-2;3];
e0=1e-8;
n=length(x0);
czod=2*length(x0);
wskaz=0;

punkty = [x0];
par = 0
global a
global zad
zad = 2
a = 50
tic
for i=1:maxit
   g=gradie(x0);
   n2=g'*g;
   if n2<e0,break,end
   if rem(i,czod)==1|~wskaz
      v=eye(n);
   else
      r=g-gs;
      vr=v*r;
      if par==0                         % DFP
         s=x0-xs;
         v=v+s*s'/(r'*s)-vr*vr'/(r'*vr);
      elseif par==1                     % WBD    
         svr=x0-xs-vr;
         v=v+svr*svr'/(svr'*r);
      elseif par==2                     % BFGS
         s=x0-xs;
         sr=s'*r;
         vrs=vr*s';
         v=v+(1+r'*vr/sr)*s*s'/sr-(vrs+vrs')/sr;
      elseif par==3                     % P1
         v=v-vr*vr'/(vr'*r);
      elseif par==4                     % P2
         s=x0-xs;
         svr=s-vr;
         v=v+svr*vr'/(vr'*r);
      elseif par==5                     % McC
         s=x0-xs;
         sr=s'*r;
         svr=s-vr;
         v=v+svr*s'/sr;
      end
   end 
   d=-v*g;
   if d'*g<0
      gs=g;
      xs=x0;
      [x0,wskaz]=kierun(x0,d);
      punkty = [punkty x0];
   else
      wskaz=0;
   end
end
czas = toc
rysuj(punkty)