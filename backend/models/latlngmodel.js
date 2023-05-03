const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const latlngSchema = new Schema({
  lat: {
    type: String,
    required: true,
  },
  lng: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("latlng", latlngSchema);
