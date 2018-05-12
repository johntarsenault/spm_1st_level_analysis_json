function [spm_1st_level_matName matlabbatch] = build_batch_spm_1st_level_TAO(userParams)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% build image List

imageName.dir            = userParams.image_dir;
imageName.runs           = userParams.image_number;
imageName.buildRoot      = 'snr%s_Run%02.0f.nii';
imageName.buildInputs{1} = userParams.monkeyNameDate;
imageName.buildInputs{2} = string(imageName.runs);

[userParams.imageList imageListError] = buildNameList_single(imageName,'4D images');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% build orderFile list (e.g. mat-files with onsets,names,durations) 

orderName.dir            = userParams.order_dir;
orderName.runs           = userParams.order_number;
orderName.buildRoot      = 'order%s_condblock.mat';
orderName.buildInputs{1} = string(orderName.runs);

[userParams.orderList orderListErrors] = buildNameList_single(orderName,'order files');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% build motion regressor list 
if userParams.motion_reg
    mot_regName.dir            = userParams.motion_dir;
    mot_regName.runs           = userParams.motion_number;
    mot_regName.buildRoot      = 'rp_%s_Run%02.0f.txt';
    mot_regName.buildInputs{1} = userParams.monkeyNameDate;
    mot_regName.buildInputs{2} = string(mot_regName.runs);

    [userParams.mot_regList mot_regListErrors] = buildNameList_single(mot_regName,'motion regressors');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% build pca regressor list
userParams.pca_regNow      = 0; %ensures pca regressor is not added to model until it is calculated

if userParams.pca_reg == 1 & userParams.pca_reg_calc == 0
    pca_regName.dir            = userParams.pca_dir;
    pca_regName.runs           = userParams.pca_number;
    pca_regName.buildRoot      = 'pcRegressor_run%02.0f.txt';
    pca_regName.buildInputs{1} = string(pca_regName.runs);
    userParams.pca_regNow      = 1;
    [userParams.pca_regList pca_regListErrors] = buildNameList_single(pca_regName,'pca regressors');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% build the spm batch file from user parameters
[spm_1st_level_matName matlabbatch] = batch_spm_1st_level_TAO(userParams);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% run glm denoise on the data and rebuild the spm batch file
if userParams.pca_reg_calc == 1
    denoise_dir            = fullfile([userParams.rootDir,'glm_denoise_data/']);
    mask                   = 1;
    userParams.pca_regList = makeGLMdenoise_pcRegressors_fullPath_seconds(spm_1st_level_matName,mask,denoise_dir);
    userParams.pca_regNow      = 1;
    [spm_1st_level_matName matlabbatch] = batch_spm_1st_level_TAO(userParams);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


