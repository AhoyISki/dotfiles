function coffee-inner
  command sleep 180 
  notify-send --transient "Water boiled"
  command sleep 300
  notify-send --transient "Coffe ready 😁"
end

function coffe
  command fish -c (command sleep 180; notify-send --transient "Water boiled"; command sleep 300; notify-send --transient "Coffe ready 😁") &;
end
