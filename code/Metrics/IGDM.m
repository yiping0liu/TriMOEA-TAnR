function Score = IGDM(PopObj,PopDec,PF,PS,a,PSmax,PSmin)
% <metric> <min>
% Inverted Generational Distance-Multi-Modal

%--------------------------------------------------------------------------
% Copyright 2017-2018 Yiping Liu
% This is the code of metirc IGDM proposed in "Yiping Liu, Gary G. Yen, 
% and Dunwei Gong, A Multi-Modal Multi-Objective Evolutionary Algorithm 
% Using Two-Archive and Recombination Strategies, IEEE Transactions on 
% Evolutionary Computation, 2018, Early Access".
% Please contact {yiping0liu@gmail.com} if you have any problem.
%--------------------------------------------------------------------------
% This code uses PlatEMO published in "Ye Tian, Ran Cheng, Xingyi Zhang, 
% and Yaochu Jin, PlatEMO: A MATLAB Platform for Evolutionary 
% Multi-Objective Optimization [Educational Forum], IEEE Computational 
% Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------
    
    %% Normalization
    PopSize = size(PopObj,1);
    % PF and obj
    numPF = size(PF,1);
    TPFMax = max(PF,[],1);
    TPFMin = min(PF,[],1);
    PF = (PF - repmat(TPFMin,numPF,1))./repmat(TPFMax-TPFMin,numPF,1);
    PopObj = (PopObj - repmat(TPFMin,PopSize,1))./repmat(TPFMax-TPFMin,PopSize,1);    
    % PS and dec
    PS = (PS - repmat(PSmin,max(a),1,numPF))./repmat(PSmax-PSmin,max(a),1,numPF);
    PopDec = (PopDec - repmat(PSmin,PopSize,1))./repmat(PSmax-PSmin,PopSize,1);

    %% Calculate IGDM
    dmax = 1;    
    Score = 0;
    for i = 1:size(PF,1)
       d = ones(1,a(i)).*dmax;
       [~,label]=min(pdist2(PopDec,PS(1:a(i),:,i)),[],2);
       for j = 1:a(i)
          temp = find(label==j);
          if ~isempty(temp)
              d(j) = min(dmax,min(pdist2(PopObj(temp,:),PF(i,:)))); 
          end
       end
       Score = Score + sum(d);
    end
    Score = Score/sum(a);
end