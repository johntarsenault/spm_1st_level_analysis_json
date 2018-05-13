
%% addpaths
%%% specify user parameters
% javaaddpath('iText-4.2.0-com.itextpdf.jar')

spm_1st_level_analysis_path = '/data/code/spm_1st_level_analysis_json/';
spm_to_GLMdenoise_path = '/data/code/spm_to_GLMdenoise/';

addpath(spm_1st_level_analysis_path);
addpath(spm_to_GLMdenoise_path);

%% specify directories
userParams.baseDir = '/data/examples/fmri/tank180425/';
userParams.results_dir = fullfile([userParams.baseDir, 'test_results/']);

%% specify mask
userParams.use_mask = 1;
userParams.mask_file = '/data/examples/fmri/tank180425/funct/mask/Tank180425_IMA_20_r_st_masked_dilate_smooth.nii';

%% specify model parameters
userParams.RT_time = 2; % in seconds (usually 2s)
userParams.Units = 'scans'; % can either be scans or secs
userParams.Pulse_Numb = 450; % number of TR pulses for each run (length of run in scans)
userParams.hpf = 128; % high-pass filter, SPM default: 128

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nifti_json_dir = '/data/examples/fmri/tank180425/funct/_5_motion_realign_across_runs/';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% build list image list and spm order file list

userParams.imageList = get_imageList_from_nifti_dir({nifti_json_dir});
userParams.orderList = get_orderList_from_imageList(userParams.imageList);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% build a motion regressor list
userParams.motion_reg = 1;

userParams.mot_regList = get_motion_regList_from_imageList(userParams.imageList);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% build pca regressors
userParams.pca_reg_calc = 0; % 1 = calc pca using glm_dneoise, 0 = do not calc pca regressors
userParams.pca_reg = 1; % 1 = use pca regressors, 0 = do not use pca regressors

%%% specify contrasts

%condition name
condName{1} = 'No_Target_150';
condName{2} = 'Task_A_150';
condName{3} = 'Task_A_Dist_150_Body_Left_225.0';
condName{4} = 'Task_A_Dist_150_Body_Left_315.0';
condName{5} = 'Task_A_Dist_150_Body_Right_225.0';
condName{6} = 'Task_A_Dist_150_Body_Right_315.0';
condName{7} = 'Task_A_Dist_150_Face_Left_225.0';
condName{8} = 'Task_A_Dist_150_Face_Left_315.0';
condName{9} = 'Task_A_Dist_150_Face_Right_225.0';
condName{10} = 'Task_A_Dist_150_Face_Right_315.0';
condName{11} = 'Task_B_150';
condName{12} = 'Task_B_Dist_150_Body_Left_225.0';
condName{13} = 'Task_B_Dist_150_Body_Left_315.0';
condName{14} = 'Task_B_Dist_150_Body_Right_225.0';
condName{15} = 'Task_B_Dist_150_Body_Right_315.0';
condName{16} = 'Task_B_Dist_150_Face_Left_225.0';
condName{17} = 'Task_B_Dist_150_Face_Left_315.0';
condName{18} = 'Task_B_Dist_150_Face_Right_225.0';
condName{19} = 'Task_B_Dist_150_Face_Right_315.0';

contrastMatrix = [18, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1; ... %1
    0, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ... %2
    0, 1, 1, 1, 1, 1, 1, 1, 1, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1]; %3

contrastName{1} = 'all_v_no_target';
contrastName{2} = 'task_a_v_task_b';
contrastName{3} = 'task_b_v_task_a';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% step 1 - build 1st level model specification
%         - also runs glm denoise if indicated
%         - second input determines version of build batch b/c
%           rules to construct lists can change across time

[spm_1st_level_matName, matlabbatch] = build_batch_spm_1st_level_json(userParams);

%% step 2 - run 1st level model specification
spm_jobman('run', matlabbatch);

%% step 3 - estimate 1st level glm
matlabbatch = estimate_glm_spm(userParams);

%% step 4 - calculate contrasts
calculate_contrast_spm(matlabbatch, contrastMatrix, contrastName);