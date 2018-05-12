function [spm_1st_level_matName, matlabbatch] = build_batch_spm_1st_level(userParams, analysisVersion)

switch analysisVersion
    case 'TIL'
        [spm_1st_level_matName, matlabbatch] = build_batch_spm_1st_level_TIL(userParams);
    case 'TIL_RM_OUT'
        [spm_1st_level_matName, matlabbatch] = build_batch_spm_1st_level_TIL_RM_OUT(userParams);
    case 'TAO'
        [spm_1st_level_matName, matlabbatch] = build_batch_spm_1st_level_TAO(userParams);
    otherwise
        error(sprintf('analysis version: %s is not supported', analysisVersion));
end
