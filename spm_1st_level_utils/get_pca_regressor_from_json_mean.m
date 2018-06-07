function currentRunPCRegressor_session = get_pca_regressor_from_json_mean(json_file,regressor_no)

if exist(json_file)
    
    %read in input json
    input_json_text = fileread(json_file);
    
    %convert text to structure
    input_json_struct = jsondecode(input_json_text);
    
    json_fieldnames = fieldnames(input_json_struct);
    
    %check for pca regressor
    regressor_cell = strfind(json_fieldnames, 'pca_regressor');
    regressor_ID = find(cellfun(@(x) numel(x), regressor_cell));
    if isempty(regressor_ID)
        error(sprintf(' no regressor found in file: %s',json_file));    
    end
    
    
    regressor_file = input_json_struct.pca_regressor;
    regressor_matrix = dlmread(regressor_file);
    
    regressor_file_parts = fileparts_full(regressor_file);
    currentRunPCRegressor_session = sprintf('%s%s_%02d%s',regressor_file_parts.path,regressor_file_parts.file,regressor_no,regressor_file_parts.ext);
    dlmwrite(currentRunPCRegressor_session, regressor_matrix(:,1:regressor_no), 'delimiter', '\t');
    
    
else
    warning([json_file, ' does not exist!']);
end