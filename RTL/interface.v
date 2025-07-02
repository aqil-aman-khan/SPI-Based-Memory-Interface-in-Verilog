module Interface #(parameter MEM_DEPTH = 256 , parameter ADDR_SIZE = 8)(
    input clk , ss_n , MOSI , rst_n ,
    output MISO 
);
//this module is to connect between the slave and memory modules
wire [9:0] rxdata ;
wire [7:0] txdata ;
wire rx_valid , tx_valid ;

slave slave(
    .MOSI(MOSI),
    .MISO(MISO),
    .clk(clk),
    .ss_n(ss_n),
    .rst_n(rst_n),
    .rx_data(rxdata),
    .tx_data(txdata),
    .rx_valid(rx_valid),
    .tx_valid(tx_valid)
);

memory #(MEM_DEPTH,ADDR_SIZE) memory (
    .din(rxdata),
    .dout(txdata),
    .clk(clk),
    .rx_valid(rx_valid),
    .tx_valid(tx_valid),
    .rst_n(rst_n)
);
endmodule