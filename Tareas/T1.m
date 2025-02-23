clear , clc, close all

im=ones(350,400)*255;

for i=1:350
    for j=1:400
        %Cruz 
        if i>= 0 && i<=125 && j >= 305 && j <= 370
            im (i,j)=0;
        elseif i>= 30 && i<=95 && j >= 275 && j <= 400
            im(i,j)=0; 
        %Semi circulo- rectángulo
        % elseif i>= 240 && i<=330 && j >= 210 && j <= 240+((45^2)-(i-280)^2)^(1/2)
        elseif i>= 240 && i<=320 && j >= 210 && j <= 240+((45^2)-(i-280)^2)^(1/2)
            im (i,j)=85; 
        % Pentágono
        elseif i>= 70 && i<=130 && j >= (-11/12)*i+(925/6) && j <= (11/12)*i+(155/6)
            im (i,j)=170;
        elseif i>= 130 && i<=210 && j <= (-5/16)*i+(1485/8) && j >= (5/16)*i-(45/8)
            im (i,j)=170;
        else 
            im(i,j)=255;
        end
    end
end

imshow(im/255) 