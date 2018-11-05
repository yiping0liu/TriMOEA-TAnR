function [Xic,Xre] = DecisionVariableAnalysis(Global,NCA,NIA)
% Decision variable analysis
% This code is modified from ControlVariableAnalysis.m and
% DividingDistanceVariables.m in MOEA-DVA

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
   
    Xic  = false(1,Global.D);
    Xre  = false(1,Global.D);
    
    %% Find convergence-related variable
    for i = 1 : Global.D
        x      = rand(1,Global.D).*(Global.upper-Global.lower) + Global.lower;
        S      = repmat(x,NCA,1);
        S(:,i) = ((1:NCA)'-1+rand(NCA,1))/NCA*(Global.upper(i)-Global.lower(i)) + Global.lower(i);
        [~,S]  = Global.problem('value',Global,S);
        S = unique(S,'rows'); % delete the duplicate
        [~,MaxFNo] = NDSort(S,inf);
        if MaxFNo == size(S,1)
            Xic(i) = true;
        else
            Xre(i) = true;
        end
    end
    
    %% Interdependence 
    % Generate the initial population        
    PopDec = rand(Global.N,Global.D);
    PopDec = PopDec.*repmat(Global.upper-Global.lower,Global.N,1) + repmat(Global.lower,Global.N,1);   
    [~,PopObj]= Global.problem('value',Global,PopDec);
    % Interdependence analysis
    interaction = false(Global.D);
    interaction(logical(eye(Global.D))) = true;
    for i = 1 : Global.D-1
        for j = i+1 : Global.D
            for time2try = 1 : NIA
                % Detect whether the i-th and j-th decision variables are interacting
                x    = randi(Global.N);
                a2   = rand*(Global.upper(i)-Global.lower(i)) + Global.lower(i);
                b2   = rand*(Global.upper(j)-Global.lower(j)) + Global.lower(j);
                Decs = repmat(PopDec(x,:),3,1);
                Decs(1,i) = a2;
                Decs(2,j) = b2;
                Decs(3,[i,j]) = [a2,b2];
                [~,F]= Global.problem('value',Global,Decs);
                delta1 = F(1,:) - PopObj(x,:);
                delta2 = F(3,:) - F(2,:);
                interaction(i,j) = interaction(i,j) | any(delta1.*delta2<0);
                interaction(j,i) = interaction(i,j);                
            end
        end
    end
    
    %% Group based on Interdependence
    while sum(sum(interaction(Xic,Xre)))
        for i = find(Xic==1)
            fprintf('i=%d\n',i);
            if sum(interaction(i,Xre))
                Xic(i) = false;
                Xre(i) = true;
            end
        end      
    end

end