function selected = Roulette(num,PreAss, concentration)

asset = 1:length(concentration);
selected = PreAss;

while length(selected)<num
    remainder = setdiff(asset, selected);
    accumulation = cumsum(concentration(remainder));
    p = rand() * accumulation(end);
    chosen_index = -1;
    for index = 1 : length(accumulation)
        if (accumulation(index) > p)
          chosen_index = index;
          break;
        end
    end
    choice = remainder(chosen_index);
    selected = [selected; choice];
end
end