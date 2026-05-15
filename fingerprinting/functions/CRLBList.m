function crlbs = CRLBList(x,nb,irs_list,var_list)
    crlbs = zeros(1,length(var_list));
    led = placeLed(5,[2,2,3],[0,0.8,-0.6]);
    matrx = fischer_matrix(x,nb,led,irs_list);
    for i = 1:length(var_list)
        crlbs(i) = trace(inv(matrx/(var_list(i))))^0.5;
    end

end