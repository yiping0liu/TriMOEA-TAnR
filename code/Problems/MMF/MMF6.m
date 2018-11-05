function varargout = MMF6(Operation,Global,input)
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
            Global.lower    = [1 -1];
            Global.upper    = [3 2];
            Global.operator = @EAreal;

            PopDec    = rand(input,Global.D).*repmat(Global.upper-Global.lower,input,1)+repmat(Global.lower,input,1);
            varargout = {PopDec};
        case 'value'
            PopDec = input;
            [N,~]  = size(PopDec);
            PopObj = NaN(N,Global.M);
            for i = 1:N
                Var = PopDec(i,:);
                if (Var(2)>-1&&Var(2)<=0)&&(((Var(1)>7/6&&Var(1)<=8/6))||(Var(1)>9/6&&Var(1)<=10/6)||(Var(1)>11/6&&Var(1)<=2))
                    Var(2)=Var(2);
                elseif (Var(2)>-1&&Var(2)<=0)&&((Var(1)>2&&Var(1)<=13/6)||(Var(1)>14/6&&Var(1)<=15/6)||(Var(1)>16/6&&Var(1)<=17/6))
                    Var(2)=Var(2);
                elseif (Var(2)>1&&Var(2)<=2)&&((Var(1)>1&&Var(1)<=7/6)||(Var(1)>4/3&&Var(1)<=3/2)||(Var(1)>5/3&&Var(1)<=11/6))
                    Var(2)=Var(2)-1;
                elseif (Var(2)>1&&Var(2)<=2)&&((Var(1)>13/6&&Var(1)<=14/6)||(Var(1)>15/6&&Var(1)<=16/6)||(Var(1)>17/6&&Var(1)<=3))
                    Var(2)=Var(2)-1;
                elseif (Var(2)>0&&Var(2)<=1)&&((Var(1)>1&&Var(1)<=7/6)||(Var(1)>4/3&&Var(1)<=3/2)||(Var(1)>5/3&&Var(1)<=11/6)||(Var(1)>13/6&&Var(1)<=14/6)||(Var(1)>15/6&&Var(1)<=16/6)||(Var(1)>17/6&&Var(1)<=3))
                    Var(2)=Var(2);
                elseif (Var(2)>0&&Var(2)<=1)&&((Var(1)>7/6&&Var(1)<=8/6)||(Var(1)>9/6&&Var(1)<=10/6)||(Var(1)>11/6&&Var(1)<=2)||(Var(1)>2&&Var(1)<=13/6)||(Var(1)>14/6&&Var(1)<=15/6)||(Var(1)>16/6&&Var(1)<=17/6))
                    Var(2)=Var(2)-1;
                end
                PopObj(i,1) = abs(Var(1)-2);
                PopObj(i,2) = 1.0 - sqrt( abs(Var(1)-2)) + 2.0*( Var(2)-sin(6*pi* abs(Var(1)-2)+pi)).^2;
            end
                        
            PopCon = [];
           
            varargout = {input,PopObj,PopCon};
        case 'PF'
            f =[];
            varargout = {f};        
    end
end