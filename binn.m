function [X_bin]=binn(X,n_bin)
[row, col]=size(X);
diff=rem(col,n_bin);
X=X(:,1:col-diff);
X=X';
X=X(:);
%ind=repmat(1:size(X,1)/n_bin,n_bin,1);
ind=repmat(1:row*(col-diff)/n_bin,n_bin,1);
ind=ind(:);
summ=accumarray(ind,X,[],@mean);
X_bin=reshape(summ,(col-diff)/n_bin,row);
X_bin=X_bin';
%spectra_bin=reshape(X_bin,a,b,col/n_bin);
%bin.X_bin=X_bin;
%bin.spectra_bin=spectra_bin;
%toc;
% Cube 60*60*253 1.873967 vs 2.062056
% cube 500*500*500 280.711773 vs 279.249029
