function [casted_x binary_x hex_x] = to_bin(x,nbits,nu)
%% Casts x to fixed point format 
% nbits - number of bits of representation
% nu - number of fractional part
sign_x = 0;
xu = round(x*2^nu);
if xu<0
    sign_x = 1;
    xu = -xu;
end
% converting number to u2
bu = dec2bin(xu,nbits-1);
if sign_x==1
   for i = 1:length(bu)
      if bu(i)=='1'
          bu(i)='0';
      else
          bu(i)='1';
      end       
   end
   bu_dec = bin2dec(bu)+1;
   bu = dec2bin(bu_dec,nbits);
   if bu(1)=='1'
       bu(1)='0';
   else
       bu(1)='1';
   end
end
if length(bu)==nbits-1
    bu = ['0' bu];
end
binary_x = bu;
casted_x = (-1)^sign_x*xu/2^nu;
hex_x = dec2hex(bin2dec(bu));
binary_x
casted_x
hex_x
