import React from 'react';
import classNames from 'classnames';

export class GenericFormGroup extends React.Component {
  render() {
    let classes = {
      'form-group': true
    };
    return (
      <div className={classNames(classes, this.props.fgClass)}>
        {this.props.children}
      </div>
    );
  }
}

GenericFormGroup.propTypes = {
  fgClass: React.PropTypes.string
};
