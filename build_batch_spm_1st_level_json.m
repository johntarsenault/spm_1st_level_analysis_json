function [spm_1st_level_matName, matlabbatch] = build_batch_spm_1st_level_json(userParams)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% build pca regressor list
if userParams.pca_reg_calc == 1
    
    userParams.pca_regList = makeGLMdenoise_pcRegressors_json(userParams);
    
elseif (userParams.pca_reg_calc == 0) & (userParams.pca_reg == 1) & (userParams.pca_reg_mean_reg_no == 1)

    userParams.pca_regList = make_pca_regList_from_imageList(userParams.imageList,'mean');
    
elseif (userParams.pca_reg_calc == 0) & (userParams.pca_reg == 1)

    userParams.pca_regList = make_pca_regList_from_imageList(userParams.imageList,'optimum');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% build the spm batch file from user parameters
[spm_1st_level_matName, matlabbatch] = batch_spm_1st_level(userParams);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%