import React, { Component } from "react";

export default class App extends Component {

  state = {
    imageFiles: [
      '/assets/images/d_r_293_.jpg'
    ],
  }

  render() {
    const { imageFiles } = this.state
    return (
      <div className="container">
        <div className="row my-1">
          {imageFiles.map((imageFile, index) => {
            return (
              <div key={index} className="col-sm-5">
                <div className="card">
                  <img src={imageFile}></img>
                </div>
              </div>
            )
          })}
        </div>
      </div>
    );
  }
}
