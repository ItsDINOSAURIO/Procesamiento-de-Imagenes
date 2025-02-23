function g = rgbtogray(imageName)
    c = double(imageName);
    
    % Obtener las dimensiones de la imagen
    [X, Y, Z] = size(c);
    
    % Convertir a escala de grises si es una imagen RGB
    if Z == 3
        g = round(c(:,:,1) * 0.299 + c(:,:,2) * 0.587 + c(:,:,3) * 0.114);
    elseif Z == 1
        g = c;
    else
        error('La imagen no tiene un formato compatible');
    end
end