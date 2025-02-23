clear , clc, close all

c=rgb2gray(imread('rauw.jpg'));
[m, n] = size(c);
im = zeros(m, n);
a=input("Ingrese el Límite Inferior: ");
b=input("Ingrese el Límite Superior: ");
L=a:b;
for i=1:m
    for j=1:n
        if ismember(c(i,j), L)
            im(i,j)=255;
            else 
             im(i,j)=0;
        end
    end
end

figure, subplot(2,2,1)
imshow(c)
title('Imagen original')

subplot(2,2,2)
imshow(im/255)
title('Imagen binivel')

x = 1:255;
y = zeros(size(x));
for i=x
    if ismember(x(i), L)
        y(i)=255;
    else
        y(i)=0;
    end
end
subplot(2,2,3.5), plot(x,y,'LineWidth',3)
ylim([0 260])
xlim([0 260])
grid on
grid minor
xlabel("r")
ylabel("s")
legend('T(r)=s')
title('Gráfica de Transformación T(r)')

for i=1:m
    for j=1:n
        if ismember(c(i,j), L)
            im(i,j)=255;
            else 
             im(i,j)=c(i,j);
        end
    end
end

figure, subplot(2,2,1)
imshow(c)
title('Imagen original')

subplot(2,2,2)
imshow(im/255)
title('Imagen resaltado con gris')

x = 1:255;
y = zeros(size(x));
for i=x
    if ismember(x(i), L)
        y(i)=255;
    else
        y(i)=x(i);
    end
end
subplot(2,2,3.5), plot(x,y,'LineWidth',3)
ylim([0 260])
xlim([0 260])
grid on
grid minor
xlabel("r")
ylabel("s")
legend('T(r)=s')
title('Gráfica de Transformación T(r)')