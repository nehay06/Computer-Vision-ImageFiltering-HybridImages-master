# Computer-Vision-ImageFiltering-HybridImages
A hybrid image is a combination of a low-pass filtered (i.e. blurry) image and a high-pass filtered (i.e.
sharp) image. Recall that one can obtain a sharp image by subtracting the blurry version of an image from
itself. Mathematically this can be written as I = blurry(I)+sharp(I). Thus a hybrid image of I1 and I2 can
be obtained as:
        Ihybrid = blurry(I1; sigma1) + sharp(I2; sigma2) = I1*g(sigma1) + I2 + I2 # g(sigma2)
        
Here, g(sigma1) and g(sigma2) are Gaussian filters with standard deviations sigma11 and sigma22 and * denotes the filtering
operator.

Algorithms:
I have used 3 ways to blur and sharpen the image. First two are inbuilt matlab function namely imfilter, imgaussfilt. I have created myfilter which is functionally same as that of imfilter. 

Output directory contains results of all the three methods. 

Installation

Download the repository, open your matlab and change the work folder to hybrid/code. Then, set images path of image1 and image2.

Finally, click evalHybrid.m Run!

Results

