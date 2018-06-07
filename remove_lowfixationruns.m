function [userParams] = remove_lowfixationruns(userParams)
%% Do not include those runs that have fixation below a certain threshold
% loop through .nii labels and get .json outputs
if userParams.fixthreshold > 0;

initial_params = userParams;
for runs = 1:length(initial_params.imageList)
    json_string{runs} = [initial_params.imageList{runs}(1:end-4) '.json'];
    
%read in input json
input_json_text{runs} = fileread(json_string{runs});
    
%convert text to structure
input_json_struct{runs} = jsondecode(input_json_text{runs});
Fixation(runs)          = str2num(input_json_struct{runs}.fixation_pct);
end

Low_Fixation = Fixation < userParams.fixthreshold;
Remove_Runs  = find(Low_Fixation==1);

userParams.imageList(Remove_Runs)   = [];
userParams.mot_regList(Remove_Runs) = [];
userParams.orderList(Remove_Runs)  = [];

disp(['After excluding runs below ' num2str(userParams.fixthreshold) '% - ' num2str(length(userParams.imageList)) ' out of ' num2str(length(initial_params.imageList)) ' remain'])
else disp('All runs included, not separated based on fixation percentage');

end
