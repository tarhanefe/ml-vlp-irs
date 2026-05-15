function points = roomDivider(room,shape,z_height)
    points(1:3,1:shape(1)*shape(2)) = 0;
    x_dist = room.x / (shape(1)+1);
    y_dist = room.y / (shape(2)+1);
    count = 1;
    for x_pts = 1:shape(1)
        for y_pts = 1:shape(2)
            points(:,count) = [x_dist*x_pts,y_dist*y_pts,z_height];
            count = count + 1;
        end
    end
    points = points';
end