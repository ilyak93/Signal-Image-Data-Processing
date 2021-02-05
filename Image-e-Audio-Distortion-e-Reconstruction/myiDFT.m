function coefs = myiDFT(in)
    [~, N] = size(in);
    my_ftx_mtx = myDFTmtx(N, true);
    coefs = (my_ftx_mtx ./ sqrt(N) * in.').';
end