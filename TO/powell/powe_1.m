% POWE_1 Pierwsza metoda Powella.
% Oznaczenia: n - wymiar zmiennej decyzyjnej
%             xn - aktualne przybli�enie rozwi�zania
%             dm - macierz kierunk�w poszukiwania
%             e0 - dok�adno�� oblicze�.

kier_baz = [];%LR
iw=iw+1;
xn_wsz{iw} = [xn];%L
qn_wsz{iw} =[koszt(xn)];
detDM = [detDM det(dm)];
for iter=itp:maxit 
   [xn, qn]=prosta1(xn,dm(:,n));
   xn_wsz{iw} = [xn_wsz{iw} xn];%L
   x0=xn;
   for i=1:n
      [xn,qn]=prosta1(xn,dm(:,i));
      xn_wsz{iw} = [xn_wsz{iw} xn];%L
      qn_wsz{iw} = [qn_wsz{iw} qn];%L
   end
   delta=norm(xn-x0);
   if delta<e0, break, end
   kier_baz=[kier_baz  dm];   %    dodana zmienna 
   dm(:,1)=[];
   dm(:,n)=(xn-x0)/delta;
d=[d dm];
end
itp=iter;
