import React from 'react';
import {Button} from '../components/button';
import {Input} from '../components/input';

export class Spinner extends React.Component {
  constructor(props) {
    super(props);
    this.state = {count: props.initVal, defaultValue: 12}
  }

  handleOnChange(event) {
    this.setState({count: event.target.value});
  }

  changeCount(arg) {
    let temp;
    if (arg === 'inc') {
      temp = parseInt(this.state.count, 10) + 1;
    } else if (arg === 'dec') {
      temp = parseInt(this.state.count, 10) - 1;
    } else {
      temp = parseInt(this.state.count, 10);
    }
    this.setState({count: temp});
  }

  withinBounds(x) {
    console.log(this.props);
    console.log(x);
    return false;
  }

  render() {
    return (
      <div className={'input-group spinner'}>
        <Input onChange={this.handleOnChange.bind(this)} value={this.state.count} />
        <div className={'btn-wrapper input-group'}>
          <Button 
            onClick={this.changeCount.bind(this, 'inc')} 
            btnClass={['btn', 'btn-default', 'up-button', 'up-down-buttons']}>
            <i className={'fa fa-caret-up'}></i>
          </Button>
          <Button 
            onClick={this.changeCount.bind(this, 'dec')} 
            btnClass={['btn', 'down-button', 'btn-default', 'up-down-buttons']}>
            <i className={'fa fa-caret-down'}></i>
          </Button>
        </div>
      </div>
    );
  }
}

Spinner.propTypes = {
  initVal: React.PropTypes.number.isRequired,
  min: React.PropTypes.number.isRequired,
  max: React.PropTypes.number.isRequired
}
