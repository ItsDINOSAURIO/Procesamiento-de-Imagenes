clear , clc, close all

c=rgb2gray(imread('rauw.jpg'));
[m, n] = size(c);
im = zeros(m, n);
r1=input("Ingrese el Valor de r1: ");
r2=input("Ingrese el Valor de r2: ");
s1=input("Ingrese el Valor de s1: ");
s2=input("Ingrese el Valor de s2: ");

m1= s1/r1;
m2=(s2-s1)/(r2-r1);
m3=(255-s2)/(255-r2);

b2=s2-(m2)*r2;
b3=255-(m3)*255;

for i=1:m
    for j=1:n
        if c(i, j) >= r1 && c(i, j) <= r2
            im(i, j) = m2 * c(i, j) + b2;
        elseif c(i, j) >= 0 && c(i, j) < r1
            im(i, j) = m1 * c(i, j);
        elseif c(i, j) >= r2 && c(i, j) <= 255
            im(i, j) = m3 * c(i, j) + b3;
        end
    end
end

figure, subplot(2,2,1)
imshow(c)
title('Imagen original')

subplot(2,2,2)
imshow(im/255)
title('Imagen Procesada')

r=[0, r1, r2,255];
s=[0, s1, s2,255];
subplot(2,2,3.5), plot(r,s,'LineWidth',3)
ylim([0 260])
xlim([0 260])
grid on
grid minor
xlabel("r")
ylabel("s")
legend('T(r)=s')
title('Gráfica de Transformación T(r)')

