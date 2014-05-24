    orig = imread('inside subsampled Gray Scale standard Quantization grade 1.jpg');
    compi = imread('inside ImageDecoded standard Quantization grade 2.jpg');
    mse = (double(orig(:)) - double(compi(:))) .^ 2;    
    mse = sum(mse(:)) / (1024*1024);
    % Calculate PSNR (Peak Signal to noise ratio)
    psnr = 10 * log10( double(max(orig(:)))^2 / mse)
    
    
   