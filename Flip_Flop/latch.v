from myhdl import *
 
def latch(q, d, g):
 
    @always_comb
    def logic():
        if g == 1:
            q.next = d
 
    return logic
