% POWE_2 Druga metoda Powella.
% Oznaczenia: n - wymiar zmiennej decyzyjnej
%             xn - aktualne przybli�enie rozwi�zania
%             dm - macierz kierunk�w poszukiwania
%             e0 - dok�adno�� oblicze�.

detdm=1;
iw=iw+1;
xn_wsz{iw} = [xn];%L
qn_wsz{iw} =[koszt(xn)];
xn=prosta1(xn,dm(:,n));


xn_wsz{iw} = [xn_wsz{iw} xn];
qn_wsz{iw} =[qn_wsz{iw} koszt(xn)];


for iter=itp:maxit   
    detDM = [detDM det(dm)];
   tmax=0;
   x0=xn;
   for i=1:n
      [xn,qn,tn]=prosta1(xn,dm(:,i));
      xn_wsz{iw} = [xn_wsz{iw} xn];%L
      qn_wsz{iw} = [qn_wsz{iw} qn];%L
      if abs(tn)>tmax
         imax=i;
         tmax=abs(tn);
         
      end

   end
   delta=norm(xn-x0);
   if delta<e0, break, end
   D=tmax*detdm/delta;
   if D>=.8
   dm(:,imax)=[];
   dm(:,n)=(xn-x0)/delta;
   zm_kier=[zm_kier im];   % dodana zmienna pomocnicza
   kier_baz=[kier_baz  dm];  % dodana zmienna pomocnicza
   detdm=D;
   xn=prosta1(xn,dm(:,n));
   xn_wsz{iw} = [xn_wsz{iw} xn];%L
   qn_wsz{iw} = [qn_wsz{iw} qn];
   end  
   disp('dm')
   dm
end
itp=iter;