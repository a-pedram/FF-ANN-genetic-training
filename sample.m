clear all;
load iris_dataset;
[trIds,valIds]=dividerand(150,.7,.3,0);
targets=irisTargets(2,trIds)';
[nets,err]=geneticTrainNets(irisInputs(:,trIds)',targets,1000,100,3,2);

est = netOutput(nets{1},irisInputs(:,valIds)');
tic;[x ,y ,t, auc] = perfcurve(irisTargets(2,valIds),est,1);toc

tic;auc = AUC(est,irisTargets(2,valIds)');toc

tic;mse= mean((irisTargets(2,valIds)'-est).^2) ; toc;
auc
figure;plot(x,y);

inputs=irisInputs(:,trIds)';
emPowerdedNet = nets{1};
for l=1:3
    for n=1:size(emPowerdedNet{l},2)
        for w=1:size(emPowerdedNet{l},1)
            est= netOutput(emPowerdedNet,inputs);
            MSE = mean((targets-est).^2);
            temp = emPowerdedNet;
            while 1
                temp{l}(w,n) =temp{l}(w,n) * .95;            
                est= netOutput(temp,inputs);
                newMSE = mean((targets-est).^2);
                if newMSE >= MSE
                    break;
                else
                    emPowerdedNet=temp;
                    MSE = newMSE;                    
                end
            end
            while 1
                temp{l}(w,n) =temp{l}(w,n) * 1.05;            
                est= netOutput(temp,inputs);
                newMSE = mean((targets-est).^2);
                if newMSE >= MSE
                    break;
                else
                    emPowerdedNet=temp;
                    MSE = newMSE;                    
                end
            end
        end
        fprintf('layer:%d Neuron:%d MSE:%g\n',l,n,MSE);
    end
end
