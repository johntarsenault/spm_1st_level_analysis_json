function spm_order_file = get_spm_mat_from_json(json_file)

if exist(json_file)
    
    %read in input json
    input_json_text = fileread(json_file);
    
    %convert text to structure
    input_json_struct = jsondecode(input_json_text);
    
    json_fieldnames = fieldnames(input_json_struct);
    
    spm_order_cell = strfind(json_fieldnames, 'spm_order_file');
    spm_order_ID = find(cellfun(@(x) numel(x), spm_order_cell));
    
    if isempty(spm_order_ID)
        error(sprintf(' no spm order file found in: %s',json_file));
    end
    
    %add values to json structure
    spm_order_file = input_json_struct.spm_order_file;
    
else
    warning([json_file, ' does not exist!']);
end