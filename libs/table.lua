-- Copyright 2024 by Christian Lang is licensed under CC BY-NC-SA 4.0

-- table sort algorithms based on https://www.lexaloffle.com/bbs/?pid=50453

function InsertionSort(arr, comp)
  for i=1,#arr do
      local j = i
      while j > 1 and not comp(arr[j-1], arr[j]) do
        arr[j],arr[j-1] = arr[j-1],arr[j]
          j -= 1
      end
  end
end
