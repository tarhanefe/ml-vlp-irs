function mixed_crlbs = mixCRLBList(x_list,nb,irs_list,var_list)
    mixed_crlbs = zeros(1,length(var_list));
    led = placeLed(5,[2,2,3],[0,0.8,-0.6]);
    crlb = 0;
    for j = x_list'
        matrx = fischer_matrix(j',nb,led,irs_list);
        crlb = crlb + trace(inv(matrx));    
    end
    crlb = sqrt(mean(crlb));
    for i = 1:length(var_list)
        mixed_crlbs(i) = crlb*sqrt(var_list(i));
    end
end