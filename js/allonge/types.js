import test from 'tape'

test('Primitives', (assert) => {
  assert.equal(2,2);
  assert.equal(void 0, undefined);
  assert.end();
})

test('Value types, evalution', (assert) => {
  assert.equal((1+2+3),(6-0));
  assert.end();
})

test('Reference, Object Types', (assert) => {
  assert.notEqual([1,2,3], [1,2,3], 'Each array expression is unique');
  assert.notEqual([1,1+1,3], [1,2,3], 'Each array expression is unique');
  assert.end();
})
