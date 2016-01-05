import React from 'react';
import ReactDOM from 'react-dom';
import ReactTestUtils from 'react/lib/ReactTestUtils';

import {Button} from '../components/button';

describe('Increment - Decrement Buttons', () => {
  let withTag = ReactTestUtils.findRenderedDOMComponentWithTag;
  let withClass = ReactTestUtils.findRenderedDOMComponentWithClass;
  let upButton;
  let downButton;

  beforeEach(() => {
    upButton = ReactTestUtils.renderIntoDocument(
      <Button btnClass={['btn', 'up-button', 'up-down-buttons']}/>
    );
    downButton = ReactTestUtils.renderIntoDocument(
      <Button btnClass={['btn', 'down-button', 'up-down-buttons']}/>
    );
  });

  it('should just exist', () => {
    assert.ok(withTag(upButton, 'button'));
    assert.ok(withTag(downButton, 'button'));
  });

  it('should have class btn', () => {
    assert.ok(withClass(upButton, 'btn'));
    assert.ok(withClass(upButton, 'up-button'));
    assert.ok(withClass(upButton, 'up-down-buttons'));
  });

  it('callback should be called', (done) => {
    let doneFn = () => {
      done();
    };
    let button = ReactTestUtils.renderIntoDocument(
      <Button btnClass={['btn', 'up-button', 'up-down-buttons']} onClick={doneFn}/>
    );
    ReactTestUtils.Simulate.click(ReactDOM.findDOMNode(button));
  });
});
