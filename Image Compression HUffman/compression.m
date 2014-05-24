I = imread('inside.jpg');
original = I;
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%% Image Encoding %%%%%%%%%%%%%%%%%%%%%%%%%%%

% http://en.wikipedia.org/wiki/Grayscale
R=I(:,:,1); G=I(:,:,2); B=I(:,:,3);
I = .299*R + .587*G + .114*B;
imwrite(I,'inside Gray Scale standard Quantization grade 1.jpg');

% Subsampling Image
% parameters are set by repetitive setting till picture reaches 1024 * 1024
%I = I(1:1.25:end,1:.7025:end,:);
I = imresize(I, [1024 1024]);
gray = I;
imwrite(I,'inside subsampled Gray Scale standard Quantization grade 1.jpg');

% DCT conversion
fun = @(block_struct) dct2(block_struct.data);
I = blockproc(I,[8 8],fun);

% Quantization with standard JPG table
% calulating new f(u,v)
jpegTableForDivide = repmat(jpegTable,128);
I_Standard = round(I./(4*jpegTableForDivide));

% Quantization with standard 4 * jpegTableForDivide table
I_Quant2 = round(I./(4*jpegTableForDivide));

% Quantization with standard 8 * jpegTableForDivide table

I_Quant3 = round(I./(8*jpegTableForDivide));

%Zigzag scan and runlength coding
if exist('runlength.txt')~=0
    delete runlength.txt;
    delete Huffmancodes.txt;
end
previousDct = 0;
for coloums = 1 : 8 : 1024
    previousDct = 0;
   for rows = 1 : 8 : 1024
        subZigzagArray = zigzag(I_Standard(coloums:coloums+8-1,rows:rows+8-1));
        
        firstDct =  previousDct - subZigzagArray(1);
        if(previousDct == 0)
            firstDct = subZigzagArray(1);
        end
        previousDct = subZigzagArray(1);
        %subZigzagArray(1) = firstDct;
        % Runlength coding
        count = 0;
        p=2;
        runLenCoding = 0;
        for i = 2:1:length(subZigzagArray)
            if subZigzagArray(i) ~=0
                runLenCoding(p) = count;
                p = p+1;
                runLenCoding(p) = subZigzagArray(i);
                p = p+1;
                count = 0;
            else
                count = count +1;
            end
        end
        runLenCoding(1) = firstDct;
        
        % Whole runlength coding is getting stored in txt file
        dlmwrite('runlength.txt',runLenCoding,'-append','delimiter',' ');
    end
 end

%line by line file read for hoffman coding
runLengthText1 = fopen('runlength.txt','r');
BitStream = '';
while ~feof(runLengthText1)
    line1 = fgets(runLengthText1);
    A1 = sscanf(line1,'%d'); 
    p = A1';
    Stream = huffmanencoding(p);
    dlmwrite('Huffmancodes.txt',Stream,'-append','delimiter',' ');  
    BitStream = strcat(BitStream,Stream);
end
comp = BitStream;
fclose(runLengthText1);
huffmandecoding(BitStream{1});

%%%%%%%%%%%%%%%%%%%%%%%%%%% Image Decoding %%%%%%%%%%%%%%%%%%%%%%%%%%%

if exist('ZigZagDecodingInput.txt')~=0
    delete ZigZagDecodingInput.txt;

end
huffmanDecoding = fopen('DecodedRunlength.txt','r');
BitStream = '';
previous = 0; counter = 0; row = 1; colon = 1;
imageDecoded = ones(1024);
while ~feof(huffmanDecoding)
    counter = counter +1 ;
    line1 = fgets(huffmanDecoding);
    A1 = sscanf(line1,'%d'); 
    A1 = A1';
    if(counter == 129)
        counter = 1;
        previous = 0;
        row = row + 8;
        colon = 1;
    end
    if(previous == 0)
        A1(1) = A1(1);
    else
        A1(1) = previous - A1(1);
    end
    imageDecoded(row : row + 8 - 1,colon : colon + 8 -1) = reverseZigZag(A1);
    colon = colon + 8;
    dlmwrite('ZigZagDecodingInput.txt',A1,'-append','delimiter',' ');
    previous = A1(1);
end

% I_Standard = imageDecoded;

fclose(huffmanDecoding);
Decoded = (imageDecoded.*(4*jpegTableForDivide))/200;
fun = @(block_struct) idct2(block_struct.data);
Decoded = blockproc(Decoded,[8 8],fun);
imwrite(Decoded,'inside ImageDecoded standard Quantization grade 2.jpg');
toc