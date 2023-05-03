const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  usertype: {
    type: String,
    required: true,
  },
  status: {
    type: String,
  },
})

module.exports = mongoose.model('User', newSchema)
