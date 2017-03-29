// Auto-generated. Do not edit!

// (in-package delbono_kobra.msg)


"use strict";

let _serializer = require('../base_serialize.js');
let _deserializer = require('../base_deserialize.js');
let _finder = require('../find.js');

//-----------------------------------------------------------

class OdomInfo {
  constructor() {
    this.t = 0.0;
    this.linearVel = 0.0;
    this.angularVel = 0.0;
    this.dx = 0.0;
    this.dy = 0.0;
    this.dtheta = 0.0;
  }

  static serialize(obj, bufferInfo) {
    // Serializes a message object of type OdomInfo
    // Serialize message field [t]
    bufferInfo = _serializer.float32(obj.t, bufferInfo);
    // Serialize message field [linearVel]
    bufferInfo = _serializer.float32(obj.linearVel, bufferInfo);
    // Serialize message field [angularVel]
    bufferInfo = _serializer.float32(obj.angularVel, bufferInfo);
    // Serialize message field [dx]
    bufferInfo = _serializer.float32(obj.dx, bufferInfo);
    // Serialize message field [dy]
    bufferInfo = _serializer.float32(obj.dy, bufferInfo);
    // Serialize message field [dtheta]
    bufferInfo = _serializer.float32(obj.dtheta, bufferInfo);
    return bufferInfo;
  }

  static deserialize(buffer) {
    //deserializes a message object of type OdomInfo
    let tmp;
    let len;
    let data = new OdomInfo();
    // Deserialize message field [t]
    tmp = _deserializer.float32(buffer);
    data.t = tmp.data;
    buffer = tmp.buffer;
    // Deserialize message field [linearVel]
    tmp = _deserializer.float32(buffer);
    data.linearVel = tmp.data;
    buffer = tmp.buffer;
    // Deserialize message field [angularVel]
    tmp = _deserializer.float32(buffer);
    data.angularVel = tmp.data;
    buffer = tmp.buffer;
    // Deserialize message field [dx]
    tmp = _deserializer.float32(buffer);
    data.dx = tmp.data;
    buffer = tmp.buffer;
    // Deserialize message field [dy]
    tmp = _deserializer.float32(buffer);
    data.dy = tmp.data;
    buffer = tmp.buffer;
    // Deserialize message field [dtheta]
    tmp = _deserializer.float32(buffer);
    data.dtheta = tmp.data;
    buffer = tmp.buffer;
    return {
      data: data,
      buffer: buffer
    }
  }

  static datatype() {
    // Returns string type for a message object
    return 'delbono_kobra/OdomInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '9844e4d0505bb71cef8082d5d9d1d1dc';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 t
    float32 linearVel
    float32 angularVel
    float32 dx
    float32 dy
    float32 dtheta
    
    `;
  }

};

module.exports = OdomInfo;
