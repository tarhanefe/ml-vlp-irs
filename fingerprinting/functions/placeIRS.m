function irs = placeIRS(room_size,array_shape,mirror_size,mirror_dist,side,orient,direction_pt)
rotation_lim = 40;
irs.irs_count = array_shape(1)*array_shape(2);
irs.xt(1:irs.irs_count,1:3) = 0;
irs.nt(1:irs.irs_count,1:3) = 0;
irs.size = mirror_size;

if orient == "random"
irs.elevation = rotation_lim*2*rand(1,irs.irs_count)-rotation_lim;
irs.azimuth = rotation_lim*2*rand(1,irs.irs_count)-rotation_lim;

elseif (orient == "uniform") || (orient == "directed")
irs.elevation = zeros(1,irs.irs_count);
irs.azimuth = zeros(1,irs.irs_count);
end

array_length = (array_shape - 1) .* (mirror_dist + mirror_size);
shape = array_shape;
switch(side)
    case 1  % LEFT 
        start_arr = ([room_size(3),room_size(2)]-array_length)/2;
        count = 1;
        for i = 1:shape(1)
            for j = 1:shape(2)
                irs.xt(count,:) = [0.02,start_arr(2) + (j-1)*(mirror_dist(2) + mirror_size(2)),start_arr(1) + (i-1)*(mirror_dist(1) + mirror_size(1))];
                irs.nt(count,:) = [1,0,0];
                elevation = irs.elevation(count);
                azimuth = irs.azimuth(count);
                irs.nt(count,:) = rotateVector(irs.nt(count,:),'y',azimuth);
                irs.nt(count,:) = rotateVector(irs.nt(count,:),'z',elevation);
                count = count + 1;
            end 
        end 
       
    case 2  %RIGHT
        start_arr = ([room_size(3),room_size(2)]-array_length)/2;
        count = 1;
        for i = 1:shape(1)
            for j = 1:shape(2)
                irs.xt(count,:) = [room_size(1)-0.02,start_arr(2) + (j-1)*(mirror_dist(2) + mirror_size(2)),start_arr(1) + (i-1)*(mirror_dist(1) + mirror_size(1))];
                irs.nt(count,:) = [-1,0,0];
                elevation = irs.elevation(count);
                azimuth = irs.azimuth(count);
                irs.nt(count,:) = rotateVector(irs.nt(count,:),'y',azimuth);
                irs.nt(count,:) = rotateVector(irs.nt(count,:),'z',elevation);
                count = count + 1;
            end 
        end 

    case 3  %FRONT
        start_arr = ([room_size(3),room_size(1)]-array_length)/2;
        count = 1;
        for i = 1:shape(1)
            for j = 1:shape(2)
                irs.xt(count,:) = [start_arr(2) + (j-1)*(mirror_dist(2) + mirror_size(2)),0.02,start_arr(1) + (i-1)*(mirror_dist(1) + mirror_size(1))];
                irs.nt(count,:) = [0,1,0];
                elevation = irs.elevation(count);
                azimuth = irs.azimuth(count);
                irs.nt(count,:) = rotateVector(irs.nt(count,:),'x',azimuth);
                irs.nt(count,:) = rotateVector(irs.nt(count,:),'z',elevation);
                count = count + 1;
            end 
        end 

    case 4  %BACK
        start_arr = ([room_size(3),room_size(1)]-array_length)/2;
        count = 1;
        for i = 1:shape(1)
            for j = 1:shape(2)
                irs.xt(count,:) = [start_arr(2) + (j-1)*(mirror_dist(2) + mirror_size(2)),room_size(2)-0.02,start_arr(1) + (i-1)*(mirror_dist(1) + mirror_size(1))];
                irs.nt(count,:) = [0,-1,0];
                elevation = irs.elevation(count);
                azimuth = irs.azimuth(count);
                irs.nt(count,:) = rotateVector(irs.nt(count,:),'x',azimuth);
                irs.nt(count,:) = rotateVector(irs.nt(count,:),'z',elevation);
                count = count + 1;
            end 
        end 
end 

if orient == "uniform"
    irs = directIRS(irs,direction_pt,"uniform");
elseif orient == "directed"
    irs = directIRS(irs,direction_pt,"directed");
end


end