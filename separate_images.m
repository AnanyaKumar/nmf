function [ separated_images ] = separate_images(images, labels)
% images(:, i) is the ith image
% label(i) is the ith label
% images{nu}(:,i) is the ith image representing digit "num"

separated_images = cell(10,1);
for i = 1:10
    separated_images{i} = images(:, labels == i-1);
end
