// Auto-generated. Do not edit!

// (in-package delbono_kobra.srv)


"use strict";

let _serializer = require('../base_serialize.js');
let _deserializer = require('../base_deserialize.js');
let _finder = require('../find.js');

//-----------------------------------------------------------

let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class GetGoalRequest {
  constructor() {
    this.go = false;
  }

  static serialize(obj, bufferInfo) {
    // Serializes a message object of type GetGoalRequest
    // Serialize message field [go]
    bufferInfo = _serializer.bool(obj.go, bufferInfo);
    return bufferInfo;
  }

  static deserialize(buffer) {
    //deserializes a message object of type GetGoalRequest
    let tmp;
    let len;
    let data = new GetGoalRequest();
    // Deserialize message field [go]
    tmp = _deserializer.bool(buffer);
    data.go = tmp.data;
    buffer = tmp.buffer;
    return {
      data: data,
      buffer: buffer
    }
  }

  static datatype() {
    // Returns string type for a service object
    return 'delbono_kobra/GetGoalRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '50769ce61ea599387c084cd1aa050412';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool go
    
    `;
  }

};

class GetGoalResponse {
  constructor() {
    this.goal = new geometry_msgs.msg.Pose();
  }

  static serialize(obj, bufferInfo) {
    // Serializes a message object of type GetGoalResponse
    // Serialize message field [goal]
    bufferInfo = geometry_msgs.msg.Pose.serialize(obj.goal, bufferInfo);
    return bufferInfo;
  }

  static deserialize(buffer) {
    //deserializes a message object of type GetGoalResponse
    let tmp;
    let len;
    let data = new GetGoalResponse();
    // Deserialize message field [goal]
    tmp = geometry_msgs.msg.Pose.deserialize(buffer);
    data.goal = tmp.data;
    buffer = tmp.buffer;
    return {
      data: data,
      buffer: buffer
    }
  }

  static datatype() {
    // Returns string type for a service object
    return 'delbono_kobra/GetGoalResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '313b76aa4f010582b3257488c62ac366';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/Pose goal
    
    
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of postion and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    `;
  }

};

module.exports = {
  Request: GetGoalRequest,
  Response: GetGoalResponse
};
