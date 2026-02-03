function cost = tunning1(control_array)
    load_system("model1");
    set_param("model1","FastRestart","on");
    
    no_var = 30;
    
    set_param("model1/DriverModel/Constant","Value",mat2str(control_array));
    set_param("model1/DriverModel/Constant1","Value",num2str(no_var));
    
    out = sim("model1");

    x = 30;
    
    s_min = 9000;
    s_sim = out.distance(length(out.distance));
    
    t_max = 1500;
    t_sim = out.time(length(out.time));
    
    Wh = out.Wh(length(out.Wh));

    f1 = Wh;
    f2 = x*activation(s_min - s_sim);
    f3 = cos(abs(s_min-s_sim)/s_min);
    f4 = cos(abs(t_max-t_sim)/t_max);
    
    cost = (f1+f2)/(f3*f4)
%att1
%[25 23 26 24 25 26 25 26 26 26 27 25 26 27 26 26 27 25 25 24 25 25 25 24 26 24 27 27 26 24 18 17 19 19 17 18 18 20 20 20 20 20 20 19 21 21 20 18 19 19 20 19 19 19 18 18 19 19 19 29]