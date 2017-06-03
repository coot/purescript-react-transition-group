"use strict"

var React = require("react");
var rtg = require("react-transition-group");

exports._cssTransitionGroup = rtg.CSSTransitionGroup

function createTransitionReactClass(spec) {
  var result = {
    displayName: spec.displayName,
    render: function(){
      return spec.render(this)()
    },
    getInitialState: function(){
      return {
        state: spec.getInitialState(this)()
      };
    },
    componentWillMount: function(){
      return spec.componentWillMount(this)()
    },
    componentDidMount: function(){
      return spec.componentDidMount(this)()
    },
    componentWillReceiveProps: function(nextProps){
      return spec.componentWillReceiveProps(this)(nextProps)()
    },
    shouldComponentUpdate: function(nextProps, nextState){
      return spec.shouldComponentUpdate(this)(nextProps)(nextState.state)()
    },
    componentWillUpdate: function(nextProps, nextState){
      return spec.componentWillUpdate(this)(nextProps)(nextState.state)()
    },
    componentDidUpdate: function(prevProps, prevState){
      return spec.componentDidUpdate(this)(prevProps)(prevState.state)()
    },
    componentWillUnmount: function(){
      return spec.componentWillUnmount(this)()
    },
    componentWillAppear: function(fn) {
      return spec.componentWillAppear(this)(fn)()
    },
    componentDidAppear: function(fn) {
      return spec.componentDidAppear(this)(fn)()
    },
    componentWillEnter: function(fn) {
      return spec.componentWillEnter(this)(fn)()
    },
    componentDidEnter: function(fn) {
      return spec.componentDidEnter(this)(fn)()
    },
    componentWillLeave: function(fn) {
      return spec.componentWillLeave(this)(fn)()
    },
    componentDidLeave: function(fn) {
      return spec.componentDidLeave(this)(fn)()
    },
  }

  return React.createClass(result)
}

exports.createTransitionReactClass = createTransitionReactClass

exports._merge = function(r1) {
  return function(r2) {
    return Object.assign({}, r2, r1)
  }
}
