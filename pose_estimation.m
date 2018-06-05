function [pose_mat] = pose_estimation(points3D,pointsImage)

    h_mat = compute_homography(points3D, pointsImage);

end

