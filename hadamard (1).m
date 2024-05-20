% Example usage:
% Read an image
img = imread('peppers.png'); % Replace with the path to your image
img = double(rgb2gray(imresize(img, [256, 256]))); % Convert to grayscale if necessary
% Determine the nearest power of 2 for image size
new_size = 2^nextpow2(max(size(img)));
% Resize the image to the nearest power of 2
img = imresize(img, [new_size, new_size]);
% Display the original image
figure;
subplot(3, 1, 1);
imshow(uint8(img));
title('Original Image');
% Apply Hadamard transform
Xk = hadamard_transform(img);
% Display the transformed image
subplot(3, 1, 2);
imshow(uint8(Xk));
title('Transformed Image');
% Apply Inverse Hadamard transform for reconstruction
reconstructed_img = hadamard_transform_inverse(Xk);
% Display the reconstructed image
subplot(3, 1, 3);
imshow(uint8(reconstructed_img));
title('Reconstructed Image');
function Xk = hadamard_transform(img)
   % Input:
   % img: Input matrix representing the image
  
   % Compute the size of the input matrix
   [rows, cols] = size(img);
   if rows ~= cols || log2(rows) ~= round(log2(rows))
       error('Input matrix size must be square and a power of 2.');
   end
  
   % Initialize the Hadamard matrix
   Hm = hadamard_recursive(rows);
  
   % Compute the Hadamard transform
   Xk = Hm * img * Hm';
  
   % Output:
   % Xk: Transformed matrix
end
function img_reconstructed = hadamard_transform_inverse(Xk)
   % Input:
   % Xk: Transformed matrix
  
   % Compute the size of the input matrix
   [rows, cols] = size(Xk);
   if rows ~= cols || log2(rows) ~= round(log2(rows))
       error('Input matrix size must be square and a power of 2.');
   end
  
   % Initialize the Hadamard matrix
   Hm = hadamard_recursive(rows);
  
   % Compute the Inverse Hadamard transform for reconstruction
   img_reconstructed = Hm' * Xk * Hm;
  
   % Normalize the reconstructed image (optional)
   img_reconstructed = img_reconstructed / max(img_reconstructed, [], 'all') * 255;
end
function Hm = hadamard_recursive(N)
   % Recursive construction of Hadamard matrix
  
   % Base case
   if N == 1
       Hm = 1;
   else
       % Recursive construction
       Hm_prev = hadamard_recursive(N/2);
       Hm = [Hm_prev, Hm_prev; Hm_prev, -Hm_prev];
   end
end

