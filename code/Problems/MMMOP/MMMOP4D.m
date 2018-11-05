function varargout = MMMOP4D(Operation,Global,input)
% <problem> <MMMOP>
% Multi-Modal Multi-Objective Problems
% operator --- EAreal

%--------------------------------------------------------------------------
% Copyright 2017-2018 Yiping Liu
% This is the code of benchmarks proposed in "Yiping Liu, Gary G. Yen, 
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

    kA = 1;
    kB = 4;
    c  = 2;
    d  = 3;
    switch Operation
        case 'init'
            Global.M        = 3;
            Global.D        = Global.M - 1 + kA + kB;
            Global.lower    = zeros(1,Global.D);
            Global.upper    = ones(1,Global.D);
            Global.operator = @EAreal;

            PopDec    = rand(input,Global.D);
            varargout = {PopDec};
        case 'value'
            PopDec = input;
            M      = Global.M;
            N      = size(input,1);
            
            y = zeros(N,M-1);
            for i=1:N
                for j = 1:M-1
                    dsum = 0;
                    y(i,j)=PopDec(i,j)*d*(d+1)*0.5;
                    for m=d:-1:1
                        dsum = dsum+m;              
                        if y(i,j)<=dsum
                            y(i,j)=(y(i,j)-dsum+m)/d;
                            break;
                        end
                    end
                end
            end
            g      = 100*(kA+kB+sum(cos(2.*pi.*c.*PopDec(:,M:M-1+kA)),2)+sum((PopDec(:,M+kA:end)-0.5).^2-cos(20.*pi.*(PopDec(:,M+kA:end)-0.5)),2));          
            PopObj = repmat(1+g,1,M).*fliplr(cumprod([ones(size(g,1),1),cos(y*pi/2)],2)).*[ones(size(g,1),1),sin(y(:,M-1:-1:1)*pi/2)];
           
            PopCon = [];
            varargout = {input,PopObj,PopCon};
        case 'PF'
            f = [];
            varargout = {f};
    end
end