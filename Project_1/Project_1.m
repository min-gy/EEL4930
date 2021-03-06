function project_1()
    d = dlmread('corrupted_speech.txt');
    fs = dlmread('fs.txt');
    X = dlmread('music.txt');
    
    a = 0.0001;
    stepsize = 5;
    max_order = 100;
    
    erle_plot_index = [5:stepsize:max_order];
    erle = zeros(max_order/stepsize,1);
    erle_counter = 1;
    w = zeros(size(X,1), max_order);
    J = zeros(size(X, 1), 1);
    
    for M = 5:stepsize:max_order
        w = zeros(size(X,1), M);
        Y = zeros(size(X, 1), 1);
        J = zeros(size(X, 1), 1);
        e = zeros(size(X, 1), 1);
        X_col_vec = zeros(M,1);

%         for times = 1:4   
%             w(1,:) = w(size(X,1),:);
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
            Y(i) = w(i,:)*X_col_vec;
            e(i) = d(i)-Y(i);
            J(i) = e(i)^2;
            w(i+1,:) = w(i,:) + (2*a*e(i)*X_col_vec).';
        end
        erle(erle_counter) = 10*log10((d.'*d)/(e.'*e));
        erle_counter = erle_counter + 1;
    end
    
    %plots ERLE
    subplot(2,2,3);
    plot(erle_plot_index, erle);
    title('ERLE Plot');
    xlabel('Filter Order');
    ylabel('ERLE Value');

    %pllot weight tracks 
    subplot(2,2,1);
    hold;
    for i = 1:M
        plot(w(:,i));
    end
    title('Weight Tracks Across Sample');
    xlabel('Audio Sample as a Time Series');
    ylabel('Weight Values');

    %plot learning curve
    subplot(2,2,2);
    plot(J);
    title('Learning Curve');
    xlabel('Audio Sample as a Time Series');
    ylabel('Error^2');
    
    %play sound
    sound(e,fs);
end