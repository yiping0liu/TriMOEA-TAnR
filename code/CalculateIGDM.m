function CalculateIGDM()
% Calculate Metric IGDM 

% IGDM cannot be calculated by PlatEMO since the Pareto optimal set is not
% saved in the .mat file obtained by an algorithm. Please use this function
% to calculate IGDM.

%--------------------------------------------------------------------------
% Copyright 2017-2018 Yiping Liu
% This is the code of Calculating IGDM in "Yiping Liu, Gary G. Yen, 
% and Dunwei Gong, A Multi-Modal Multi-Objective Evolutionary Algorithm 
% Using Two-Archive and Recombination Strategies, IEEE Transactions on 
% Evolutionary Computation, 2018, Early Access".
% Please contact {yiping0liu@gmail.com} if you have any problem.
%--------------------------------------------------------------------------

filename1 = "TriMOEATAR_MMMOP1A_M2_1.mat";
filename2 = "MMMOP1A_PFPS.mat";

file1 = matfile(filename1,'Writable',true);
file2 = matfile(filename2);

pop = file1.Population;
objs = pop.objs;
decs = pop.decs;

pf = file2.PF;
ps = file2.PS;
nM = file2.a;
psmax = file2.PSmax;
psmin = file2.PSmin;

metric = IGDM(objs,decs,pf,ps,nM,psmax,psmin);
file1.IGDM = metric;

end