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
    %w(1,:) = filler;
    Y = zeros(size(X, 1), 1);
    J = zeros(size(X, 1), 1);
    e = zeros(size(X, 1), 1);
    
    X_col_vec = zeros(M,1);
    
    %step through sample i in the time series
    for i = 1:size(X,1)
        if i < M+1
            X_col_vec = zeros(M, 1);
            j = 0;
            if i>1
                for j = 1:i-1
                    X_col_vec(j) = X(i-j);
                end
            end
        else
            for j = 1:M
                X_col_vec(j) = X(i-j);
            end
        end
        %X_col_vec = repmat(X(i), M, 1); 
        Y(i) = w(i,:)*X_col_vec;
        e(i) = d(i)-Y(i);
        J(i) = e(i)^2;
        temp = X(i);
        temp_e = e(i);
        temp_w = w(i,:);
        temp_nextw = w(i+1,:);
        %w(i+1,:) = w(i,:) + 2*a*e(i)*temp;
        temp_nextw = temp_w + 2*a*temp_e*temp;
    end
    
    sound(e,fs);
    
    hold;
    for i = 1:M
        plot(w(:,i));
    end
    plot(J);
        


end