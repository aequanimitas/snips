import React from 'react';
import ReactTestUtils from 'react/lib/ReactTestUtils';
import ReactDOM from 'react-dom';
import {Input} from '../components/input';

describe('Input', () => {
  let instance;

  it('should have a default value', () => {
    instance = ReactTestUtils.renderIntoDocument(<Input default="12" />);
    let inp = ReactDOM.findDOMNode(instance);
    expect(inp.type).to.equal('text');
    expect(inp.defaultValue).to.equal('12');
  });

  it('should change', (done) => {
    let doneFn = () => {
      done();
    };
    instance = ReactTestUtils.renderIntoDocument(<Input default="12" onChange={doneFn}/>);
    ReactTestUtils.Simulate.change(ReactDOM.findDOMNode(instance));
  });
});
