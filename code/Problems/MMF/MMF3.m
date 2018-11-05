function varargout = MMF3(Operation,Global,input)
% <problem> <MMF>
% Multi-modal Multi-objective test Function
% operator --- EAreal

%--------------------------------------------------------------------------
% Copyright 2017-2018 Yiping Liu
% This is the code of MMF used in "Yiping Liu, Gary G. Yen, 
% and Dunwei Gong, A Multi-Modal Multi-Objective Evolutionary Algorithm 
% Using Two-Archive and Recombination Strategies, IEEE Transactions on 
% Evolutionary Computation, 2018, Early Access".
% Please contact {yiping0liu@gmail.com} if you have any problem.
%--------------------------------------------------------------------------
% MMF is proposed in " Caitong Yue, Boyang Qu, and Jing Liang, 
% A Multi-objective Particle Swarm Optimizer Using Ring Topology for 
% Solving Multimodal Multi-objective Problems, IEEE Transactions on 
% Evolutionary Computation, 2017, Early Access".
%--------------------------------------------------------------------------
% This code uses PlatEMO published in "Ye Tian, Ran Cheng, Xingyi Zhang, 
% and Yaochu Jin, PlatEMO: A MATLAB Platform for Evolutionary 
% Multi-Objective Optimization [Educational Forum], IEEE Computational 
% Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

    switch Operation
        case 'init'
            Global.M        = 2;
            Global.D        = 2;
            Global.lower    = zeros(1,Global.D);
            Global.upper    = [1 1.5];
            Global.operator = @EAreal;

            PopDec    = rand(input,Global.D).*repmat(Global.upper-Global.lower,input,1)+repmat(Global.lower,input,1);
            varargout = {PopDec};
        case 'value'
            PopDec = input;
            [N,~]  = size(PopDec);
            PopObj = NaN(N,Global.M);
            PopObj(:,1) = PopDec(:,1);
            for i = 1:N
                if PopDec(i,2)>=0 && PopDec(i,2)<=0.5
                    PopObj(i,2) = PopDec(i,2)-PopDec(i,1)^0.5;
                end
                if PopDec(i,2)>0.5 && PopDec(i,2)<1 && PopDec(i,1)>=0 && PopDec(i,1)<=0.25    
                    PopObj(i,2) = PopDec(i,2)-0.5-PopDec(i,1)^0.5;
                end
                if PopDec(i,2)>0.5 && PopDec(i,2)<1 && PopDec(i,2)>0.25              
                    PopObj(i,2) = PopDec(i,2)-PopDec(i,1)^0.5;
                end
                if PopDec(i,2)>=1 && PopDec(i,2)<=1.5                                       
                    PopObj(i,2) = PopDec(i,2)-0.5-PopDec(i,1)^0.5;
                end
                PopObj(i,2) = 1 - PopDec(i,1)^0.5 + 2*((4*PopObj(i,2)^2)-2*cos(20*PopObj(i,2)*pi/sqrt(2))+2);
            end           
           
            PopCon = [];
           
            varargout = {input,PopObj,PopCon};
        case 'PF'
            f =[];
            varargout = {f};        
    end
end