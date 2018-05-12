spm_1st_level_analysis_path = '/mnt/.autofs/storage/gbw-s-neu01_fmri-monkey-03/PROJECT/John/code/fmri_basics/spm_1st_level_analysis_json/';
spm_to_GLMdenoise_path = '/mnt/.autofs/storage/gbw-s-neu01_fmri-monkey-03/PROJECT/John/code/fmri_basics/spm_to_GLMdenoise/';

addpath(spm_1st_level_analysis_path);
addpath(spm_to_GLMdenoise_path);
%% specify user parameters

%%% specify directories
userParams.rootDir = '/data/fmri_monkey_03/PROJECT/John/TIL/ANALYSIS/Dozer161012/';
userParams.results_dir = fullfile([userParams.rootDir, 'test_results', '/']);

%%%% specify template and monkey name & mask
userParams.templateSpace = "Dozer";
userParams.monkeyNameDate = "Dozer161012";
userParams.mask_folder = '/data/fmri_monkey_03/PROJECT/John/TIL/TEMPLATE_DOZER/';
userParams.mask_file = 'Dozer_Anat_1mm_Mask_Crop.nii';

%%% model params
userParams.RT_time = 2; % in seconds (usually 2s)
userParams.Units = 'scans'; % can either be scans or secs
userParams.Pulse_Numb = 300; % number of TR pulses for each run (length of run in scans)
userParams.hpf = 128; % high-pass filter, SPM default: 128

%specify image info
nifti_dir{1} = '/mnt/.autofs/storage/gbw-s-neu01_fmri-monkey-03/PROJECT/Sjoerd/FaceBody_Discrimination/fMRI/daily_fMRI_results/tank180425/kanade/funct/_4_slice_by_slice_lucas_kanade/';
nifti_dir{2} = '/mnt/.autofs/storage/gbw-s-neu01_fmri-monkey-03/PROJECT/Sjoerd/FaceBody_Discrimination/fMRI/daily_fMRI_results/tank180425/kanade/funct/_3_slice_timing_afni_alt_z2_preproc/';
userParams.imageList = get_imageList_from_nifti_dir(nifti_dir);

clear imageList
imageList{1} = '/mnt/.autofs/storage/gbw-s-neu01_fmri-monkey-03/PROJECT/Sjoerd/FaceBody_Discrimination/fMRI/daily_fMRI_results/tank180423/kanade/funct/_7_fsl_smooth_preproc/Tank180423_IMA_23a_r_st_mr_nr_s.nii';
userParams.orderList = get_orderList_from_nifti_dir(userParams.imageList);

%specify order info
userParams.order_dir = fullfile([userParams.rootDir, 'Dozer161012_SPM_Files', '/']);
userParams.order_number = [2:3];

%%% specify motion regressor info
userParams.motion_reg = 1; % 1 = use motion regressors, 0 = do not use motion regressors
userParams.motion_dir = userParams.image_dir;
userParams.motion_number = [10:11];

%%% specify regressors to use
userParams.pca_reg_calc = 0; % 1 = calc pca using glm_dneoise, 0 = do not calc pca regressors
userParams.pca_reg = 1; % 1 = use pca regressors, 0 = do not use pca regressors
userParams.pca_dir = fullfile([userParams.rootDir, 'funct', '/']); % use to build pca_reg list if pca_reg_calc ==0 and pca_reg == 1
userParams.pca_number = [1:2] % use to build pca_reg list if pca_reg_calc ==0 and pca_reg == 1

%%% specify contrasts

%condition name
condName{1} = '2% up    LVF  (RHR)';
condName{10} = '2% up    LVF  (LHR)';
condName{2} = '2% down  LVF  (RHR)';
condName{11} = '2% down  LVF  (LHR)';
condName{3} = '2% up    RVF  (RHR)';
condName{12} = '2% up    RVF  (LHR)';
condName{4} = '2% down  RVF  (RHR)';
condName{13} = '2% down  RVF  (LHR)';
condName{5} = '50% up   LVF  (RHR)';
condName{14} = '50% up   LVF  (LHR)';
condName{6} = '50% down LVF  (RHR)';
condName{15} = '50% down LVF  (LHR)';
condName{7} = '50% up   RVF  (RHR)';
condName{16} = '50% up   RVF  (LHR)';
condName{8} = '50% down RVF  (RHR)';
condName{17} = '50% down RVF  (LHR)';
condName{9} = '0% (RHR)';
condName{18} = '0% (LHR)';

