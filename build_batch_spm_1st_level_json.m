function [spm_1st_level_matName, matlabbatch] = build_batch_spm_1st_level_json(userParams)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% build pca regressor list
userParams.pca_regNow = 0; %ensures pca regressor is not added to model until it is calculated

if userParams.pca_reg_calc == 1
    
    userParams.pca_regList = makeGLMdenoise_pcRegressors_json(userParams);
    
elseif (userParams.pca_reg_calc == 0) & (userParams.pca_reg == 1)

    userParams.pca_regList = make_pca_regList_from_imageList(userParams.imageList);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% build the spm batch file from user parameters
[spm_1st_level_matName, matlabbatch] = batch_spm_1st_level(userParams);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%