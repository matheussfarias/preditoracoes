// funcao de correlacao
function Rx = comat(x,N)
    px = xcorr(x,N,'biased');
    for i = 1:N+1
        Rx(:,i) = px((N+2-i):(2*(N+1)-i));
    end
endfunction

//para fins didaticos, a implementacao pura do LMS
function [y,e,wn]=filterLMS(x,d,mi,N)
    xn=zeros(N+1,1);
    Wn=zeros(N+1,1);
    M=length(x);
    for n=1:M
        xn=[x(n);xn(1:N)];
        y(n)= Wn'*xn;
        e(n)=d(n)-y(n);
        Wn = Wn + 2*mi*e(n)*xn;
    end 
    wn=Wn
endfunction

//implementacao modificada para o caso do projeto
function [y]=LMSpredict(x,l,u,N)
    xd=[zeros(1,l) x];
    xn=zeros(N+1,1)
    Wn=zeros(N+1,1);
    M=length(xd);
    for n=1:M
        xn=[xd(n);xn(1:N)];
        y(n)= Wn'*xn;
        if(n>M-l)
            e =0;
        else
            e=x(n)-y(n);
        end
        Wn = Wn + 2*u*e*xn;
    end 
endfunction
