function T = metamericLight(f,g)
cmf = csvread('./data/ciexyz64_1.csv');
init_lambda = 400;
end_lambda = 700;
space_lambda = 10;
lambdas = init_lambda:space_lambda:end_lambda;
idx = find(cmf(:,1)==init_lambda);
R = cmf(idx:space_lambda:idx+(end_lambda-init_lambda),2:4)';
a = 1.4388e-2;
L_T = @(T) 1./lambdas.^5.*1./(exp(a./(lambdas.*T))-1);
Ts = 2500e3:50e3:10000e3;
D = zeros(1,length(Ts));
for i = 1:length(Ts)
    SPD = (L_T(Ts(i))./sum(L_T(Ts(i))))';
    tmpf = R.*repmat(f',[3,1])*SPD;
    tmpg = R.*repmat(g',[3,1])*SPD;
    D(i)=norm(tmpf- tmpg);
end
[~,idic] = min(D);
T=Ts(idic);
figure
plot(Ts,D)
grid on
title('L_2 distance as a function of Temperature')
xlabel('Temperature')
ylabel('L_2 distance')
figure
plot(lambdas,L_T(T)./sum(L_T(T)))
grid on
title(sprintf('Spectral Power Distribution at best T = %dK ',T/1000))
xlabel('wavelength')
end