contrastMatrix = [-1, -1, -1, -1, -1, -1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1; ... %1
    -1, -1, 1, 1, -1, -1, 1, 1, 0, -1, -1, 1, 1, -1, -1, 1, 1, 0; ... %2
    -1, -1, -1, -1, -1, -1, -1, -1, 8, -1, -1, -1, -1, -1, -1, -1, -1, 8; ... %3
    0, 0, 0, 0, -1, -1, -1, -1, 4, 0, 0, 0, 0, -1, -1, -1, -1, 4; ... %4
    -1, -1, -1, -1, 0, 0, 0, 0, 4, -1, -1, -1, -1, 0, 0, 0, 0, 4; ... %5
    0, 0, 0, 0, -1, -1, 1, 1, 0, 0, 0, 0, 0, -1, -1, 1, 1, 0; ... %6
    -1, -1, 1, 1, 0, 0, 0, 0, 0, -1, -1, 1, 1, 0, 0, 0, 0, 0; ... %7
    -1, -1, 0, 0, 0, 0, 0, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0, 2; ... %8
    0, 0, -1, -1, 0, 0, 0, 0, 2, 0, 0, -1, -1, 0, 0, 0, 0, 2; ... %9
    0, 0, 0, 0, -1, -1, 0, 0, 2, 0, 0, 0, 0, -1, -1, 0, 0, 2; ... %10
    0, 0, 0, 0, 0, 0, -1, -1, 2, 0, 0, 0, 0, 0, 0, -1, -1, 2; ... %11
    -1, 1, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0; ... %12
    0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0; ... %13
    0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0; ... %14
    0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, -1, 1, 0; ... %15
    -1, 0, 0, 0, 0, 0, 0, 0, 1, -1, 0, 0, 0, 0, 0, 0, 0, 1; ... %16
    0, -1, 0, 0, 0, 0, 0, 0, 1, 0, -1, 0, 0, 0, 0, 0, 0, 1; ... %17
    0, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 1; ... %18
    0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0, 0, 1; ... %19
    0, 0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, 0, -1, 0, 0, 0, 1; ... %20
    0, 0, 0, 0, 0, -1, 0, 0, 1, 0, 0, 0, 0, 0, -1, 0, 0, 1; ... %21
    0, 0, 0, 0, 0, 0, -1, 0, 1, 0, 0, 0, 0, 0, 0, -1, 0, 1; ... %22
    0, 0, 0, 0, 0, 0, 0, -1, 1, 0, 0, 0, 0, 0, 0, 0, -1, 1];%23

contrastName{1} = 'RightHand_v_LeftHand';
contrastName{2} = 'LeftMotion_v_RightMotion';
contrastName{3} = 'Motion_v_NoMotion';
contrastName{4} = '50Pct_v_0Pct';
contrastName{5} = '2Pct_v_0Pct';
contrastName{6} = '50PctLeft_v_50PctRight';
contrastName{7} = '2PctLeft_v_2PctRight';
contrastName{8} = '2PctLeft_v_0Pct';
contrastName{9} = '2PctRight_v_0Pct';
contrastName{10} = '50PctLeft_v_0Pct';
contrastName{11} = '50PctRight_v_0Pct';
contrastName{12} = '2PctLeftUp_v_2PctLeftDown';
contrastName{13} = '2PctRightUp_v_2PctRightDown';
contrastName{14} = '50PctLeftUp_v_60PctLeftDown';
contrastName{15} = '50PctRightUp_v_60PctRightDown';
contrastName{16} = '2%_up____LVF';
contrastName{17} = '2%_down__LVF';
contrastName{18} = '2%_up____RVF';
contrastName{19} = '2%_down__RVF';
contrastName{20} = '50%_up___LVF';
contrastName{21} = '50%_down_LVF';
contrastName{22} = '50%_up___RVF';
contrastName{23} = '50%_down_RVF';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% step 1 - build 1st level model specification
%         - also runs glm denoise if indicated
%         - second input determines version of build batch b/c
%           rules to construct lists can change across time

[spm_1st_level_matName, matlabbatch] = build_batch_spm_1st_level(userParams, 'TIL');

%% step 2 - run 1st level model specification
spm_jobman('run', matlabbatch);

%% step 3 - estimate 1st level glm
matlabbatch = estimate_glm_spm(userParams);

%% step 4 - calculate contrasts
calculate_contrast_spm(matlabbatch, contrastMatrix, contrastName);