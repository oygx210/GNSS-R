function e = invFresnel(R, S)
% R: Fresnel reflection coefficient
% S: specular data
% e: dielectric constant

e = zeros(size(S.data, 1), 1);

tol = 1e-4;
K = 10;

for i = 1:size(S.data, 1)
    if R(i) > 1
        error('Out of bounds');
    end
    
    e(i) = 5;
    theta = S.data(i, S.header.theta);
    
    [Rvv,Rhh]=fresnelCoeff(e(i),theta);
    [~,Rcs]=cocross(Rvv,Rhh);
    
    while abs(R(i)-Rcs) > tol
        e(i) = e(i)+K*(R(i)-Rcs);

        [Rvv,Rhh]=fresnelCoeff(e(i),theta);
        [~,Rcs]=cocross(Rvv,Rhh);
    end
end

end

