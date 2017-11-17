clc; clear;

p1_list.a = 1:4;
p1_list.b = 4:6;
p1_list.c = linspace(0, 1, 5);
p1_list.d = linspace(1, 0, 3);

p2_list.c = p1_list.c;
p2_list.b = p1_list.b;
p2_list.other = 1:3;

for p1_it = 1:param_linearize(p1_list, 0)
    p1 = param_linearize(p1_list, p1_it);
    p2_it = param_translate(p1_list, p1_it, p2_list);
    p2 = param_linearize(p2_list, p2_it);

    if( abs(p1.b - p2.b) > 1e-6 || abs(p1.c - p2.c) > 1e-6 )
        error('Broken.');
    end
end
disp('Works!');