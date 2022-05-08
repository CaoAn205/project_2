import React, { Component } from "react";
import { CustomPolygon } from "../common/CustomPolygon";
import DrawRectButton from "../common/DrawRectButton";
import { Svg } from 'react-svg-path';


export default class App extends Component {
  state = {
    card: {
      width: 1200,
      height: 675,
    },
    svgClassName: null,
    currentVertex: null,
    newShape: [],
    shapePoints: [],
    imageFile: '/assets/images/d_r_293_.jpg',
  }

  handleDrawRectButtonClick = () => {
    if (!this.state.svgClassName) {
      this.setState({ svgClassName: 'new-polygon' })
    }
  }

  handleSvgDrawNewShape = (e) => {
    if (this.state.svgClassName) {
      const newShape = this.state.newShape
      if (e.type === 'pointerdown') {
        newShape.unshift([e.nativeEvent.offsetX, e.nativeEvent.offsetY])
        this.setState({ newShape })
      } else if (e.type === 'pointerup') {
        const shapePoints = this.state.shapePoints
        const firstX = newShape[0][0]
        const firstY = newShape[0][1]
        const lastX = e.nativeEvent.offsetX
        const lastY = e.nativeEvent.offsetY

        newShape.push([lastX, firstY], [lastX, lastY], [firstX, lastY])
        shapePoints.push(newShape)
        this.setState({ shapePoints, newShape: [], svgClassName: null })
      }
    }
  }

  handleRemoveVertex = (e, index, shapeIndex = 0) => {
    e.preventDefault()
    const shapePoints = this.state.shapePoints
    const points = shapePoints[shapeIndex].filter((_point, i) => i !== index)

    shapePoints[shapeIndex] = points
    this.setState({ shapePoints })
  }

  handleVertexDrag = (e, position, index, shapeIndex = 0) => {
    const shapePoints = this.state.shapePoints
    const points = shapePoints[shapeIndex]
    const currentVertex = this.state.currentVertex
    const newPoint = [position.x, position.y]

    if (e.ctrlKey) {
      if (currentVertex) {
        points[currentVertex] = newPoint
      } else {
        const newPointIndex = index + 1

        points.splice(newPointIndex, 0, newPoint)
        this.setState({ currentVertex: newPointIndex })
      }
    } else {
      points[index] = newPoint
    }

    shapePoints[shapeIndex] = points
    this.setState({ shapePoints })
  }

  handleVertexDragStop = () => {
    this.setState({ currentVertex: null })
  }

  handlePolygonDragStop = (position, shapeIndex = 0) => {
    const shapePoints = this.state.shapePoints
    const points = shapePoints[shapeIndex].map(point => {
      point[0] += position.x
      point[1] += position.y

      return point
    })

    shapePoints[shapeIndex] = points
    this.setState({ shapePoints })
  }

  render() {
    const { width, height } = this.state.card
    const { imageFile } = this.state
    return (
      <div className="container">
        <div className="row my-1">
          <div className="col-sm-11">
            <div className="card" style={
              {
                height: height,
                width: width,
                backgroundImage: `url(${imageFile})`,
                backgroundPosition: 'center',
                backgroundSize: 'cover',
                backgroundRepeat: 'no-repeat',
              }
            }>
              <Svg draggable="true" className={this.state.svgClassName}
                width={width}
                height={height}
                onPointerDown={this.handleSvgDrawNewShape}
                onPointerUp={this.handleSvgDrawNewShape}
              >
                {this.state.shapePoints.map((shapePoint, index) => {
                  if (shapePoint.length !== 0) {
                    return (
                      <CustomPolygon
                        key={index}
                        shapeIndex={index}
                        points={shapePoint}
                        onPolygonDragStop={this.handlePolygonDragStop}
                        onVertexDrag={this.handleVertexDrag}
                        onVertexDragStop={this.handleVertexDragStop}
                        onRemoveVertex={this.handleRemoveVertex}
                      />
                    )
                  }
                })}
              </Svg>
            </div>
          </div>
          <div className="col-sm-1" style={{ width: 60 }}>
            <DrawRectButton handleClick={this.handleDrawRectButtonClick} />
          </div>
        </div>
      </div>
    );
  }
}
