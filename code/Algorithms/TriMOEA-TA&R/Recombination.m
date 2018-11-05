function FS = Recombination(AC,AD,Xic,Xre,eps_peak,fS,RankC)
% Recombination

%--------------------------------------------------------------------------
% Copyright 2017-2018 Yiping Liu
% This is the code of TriMOEA-TA&R proposed in "Yiping Liu, Gary G. Yen, 
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

    ACDec = AC.decs;
    ADDec = AD.decs;     
    [N,D] = size(ADDec);
    peak = find( ((fS - min(fS)) < eps_peak) & RankC == 1 );    
    FS = NaN(length(peak).*N,D);
    FS(:,Xic) =  kron( ACDec(peak',Xic),ones(N,1));
    FS(:,Xre) =  repmat(ADDec(:,Xre),length(peak),1);          
end