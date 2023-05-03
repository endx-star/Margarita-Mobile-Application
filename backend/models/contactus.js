const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const contactSchema = new Schema({
  userid: {
    type: Schema.Types.ObjectId,
    required: true,
  },

  username: {
    type: String,
    required: true,
  },
  message: {
    type: String,
    required: true,
  },
  date: {
    type: String,
    required: true,
  },
  useremail: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("contactus", contactSchema);
