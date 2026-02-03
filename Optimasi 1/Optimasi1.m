load_system("model1");
set_param("model1","FastRestart","off");

no_var = 30;

lb_vmax = ones([1,no_var]).*22;
lb_vmin = ones([1,no_var-1]).*16;
lb_glide = 20; %ini coba ganti 20 aja (attempt 26)

ub_vmax = ones([1,no_var]).*28;
ub_vmin = ones([1,no_var-1]).*22;
ub_glide = no_var;

lb = [lb_vmax,lb_vmin,lb_glide];
ub = [ub_vmax,ub_vmin,ub_glide];

A1 = zeros([no_var-1,no_var*2]);
for i = 1:no_var-1
    A1(i,i) = -1;
    A1(i,no_var+i) = 1;
end
   
A2 = zeros([no_var-1,no_var*2]);
for i = 1:no_var-1
    A2(i,i+1) = -1;
    A2(i,no_var+i) = 1;
end

A = [A1;A2];
b = ones([(no_var-1)*2,1]).*-5;
%cobain parpoolnya claude

ga_opt = optimoptions('ga','Display','off','Generations',100,'PopulationSize',50,'PlotFcns',@gaplotbestf,'CreationFcn',@gacreationuniform,'FitnessScalingFcn',@fitscalingrank,'SelectionFcn',{@selectiontournament,4},'CrossoverFraction',0.5,'MutationFcn',@mutationadaptfeasible,'CrossoverFcn',@crossoverarithmetic,'UseParallel',false);
obj_fn = @(control_array) tunning1(control_array);
IntCon = 1:(no_var*2); %untuk membuat 40 indeks menjadi integer

[control_array, best] = ga((obj_fn),no_var*2,A,b,[],[],lb,ub,[],IntCon,ga_opt);