clear, close all, clc

[x, loc] = uigetfile({'*.png;*.jpg;*.jpeg', 'Image Files (*.png, *.jpg, *.jpeg)'}, 'Select a file', 'D:\Upiita\5to\PDI\');
rgbtogray 

p=input('INGRESE EL VALOR DE P: ');
figure
imshow(g/255);
[X,Y]=size(g);
ni=zeros(X,Y);
[x,y] = ginput()
x = round(x);
y = round(y);
s=g(x,y);

for i=x-2:x+2
    for j=y-2:y+2
        ev=g(i,j);
        if abs(ev-s)<=p
            ni(i,j)=255;
            for a=i-2:i+2
                for b=j-2:j+2
                    ev=g(a,b);
                    if abs(ev-s)<=p
                        ni(a,b)=255;
                    else
                        ni(a,b)=0;
                    end
                end
            end
        else
            ni(i,j)=0;
        end
    end
end


figure
imshow(ni/255);

% % Cola de píxeles para procesar
% queue = [x, y];
% % Marca el punto inicial como parte de la región
% ni(x, y) = 255;
% mean_value = g(x, y);
% 
% % Desplazamientos para los vecinos (8 conectividad)
% neighbors = [-1, -1; -1, 0; -1, 1; 0, -1; 0, 1; 1, -1; 1, 0; 1, 1];
% 
% while ~isempty(queue)
%     % Toma el primer píxel de la cola
%     current_pixel = queue(1, :);
%     queue(1, :) = [];
% 
%     % Revisa los píxeles vecinos
%     for k = 1:size(neighbors, 1)
%         new_x = current_pixel(1) + neighbors(k, 1);
%         new_y = current_pixel(2) + neighbors(k, 2);
% 
%         % Asegúrate de que el nuevo píxel está dentro de los límites de la imagen
%         if new_x > 0 && new_x <= X && new_y > 0 && new_y <= Y
%             % Revisa si el píxel vecino cumple con la condición de similitud
%             if ni(new_x, new_y) == 0 && abs(g(new_x, new_y) - mean_value) <= p
%                 % Agrega el píxel vecino a la región
%                 ni(new_x, new_y) = 255;
%                 % Agrega el píxel vecino a la cola
%                 queue = [queue; new_x, new_y];
%             end
%         end
%     end
% end