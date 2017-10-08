function project_1()

    d = dlmread('corrupted_speech.txt');
    fs = dlmread('fs.txt');
    X = dlmread('music.txt');
    
    %define filter order M, step size a, and initialize weights with
    %randn()
    M = 5;
    a = 0.001;
    filler = randn(1,M);
    w = zeros(size(X,1), M);
    w(1,:) = filler;
    Y = zeros(size(X, 1), 1);
    J = zeros(size(X, 1), 1);
    e = zeros(size(X, 1), 1);
    
    X_col_vec = zeros(M,1);
    
    %step through sample i in the time series
    for i = 1:size(X,1)
        X_col_vec = repmat(X(i), M, 1); 
        Y(i) = w(i,:)*X_col_vec;
        e(i) = d(i)-Y(i);
        J(i) = e(i)^2;
        w(i+1,:) = w(i,:) + 2*a*e(i)*X(i);
    end
    
    %sound(e,fs);
    
    hold;
    for i = 1:M
        plot(w(:,i));
    end
%     
%     subplot(1,2,1);
%     plot(w(:,1));
%     subplot(1,2,2);
%     plot(w(:,30));
        


end