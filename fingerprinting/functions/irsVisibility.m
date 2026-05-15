function check = irsVisibility(x,nb,irs,led)
    l = led.l;
    xt = irs.xt;
    nt = irs.nt;
    irs2led = (l-xt)./nnorm(l-xt);
    irs2pd = (x-xt)./nnorm(x-xt);
    angle_arrival = acosd(dot(irs2led',nt')');
    angle_reflection = acosd(dot(irs2pd',nt')');
    psi = acosd(-1*sum(irs2pd'.*nb')');
    check = (angle_arrival < 90) .* (angle_reflection < 90) .* (psi < 90);
end