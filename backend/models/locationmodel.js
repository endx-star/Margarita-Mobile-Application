const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const locSchema = new Schema({
  userid: {
    type: Schema.Types.ObjectId,
    required: true,
  },

  date: {
    type: String,
    required: true,
  },
  time: {
    type: String,
    required: true,
  },

  address: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("location", locSchema);
