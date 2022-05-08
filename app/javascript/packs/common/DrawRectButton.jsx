import React, { Component } from "react";

export default class DrawRectButton extends Component {
  render() {
    return (
      <div className="draw-tool-menu">
        <div className="e-row">
        </div>
        <div className="e-row">
          <button
            onClick={this.props.handleClick}
            className="btn btn-draw-tool">
            <img src="/assets/images/rect-icon.svg"></img>
          </button>
        </div>
      </div>
    );
  }
}