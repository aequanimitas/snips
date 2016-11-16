function smallestDivisor(x, y) {
  function findDivisor(end, start) {
    if ((start * start) > end) return end;
    if (start % 2 === 0) return start;
    return findDivisor(end, start++);
  }
  return findDivisor(x, y);
}

console.log(smallestDivisor(104729, 2));
