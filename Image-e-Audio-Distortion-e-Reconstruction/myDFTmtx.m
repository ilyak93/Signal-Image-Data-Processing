function DFTmtx = myDFTmtx(N, inv)
    sgn = sign(inv-0.5);
    [k, l] = ndgrid(0:N-1, 0:N-1);
    W = sgn*1i*2*pi/N;
    DFTmtx = exp(W .* k .* l) ./ sqrt(N);
    clear k l
end