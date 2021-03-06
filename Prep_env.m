opts = Prep_env()
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% to prepare the environment variables
%if ~isdeployed()
addpath('util');
addpath('util/io');
%end

if ~exist('util/vlfeat-0.9.18/toolbox/mex','dir')
    if isunix
        cd 'util/vlfeat-0.9.18/';
        mexloc = fullfile(matlabroot,'bin/mex');
        % This is necessary to include support to OpenMP in Mavericks+XCode5
        % gcc4.2 can be installed from MacPorts
        %if strcmpi(computer,'MACI64')
        %   system(sprintf('make MEX=%s CC=/opt/local/bin/gcc-apple-4.2',mexloc));
        %else
        system(sprintf('make MEX=%s',mexloc));
        %end
        cd ../..;
    else
        run('util/vlfeat-0.9.18/toolbox/vl_compile');
    end
end


run('util/vlfeat-0.9.18/toolbox/vl_setup')
pathModel = 'model';
opts.pathDoc ='Docs';
opts.pathQuery ='Queries';
load(fullfile(pathModel,'opts.mat'));
opts.pathModel = 'model';
opts.pathDoc ='Docs';
opts.pathQuery ='Queries';
