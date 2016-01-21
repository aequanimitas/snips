import 'purecss/build/pure.css';
require('../static/css/main.css');

import React from 'react';
import { render } from 'react-dom';

let Sample = React.createClass({
   render: function() {
     return <div>Snips</div>
   }
});

render(
 <Sample />,
 document.getElementById('root')
);
