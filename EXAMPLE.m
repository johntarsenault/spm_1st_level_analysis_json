
%% addpaths
spm_1st_level_analysis_path = '/data/fmri_monkey_03/PROJECT/John/code/fmri_basics/spm_1st_level_analysis_json/';
spm_to_GLMdenoise_path = '/data/fmri_monkey_03/PROJECT/John/code/fmri_basics/spm_to_GLMdenoise/';
addpath(genpath(spm_1st_level_analysis_path));
addpath(spm_to_GLMdenoise_path);

%% specify directories
userParams.baseDir = '/data/fmri_monkey_03/PROJECT/Sjoerd/FaceBody_Discrimination/fMRI/daily_fMRI_results/tank180425/kanade/';
userParams.niftiDir = fullfile(userParams.baseDir, 'funct/_7_fsl_smooth_preproc/')
userParams.results_dir = fullfile(userParams.baseDir, '/test_results/');

%% specify mask
userParams.use_mask = 1;
userParams.mask_file = '/data/fmri_monkey_03/PROJECT/Sjoerd/FaceBody_Discrimination/fMRI/template/tank/tank_mask.nii';

%% specify model parameters
userParams.RT_time = 2; % in seconds (usually 2s)
userParams.Units = 'scans'; % can either be scans or secs
userParams.Pulse_Numb = 450; % number of TR pulses for each run (length of run in scans)
userParams.hpf = 128; % high-pass filter, SPM default: 128

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% build list image list and spm order file list

userParams.imageList = get_imageList_from_nifti_dir({userParams.niftiDir});
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
    0, -1, -1, -1, -1, -1, -1, -1, -1, -1,  1,  1,  1,  1,  1,  1,  1,  1,  1; ... %2
    0,  1,  1,  1,  1,  1,  1,  1,  1,  1, -1, -1, -1, -1, -1, -1, -1, -1, -1; ... %3
    0,  0, -1,  1, -1,  1, -1,  1, -1,  1,  0, -1,  1, -1,  1, -1,  1, -1,  1; ... %4
    0,  0,  1, -1,  1, -1,  1, -1,  1, -1,  0,  1, -1,  1, -1,  1, -1,  1, -1; ... %5
    0,  0, -1,  0,  1,  0,  0,  0,  0,  0,  0, -1,  0,  1,  0,  0,  0,  0,  0; ... %6
    0,  0,  0, -1,  0,  1,  0,  0,  0,  0,  0,  0, -1,  0,  1,  0,  0,  0,  0; ... %7
    0,  0,  0,  0,  0,  0, -1,  0,  1,  0,  0,  0,  0,  0,  0, -1,  0,  1,  0; ... %8
    0,  0,  0,  0,  0,  0,  0, -1,  0,  1,  0,  0,  0,  0,  0,  0, -1,  0,  1; ... %9
    0,  0, -1,  0, -1,  0,  1,  0,  1,  0,  0, -1,  0, -1,  0,  1,  0,  1,  0; ... %10
    0,  0,  1,  0,  1,  0, -1,  0, -1,  0,  0,  1,  0,  1,  0, -1,  0, -1,  0; ... %11
    0,  0,  0, -1,  0, -1,  0,  1,  0,  1,  0,  0, -1,  0, -1,  0,  1,  0,  1; ... %12
    0,  0,  0,  1,  0,  1,  0, -1,  0, -1,  0,  0,  1,  0,  1,  0, -1,  0, -1; ... %13
    0,  2, -1,  0, -1,  0,  0,  0,  0,  0,  2, -1,  0, -1,  0,  0,  0,  0,  0; ... %14
    0,  2,  0, -1,  0, -1,  0,  0,  0,  0,  2,  0, -1,  0, -1,  0,  0,  0,  0; ... %15
    0,  2,  0,  0,  0,  0, -1,  0, -1,  0,  2,  0,  0,  0,  0, -1,  0, -1,  0; ... %16
    0,  2,  0,  0,  0,  0,  0, -1,  0, -1,  2,  0,  0,  0,  0,  0, -1,  0, -1; ... %17
    0,  1, -1,  0,  0,  0,  0,  0,  0,  0,  1, -1,  0,  0,  0,  0,  0,  0,  0; ... %18
    0,  1,  0, -1,  0,  0,  0,  0,  0,  0,  1,  0, -1,  0,  0,  0,  0,  0,  0; ... %19
    0,  1,  0,  0, -1,  0,  0,  0,  0,  0,  1,  0,  0, -1,  0,  0,  0,  0,  0; ... %20
    0,  1,  0,  0,  0, -1,  0,  0,  0,  0,  1,  0,  0,  0, -1,  0,  0,  0,  0; ... %21 
    0,  1,  0,  0,  0,  0, -1,  0,  0,  0,  1,  0,  0,  0,  0, -1,  0,  0,  0; ... %22
    0,  1,  0,  0,  0,  0,  0, -1,  0,  0,  1,  0,  0,  0,  0,  0, -1,  0,  0; ... %23
    0,  1,  0,  0,  0,  0,  0,  0, -1,  0,  1,  0,  0,  0,  0,  0,  0, -1,  0; ... %24
    0,  1,  0,  0,  0,  0,  0,  0,  0, -1,  1,  0,  0,  0,  0,  0,  0,  0, -1] %25


contrastName{1} = 'all_v_no_target';
contrastName{2} = 'task_a_v_task_b';
contrastName{3} = 'task_b_v_task_a';
contrastName{4} = 'stimuli_left_v_stimuli_right';
contrastName{5} = 'stimuli_right_v_stimuli_left';
contrastName{6} = 'lvf_body_left_v_right';
contrastName{7} = 'rvf_body_left_v_right';
contrastName{8} = 'lvf_face_left_v_right';
contrastName{9} = 'rvf_face_left_v_right';
contrastName{10} = 'lvf_body_v_face';
contrastName{11} = 'lvf_face_v_body';
contrastName{12} = 'rvf_body_v_face';
contrastName{13} = 'rvf_face_v_body';
contrastName{14} = 'lvf_body_v_fix';
contrastName{15} = 'rvf_body_v_fix';
contrastName{16} = 'lvf_face_v_fix';
contrastName{17} = 'rvf_face_v_fix';
contrastName{18} = 'lvf_body_left';
contrastName{19} = 'rvf_Body_left';
contrastName{20} = 'lvf_Body_right';
contrastName{21} = 'rvf_Body_right';
contrastName{22} = 'lvf_face_left';
contrastName{23} = 'rvf_face_left';
contrastName{24} = 'lvf_face_right';
contrastName{25} = 'rvf_face_right';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% step 1 - build 1st level model specification
%         - also runs glm denoise if indicated

[spm_1st_level_matName, matlabbatch] = build_batch_spm_1st_level_json(userParams);

%% step 2 - run 1st level model specification
spm_jobman('run', matlabbatch);

%% step 3 - estimate 1st level glm
matlabbatch = estimate_glm_spm(userParams);

%% step 4 - calculate contrasts
calculate_contrast_spm(matlabbatch, contrastMatrix, contrastName);