function pca_regList = make_pca_regList_from_imageList(imageList, num_regressors)

switch num_regressors
    case 'optimum'
        
        for i_images = 1:numel(imageList)
            imageList_parts{i_images} = fileparts_full(imageList{i_images});
            jsonList{i_images} = [imageList_parts{i_images}.path, imageList_parts{i_images}.file, '.json'];
            pca_regList{i_images} = get_pca_regressor_from_json(jsonList{i_images});
        end
        
    case 'mean'
        num_pca_regressors_array = zeros(1, numel(imageList));
        
        for i_images = 1:numel(imageList)
            imageList_parts{i_images} = fileparts_full(imageList{i_images});
            jsonList{i_images} = [imageList_parts{i_images}.path, imageList_parts{i_images}.file, '.json'];
            num_pca_regressors_array(i_images) = find_num_pca_regressor_from_json(jsonList{i_images});
        end
        
        %find the mean number of regressors
        mean_num_pca_regressors = round(mean(num_pca_regressors_array));
        
        for i_images = 1:numel(imageList)
            pca_regList{i_images} = get_pca_regressor_from_json(jsonList{i_images});
        end
        
        
end
