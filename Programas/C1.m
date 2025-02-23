clear , clc, close all

im=ones(300,250)*255;

for i=1:300
    for j=1:250
        if i>= 180 && i<=240 && j >= 100 && j <= 200
            im (i,j)=50;
        elseif i>= 90 && i<=150 && j >= ((-2/3)*i)+110 && j <= ((2/3)*i)-10
            im (i,j)=120;
        elseif i>= 60 && i<=120 && j >= 150 && j <= 200+((30^2)-(i-90)^2)^(1/2)
            im (i,j)=200;
        else 
            im(i,j)=255;
        end
    end
end

imshow(im/255) 
%Se divide entre 255 para normalizar el valor de cada "pixel" puesto que 
% son valores de tipo double y se necesitan valores entre 0-1, si se
% encuentra fuera del rango se tomará como "blanco" 