function check = ledVisibility(x,nb,led)
    l = led.l;
    check = (((l-x)*nb') >= 0);
end
