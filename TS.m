function [X_]=TS(A_all, A_all_t, y, IterNum, r)
%% Simplified Alternating Minimization for tensor sensing


[m, n, k] = size(X);
U0 = randn(m, r, k);
U = Tensor2fullCircM(U0);    
for l = 1 : IterNum
    V = LS_V(A_all, U, r*k, y, n);
    U = LS_U(A_all_t, V, r*k, y, m*k);
end
X_ = U * V;

    function [V] = LS_V(A2m, U, r, y, n)
        U_ = mat2diaMat(U,n);         
        W = A2m*U_;
        V_ = W \ y ;

        clear W;
        V = Vec2Mat(V_,[r, n]);       
     
    end

    function [U] = LS_U(A_t2m, V, r, y, m)
        Vt = V.';
        Vt_ = mat2diaMat(Vt,m);
        W = A_t2m*Vt_;
        U_ = W \ y ;
        clear W;
        U = (Vec2Mat(U_,[r, m])).';
    end
end






