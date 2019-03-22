function label = toClient(class)
    bigger = class-4 > 0;
    label = class;
    label(bigger) = label(bigger)-4;
end