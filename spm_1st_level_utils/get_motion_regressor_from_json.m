function regressor_file = get_motion_regressor_from_json(json_file)

if exist(json_file)
    
    %read in input json
    input_json_text = fileread(json_file);
    
    %convert text to structure
    input_json_struct = jsondecode(input_json_text);
    
    json_fieldnames = fieldnames(input_json_struct);
    
    regressor_cell = strfind(json_fieldnames, 'motion_regressor');
    regressor_ID = find(cellfun(@(x) numel(x), regressor_cell));
    
    if isempty(regressor_ID)
        error(sprintf(' no regressor file found in: %s',json_file));    
    end
    
    
    
    %add values to json structure
    regressor_file = input_json_struct.motion_regressor;
    
else
    warning([json_file, ' does not exist!']);
end