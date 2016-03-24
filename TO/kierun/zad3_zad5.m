%% Sprawozdanie TO - Łukasz Radzio
% Optymalizacja na kierunku
%
% 8.03.2016 wtorek 8.00
%
%% zad 3
clear all
global a_wsp
global max_it_zlo
global max_it_apr
global zad
zad = 3;
% wykresy = 0;
k=40;
n=20;
Wyniki=ones(k,n)*10;
tic
for max_it_zlo=0:k-1
    %max_it_zlo %informacja o postepie obliczen
    for max_it_apr=0:n-1
        rozw = zeros(1,5);%wejscie do petli
        dokladnosc = 0.1;
        while length(rozw)==5
            a_wsp = [1 -91.11 -899.989 1100.009 -110.91 1];
            close all;
            rozw =[];
            for i=1:5
                [a,b,z,q] = prosta1(0,1);
% Wizualizacja na potrzeby testowania
%                 if wykresy~=0
%                     figure(i)
%                     
%                     t = linspace(min(z),max(z),100);
%                     plot(z',koszt(0,z',1),'o')
%                     hold on
%                     plot(t',koszt(0,t',1))
%                     plot(a,b,'*r');
%                 end
                % hold off
                 if b<dokladnosc
                    % disp('tak');
                     a_wsp = deconv(a_wsp,[1 -a]);
                     % Dzielenie wielomianów dokonuje za pomocą
                     % dekonwolucji. Wyniki są zgodne z równaniami z
                     % instrukcji.
                     rozw = [rozw a];
                 end
            end
            if length(rozw)==5
                rozw = sort(rozw);
                if(norm(rozw - [-10 0.01 0.1 1 100])<1e-4)
                    %przebadane parametry 1e-6, 1e-10
                    Wyniki(max_it_zlo+1,max_it_apr+1) = dokladnosc;
                end
            end
            dokladnosc=dokladnosc*0.1;                
        end
    end
end
toc
% Prezentacja wyników
mesh(log10(Wyniki))
ylabel('max it zlo - 1');
xlabel('max it apr - 1');
zlabel('rzad dokladnosci = log|wartosc minimum|');
%%
close all
%%
% Zadanie polegało na znalezieniu wszystkich miejsc zerowych wielomianu
% piątego stopnia. Skrypt rozwiązuje zadanie wielokrotnie dla różnych
% parametrów max_it_zlo i max_it_apr (ograniczających liczbę iteracji dla
% złotego podziału i aproksymacji kwadratowej).

%% Wyniki
% <html><h3>Warunek akceptacji rozwiązania = norma z różnicy rozwiązania numerycznego
% i analitycznego < 1e-8</h3></html>
openfig('wiel_m8.fig') ;
%% 
% Na wykresie widać, że zbyt duże zwiększenie max_it_apr nie przynosi
% dalszej poprawy dokładności. Występuje nasycenie. Natomiast zbyt wysoko
% ustawione max_it_zlo pogarsza dokładność, aż do odrzucenia rozwiązań.
%%
% <html><h3>Warunek akceptacji rozwiązania = norma z różnicy rozwiązania numerycznego
% i analitycznego < 1e-4</h3></html>
openfig('wiel_m4.fig');
%%
% Dla bardzo dużych max_it_zlo dokładność powoli wraca, ale dla
% (max_it_zlo,max_it_apr) = (4,14) dokładność wynosi -21, a dla (40,0) -13.
% Oznacza to, że bardziej opłaca się zwiększyć liczbę wywołań aproksymacji
% kwadratowej.
%
% Może to być spowodowane tym, że wielomiany są dobrze przybliżane
% funkcjami kwadratowymi, a dla zbyt dużych max_it_zlo przedział początkowy
% dla algorytmu aproksymacji kwadratowej jest zbyt mały, przez co działają
% warunki stopu które zabezpieczają przed błędami numerycznymi i
% aproksymacja nie zostaje przeprowadzona, bądź zostaje przeprowadzona,
% ale w mniejszej liczbie iteracji, po czym się nasyca.
%

%% zad 5
%clear all;

zad = 5;
global a
global b
a=-0.1;
b=10;
Wyniki = 10*ones(4);
rysoj = [1e-4 1e3];
for a = -logspace(-1,-4,4)
    for b =logspace(0,3,4)
        z=[];
        q=[];
        x0 = 0;
        d = 1;
        zw = [-2 -0.3 20]';
        qw = koszt(0,zw,d)';
        maxit = 10000;
        [zw,qw,z,q]=apropa(x0,d,zw,qw,maxit,z,q);
        if all(rysoj==[-a b])
            a
            b
            figure(10)
            t = linspace(min(z),max(z),100);
            plot(z',koszt(x0,z',d),'o')
            hold on
            plot(zw(2),qw(2),'*r')
            plot(t',koszt(0,t',d))
            xlabel('x');
            ylabel('y');
            title('Przebieg algorytmu dla a=-1e-4, b=1e3')
            hold off
 
        end
        Wyniki(-log10(-a),log10(b)+1) = zw(2);
        a;
        b;
        zw(2);
    end
end
Wyniki
%pause
figure(11)
mesh((abs(Wyniki)))
xlabel('-log(-a)');
ylabel('log(b)');
zlabel('|rozwiazania|');

%% Opis eksperymentu
% W pętlach badam zachowanie aproksymacji kwadratowej dla wartości
% parametrów a ze zbioru {-0.1 -0.01 ... -1e-4} oraz b ze zbioru {1 10 100
% 1000}. Dobieram je w pary i obliczam wynik algorytmu z parametrem
% określającym maksymalną liczbę iteracji równym 100.
% Wyniki zawierają rozwiązania wzkazane przez algorytm. Z numerem kolumny
% rośnie wsp. b, z numerem wiersza maleje moduł wsp a, więc a rośnie (a
% ujemne)

%% Wyniki
% Dla  zw = [-2 -1.9 2]';
%
% Wyniki =
% 
%    -0.0000   -0.3743   -1.6697   -1.8765
%    -0.3743   -1.6697   -1.8765   -1.8977
%    -1.6697   -1.8765   -1.8977   -1.8998
%    -1.8765   -1.8977   -1.8998   -1.9000
%%
% Dla zw = [-2 -0.3 2]';
%
% Wyniki =
% 
%    -0.0000   -0.0011   -0.2224   -0.2923
%    -0.0011   -0.2224   -0.2923   -0.2993
%    -0.2224   -0.2923   -0.2993   -0.2999
%    -0.2923   -0.2993   -0.2999   -0.3000
%%
% zw = [-20 -0.3 20]';
%
% Wyniki =
% 
%    -0.0000   -0.0114   -0.0052   -0.2403
%    -0.0114   -0.0052   -0.2403   -0.2942
%    -0.0052   -0.2403   -0.2942   -0.2994
%    -0.2403   -0.2942   -0.2994   -0.2999
%% Wnioski
% Im bliżej rozwiązania znajduje się punkt środkowy, tym lepszą zbierzność
% otrzymujemy. Im mniejszy moduł a i im większy wsp b tym słabsza
% zbieżność. Zmiana początkowego przedziału niepewności nie wpływa na
% zbieżność w tak znaczącym stopniu jak wartość punktu wewnętrznego. W
% dalszych próbach nawet zwiększenie maksymalnej liczby iteracji do wartości 
% 10000 nie powodowało poprawy wartości optymalnej. Algorytm aproksymacji
% kwadratowej nie gwarantuje zbieżności.










