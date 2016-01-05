import React from 'react';
import classNames from 'classnames';

export class Label extends React.Component {
  render() {
    return (
      <span className={classNames(this.props.lblClass)}>
        {this.props.children}
      </span>
    );
  }
}

Label.propTypes = {
  lblClass: React.PropTypes.string
};
