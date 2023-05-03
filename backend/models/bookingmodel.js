const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const bookingSchema = new Schema({
  serviceproviderid: {
    type: Schema.Types.ObjectId,
    required: true,
  },
  userid: {
    type: Schema.Types.ObjectId,
    required: true,
  },
  tasklat: {
    type: Number,
    required: true,
  },
  tasklng: {
    type: Number,
    required: true,
  },
  dropoffdate: {
    type: String,
    required: true,
  },
  dropofftimefrom: {
    type: String,
    required: true,
  },
  dropofftimeto: {
    type: String,
    required: true,
  },
  pickupdate: {
    type: String,
    required: true,
  },
  pickuptimefrom: {
    type: String,
    required: true,
  },
  pickuptimeto: {
    type: String,
    required: true,
  },
  usercontactno: {
    type: String,
    required: true,
  },
  username: {
    type: String,
    required: true,
  },
  status: {
    type: String,
  },
  dogbreed: {
    type: String,
    required: true,
  },
  dogname: {
    type: String,
    required: true,
  },
  doglocation: {
    type: String,
    required: true,
  },
  amount: {
    type: String,
  },
  pettype: {
    type: String,
  },
});

module.exports = mongoose.model("Booking", bookingSchema);
