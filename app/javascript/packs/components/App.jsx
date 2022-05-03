import React, { Component } from "react";
import NavBar from "./NavBar";
import { CustomPolygon } from "./CustomPolygon";

export default class App extends Component {
  render() {
    return (
      <div>
        <NavBar />
        <div className='container'>
          <CustomPolygon />
        </div>
      </div>
    );
  }
}