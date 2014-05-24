function [a] = zigzag(b)
    a=1;p=1;t=1;
    b = fliplr(b);
    for index = 7:-1:-7
        if mod(index,2)==0
            temp = diag(b,index)';
        else 
            temp = fliplr(diag(b,index)');
        end
        for i = p:1:length(temp)+p-1
            a(i) = temp(t);
            t=t+1;
        end
        t=1;
        p = length(a)+1;
    end
end