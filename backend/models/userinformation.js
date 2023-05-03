const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const userinformation = new Schema({
  username: String,
  bio: String,
  name: String,
  email: String,
  usertype: String,
  content: Array,
  follower: Array,
  following:Array,
  image:String,
  story:Array,
  lastname:String,
  firstname:String,
  phone:String,


  _id: Schema.Types.ObjectId,
});

module.exports = mongoose.model("Userinformation", userinformation);
