function calculate_contrast_spm(matlabbatch,contrastMatrix,contrastName)         


%% load SPM.mat
load(matlabbatch{1}.spm.stats.fmri_est.spmmat{1})

% Check whether the amount of conditions is correct
if length(SPM.Sess(1).U) ~= size(contrastMatrix,2); % assuming here that all conditions are the same for each session
    error(['Contrast Matrix doesnt have the right size!']);
end

% Add zeros for regressors of no interest            
contrastMatrix = [contrastMatrix zeros(size(contrastMatrix,1),length(SPM.Sess(1).C.name))];



SPM.xCon(1:length(SPM.xCon))=[];  %delete previously specified contrasts
       
% T-contrasts
	for nr_contrast=1:size(contrastMatrix,1)
		[c,I,emsg,imsg] = spm_conman('ParseCon',repmat(contrastMatrix(nr_contrast,:),1,size(SPM.Sess,2)),SPM.xX.xKXs,'T');
		DxCon = spm_FcUtil('Set',contrastName{nr_contrast},'T','c',c,SPM.xX.xKXs);
		if isempty(SPM.xCon)
       			SPM.xCon = DxCon;
    		elseif ~isempty(DxCon)
        		SPM.xCon(end+1) = DxCon;
		end
        % and evaluate
	SPM = spm_contrasts(SPM,length(SPM.xCon));
    end
    
    results_dir = [fileparts(matlabbatch{1}.spm.stats.fmri_est.spmmat{1}),'/'];
    %% Change contrast names to those specified in the matrix above
    for contrasts = 1:length(contrastName)
        spmT_name{contrasts} = [results_dir sprintf('spmT_%04.0f.nii',contrasts)];
        new_name{contrasts}  = [results_dir sprintf('spmT_%02.0f_',contrasts) contrastName{contrasts} '.nii'];
        movefile(spmT_name{contrasts},new_name{contrasts});
    end
        