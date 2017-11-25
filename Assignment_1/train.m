function [ err ] = train( M )

    %generate pure sin wave
    x = [0:1/50:2];
    x = x.';
    xx = x(2:101,1:1);
    e = normrnd(0, .1, 100, 1);
    f = sin(2*pi*xx) + e;
    plot(xx,f);

    X = zeros(M,100);

    for n = 1:M
        X(n,:) = xx.^n;
    end

    X = X.';
    w = (inv(X.'*X))*X.'*f;

    X_test = zeros(M,100);

    x_test = [0:1/50:2];
    x_test = x_test.';
    xx_test = x_test(2:101,1:1);
    f_test = sin(2*pi*x_test);
    for n = 1:M
        X_test(n,:) = xx_test.^n;
    end 

    X_test = X_test.';

    predicted = X_test*w;

    plot(xx, f, xx_test, predicted);
    
    err = get_error(w, X, predicted);

end

function err = get_error(w, X, t)
        matrix = (w.'*X.' - t.');
        w.'*X.'
        X
        t
        matrix
        err = 1/2*matrix*matrix.';
end

