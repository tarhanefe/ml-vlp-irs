function power_map = powerMap(irs,led,noise_var)
spanx = 0:0.01:4;
spany = 0:0.01:4;
z = 0.85;
power_map(1:length(spanx),1:length(spany)) = 0;
for x = 1:length(spanx)
    for y = 1:length(spany)
        power_map(x,y) = calcPower([spanx(x),spany(y),z],[0,0,1],irs,led,noise_var,0).power;
    end
end
end