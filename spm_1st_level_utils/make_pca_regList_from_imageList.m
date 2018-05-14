function pca_regList = make_pca_regList_from_imageList(imageList)

for i_images = 1:numel(imageList)
    imageList_parts{i_images} = fileparts_full(imageList{i_images});
    jsonList{i_images} = [imageList_parts{i_images}.path, imageList_parts{i_images}.file, '.json'];
    pca_regList{i_images} = get_pca_regressor_from_json(jsonList{i_images});
end
