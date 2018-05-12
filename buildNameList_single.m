function [nameList errorNames] = buildNameList_single(name,listDataType)

%% initialize lists
%empty string array
nameList   = strings(1,numel(name.runs));

%counter for image number and errors
counter         = 0;
countErrors     = 0;
errorNames      = strings(1);

%% build list for each run

    %loop through runs
    for j = 1:numel(name.runs)
        
        %build inputs for sprintf 
        currentInput = [];
        for k = 1:numel(name.buildInputs)
            if numel(name.buildInputs{k}) == numel(name.runs)
                currentInput = [currentInput name.buildInputs{k}(j)];
            else
                currentInput = [currentInput name.buildInputs{k}];
            end
        end
        
        %build name of current image
        currentName = sprintf(fullfile(name.dir,name.buildRoot),currentInput);
        
        %add to nameList        
        counter = counter +1; %add to counter for new image
        nameList(counter) = currentName;
        
        
        %check if name is present; throw warning if not
        
        if exist(currentName, 'file')
            % File exists.  Do stuff....
        else
            countErrors = countErrors+1;
            errorNames(countErrors) = currentName;
            
            % File does not exist.
            warningMessage = sprintf('\nWarning: file does not exist:\n%s', currentName);
            disp(warningMessage);
        end

    end



if ~countErrors
    disp(sprintf('\n\nall %s found!',listDataType));
else
    disp(sprintf('\nimages missing!\n\nyou  best  check yourself\nbefore you wreck yourself'));
    nameList = [];
end
