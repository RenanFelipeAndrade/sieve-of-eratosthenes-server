module SieveOfEratosthenes
export init
end

function init(maxRange::UInt128)
  sieveAsElement::UInt128 = (uint128"1" << 128) - 1
  # initializes a vector of n size 
  sieveVec = Vector{UInt128}(undef, fld(maxRange, 128) + 1)
  fill!(sieveVec, sieveAsElement)

  return sieveOfEratosthenes(uint128"1", sieveVec, maxRange)
end

function sieveOfEratosthenes(number::UInt128, sieve::Vector{UInt128}, maxRange)
  rest::UInt128 = (number % 129) - 1
  intDiv::UInt128 = fld(number, 129) + 1
  shift::UInt128 = (uint128"1" << rest)
  result::UInt128 = sieve[intDiv] & shift

  if number <= 1
    sieve[intDiv] = xor(sieve[intDiv], shift)
  elseif result > 1
    composite::UInt128 = number * 2
    while composite < length(sieve) * 129
      intDiv = fld(composite, 129) + 1
      rest = (composite % 129) - 1
      shift = (uint128"1" << rest)
      sieve[intDiv] = sieve[intDiv] & ~shift
      composite += number
    end
  end
  if number <= sqrt(maxRange)
    sieveOfEratosthenes(number + uint128"1", sieve, maxRange)
  end
  return sieve
end