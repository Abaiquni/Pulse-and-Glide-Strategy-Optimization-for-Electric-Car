function cost = tunning3(control_array)

    model_name = "model1";
    load_system(model_name);
    set_param(model_name, "FastRestart", "on");

    set_param('model1/DriverModel1/Constant', 'Value', mat2str(control_array));  % NO QUOTES!
    
    % Run simulation
    out = sim(model_name);
    
    % Calculate cost
    x = 20;
    s_min = 9100;
    s_sim = out.distance(length(out.distance));
    
    t_max = 1490;
    t_sim = out.time(length(out.time));
    
    Wh = out.Wh(length(out.Wh));
    
    f1 = Wh;
    f2 = x*activation(s_min - s_sim);
    f3 = cos(abs(s_min-s_sim)/s_min);
    f4 = cos(abs(t_max-t_sim)/t_max);
    
    cost = (f1+f2)/(f3*f4)


