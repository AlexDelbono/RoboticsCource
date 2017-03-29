// Auto-generated. Do not edit!

// (in-package delbono_kobra.msg)


"use strict";

let _serializer = require('../base_serialize.js');
let _deserializer = require('../base_deserialize.js');
let _finder = require('../find.js');

//-----------------------------------------------------------

class Ptz {
  constructor() {
    this.p = 0.0;
    this.t = 0.0;
    this.z = 0.0;
  }

  static serialize(obj, bufferInfo) {
    // Serializes a message object of type Ptz
    // Serialize message field [p]
    bufferInfo = _serializer.float32(obj.p, bufferInfo);
    // Serialize message field [t]
    bufferInfo = _serializer.float32(obj.t, bufferInfo);
    // Serialize message field [z]
    bufferInfo = _serializer.float32(obj.z, bufferInfo);
    return bufferInfo;
  }

  static deserialize(buffer) {
    //deserializes a message object of type Ptz
    let tmp;
    let len;
    let data = new Ptz();
    // Deserialize message field [p]
    tmp = _deserializer.float32(buffer);
    data.p = tmp.data;
    buffer = tmp.buffer;
    // Deserialize message field [t]
    tmp = _deserializer.float32(buffer);
    data.t = tmp.data;
    buffer = tmp.buffer;
    // Deserialize message field [z]
    tmp = _deserializer.float32(buffer);
    data.z = tmp.data;
    buffer = tmp.buffer;
    return {
      data: data,
      buffer: buffer
    }
  }

  static datatype() {
    // Returns string type for a message object
    return 'delbono_kobra/Ptz';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7d67c83f522ade3e3af5cf25a4c6fe96';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 p
    float32 t
    float32 z
    
    `;
  }

};

module.exports = Ptz;
