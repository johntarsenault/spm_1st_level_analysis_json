function [regressor_no] = find_num_pca_regressor_from_json(json_file)

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
    
    %check for pca regressor no
    regressor_no_cell = strfind(json_fieldnames, 'pca_regressor_no');
    regressor_no_ID = find(cellfun(@(x) numel(x), regressor_no_cell));
    if isempty(regressor_no_ID)
        error(sprintf(' no pca no found in json file: %s',json_file));    
    end
    
    
    regressor_file = input_json_struct.pca_regressor;
    regressor_no = input_json_struct.pca_regressor_no;
    
else
    warning([json_file, ' does not exist!']);
end