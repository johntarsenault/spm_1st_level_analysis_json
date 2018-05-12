function imageList = get_imageList_from_nifti_dir(nifti_dir)

addpath(genpath('/fmri/apps/nx3k_matlab/'))


clear  nifti_file
for i_dir = 1:numel(nifti_dir)
  nifti_file(i_dir).name = util.dirr(nifti_dir{i_dir},'.nii',0,'file');
end

imageList = cat(2,nifti_file.name);