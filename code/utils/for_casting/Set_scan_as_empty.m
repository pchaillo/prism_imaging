function scan_out = Set_scan_as_empty(scan_in)
 
% ENG : Uselsul to distinguish point from peak selection to point that is added to avoid shift
% FR : sert a differencier les points ajoutes des autres => a integrer au reste

scan_out = scan_in;
scan_out.num = -scan_out.num;