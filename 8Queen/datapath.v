module datapath (
    output_enable,
    
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
    
    
endmodule