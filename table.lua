-- table sort algorithms based on https://www.lexaloffle.com/bbs/?pid=50453

table = {}

function table.isort(arr, comp)
  for i=1,#arr do
      local j = i
      while j > 1 and not comp(arr[j-1], arr[j]) do
        arr[j],arr[j-1] = arr[j-1],arr[j]
          j = j - 1
      end
  end
end

function table.qsort(a,c,l,r)
  c,l,r=c or function(a,b) return a<b end,l or 1,r or #a
  if l<r then
    if c(a[r],a[l]) then
      a[l],a[r]=a[r],a[l]
    end

    local lp,k,rp,p,q=l+1,l+1,r-1,a[l],a[r]

    while k<=rp do
      local swaplp=c(a[k],p)
      if swaplp or c(a[k],q) then
      else
        while c(q,a[rp]) and k<rp do
          rp-=1
        end
        a[k],a[rp],swaplp=a[rp],a[k],c(a[rp],p)
        rp-=1
      end
      if swaplp then
        a[k],a[lp]=a[lp],a[k]
        lp+=1
      end
      k+=1
    end
    lp-=1
    rp+=1

    a[l],a[lp]=a[lp],a[l]
    a[r],a[rp]=a[rp],a[r]
    qsort(a,c,l,lp-1       )
    qsort(a,c,  lp+1,rp-1  )
    qsort(a,c,       rp+1,r)
  end
end
