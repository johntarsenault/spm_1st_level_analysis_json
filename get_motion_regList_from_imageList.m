function mot_regList = get_motion_regList_from_imageList(imageList)

for i_images = 1:numel(imageList)
    imageList_parts{i_images} = fileparts_full(imageList{i_images});
    jsonList{i_images} = [imageList_parts{i_images}.path, imageList_parts{i_images}.file, '.json'];
    mot_regList{i_images} = get_motion_regressor_from_json(jsonList{i_images});
end
