//************************************************
//  Filename      : vga_v_top.v                             
//  Author        : kingstacker                  
//  Company       : School                       
//  Email         : kingstacker_work@163.com     
//  Device        : Altera cyclone4 ep4ce6f17c8  
//  Description   :                              
//************************************************
module  vga_v_top #(parameter WIDTH = 10)(
    //input;
    input    wire    sys_clk,
    input    wire    rst_n,
    //output;
    output   wire    hs,
    output   wire    vs,
    output   wire    [7:0]        rgb_o 
);
wire clk;
wire [WIDTH+1:0] line_cnt;
wire [WIDTH+1:0] ver_cnt;
//pll_1 inst;
pll_1  pll_1_u1( 
    .inclk0             (sys_clk),
    .c0                 (clk)
);
//coo_out inst;
coo_out  coo_out_u1( 
    .clk                (clk),
    .rst_n              (rst_n),
    .hs                 (hs),
    .vs                 (vs),
    .line_cnt           (line_cnt),
    .ver_cnt            (ver_cnt)
);
//color_out inst;
color_out  color_out_u1( 
    .clk                (clk),
    .rst_n              (rst_n),
    .line_cnt           (line_cnt),
    .ver_cnt            (ver_cnt),
    .rgb_o              (rgb_o)
);

endmodule