% Skrypt obrazuje utratę dokładności przy zbyt dużej liczbie proksymacji
% kwadratowych
global max_it_zlo
global max_it_apr
global zad
n=80;
k=20;
zad = 4; % badanie aproksymacji
Wyniki = zeros(n,k);
for max_it_zlo=0:n
    %max_it_zlo %informacja o postepie obliczen
    for max_it_apr=0:k
        [a,b,z,q] = prosta1(0,1);
        Wyniki(max_it_zlo+1,max_it_apr+1) = a;      
        
        
    end
end
Wyniki = Wyniki-5;
%Wyniki(1:6,1:6)=0;
mesh(log10(abs(Wyniki)))
ylabel('max it ZLO')
xlabel('max it APR')
