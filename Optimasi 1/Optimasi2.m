load_system("model1");
set_param("model1","FastRestart","off");

no_var = 70; %30 for eprix, 60 for lusail (13-15 gas each lap)

lb_vmax = ones([1, no_var]) .* 26; %23 for eprix, 26 for lusail
lb_vmin = ones([1, no_var - 1]) .* 22; %18 for eprix, 22 for lusail
lb_glide = 50; %22 for eprix, 45 for lusail 

ub_vmax = ones([1, no_var]) .* 30; %28 for eprix, 30 for lusail
ub_vmin = ones([1, no_var - 1]) .* 26; %23 for eprix, 26 for lusail
ub_glide = no_var;

lb = [lb_vmax, lb_vmin, lb_glide];
ub = [ub_vmax, ub_vmin, ub_glide];

A1 = zeros([no_var-1,no_var*2]);
for i = 1:no_var-1
    A1(i,i) = -1;
    A1(i,no_var+i) = 1;
end
   
A2 = zeros([no_var - 1, no_var * 2]);
for i = 1:no_var - 1
    A2(i, i + 1) = -1;
    A2(i, no_var + i) = 1;
end

A = [A1; A2];
b = ones([(no_var - 1) * 2, 1]) .* -4;%ganti 4 atau 5 


ga_opt = optimoptions('ga', ...
    'Display','off', ...
    'Generations', 200, ...           % Jumlah Generasi Maksimum: 500
    'PopulationSize', 100, ...           % Jumlah Populasi: 
    'PlotFcns',{@gaplotbestf,@gaplotscores,@gaplotbestindiv}, ...
    'CreationFcn', @gacreationuniform, ... % Algoritma Creation: Uniform
    'FitnessScalingFcn', @fitscalingrank, ... % Algoritma Scaling: Rank
    'SelectionFcn', {@selectiontournament,4}, ... % Algoritma Seleksi: Tournament
    'MutationFcn', @mutationadaptfeasible, ... % Algoritma Mutasi: Adaptive Feasible
    'CrossoverFcn', @crossoverarithmetic, ... % Algoritma Crossover: Arithmetic
    'CrossoverFraction', 0.8, ...        % Fraksi Crossover: 0.5 coba 0.8
    'EliteCount',5, ...   % Fraksi Elite: sebelumnya 5
    'UseParallel', true);                % UseParallel: True

% 8. DEFINE OBJECTIVE FUNCTION
obj_fn = @(control_array) tunning2(control_array);
IntCon = 1:(no_var * 2);

% 9. RUN GA WITH TIMING
fprintf('\n=== Starting Parallel GA Optimization ===\n');

[control_array, best] = ga(obj_fn, no_var * 2, A, b, [], [], lb, ub, [], IntCon, ga_opt);

