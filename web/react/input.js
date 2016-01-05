import React from 'react';

export class Input extends React.Component {
  render() {
    return (
      <input {...this.props} className={'form-control'} type={this.props.inputType} defaultValue={this.props.default} />
    );
  }
}
