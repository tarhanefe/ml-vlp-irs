function crlb_map = CRLBMap(irs_list,led,noise_var)
spanx = 0:0.01:4;
spany = 0:0.01:4;
nb = [0 0 1];
z = 0.85;
crlb_map(1:length(spanx),1:length(spany)) = 0;
for x = 1:length(spanx)
    for y = 1:length(spany)
        loc = [x y z];
        matrx = fischer_matrix(loc,nb,led,irs_list);
        crlb_map(x,y) = trace(inv(matrx))^0.5;
    end
end
end