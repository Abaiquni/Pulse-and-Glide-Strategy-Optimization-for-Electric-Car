load_system("model1");
set_param("model1","FastRestart","off");

variables = 3;
no_var = 30;

lb_vmax = 22;
lb_vmin = 16;
lb_glide = 20;

ub_vmax = 28;
ub_vmin = 22;
ub_glide = no_var;

lb = [lb_vmax, lb_vmin, lb_glide];
ub = [ub_vmax, ub_vmin, ub_glide];

% IMPROVED GA OPTIONS
ga_opt = optimoptions('ga', ...
    'Display', 'iter', ...
    'Generations', 100, ...                    % Increased from 20
    'PopulationSize', 100, ...                 % Increased from 50
    'EliteCount', 10, ...                      % Keep best 10% elite
    'PlotFcns', @gaplotbestf, ...
    'CreationFcn', @gacreationuniform, ...
    'FitnessScalingFcn', @fitscalingrank, ...
    'SelectionFcn', {@selectiontournament, 2}, ... % Reduced from 4 (less aggressive)
    'CrossoverFraction', 0.8, ...              % Increased from 0.5
    'MutationFcn', @mutationadaptfeasible, ...
    'CrossoverFcn', @crossoverarithmetic, ...
    'UseParallel', false, ...
    'FunctionTolerance', 1e-6, ...             % Stricter convergence criterion
    'ConstraintTolerance', 1e-6);

obj_fn = @(control_array) tunning3(control_array);
IntCon = 1:3;

[control_array, best] = ga(obj_fn, variables, [], [], [], [], lb, ub, [], IntCon, ga_opt);