clear all;
clc;
ptCloud = pcread('teapot.ply');
figure
pcshow(ptCloud); 
title('Teapot');

% Select a subset of the points
% Np = 40;
% P = X( :, uint32( ceil( rand( 1, 41472 ) * Nx ) ) );

A = [cos(pi/6) sin(pi/6) 0 0; ...
    -sin(pi/6) cos(pi/6) 0 0; ...
            0         0  1 0; ...
            5         5 10 1];
tform1 = affine3d(A);
sub_ptCloud_mat = ptCloud.Location(1:20000,:);
sub_ptCloud = pointCloud(sub_ptCloud_mat);
ptCloudTformed = pctransform(sub_ptCloud,tform1);

%figure
pcshow(ptCloudTformed);
%title('Transformed Teapot');
pcshowpair(ptCloud, ptCloudTformed)

pause('on')
% get intermidiate results by modifing the max iteration
% needs 36 iters to get local min
for i = 1:50
    pause(0.2)
    [tform, ptCloudReg] = pcregrigid(ptCloudTformed,ptCloud,'Extrapolate',true,'Verbose',true,'MaxIterations',i);
    pcshowpair(ptCloud, ptCloudReg)
    title(num2str(i));
end

% needs 71 iters to get local min, if do not use the acceleration method.
% for i = 100
%     [tform, ptCloudReg] = pcregrigid(ptCloudTformed,ptCloud,'Verbose',true,'MaxIterations',i);
%     pcshowpair(ptCloud, ptCloudReg)
%     title(num2str(i));
% end

