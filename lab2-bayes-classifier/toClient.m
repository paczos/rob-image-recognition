function label = toClient(class)
% class - output of a classifier trained on all classes found in data
% label - projection of the resulting class onto the set of classes expected by the client
    tobestandardized = class-4 > 0;
    label = class;
    label(tobestandardized) = label(tobestandardized)-4;
end