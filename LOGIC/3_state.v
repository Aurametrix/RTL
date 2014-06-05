/*
3-state buffers and inverters propagate z (3-state or high-impedance) if their control signal is deasserted. 
These can have three delay specifications: a rise time, a fall time, and a time to go into 3-state.
*/

bufif0 #(5) not_1 (BUS, A, CTRL); /* BUS = A
5 time units after CTRL goes low. */
notif1 #(3,4,6) c1 (bus, a, b, cntr); /* bus goes tri-state
6 time units after ctrl goes low. */
