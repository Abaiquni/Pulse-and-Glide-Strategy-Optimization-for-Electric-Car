% ==================== FUNGSI FITNESS UNTUK PARALLEL ====================
function cost = tunning2(control_array)
    % Fungsi ini HARUS ADA di file terpisah bernama tunning2_parallel.m
    % atau didefinisikan di bawah kode utama
    % 
    % % Load variables from .mat file
    loaded_vars = load('model_variables.mat');
    % 
    % % Assign variables to base workspace
    names = fieldnames(loaded_vars);
    for i = 1:length(names)
         assignin('base', names{i}, loaded_vars.(names{i}));
    end
    % 
    % Load model (setiap worker perlu load sendiri)
    model_name = "model1";
    
    % Cek jika model sudah loaded
    load_system(model_name);
    
    
    set_param(model_name, "FastRestart", "on");
    
    no_var = 70; %30 eprix, 70 lusail
    
    set_param(model_name + "/DriverModel/Constant", "Value", mat2str(control_array));
    set_param(model_name + "/DriverModel/Constant1", "Value", num2str(no_var));
    
    % Run simulation
    out = sim(model_name);
    
    set_param(model_name, "FastRestart", "off");
    
    % Calculate cost
    x = 20;
    
    %mincurvlusail 14630 (+120 jadi 14750 buat safety)
    %mindistlusail 14430 (+120 jadi 14550 buat safety)
    %mincurveprix 9100
    %mindisteprix

    s_min = 14550;
    s_sim = out.distance(length(out.distance));
    

    %tmax eprix = 1490
    %tmax lusail = 2100 (-30 jadi 2070 buat safety)
    t_max = 2070;
    t_sim = out.time(length(out.time));
    
    Wh = out.Wh(length(out.Wh));
    
    f1 = Wh;
    f2 = x*activation(s_min - s_sim); % activation function
    f3 = cos(abs(s_min - s_sim) / s_min);
    f4 = cos(abs(t_max - t_sim) / t_max);
    
    cost = (f1 + f2) / (f3 * f4)
end