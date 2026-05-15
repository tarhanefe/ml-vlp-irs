function der = derlos(x,nb,dim,led)
    l = led.l;
    n = led.n;
    m = 5;
    Apd = (0.004)^2;
    val1 = -1*(m+1)*Apd/(2*pi*norm(x-l)^(m+3));
    val2 = nb(dim)*((x-l)*n')^m;
    val3 = m*n(dim)*((x-l)*n')^(m-1)*((l-x)*nb');
    val4 = (m+3)*(x(dim)-l(dim))*((x-l)*n')^(m)*(l-x)*nb'/norm(x-l)^2;
    der = val1*(val2-val3+val4);
end