function [nameList errorNames] = buildNameList(name,listDataType)

%empty string array
nameList   = strings(1,numel(cat(2,name.runs)));

%counter for image number and errors
counter     = 0 ;
countErrors = 0;

errorNames = strings(1);

%loop through days
for i = 1:numel(name)
    
    %loop through runs
    for j = 1:numel(name(i).runs)
        
        %build inputs for sprintf 
        currentInput = [];
        for k = 1:numel(name(i).buildInputs)
            if numel(name(i).buildInputs{k}) == numel(name(i).runs)
                currentInput = [currentInput name(i).buildInputs{k}(j)];
            else
                currentInput = [currentInput name(i).buildInputs{k}];
            end
        end
        
        %build name of current image
        currentName = sprintf(fullfile(name(i).dir,name(i).buildRoot),currentInput);
        
        %add to imageList        
        counter = counter +1; %add to counter for new image
        nameList(counter) = currentName;

        
        
        %check if image is present; throw warning if not
        
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
end


if ~countErrors
    disp(sprintf('\n\nall %s found!',listDataType));
else
    disp(sprintf('\nimages missing!\n\nyou  best  check yourself\nbefore you wreck yourself'));
    nameList = [];
end
