% Path to your output directory (change this to your output directory)

clear;
clc;
clf;
dataDir = fullfile('..','data');

% List of images
%imageNames = {'dog.bmp','cat.bmp','plane.bmp','bird.bmp','plane.bmp','bird.bmp','motorcycle.bmp','bicycle.bmp','fish.bmp','submarine.bmp','submarine.bmp','fish.bmp','einstein.bmp','marilyn.bmp'};
imageNames = {'dog.bmp','cat.bmp'};
for i = 1:2:length(imageNames)-1,
    
    
    % Read first image
    imfirst = imread(fullfile(dataDir, imageNames{i}));
    % Read  second image
    imSecond1 = imread(fullfile(dataDir, imageNames{i+1}));
    imSecond = imresize(imSecond1,[size(imfirst,1) size(imfirst,2)]);
    %Plot the first and second Image
    fig = figure(1);clf;
    subplot(3,3,1); imagesc(imfirst); axis image off;
    title(strcat('Image1:',imageNames{i}(1:end-4)));
    subplot(3,3,2); imagesc(imSecond); axis image off;
    title(strcat('Image2:',imageNames{i+1}(1:end-4)));
    
   
    imfirst = im2single(imfirst);
    imSecond = im2single(imSecond);
    
    foldertitle = strcat(imageNames{i}(1:end-4),imageNames{i+1}(1:end-4));
    %methods of filters to be used. I have used two inbuilt matlab
    %function.Third one is my own filter which does the same function as
    %imfilter.
    methods = {'imfilter','imgaussfilt','myfilter'};
    for index = 1:length(methods)
        sigma1 = 5;
        sigma2 =3;
        
        hybridIm = hybridImage(imfirst,imSecond,sigma1,sigma2,methods{index});
        
        outDir = fullfile('..', 'output',foldertitle, methods{index});
        if ~exist(outDir, 'file')
            mkdir(outDir);
        end
        
        scaledImage = vis_hybrid_image(hybridIm);
        
        % Write image output
        outimageName = sprintf([imageNames{i}(1:end-4),'-',imageNames{i+1}(1:end-4), '-hybrid.jpg']);
        outimageName = fullfile(outDir, outimageName);
        imwrite(hybridIm, outimageName);
        outimageName = sprintf([imageNames{i}(1:end-4),'-',imageNames{i+1}(1:end-4), '-hybrid-scaled.jpg']);
        outimageName = fullfile(outDir, outimageName);
        imwrite(scaledImage, outimageName);
        
        subplot(3,3,3);  imagesc(hybridIm); axis image off;
        title('Hybrid image');
        subplot(3,3,[4 9]);  imagesc(scaledImage); axis image off;
        title(strcat('Scaled Hybrid image',' ',' sigma1=',num2str(sigma1),', sigma2= ',num2str(sigma2)));
        savedfigName = strcat(imageNames{i},imageNames{i+1},'SavedFig.bmp') ;
        %Save the figure
        saveas(fig,fullfile(outDir, savedfigName))
    end
end
