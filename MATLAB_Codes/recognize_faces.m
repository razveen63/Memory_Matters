function predict = recognize_faces(cam, newnet,x,folder_names,relation_names)
    persistent previousPrediction  % Variable to store previous prediction
    
    img = snapshot(cam);
    [img, face] = cropface(img);

    if face == 1
        img = imresize(img, [227 227]);
        predict = classify(newnet, img);
        imshow(img);
        title(char(predict));
        drawnow;

        randomAnswer = string(predict);
        j = "";  % Initialize j with an empty string

        for g = 1:length(folder_names)
            if strcmp(char(predict), char(folder_names(g)))
                h = relation_names{g};
                j = string(h);
            end
        end

        if isempty(previousPrediction) || ~strcmp(char(predict), char(previousPrediction))
            % Display and write the text only if the current prediction is different
            text = strcat(randomAnswer, ' detected, relation:', j);
            write(x, text, "string");
%             flush(x);
        end
        
        previousPrediction = predict;  % Store the current prediction for future comparison
    end
end
