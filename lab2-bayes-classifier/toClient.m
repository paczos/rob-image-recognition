function label = toClient(class)
    tobestandardized = class-4 > 0;
    label = class;
    label(tobestandardized) = label(tobestandardized)-4;
end