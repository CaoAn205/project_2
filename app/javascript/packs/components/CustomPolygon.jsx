import React from "react";
import { Svg, Polygon, Circle } from 'react-svg-path';
import Draggable from "react-draggable";

export class CustomPolygon extends React.Component {
  state = {
    points: [
      [10, 60],
      [40, 5],
      [104, 60],
      [40, 120],
    ],
    stroke: '#00ffb2',
    strokeWidth: 1,
    fill: '#7affd7',
    currentIndex: null,
  }

  handleRemoveVertex(e, index) {
    e.preventDefault()
    const points = this.state.points.filter((_point, i) => i !== index)
    this.setState({ points })
  }

  handleVertexDrag(e, position, index) {
    const points = this.state.points
    const currentIndex = this.state.currentIndex
    const newPoint = [position.x, position.y]

    if (e.ctrlKey) {
      if (currentIndex) {
        points[currentIndex] = newPoint
      } else {
        const newPointIndex = index + 1

        points.splice(newPointIndex, 0, newPoint)
        this.setState({ currentIndex: newPointIndex })
      }
    } else {
      points[index] = newPoint
    }
    this.setState({ points })
  }

  handleVertextDragStop() {
    this.setState({ currentIndex: null })
  }

  handlePolygonDrag(e, position) {
    console.log(e)
    console.log(position)
    // TODO: Make sure to use onStop or onDrag
  }

  render() {
    return (
      <div>
        <Svg width={800} height={800}>
          <Draggable
            position={{ x: 0, y: 0 }}
            onDrag={(e, position) => this.handlePolygonDrag(e, position)}
          >
            <Polygon
              points={this.state.points}
              stroke={this.state.stroke}
              strokeWidth={this.state.strokeWidth}
              fill={this.state.fill}
            />
          </Draggable>
          {this.state.points.map((point, index) => {
            return (
              <Draggable
                key={index}
                position={{ x: point[0], y: point[1] }}
                onDrag={(e, position) => this.handleVertexDrag(e, position, index)}
                onStop={() => this.handleVertextDragStop()}
              >
                <Circle
                  onContextMenu={(e) => this.handleRemoveVertex(e, index)}
                  size={3}
                  cx={0}
                  cy={0}
                  fill='#0e98dd'
                />
              </Draggable>
            )
          })}
        </Svg>
      </div >
    )
  }
}