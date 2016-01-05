import React from 'react';
import ReactTestUtils from 'react/lib/ReactTestUtils';
import {GenericFormGroup} from '../components/form';
import {Label} from '../components/lagaslabel.js';

describe('Routine Work, a single exercise', () => {
  it('should have an instance of the GenericFormGroup that contains a label', () => {
    let instance = ReactTestUtils.renderIntoDocument(
      <GenericFormGroup fgClass='lagas-form-group lagas-routine-work'>
        <Label lblClass='lagas-routine-label' />
      </GenericFormGroup>
    );
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithClass(instance, 'lagas-form-group'));
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithClass(instance, 'lagas-routine-work'));
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithClass(instance, 'lagas-routine-label'));
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithTag(instance, 'span'));
  });

  it('should have an instance of the GenericFormGroup that contains an input', () => {
    let instance = ReactTestUtils.renderIntoDocument(
      <GenericFormGroup fgClass='lagas-form-group lagas-routine-work'>
        <Label lblClass='lagas-routine-label' />
      </GenericFormGroup>
    );
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithClass(instance, 'lagas-form-group'));
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithClass(instance, 'lagas-routine-work'));
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithClass(instance, 'lagas-routine-label'));
    assert.ok(ReactTestUtils.findRenderedDOMComponentWithTag(instance, 'span'));
  });
});
