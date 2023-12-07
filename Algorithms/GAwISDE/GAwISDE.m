classdef GAwISDE < ALGORITHM
% <multi> <real/binary/permutation> <constrained/none>
% Nondominated sorting genetic algorithm II

%------------------------------- Reference --------------------------------
% K. Deb, A. Pratap, S. Agarwal, and T. Meyarivan, A fast and elitist
% multiobjective genetic algorithm: NSGA-II, IEEE Transactions on
% Evolutionary Computation, 2002, 6(2): 182-197.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2021 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

methods


function main(Algorithm,Problem)
% <algorithm> <UISDE+>
% UISDE
%------------------------------- Reference --------------------------------

%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------   
    %% Generate the reference points and random population
    Population        = Problem.Initialization();
    PopObj            = Population.objs;
    [DistanceValue, DistanceValue2]     = F_distanceMM(PopObj);
   

    front_num = [];
    %% Optimization
    while Algorithm.NotTerminated(Population)
%         
        MatingPool         = MatingSelection(Population.objs,DistanceValue,Problem.M);
        Offspring          = OperatorGA(Problem,Population(MatingPool));
%       Offspring          = AdapativeOffspring(Population,Problem,DistanceValue,DistanceValue2,index);
        Population         = [Population,Offspring];
        PopObj             = Population.objs;
        [DistanceValue, DistanceValue2]    = F_distanceMM(PopObj);
        front_num = [front_num,numel(find(DistanceValue2 ~=1))];
        %[~,rank]         = sort(DistanceValue,'ascend');  
        [~,rank] = sortrows([DistanceValue',DistanceValue2'],[1,2]);
        % next population
        Population       = Population(rank(1:Problem.N));         	
        DistanceValue    = DistanceValue(rank(1:Problem.N));
        
    end
end
end 
end