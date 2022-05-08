import React from "react";
import { Polygon, Circle } from 'react-svg-path';
import Draggable from "react-draggable";

export class CustomPolygon extends React.Component {
  state = {
    stroke: '#00ffb2',
    strokeWidth: 1,
    fill: 'rgba(122, 255, 215, 0.5)',
  }

  render() {
    const { shapeIndex, points, onPolygonDragStop, onVertexDrag, onVertexDragStop, onRemoveVertex } = this.props
    return (
      <React.Fragment>
        <Draggable
          position={{ x: 0, y: 0 }}
          onStop={(_e, position) => onPolygonDragStop(position, shapeIndex)}
        >
          <Polygon
            points={points}
            stroke={this.state.stroke}
            strokeWidth={this.state.strokeWidth}
            fill={this.state.fill}
          />
        </Draggable>
        {points.map((point, index) => {
          return (
            <Draggable
              key={index}
              position={{ x: point[0], y: point[1] }}
              onDrag={(e, position) => onVertexDrag(e, position, index, shapeIndex)}
              onStop={() => onVertexDragStop()}
            >
              <Circle
                onContextMenu={(e) => onRemoveVertex(e, index, shapeIndex)}
                size={3}
                cx={0}
                cy={0}
                fill='#0e98dd'
              />
            </Draggable>
          )
        })}
      </React.Fragment>
    )
  }
}