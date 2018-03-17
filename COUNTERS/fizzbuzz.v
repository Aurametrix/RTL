if (increment) begin
  if (digit0 != 9) begin
    // Regular increment digit 0
    digit0 <= digit0 + 1;
  end else begin
    // Carry from digit 0
    digit0 <= 0;
    if (digit1 != 9) begin
      // Regular increment digit 1
      digit1 <= digit1 + 1;
    end else begin
      // Carry from digit 1
      digit1 <= 0;
      digit2 <= digit2 + 1;
    end
  end
end
