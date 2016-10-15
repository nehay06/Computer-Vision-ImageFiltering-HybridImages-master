function Image = hybridImage(im1, im2, sigma1, sigma2,method)

%computes the hybrid image using Ihybrid = blurry(I1; 1) + sharp(I2; 2) = I1  g(1) + I2 ? I2  g(2): (1)
%Here, g(1) and g(2) are Gaussian filters with standard deviations 1 and 2 and * denotes the filtering
%operator.

imblur = imageFilter(im1,method,sigma1);
imsharpen = im2-imageFilter(im2,method,sigma2);
Image = imblur + imsharpen;

function result = imageFilter(image,option,sigma)

result = zeros(size(image));
if strcmp(option,'imgaussfilt')
    result = imgaussfilt(image,sigma);
else
    %creates a Gaussian lowpass filter of size hsize(sigma*4+1) with standard deviation sigma (positive)
    filter = fspecial('gaussian' ,sigma*4+1,sigma);
    %Handles the cases where the filter sizes are not given as odd numbers
    if (~mod(size(filter, 1), 2) || ~mod(size(filter, 2), 2))
        error('The row and column size of the filter have to be in odd numbers.');
    end
    [filter_row, filter_column] = size(filter);
    r_margin = (filter_row - 1) / 2;
    c_margin = (filter_column - 1) / 2;
    
    if strcmp(option,'imfilter')
        %Loop through each color channel
        for layer = 1:size(image, 3)
            tic
            % Padded array to handle missing information in image
            paddedImage = padarray(image(:, :, layer), [r_margin c_margin], 'symmetric');
            temp = zeros(size(paddedImage(:,:,1)));
            temp = imfilter(paddedImage,filter);
            [paddedImageHeight,paddedImageWidth] = size(paddedImage);
            %regaining original image size
            result(:,:,layer) = temp(r_margin+1:paddedImageHeight-r_margin,c_margin+1:paddedImageWidth-c_margin);
            toc
        end
        
    else
        %Loop through each color channel
        for layer = 1:size(image, 3)
            tic
            % Padded array to handle missing information in image
            paddedImage = padarray(image(:, :, layer), [r_margin c_margin], 'symmetric');
            % Calculate dot product of filter and sliding array from image
            % Transpose filter and convert each fw by fh block from the image into a column
            filtered = filter(:)'*im2col(paddedImage, size(filter), 'sliding');
            result(:,:,layer) = col2im(filtered, [1 1], [size(image, 1) size(image, 2)]);
            toc
        end
    end
    
end

