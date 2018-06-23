function net= createNet(fSize,nLayer1, nLayer2)
layer1 = (rand(fSize+1,nLayer1)-.5)*6;
layer2 = (rand(nLayer1+1,nLayer2)-.5)*6;
layer3 = (rand(nLayer2+1,1)-.5)*6;
net=cell(1,3);
net{1}=layer1;
net{2}=layer2;
net{3}=layer3;
end