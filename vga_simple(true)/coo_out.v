//************************************************
//  Filename      : coo_out.v                             
//  Author        : kingstacker                  
//  Company       : School                       
//  Email         : kingstacker_work@163.com     
//  Device        : Altera cyclone4 ep4ce6f17c8  
//  Description   : product the coodinate and hs vs;                             
//************************************************
module  coo_out #(parameter WIDTH = 10)(
    //input;
    input    wire    clk,  //65mhz;
    input    wire    rst_n,
    //output;
    output   wire     hs,	//horizontal synchronization;
    output   wire     vs,   //vertical syn;
    output   wire     [WIDTH+1:0]  line_cnt, //line coodinate;
    output   wire     [WIDTH+1:0]  ver_cnt   //vertical coodinate;
);  //1024*768;
 localparam HTA = 11'd128,  //sync pulse;
            HTB = 11'd88,  //back porch;
            HTC = 11'd800, //visible area;
            HTD = 11'd40,   //front porch;
            VTA = 11'd4,    //sync pulse;
            VTB = 11'd23,   //back porch;
            VTC = 11'd600,  //visible area;
            VTD = 11'd1,    //front porch;
            line_cnt_rMAX = HTA+HTB+HTC+HTD-1'b1, //max line count;
            ver_cnt_rMAX  = VTA+VTB+VTC+VTD-1'b1, //max ver  count;
            HSTART = HTA+HTB,
            VSTART = VTA+VTB;
reg [WIDTH+1:0] line_cnt_r;            
reg [WIDTH+1:0] ver_cnt_r;
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        line_cnt_r <= 11'd0;
    end //if
    else begin
        if (line_cnt_r == line_cnt_rMAX) begin
            line_cnt_r <= 11'd0;
          end //if
          else begin
            line_cnt_r <= line_cnt_r + 1'b1;
          end //else  
    end //else
end //always
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        ver_cnt_r <= 11'd0;
    end //if
    else begin
        if ((ver_cnt_r == ver_cnt_rMAX)&&(line_cnt_r == line_cnt_rMAX)) begin
               ver_cnt_r <= 11'd0;
           end //if
           else begin
               ver_cnt_r <= (line_cnt_r == line_cnt_rMAX)? (ver_cnt_r + 1'b1) : ver_cnt_r;
           end //else   
    end //else
end //always
assign hs = (line_cnt_r < HTA) ? 1'b0 : 1'b1;
assign vs =  (ver_cnt_r < VTA) ? 1'b0 : 1'b1;
assign line_cnt = line_cnt_r;
assign ver_cnt = ver_cnt_r;


endmodule