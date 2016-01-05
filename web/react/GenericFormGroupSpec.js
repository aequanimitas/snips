import React from 'react';
import ReactTestUtils from 'react/lib/ReactTestUtils';
import {GenericFormGroup} from '../components/form';

describe('GenericFormGroup', () => {
  it('just renders', () => {
    let instance = ReactTestUtils.renderIntoDocument(
      <GenericFormGroup>
        <span className='child1'> Test </span>
      </GenericFormGroup>
    );
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithClass(instance, 'child1'));
  });

  it('has a default class form .form-group', () => {
    let instance = ReactTestUtils.renderIntoDocument(<GenericFormGroup />);
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithClass(instance, 'form-group'));
  });

  it('has a default class form .lagas-form-group', () => {
    let instance = ReactTestUtils.renderIntoDocument(
      <GenericFormGroup fgClass='lagas-form-group' />
    );
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithClass(instance, 'lagas-form-group'));
  });
});
