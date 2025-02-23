clear, close all, clc

[x, loc] = uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files (*.png, *.jpg, *.jpeg)'}, 'Select a file', 'D:\Upiita\5to\PDI\');
rgbtogray 

% CREAR MASCARA

s=input('INGRESE EL VALOR DE SIGMA:');
figure; 
subplot(231),imshow(g/255);
n=ceil(s*3)*2+1; 
M=zeros(n);
[X,Y]=size(M); 
r=zeros(X*Y,1);
M2=zeros(X*Y,1); 
aux=1;

for i=1:X
    for j=1:Y
        r(aux)=(i-ceil(n/2))^2+(j-ceil(n/2))^2; 
        M(i,j)=-(((r(aux))-(s^2))  /  (s^4))*exp(-(r(aux))/(2*s^2));
        M2(aux)=M(i,j); 
        aux=aux+1;
    end 
end 

M=M-mean(M(:));
 R=linspace(0,r(end));
 F=-(((R)-(s.^2))  ./  (s.^4)).*exp(-(R)./(2.*s^2));

% SOBRERO DE CHARRO 

K = ceil(s*3)*2+1;
J= -floor(K/2):floor(K/2);
for i = 1:K
for j = 1:K
    valor = J(i)^2+J(j)^2;
    mk(i,j) = -((valor-s^2)/s^4)*exp(-valor/(2*s^2));
end
end

subplot(232),mesh(mk);


subplot(233), plot(R,F, 'Color', 'k'); 
hold on; 
plot(-R,F, 'Color', 'k'); 
line([s, s], [min(F), max(F)], 'Color', 'r', 'LineWidth', 0.5);
line([-s, -s], [min(F), max(F)], 'Color', 'r', 'LineWidth', 0.5);
title('SECCION TRANSVERSAL DE LA FUNCION')
axis on;
grid on;


% APLICANDO MASCARA

[X , Y]=size(g) ;

ir=zeros(X-(n-1) , Y-(n-1));

for i=1:size(g,1)-(n-1)
    for j=1:size(g,2)-(n-1)
        vec=double(g(i:i+n-1 , j:j+n-1)).*M;
        suma=sum(vec,'all');
        ir(i,j)=suma;
        if ir(i,j)>0
            ir(i,j)=255; 
        else 
            ir(i,j)=0; 
        end 
    end 
end


subplot(234), imshow(ir/255);
title('IMAGEN RESULTANTE');

%  ROBERTS 

[X,Y]=size(ir);

mrx=[0 0 0; 0 1 0; 0 -1 0]; 
mry=[0 0 0; 0 1 -1; 0 0 0];
[~,n2]=size(mry);
nueva=zeros(X-(n2-1) , Y-(n2-1));
nueva2=zeros(X-(n2-1) , Y-(n2-1));
nueva3=zeros(X-(n2-1) , Y-(n2-1));

for i=1:size(ir,1)-(n2-1)
    for j=1:size(ir,2)-(n2-1)
        vec=double(ir(i:i+n2-1 , j:j+n2-1)).*mrx;
        vec2=double(ir(i:i+n2-1 , j:j+n2-1)).*mry;
        nuevo=abs(sum(vec,'all'));
        nuevo2=abs(sum(vec2,'all'));
        nueva2(i,j)=nuevo; 
        nueva3(i,j)=nuevo2;
    end 
end 

nueva=nueva2+nueva3;
subplot(235), imshow(nueva/255);
title('APLICANDO ROBERTS');
