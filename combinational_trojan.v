module combinational_trojan(i,res,c);
input [9:0] i;
input c;
output res;
wire [3:0] pbin, q, Q, memyin, pbinm;

wire t;
assign t = i[3]&(~i[2])&i[1]&i[0];
assign pbinm[3] = (pbin[3]&(~t)) + (Q[3]&t);
assign pbinm[2] = (pbin[2]&(~t)) + (Q[2]&t);
assign pbinm[1] = (pbin[1]&(~t)) + (Q[1]&t);
assign pbinm[0] = (pbin[0]&(~t)) + (Q[0]&t);

encd E(i,pbin);

dl pbuf3(pbinm[3],q[3],c);
dl pbuf2(pbinm[2],q[2],c);
dl pbuf1(pbinm[1],q[1],c);
dl pbuf0(pbinm[0],q[0],c);

dl memy3(memyin[3],Q[3],c);
dl memy2(memyin[2],Q[2],c);
dl memy1(memyin[1],Q[1],c);
dl memy0(memyin[0],Q[0],c);

assign res = (~(q[1]^Q[1]))&(~(q[0]^Q[0]))&(~(q[2]^Q[2]))&(~(q[3]^Q[3]));
endmodule 

module dl(d,q,c);
input d,c;
output reg q;
/* initial
begin
	q = 1;
end */

always @(posedge(c))
begin
	q = d;
end
endmodule

module encd(i,o);
input [9:0] i;
output reg [3:0] o;
always @(i)
if(i==0)
begin
	o = 4'd0;
end

else if((i>0) && (i<4))
begin
	o = 4'd1;
end
else if((i>=4) && (i<8))
begin
	o = 4'd2;
end
else if((i>=8) && (i<16))
begin
	o = 4'd3;
end
else if((i>=16) && (i<32))
begin
	o = 4'd4;
end
else if((i>=32) && (i<64))
begin
	o = 4'd5;
end
else if((i>=64) && (i<128))
begin
	o = 4'd6;
end
else if((i>=128) && (i<256))
begin
	o = 4'd7;
end
else if((i>=256) && (i<512))
begin
	o = 4'd8;
end
else if((i>=512) && (i<1024))
begin
	o = 4'd9;
end
endmodule
