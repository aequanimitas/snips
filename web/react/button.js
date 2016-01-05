import React from 'react';
import classNames from 'classnames';

export class Button extends React.Component {
  render() {
    return (
      <button {...this.props} className={classNames(this.props.btnClass)}>
        {this.props.children}
      </button>
    );
  }
}

Button.propTypes = {
  btnClass: React.PropTypes.array
};
