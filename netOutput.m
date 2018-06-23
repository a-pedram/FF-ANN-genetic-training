function  output = netOutput(net,input)
input=[input ones(size(input,1),1)]; %bias
out1 =  input * net{1}; 
out1 =  1.0 ./ ( 1.0 + exp(-out1) );
out1 = [out1 ones(size(out1,1),1)]; %bias
out2 = out1 * net{2};
out2 =  1.0 ./ ( 1.0 + exp(-out2) );
out2 = [out2 ones(size(out2,1),1)]; %bias
out = out2 * net{3};
output = 1.0 ./ ( 1.0+ exp(-out) );
end

