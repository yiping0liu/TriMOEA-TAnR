# TriMOEA-TA&R
Copyright 2017-2018 Yiping Liu

These are the codes of TriMOEA-TA&R, MMMOP1-6, and IGDM proposed in "Yiping Liu, Gary G. Yen, and Dunwei Gong, A Multi-Modal Multi-Objective Evolutionary Algorithm Using Two-Archive and Recombination Strategies, IEEE Transactions on Evolutionary Computation, 2018, Early Access".
Please contact {yiping0liu@gmail.com} if you have any problem.

The codes use PlatEMO published in "Ye Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB Platform for Evolutionary Multi-Objective Optimization [Educational Forum], IEEE Computational Intelligence Magazine, 2017, 12(4): 73-87". 

Please drop all the codes into the main folder of PlatEMO. 
Note that IGDM cannot be calculated by PlatEMO since the Pareto optimal set is not saved in the .mat file obtained by an algorithm. Please use CalculateIGDM.m to calculate IGDM.
The data of Pareto optimal fronts and Pareto optimal sets of MMMOP1-6 are available in .\PFPS.

The benchmarks MMF1-8 proposed in " Caitong Yue, Boyang Qu, and Jing Liang, A Multi-objective Particle Swarm Optimizer Using Ring Topology for Solving Multimodal Multi-objective Problems, IEEE Transactions on Evolutionary Computation, 2017, Early Access" are also included.
