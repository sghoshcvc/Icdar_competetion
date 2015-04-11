function data = load_LP(opts)
disp('* Reading LP info *');

load([opts.pathDataset 'traindata.mat']);
load([opts.pathDataset 'testdata.mat']);

i=1;
images = {};
data = traindata;
for j=1:length(data)
    words(i).pathIm = [opts.pathDataset data(j).ImgName];
    im = imread(words(i).pathIm);
    if ndims(im)>2
        im = rgb2gray(im);
    end    
    [words(i).H,words(i).W] = size(im);
    words(i).loc = [1 words(i).W 1 words(i).H];
    words(i).gttext = data(j).GroundTruth;    
    i = i+1;
end

data = testdata;
for j=1:length(data)
    words(i).pathIm = [opts.pathDataset data(j).ImgName];
    im = imread(words(i).pathIm);
    if ndims(im)>2
        im = rgb2gray(im);
    end
    [words(i).H,words(i).W] = size(im);
    words(i).loc = [1 words(i).W 1 words(i).H];
    words(i).gttext = data(j).GroundTruth;    
    i = i+1;
end

clear data;

newClass = 1;
words(1).class = [];
classes = containers.Map();
idxClasses = {};
names = {};

for i=1:length(words)
    gttext = lower(words(i).gttext);
    % Determine the class of the query given the GT text
    if isKey(classes, gttext)
        class = classes(gttext);
    else
        class = newClass;
        newClass = newClass+1;
        classes(gttext) = class;
        idxClasses{class} = int32([]);
        names{class} = gttext;
    end
    idxClasses{class} = [idxClasses{class} i];
    words(i).class = class;
end

%% Output
data.words = words;
data.classes = classes;
data.idxClasses = idxClasses;
data.names = names;
end