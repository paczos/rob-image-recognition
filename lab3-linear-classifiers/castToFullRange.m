function labelsFullRange = castToFullRange(labelsSmallRange, group,rejectIdx)
    tocastsel = labelsSmallRange ~= (unique(labelsSmallRange))(rows(unique(labelsSmallRange)));
    tocastval = labelsSmallRange(tocastsel);
    cast = group(tocastval);
    labelsSmallRange(tocastsel) = cast;
    labelsFullRange = labelsSmallRange;
end
