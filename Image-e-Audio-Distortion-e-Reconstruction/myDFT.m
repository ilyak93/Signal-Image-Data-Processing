function coefs = myDFT(in)
    [~, N] = size(in);
    my_ftx_mtx = myDFTmtx(N, false);
    coefs = (my_ftx_mtx ./ sqrt(N) * in.').';
end