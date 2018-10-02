function [spm_1st_level_matName, matlabbatch] = batch_spm_1st_level(userParams)

%% default model parameters

matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0, 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

%% user defined model parameters
matlabbatch{1}.spm.stats.fmri_spec.timing.units = userParams.Units;
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = userParams.RT_time;
matlabbatch{1}.spm.stats.fmri_spec.mask = {[userParams.mask_file, ',1']};
matlabbatch{1}.spm.stats.fmri_spec.dir = {userParams.results_dir};

%% Specify images and order files

% loop through each 4D nifti image in the imageList
for run = 1:numel(userParams.imageList)
    
    %get number of timepoints in current run
    Pulse_Numb = numel(spm_vol(char(userParams.imageList(run))));
    
    %loop through each timepoint and assign an image
    for TRnumb = 1:Pulse_Numb
        matlabbatch{1}.spm.stats.fmri_spec.sess(run).scans{TRnumb, 1} = [char(userParams.imageList(run)), ',', num2str(TRnumb)];
    end
    
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(run).hpf = userParams.hpf;
    
    % Generate timing files based on a function that should be adapted from
    % paradigm to paradigm!
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(run).multi = {char(userParams.orderList(run))};
end

%% add motion regressor

if userParams.motion_reg == 1;
    
    %loop through each run
    for run = 1:numel(matlabbatch{1}.spm.stats.fmri_spec.sess)
        
        %load realignment mat files
        realignment_txtFile = char(userParams.mot_regList{run});
        realignment_matFile = dlmread(realignment_txtFile);
        
        %check if realignment txt files contains the correct number of
        %dataPoints
        
        if size(realignment_matFile, 1) ~= Pulse_Numb;
            realignment_matFile = realignment_matFile';
            if size(realignment_matFile, 1) ~= Pulse_Numb;
            error(['Motion regressor parameters for ', char(userParams.imageList(run)), ' are not correct!'])
            end
            end
        
        %add txt file name to regressors
        matlabbatch{1}.spm.stats.fmri_spec.sess(run).multi_reg = {realignment_txtFile};
        
        
    end
    
    %string for batchFile naming
    motion_str = 'motReg';
    
else
    motion_str = 'no_motReg';
end

%% add glm denoise pca regressors
if userParams.pca_reg == 1
    
    % Combine denoise and motion regressor columns
    for run = 1:numel(matlabbatch{1}.spm.stats.fmri_spec.sess)
        
        %load motion regressor
        txt_file{run} = char(matlabbatch{1}.spm.stats.fmri_spec.sess(run).multi_reg);
        txt_data{run} = load(txt_file{run});
        
        % if vector is column sorted instead of row sorted rotate
        if size(txt_data{run},1) == 1
            txt_data{run} = txt_data{run}';
        end
        
        %load pca regressor file
        pca_reg_file{run} = load(char(userParams.pca_regList{run}));
        
        % create new regressor file combining motion regressor
        % and pca regressor
        clear multi_reg_file
        
        
        % check if directory exists if not then create
        new_motion_dir = fullfile(userParams.baseDir, '/funct/regressor/')
        if ~exist(new_motion_dir)
            mkdir(new_motion_dir)
        end
        
        multi_reg_file = [txt_data{run}, pca_reg_file{run}];
        
        multi_reg_fileName = sprintf([userParams.baseDir, '/funct/regressor/', 'multi_reg_run%02.0f.txt'], run);
        
        dlmwrite(multi_reg_fileName, multi_reg_file, 'delimiter', ' ');
        
        matlabbatch{1}.spm.stats.fmri_spec.sess(run).multi_reg = {multi_reg_fileName};
    end
    
    %string for batchFile naming
    pca_str = 'pcaReg';
else
    pca_str = 'no_pcaReg';
    
end

%% if no results directory; make results directory
if ~exist(userParams.results_dir)
    mkdir(userParams.results_dir);
end

%% generate batch file name and save matlabbatch
a = datestr(clock, 31);
time_stamp = [a(3:4), a(6:7), a(9:10), '_', a(12:13), 'h', a(15:16)];

split_baseDir = strsplit(userParams.baseDir, '/');
split_baseDir(find(cellfun(@isempty, split_baseDir))) = [];
monkeyNameDate = split_baseDir{end};

spm_1st_level_matName = ['batch_', char(monkeyNameDate), '_', time_stamp, '_', motion_str, '_', pca_str, '.mat'];
spm_1st_level_matName = fullfile(userParams.results_dir, '..', spm_1st_level_matName);

save(spm_1st_level_matName, 'matlabbatch')
