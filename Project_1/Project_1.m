function project_1()

    d = dlmread('corrupted_speech.txt');
    fs = dlmread('fs.txt');
    X = dlmread('music.txt');
    
    %define filter order M, step size a, and initialize weights with
    %randn()
    a = 0.0001;
    stepsize = 5;
    max_order = 100;
    M= 150;
    
    erle_plot_index = [5:stepsize:max_order];
    erle = zeros(max_order/stepsize,1);
    erle_counter = 1;
    w = zeros(size(X,1), max_order);
    J = zeros(size(X, 1), 1);
    
%     for M = 5:stepsize:max_order
        %filler = randn(1,M);
        w = zeros(size(X,1), M);
        %w(1,:) = filler;
        Y = zeros(size(X, 1), 1);
        J = zeros(size(X, 1), 1);
        e = zeros(size(X, 1), 1);
        X_col_vec = zeros(M,1);

        for times = 1:4   
            w(1,:) = w(size(X,1),:);
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
            erle_counter = erle_counter+1;
            subplot(2,2,times);
            
            hold on;
            for b = 1:M
                plot(w(:,b));
            end
            hold off;
        end
%     end
    
%     subplot(2,2,3);
%     plot(erle_plot_index, erle);
% 
%     %plots
%     subplot(2,2,1);
%     hold;
%     for i = 1:M
%         plot(w(:,i));
%     end
% 
%     subplot(2,2,2);
%     plot(J);
      sound(e);

%     subplot(2,2,1)
%     plot(d, 'green');
%     hold;
%     plot(e, 'red');
%     legend('music+voice','error');
%    
%     subplot(2,2,3);
%     plot(d, 'green');
%     hold;
%     plot(X, 'black');
%     legend('music+voice','music');

end