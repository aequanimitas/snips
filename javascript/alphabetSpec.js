describe("Alphabet", function() {
  describe("vowels", function() {
    // this should be a range
    function letSeq(ch, chEnd, arr) {
      if (ch.charCodeAt(0) > chEnd.charCodeAt(0)) {
        return arr;
      } else {
        arr.push(ch);
        return letSeq(String.fromCharCode((ch.charCodeAt(0)) + 1), chEnd, arr);
      }
    }
 
  });
})
