function varargout = MMMOP6(Operation,Global,input)
% <problem> <MMMOP>
% Multi-Modal Multi-Objective Problems
% kA ---  2 --- number of variables in XA (must be even)
% kB ---  1 --- number of variables in XB
% c ---  2 --- c > 0
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

    [kA,kB,c] = Global.ParameterSet(0,2,1);
    switch Operation
        case 'init'
            Global.M        = 2;
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
            y      = (PopDec(:,M:M+kA-1)-0.5)*12;
            z      = 2*c*PopDec(:,M+kA:end)-2*floor(c*PopDec(:,M+kA:end))-1;
            t      = ones(N,kB);
            for i = 1:kB
                for j = 1:M-1
                    t(:,i)=t(:,i).*sin(2*pi*PopDec(:,j)+(i-1)*pi/kB);
                end
            end  
            g = sum((y(:,1:2:kA-1).^2+y(:,2:2:kA)-11).^2+(y(:,1:2:kA-1)+y(:,2:2:kA).^2-7).^2,2)+sum((z-t).^2,2);    
            PopObj = repmat(1+g,1,M).*fliplr(cumprod([ones(size(g,1),1),cos(PopDec(:,1:M-1)*pi/2)],2)).*[ones(size(g,1),1),sin(PopDec(:,M-1:-1:1)*pi/2)];
           
            PopCon = [];
            varargout = {input,PopObj,PopCon};
        case 'PF'
            f = UniformPoint(input,Global.M);
            f = f./repmat(sqrt(sum(f.^2,2)),1,Global.M);
            varargout = {f};
    end
end