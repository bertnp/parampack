clear; clc;
% this file contains a parameter sweep over 14 (win_len, lambda) pairs and 60
% data indices
load('../../Data/bpdn_tuned_winlen-0-2017.08.25.17.13.53.mat');

% we can extract out the emd_dist in a number of ways

% by fulling specifying the fields
mean_errs = mean(...
    out2array(outs.bpdn, p_list.bpdn, 'dist_emd', {'data_index', 'win_len'}));
disp(mean_errs);

% we can swap the order
mean_errs = mean(...
    out2array(outs.bpdn, p_list.bpdn, 'dist_emd', {'win_len', 'data_index'}), 2)';
disp(mean_errs);

% or just specify one
mean_errs = mean(out2array(outs.bpdn, p_list.bpdn, 'dist_emd', {'data_index'}));
disp(mean_errs);

% or the other
mean_errs = mean(out2array(outs.bpdn, p_list.bpdn, 'dist_emd', {'win_len'}), 2)';
disp(mean_errs);

% if we only have one we don't need the { }
mean_errs = mean(out2array(outs.bpdn, p_list.bpdn, 'dist_emd', 'data_index'));
disp(mean_errs);