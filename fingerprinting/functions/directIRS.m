% Function gets input as a irs structure and a point to direct the irs, and
% returns the same irs object with updated norms. Also it can take input as
% a direction type: "uniform" or "directed". 

function irs = directIRS(irs,direction_pt,type)
    size_irs = size(irs.xt);
    if type == "directed"
        for j = 1:size_irs(1)
            xt = irs.xt(j,:);
            dist = norm(xt-direction_pt);
            nt = (direction_pt-xt)/dist;
            irs.nt(j,:) = nt;
        end
    elseif type == "uniform"
         xt = irs.xt(ceil(size_irs(1)/2),:);
         dist = norm(xt-direction_pt);
         nt = (direction_pt-xt)/dist;
         irs.nt = nt;
            for j = 1:size_irs(1)
                irs.nt(j,:) = nt;
            end
    end
end