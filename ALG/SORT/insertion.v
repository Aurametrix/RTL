fan_size := 0;
while more_cards do
/* Take next card. */
  fan_size := fan_size + 1;
  new_card := input;

/* Find position to insert new card. */
new_pos := 0;
found_pos := false;
while not found_pos do
  new_pos := new_pos + 1;
  if new_pos = fan_size then
    found_pos := true
  else
    if fan[new_pos] >= new_card then
      found_pos := true;
end_while;

/* Shift all cards from insert position to end. */
  for index := fan_size to new_pos + 1 step - 1 do
    fan[index] := fan[index-1]
  end_for;

/* Insert new cars(sic.). */
  fan[new_pos] := new_card;
end_while;
