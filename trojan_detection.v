module trojan_detection(res);
reg [9:0] i;
integer correct;
reg [3:0] capture [0:1023];
reg [3:0] golden [0:1023];
integer j,k;

//input c;
output res;
wire [3:0] pbin, q, Q, memyin, pbinm;

wire t;
assign t = i[3]&(~i[2])&i[1]&i[0];
assign pbinm[3] = (pbin[3]&(~t)) + (Q[3]&t);
assign pbinm[2] = (pbin[2]&(~t)) + (Q[2]&t);
assign pbinm[1] = (pbin[1]&(~t)) + (Q[1]&t);
assign pbinm[0] = (pbin[0]&(~t)) + (Q[0]&t);

encd E(i,pbin);

dl pbuf3(pbinm[3],q[3]);
dl pbuf2(pbinm[2],q[2]);
dl pbuf1(pbinm[1],q[1]);
dl pbuf0(pbinm[0],q[0]);

dl memy3(memyin[3],Q[3]);
dl memy2(memyin[2],Q[2]);
dl memy1(memyin[1],Q[1]);
dl memy0(memyin[0],Q[0]);

initial 
begin
	i = 9'd0;
	j = 0;
	correct = 0;
	k = -1;
end

initial
begin
for(j = 0; j<1024; j=j+1)
begin
if(j==0)
begin
	golden[j] = 4'bxxxx;
end
else if(j==1)
begin
	golden[j] = 4'd0;
end
else if((j>1) && (j<4))
begin
	golden[j] = 4'd1;
end
else if((j>=4) && (j<8))
begin
	golden[j] = 4'd2;
end
else if((j>=8) && (j<16))
begin
	golden[j] = 4'd3;
end
else if((j>=16) && (j<32))
begin
	golden[j] = 4'd4;
end
else if((j>=32) && (j<64))
begin
	golden[j] = 4'd5;
end
else if((j>=64) && (j<128))
begin
	golden[j] = 4'd6;
end
else if((j>=128) && (j<256))
begin
	golden[j] = 4'd7;
end
else if((j>=256) && (j<512))
begin
	golden[j] = 4'd8;
end
else if((j>=512) && (j<1024))
begin
	golden[j] = 4'd9;
end
end
end
//w

always
begin
	//while(j<1024)
	//begin
	/*	if (j == 1024)
		begin
			flag = 1;
		end
		else
		begin
		end */
		//capture[j] = q;
		//j = j+1;
			/*k = i;
			correct[0] = ~(q[0]^golden[k][0]);
			correct[1] = ~(q[1]^golden[k][1]);
			correct[2] = ~(q[2]^golden[k][2]);
			correct[3] = ~(q[3]^golden[k][3]); */
			if(k<1024)
			begin
				capture[k] = q;
				if(capture[k] === golden[k])
				begin
					correct = correct+1;
				end
				else
				begin
				end
			end
			else
			begin 
			end
			#50 i = i+1;
			k = k+1;
end		
	//	
	//end

assign res = (~(q[1]^Q[1]))&(~(q[0]^Q[0]))&(~(q[2]^Q[2]))&(~(q[3]^Q[3]));
endmodule 

module dl(d,q);
input d;
//input [9:0] i;
output reg q;
/* initial
begin
	q = 1;
end */

always @(d)
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
	o = 4'bxxxx;
end
else if(i==1)
begin
	o = 4'd0;
end
else if((i>1) && (i<4))
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

