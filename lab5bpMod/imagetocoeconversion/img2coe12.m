function img2 = img2coe12(imgfile, outfile)
% Create .coe file from image
% .coe file contains 12-bit words
% each word contains one 12-bit pixel
% color word: [R3,R2,R1,R0,G3,G2,G1,G0,B3,B2,B1,B0]
% img2 = img2coe12(imgfile, outfile)
% img2 is 4096-color image
% imgfile = input file: .bmp, .jpg, .png, etc.
% outfile = output file: .coe
% Example:
% img2 = img2coe12('loons100x100.jpg', 'loons100x100.coe');

% Read the image
img = imread(imgfile);
h = size(img, 1); w = size(img, 2);

% Open the .coe file
s = fopen(outfile,'W');

% Print header
fprintf(s,'%s\n','; VGA Memory Map ');
fprintf(s,'%s\n','; .COE file with hex coefficients ');
fprintf(s,'; Height: %d, Width: %d\n\n', h, w);

fprintf(s,'%s\n','memory_initialization_radix=16;'); 
fprintf(s,'%s\n','memory_initialization_vector=');

% Convert color channels to binary
R = dec2bin(img(:,:,1)',8);
G = dec2bin(img(:,:,2)',8);
B = dec2bin(img(:,:,3)',8);

% Stitch together the output words
out = bin2dec([ R(:,1:4) G(:,1:4) B(:,1:4) ]);
img2 = img;

for i=1:h-1
    sol = i*w-w+1; % Start of line
    eol = i*w;     % End of line
    
    % Print out words
    fprintf(s,'%03X,',out(sol:eol,:));
    fprintf(s,'\n');
    
    % Save new image
    img2(i,:,1) = bin2dec(R(sol:eol,1:4))'*2^4';
    img2(i,:,2) = bin2dec(G(sol:eol,1:4))'*2^4';
    img2(i,:,3) = bin2dec(B(sol:eol,1:4))'*2^4';
end

% Print out the last row
fprintf(s,'%02X,',out(h*w-w+1:end-1,:));
fprintf(s,'%02X;',out(end,:));

img2(h,:,1) = bin2dec(R(h*w-w+1:end,1:4))'*2^4';
img2(h,:,2) = bin2dec(G(h*w-w+1:end,1:4))'*2^4';
img2(h,:,3) = bin2dec(B(h*w-w+1:end,1:4))'*2^4';

% Close the .coe file
fclose(s);

