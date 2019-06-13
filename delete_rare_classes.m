[numFiles , ~] = size(wave.Files);
Labels = [];
for i = 1 : numFiles
    [~,name,~] = fileparts(wave.Files{i});
    if class(id == str2num(name)) == 'car_horn' || class(id == str2num(name)) == 'gun_shot'
        delete(wave.Files{i})
    end
end