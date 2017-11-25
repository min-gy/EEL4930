function assignment_4()
    %number of iterations
    N = 100;

    [mu_n1, mu_ML1] = compute(2, 2, 10, 2);
    [mu_n2, mu_ML2] = compute(10, 2, 10, 2);
    
    [mu_n3, mu_ML3] = compute(2, .1, 10, 2);
    [mu_n4, mu_ML4] = compute(2, 1, 10, 2);
    [mu_n5, mu_ML5] = compute(2, 100, 10, 2);
    
    [mu_n6, mu_ML6] = compute(2, 2, 10, .1);
    [mu_n7, mu_ML7] = compute(2, 2, 10, 1);
    [mu_n8, mu_ML8] = compute(2, 2, 10, 10);
    
    subplot(2,2,1)
    hold;
    plot(mu_n1, 'b');
    plot(mu_ML1, 'b--');
    plot(mu_n2, 'r');
    plot(mu_ML2, 'r--');
    legend('MAP - wrong prior mean','ML - wrong prior mean','MAP - correct prior mean','ML - correct prior mean');
    xlabel('Number of data point from Gaussian distribution');
    ylabel('Mean');
    
    subplot(2,2,2);
    hold;
    plot(mu_n3,'b');
    plot(mu_ML3, 'b--');
    plot(mu_n4,'r');
    plot(mu_ML4, 'r--');
    plot(mu_n5, 'g');
    plot(mu_ML5, 'g--');
    legend('MAP - sig0 = .1','ML - sig0 = .1','MAP - sig0 = 1','ML - sig0 = 1','MAP - sig0 = 10','ML - sig0 = 10');
    xlabel('Number of data point from Gaussian distribution');
    ylabel('Mean');
    
    subplot(2,2,3);
    hold;
    plot(mu_n6,'b');
    plot(mu_ML6, 'b--');
    plot(mu_n7,'r');
    plot(mu_ML7, 'r--');
    plot(mu_n8, 'g');
    plot(mu_ML8, 'g--');
    legend('MAP - sig = .1','ML - sig = .1','MAP - sig = 1','ML - sig = 1','MAP - sig = 10','ML - sig = 10');
    xlabel('Number of data point from Gaussian distribution');
    ylabel('Mean');
    
    function [mu_n, mu_ML] = compute(init_mu_n, init_sig_n, mu, sig)
        %define matrices
        X = zeros(N,1);
        sig_n = zeros(N,1);
        mu_n = zeros(N,1);
        mu_ML = zeros(N,1);

        %determine initial values
        mu_n(1) = init_mu_n;
        sig_n(1) = init_sig_n;
        X(1) = normrnd(mu, sig);

        for i = 1:N
            X(i) = normrnd(mu,sig);

            sig_n(i+1) = 1/(sig_n(i)^2) + i/(sig)^2;
            sig_n(i+1) = 1/sig_n(i+1);
            mu_ML(i) = (1/i)*sum(X);
            mu_n(i+1) = (sig^2/(i*sig_n(i)^2+sig^2))*(mu_n(i)) + (i*sig_n(i)^2/(i*sig_n(i)^2+sig^2))*(mu_ML(i));
        end   
    end
end