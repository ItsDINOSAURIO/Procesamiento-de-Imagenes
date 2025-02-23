clear , clc, close all

c=rgb2gray(imread('rauw.jpg'));
figure, subplot(2,2,1)
imshow(c)
title('Imagen original')

[m, n] = size(c);
im = zeros(m, n);

for i=1:m
    for j=1:n
        r=c(i,j);
        s=255-r;
        im(i,j)=s;
    end
end

subplot(2,2,2)
imshow(im/255)
title('Imagen negativo')

x = 1:255;
subplot(2,2,3.5), plot(x,255-x,'LineWidth',3)
ylim([0 260])
xlim([0 260])
grid on
grid minor
xlabel("r")
ylabel("s")
legend('T(r)=s')
title('Gráfica de Transformación T(r)')