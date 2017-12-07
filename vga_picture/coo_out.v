//************************************************
//  Filename      : coo_out.v                             
//  Author        : kingstacker                  
//  Company       : School                       
//  Email         : kingstacker_work@163.com     
//  Device        : Altera cyclone4 ep4ce6f17c8  
//  Description   : product the coodinate and hs vs;                             
//************************************************
module  coo_out #(parameter WIDTH = 10)(
    input    wire                 clk         ,   //65mhz;
    input    wire                 rst_n       ,
    output   wire                 hs          ,	  //horizontal synchronization;
    output   wire                 vs          ,   //vertical syn;
    output   reg     [WIDTH-1:0]  line_coo    ,   //line coodinate;
    output   reg     [WIDTH-1:0]  ver_coo         //vertical coodinate;
);  //1024*768;
 localparam HTA = 11'd136,  //sync pulse;
            HTB = 11'd160,  //back porch;
            HTC = 11'd1024, //visible area;
            HTD = 11'd24,   //front porch;
            VTA = 11'd6,    //sync pulse;
            VTB = 11'd29,   //back porch;
            VTC = 11'd768,  //visible area;
            VTD = 11'd3,    //front porch;
            LINE_CNTMAX = HTA+HTB+HTC+HTD-1'b1, //max line count;
            VER_CNTMAX  = VTA+VTB+VTC+VTD-1'b1, //max ver  count;
            HSTART = HTA+HTB,
            VSTART = VTA+VTB;
reg [WIDTH+1:0] line_cnt;            
reg [WIDTH+1:0] ver_cnt;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        line_cnt <= 11'd0;
    end //if
    else begin
        if (line_cnt == LINE_CNTMAX) begin
            line_cnt <= 11'd0;
          end //if
          else begin
            line_cnt <= line_cnt + 1'b1;
          end //else  
    end //else
end //always
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        ver_cnt <= 11'd0;
    end //if
    else begin
        if ((ver_cnt == VER_CNTMAX)&&(line_cnt == LINE_CNTMAX)) begin
               ver_cnt <= 11'd0;
           end //if
           else begin
               ver_cnt <= (line_cnt == LINE_CNTMAX)? (ver_cnt + 1'b1) : ver_cnt;
           end //else   
    end //else
end //always
assign hs = (line_cnt < HTA) ? 1'b0 : 1'b1;
assign vs =  (ver_cnt < VTA) ? 1'b0 : 1'b1;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        line_coo <= 0;
        ver_coo  <= 0;
    end //if
    else begin
        if((line_cnt >= HSTART)&&(line_cnt < HSTART + HTC)&&(ver_cnt >=VSTART)&&(ver_cnt < VSTART + VTC)) begin
        	line_coo <= line_cnt - HSTART;
        	ver_coo  <= ver_cnt  - VSTART;
        end
    end //else
end //always


endmodule