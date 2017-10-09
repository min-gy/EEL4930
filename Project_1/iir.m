function iir ()

    d = dlmread('corrupted_speech.txt');
    fs = dlmread('fs.txt');
    X = dlmread('music.txt');
    
    %define filter order M, step size a, and initialize weights with
    %randn()
    a = 0.0001;
    u = 2;
    one_minus_u = 1-u;

    M = 150;
    X_k = padarray(X.', [M-1,0], 0, 'post');
    
    w = zeros(size(X,1), M);
    %w(1,:) = filler;
    Y = zeros(size(X, 1), 1);
    J = zeros(size(X, 1), 1);
    e = zeros(size(X, 1), 1);


    %step through sample i in the time series
    for i = 1:size(X,1)
        if i > 1
            for k = 2:M
                X_k(k,i) = one_minus_u*X_k(k,i-1)+ u*X_k(k-1,i-1);
            end
        end
        Y(i) = w(i,:)*X_k(:,i);
        e(i) = d(i)-Y(i);
        J(i) = e(i)^2;
        w(i+1,:) = w(i,:) + (2*a*e(i)*X_k(:,i)).';
    end

    %plots
    subplot(2,1,1);
    hold;
    for i = 1:M
        plot(w(:,i));
    end

    subplot(2,1,2);
    plot(J);
    sound(e);

end