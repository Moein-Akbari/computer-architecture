module datapath (
    enable_output,
    
    // Decoder
    shift_right,
    
    // Counter
    reset_counter,
    count_up, 
    count_down,
    
    // Down counter
    count,
    load_counter,

    // Controller-inputs
    cout,
    down_counter_zero,
    last_queen_counter_zero,
    last_cell,
    safe,
    
    // Output
    out_bus
);
    input enable_output, 
          shift_right, 
          reset_counter, 
          count_up, 
          count_down,
          count,
          load_counter;
    output cout,
           down_counter_zero,
           last_queen_counter_zero,
           last_cell,
           safe;
    output [7:0] out_bus;
    generate
        for (i = ; ; ) begin
            
        end
    endgenerate
endmodule