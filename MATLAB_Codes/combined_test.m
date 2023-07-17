% clear; clc;
% b = bluetooth('HC-05',1);
% fopen(b);
% mypi = raspi(); %declare raspberry pi
% cam = cameraboard(mypi,'Resolution','1280x720');%declare the camera
photo_path ='insert file path to folder "photo"';
relation_path = 'insert file path to folder "relation"';
% get the folder contents(names) of the photo folder
% get the folder contents(names) of the relation folder
d = dir(fullfile(photo_path, '*'));
dfolders = d([d(:).isdir]);
% remove '.' and '..' 
dfolders = dfolders(~ismember({dfolders(:).name},{'.','..'}));
folder_names = {dfolders.name};

% get the folder contents(names) of the relation folder
e = dir(fullfile(relation_path, '*'));
efolders = e([e(:).isdir]);
% remove '.' and '..' 
efolders = efolders(~ismember({efolders(:).name},{'.','..'}));
relation_names = {efolders.name};

loaded_data = load('trained_network.mat');
loaded_net = loaded_data.newnet;

% Use loaded_net as a parameter in other functions
% newnet = done(photo_path);  
while true
gpiopin_read = 16;
status = readDigitalPin(mypi,gpiopin_read);
    if(status == 1)
        %ask user to enter name and create directory
        prompt = {'Enter name of person:'};
        dlgtitle = 'Person';
        name = inputdlg(prompt,dlgtitle);
        name_conv = strcat('C:\Users\razve\OneDrive\Desktop\S3 - ECTE351\Modified_Attempt4\photos\',char(name));
        mkdir(name_conv);%create folder with person's name
        crop_path = 'C:\Users\razve\OneDrive\Desktop\S3 - ECTE351\Modified_Attempt4\croppedfaces';
        new2 = strcat(crop_path,'\',char(name));
        mkdir(new2);
        % create folder for defining relation to person
        prompt1 = {'Enter relation to person: '};
        dlgtitle1 = 'Relation';
        rel = inputdlg(prompt1,dlgtitle1);
        create_relation = strcat(relation_path,'\',char(rel));
        mkdir(create_relation);

        % start training the data with addition to the new person's profile
        capture_face(cam,char(name))
        msgbox('Images successfully captured');
        done(photo_path);
        loaded_data = load('trained_network.mat');
        loaded_net = loaded_data.newnet;
    else
        recognize_faces(cam,loaded_net,b,folder_names,relation_names);               
    end
end