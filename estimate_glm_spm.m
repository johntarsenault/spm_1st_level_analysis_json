function [matlabbatch] = estimate_glm_spm(userParams)

%% Estimation GLM
matlabbatch{1}.spm.stats.fmri_est.spmmat = {fullfile([userParams.results_dir 'SPM.mat'])};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run',matlabbatch) % estimate fMRI model