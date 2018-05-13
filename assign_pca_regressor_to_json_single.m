function assign_pca_regressor_to_json_single(current_json_file, current_pca_regressor,current_pca_regressor_no)

if exist(current_json_file)
    
    %read in input json
    input_json_text = fileread(current_json_file);
    
    %convert text to structure
    input_json_struct = jsondecode(input_json_text);
    
    %add values to json structure
    input_json_struct.('pca_regressor') = current_pca_regressor;
    input_json_struct.('pca_regressor_no') = current_pca_regressor_no;

    %convert struct to text
    output_json_text = jsonencode(input_json_struct);
    output_json_text = strrep(output_json_text,',',',\n');
    output_json_text = strrep(output_json_text,'%','%%');
    
    %write text to json file
    fid = fopen(current_json_file, 'w');
    if fid == -1
        error('Cannot create JSON file');
    end
    
    fprintf(fid, output_json_text);
    fclose(fid);
    
else
    warning([input_json, ' does not exist!']);
end