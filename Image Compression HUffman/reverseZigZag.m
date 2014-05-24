%  %A = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24;25 26 27 28 29 30 31 32;33 34 35 36 37 38 39 40;41 42 43 44 45 46 47 48;49 50 51 52 53 54 55 56;57 58 59 60 61 62 63 64];
%  A = o;
% % creating runLength;
function [block] = reverseZigZag(A)
p = 1;
runlength2 = 0;
runlength2(1) = A(1);
for index  = 2 : 2 :length(A)
    runlengthCoff = A(index) ;
    AcCoff = A(index + 1);
    p = length(runlength2) + 1;
    for count = p : 1 : (runlengthCoff + p - 1)
        runlength2(count) = 0;
    end
    if(runlengthCoff == 0)
        count = length(runlength2);
    end
    runlength2(count+1) = AcCoff;
end

zeros = length(runlength2) + 1;

for index = zeros : 1 : 64
    runlength2(index) = 0;
end

blk8by8(1,1) = runlength2(1);
blk8by8(1,2) = runlength2(2);   blk8by8(2,1) = runlength2(3);
blk8by8(3,1) = runlength2(4);   blk8by8(2,2) = runlength2(5); blk8by8(1,3) = runlength2(6);
blk8by8(1,4) = runlength2(7);   blk8by8(2,3) = runlength2(8); blk8by8(3,2) =  runlength2(9); blk8by8(4,1) =  runlength2(10); 
blk8by8(5,1) = runlength2(11);  blk8by8(4,2) = runlength2(12); blk8by8(3,3) =  runlength2(13); blk8by8(2,4) =  runlength2(14); blk8by8(1,5) =  runlength2(15); 
blk8by8(1,6) = runlength2(16);   blk8by8(2,5) = runlength2(17); blk8by8(3,4) =  runlength2(18); blk8by8(4,3) =  runlength2(19); blk8by8(5,2) =  runlength2(20); blk8by8(6,1) =  runlength2(21); 
blk8by8(7,1) = runlength2(22);   blk8by8(6,2) = runlength2(23); blk8by8(5,3) =  runlength2(24); blk8by8(4,4) =  runlength2(25); blk8by8(3,5) =  runlength2(26); blk8by8(2,6) =  runlength2(27); blk8by8(1,7) =  runlength2(28); 
blk8by8(1,8) = runlength2(29);   blk8by8(2,7) = runlength2(30); blk8by8(3,6) =  runlength2(31); blk8by8(4,5) =  runlength2(32); blk8by8(5,4) =  runlength2(33); blk8by8(6,3) =  runlength2(34); blk8by8(7,2) =  runlength2(35); blk8by8(8,1) =  runlength2(36); 
blk8by8(8,2) = runlength2(37);   blk8by8(7,3) = runlength2(38); blk8by8(6,4) =  runlength2(39); blk8by8(5,5) =  runlength2(40); blk8by8(4,6) =  runlength2(41); blk8by8(3,7) =  runlength2(42); blk8by8(2,8) =  runlength2(43); 
blk8by8(3,8) = runlength2(44);  blk8by8(4,7) = runlength2(45); blk8by8(5,6) =  runlength2(46); blk8by8(6,5) =  runlength2(47); blk8by8(7,4) =  runlength2(48); blk8by8(8,3) =  runlength2(49); 
blk8by8(8,4) = runlength2(50);  blk8by8(7,5) = runlength2(51); blk8by8(6,6) =  runlength2(52); blk8by8(5,7) =  runlength2(53); blk8by8(4,8) =  runlength2(54); 
blk8by8(5,8) = runlength2(55);  blk8by8(6,7) = runlength2(56); blk8by8(7,6) =  runlength2(57); blk8by8(8,5) =  runlength2(58); 
blk8by8(8,6) = runlength2(59);  blk8by8(7,7) = runlength2(60); blk8by8(6,8) = runlength2(61);   
blk8by8(7,8) = runlength2(62);  blk8by8(8,7) = runlength2(63);  
blk8by8(8,8) = runlength2(64);  

block = blk8by8;
end

