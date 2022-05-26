function [] = PopulateDatabaseFolder(eyes)
    if eyes
        path = what('Eyes').path;
        eyesArg = 'true';
        target = 300;
    else
        path = what('NoEyes').path;
        eyesArg = 'false';
        target = 400;
    end
    images = dir(append(path,'\*.jpg'));
    L = length(images);
    target = target - L;
    if target > 0
        getImagesPath = what('GetImages').path;
        oldDir = cd(getImagesPath);
        pythonCall = append('get_images.py ', eyesArg, ' ', string(target));
        pyrunfile(pythonCall);
        movefile(append('images\*.jpg'), path);
        rmdir('images');
        cd(oldDir);
    end
end

