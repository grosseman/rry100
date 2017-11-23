Elevation = [90 85 80 75 70 65 60 57.5 55 52.5 50 ...
    47.5 45 42.5 40 37.5 35 32.5 30];
Vant = [1.785 1.802 1.808 1.807 1.808 1.809 1.819 1.799 1.799 1.804 1.803 1.804 1.806 1.808 1.810 1.812 1.815 1.822 1.828];
Vwarm = [2.276 2.272 2.277 2.269 2.267 2.266 2.275 2.256 2.252 2.257 2.257 2.248 2.255 2.255 2.256 2.255 2.251 2.253 2.262];
Vhot = [2.335 2.337 2.338 2.338 2.337 2.335 2.342 2.323 2.325 2.325 2.327 2.323 2.326 2.326 2.325 2.325 2.324 2.327 2.334];
Twarm = [27.0 26.5 26.3 26.1 25.4 25.8 25.7 25.5 25.4 25.2 25.0 24.8 24.8 24.6 24.7 24.7 24.6 24.6 24.7];
Thot = [69.9 69.8 69.3 69.1 69.1 69.3 69.3 69.2 69.4 69.1 69.8 69.2 69.1 69.5 69.5 69.2 69.5 69.5 63.4];
%------------------------
Tground = 289;
Teff = 0.95*Tground;
Tbg = 2.8;
D_Thot = -41.09; 
%------------------------
Twarm_avg = mean(Twarm);
Thot_avg = mean(Thot);
%-------------------------
V1 = Vwarm - Vant;
V2 = Vwarm - Vhot;

Tant = Twarm_avg - (V1./V2).*(Twarm_avg - (Thot_avg + D_Thot));

M =@(e) 1./sin(deg2rad(e));
Mtz = -log( (Teff-Tant)/(Teff-Tbg));

p = polyfit(M(Elevation),Mtz,1);
l = (0:0.1:2);
f = polyval(p,l);
plot(M(Elevation),Mtz,'*');
hold on
plot(l,f);
xlabel('M(e)'); ylabel('M(e)tz')

figure
plot(M(Elevation),exp(-Mtz));
hold on
plot(M(Elevation),exp(Mtz));
legend('Tropospheric transm','Tropospheric att','location','East')
grid on

Y = mean(Vhot./Vwarm);

Trec = (Thot_avg - Y.*Twarm_avg)/(Y-1);

